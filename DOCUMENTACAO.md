# Documentação — recommendation.py

Sistema de recomendação de filmes baseado em lógica fuzzy (scikit-fuzzy).  
Opera em dois modos: recomendação para um usuário específico e avaliação via matriz de confusão.

---

## Visão Geral do Fluxo

```
PostgreSQL
   │
   ├─ get_history()        → histórico de filmes assistidos pelo usuário
   ├─ get_user_profile()   → favoritos declarados (gênero, ator, diretor)
   └─ get_movie_by_id()    → atributos do filme candidato
          │
          ▼
   calcular_afinidade()        → score 0–1 por eixo (gênero / ator / diretor)
          │
          ▼
   calcular_input_com_perfil() → input 0–10 com boost de perfil declarado
          │
          ▼
   construir_sistema_fuzzy()   → sistema de inferência (4 antecedentes, 19 regras)
          │
          ▼
   ControlSystemSimulation.compute() → defuzzificação → score 0–100 %
          │
          ├─ Modo normal   → plotar_pertinencia() + save_recommendations()
          └─ Modo avaliar  → score_para_categoria() → avaliar_cenarios() → plotar_matriz_confusao()
```

---

## Constantes Globais

| Constante | Tipo | Descrição |
|-----------|------|-----------|
| `DB_CONFIG` | dict | Parâmetros de conexão PostgreSQL (host, porta, banco, usuário, senha) |
| `query_get_movies` | str | Query SQL que busca um filme candidato pelo id, incluindo gêneros, atores e diretores via `json_agg` em subqueries |
| `CLASSES_RECOMENDACAO` | list | Ordem das categorias de saída: `['baixa', 'media', 'alta', 'muito_alta']` |
| `CENARIOS_TESTE` | list | 15 cenários (5 usuários × 3 filmes) com saída esperada. Usado apenas no modo `--avaliar` |

---

## Funções de Banco de Dados

### `get_db_connection()`
- **Entrada:** nenhuma (usa `DB_CONFIG` global)
- **Saída:** `psycopg2.connection`
- Abre e retorna uma conexão. Cada função de banco abre sua própria conexão e a fecha no bloco `finally`, evitando leaks de conexão.

---

### `get_user_id_by_name(name)`
- **Entrada:** `name: str` — nome do usuário (padrão `"Guilherme"`)
- **Saída:** `int` com o id, ou `None` se não encontrado
- Executa `SELECT id FROM tbl_users WHERE name = %s LIMIT 1`.

---

### `get_history(user_id)`
- **Entrada:** `user_id: int`
- **Saída:** lista de dicts com a estrutura abaixo, ou `None` em caso de erro

```python
[
  {
    'user_average':    float,   # nota que o usuário deu ao filme
    'minutes_watched': int,     # minutos assistidos
    'like':            bool,    # curtiu ou não
    'movies': {
      'duration':   int,        # duração total do filme (minutos)
      'genders':    [{'name': str}],
      'actors':     [{'name': str}],
      'directors':  [{'name': str}],
    }
  },
  ...
]
```

A query faz JOIN entre `tbl_historic` e `tbl_movies` e usa subqueries com `json_agg` para trazer metadados do filme em uma única consulta. O `RealDictCursor` retorna linhas como dicionários.

---

### `get_movies(query)`
- **Entrada:** `query: str` — string SQL completa
- **Saída:** lista de `RealDictRow` com os campos do filme
- Executor genérico. No modo normal é chamado com `query_get_movies`.

---

### `save_recommendations(user_id, recommendations)`
- **Entrada:** `user_id: int` + lista de `{'movieId': int, 'recommendation_score': float}`
- **Saída:** nenhuma (efeito colateral em `tbl_recommendations`)
- Usa `ON CONFLICT (user_id, movie_id) DO UPDATE SET recommendation_score = EXCLUDED.recommendation_score` — se o par já existir, atualiza o score; caso contrário, insere.

---

### `get_user_profile(user_id)`
- **Entrada:** `user_id: int`
- **Saída:** `{'favorite_gender': str, 'favorite_actor': str, 'favorite_director': str}`
- Faz `LEFT JOIN` em `tbl_genders`, `tbl_actors` e `tbl_directors` para retornar os **nomes** dos favoritos declarados (não os ids).

---

### `get_movie_by_id(movie_id)`
- **Entrada:** `movie_id: int`
- **Saída:** `RealDictRow` com id, title, description, duration, released_year, average, genders, actors, directors
- Mesma estrutura da `query_get_movies`, mas parametrizada com `%s`. Usada no modo `--avaliar` para buscar os filmes dos cenários de teste.

---

## Lógica de Recomendação

### `calcular_afinidade(historico_filmes, chave, valores_alvo, verbose=True)`

Mede o quão afinado o usuário é com um atributo do filme candidato com base no histórico.

**Entradas:**
- `historico_filmes` — retorno de `get_history`
- `chave` — `'genders'`, `'actors'` ou `'directors'`
- `valores_alvo` — lista `[{'name': str}]` dos atributos do filme candidato
- `verbose` — se `True`, imprime debug detalhado no terminal

**Processamento passo a passo:**

1. Monta `nomes_alvo`: set com os nomes do filme candidato para aquela chave
2. Filtra o histórico mantendo só filmes que compartilham pelo menos um atributo com o candidato → `filmes_filtrados`
3. Se `filmes_filtrados` está vazio → retorna `0` imediatamente

4. Calcula 4 componentes normalizados (todos em 0–1):

| Variável | Cálculo | Peso |
|----------|---------|------|
| **Q** (Quantidade) | `len(filtrados) / len(total)` — proporção do histórico com match | 0.4 |
| **N** (Nota) | `media(user_average) / 10` — quão bem avaliou esses filmes | 0.3 |
| **T** (Tempo) | `media(minutes_watched / duration)` com teto em 1.0 — conclusão média | 0.2 |
| **C** (Curtida) | `media(like)` — proporção curtida (bool como 0/1) | 0.1 |

5. Combina:
```
afinidade = 0.4 × Q + 0.3 × N + 0.2 × T + 0.1 × C
```

**Exemplo:** Usuário com 6 filmes, 3 de Action (Q=0.5), notas médias 9.0 (N=0.9), todos assistidos completo (T=1.0), todos curtidos (C=1.0):
```
afinidade = 0.4×0.5 + 0.3×0.9 + 0.2×1.0 + 0.1×1.0 = 0.77
```

**Saída:** `float` entre 0 e 1 (arredondado em 2 casas decimais)

---

### `calcular_input_com_perfil(score_historico, nome_favorito, lista_itens_filme, peso_historico=0.6, peso_perfil=0.4)`

Combina o score do histórico com o sinal do perfil declarado para gerar o input final da variável fuzzy.

**Entradas:**
- `score_historico` — `afinidade × 10` (escala 0–10)
- `nome_favorito` — favorito declarado do usuário (ex: `"Action"`, `"Christopher Nolan"`)
- `lista_itens_filme` — `[{'name': str}]` dos atributos do filme candidato
- Pesos: `0.6` para histórico, `0.4` para perfil

**Processamento:**
```python
perfil_score = 10.0  se nome_favorito está em lista_itens_filme
             =  0.0  caso contrário

resultado = 0.6 × score_historico + 0.4 × perfil_score
```

**Por que isso importa:**

| Situação | score_historico | perfil_score | input final |
|----------|----------------|-------------|-------------|
| Sem histórico, favorito bate | 0 | 10 | **4.0** → zona média |
| Histórico alto, favorito bate | 9.0 | 10 | **9.4** → zona alta máxima |
| Histórico alto, favorito não bate | 7.0 | 0 | **4.2** → zona média |
| Sem histórico, favorito não bate | 0 | 0 | **0.0** → zona baixa |

**Saída:** `float` entre 0 e 10

---

### `construir_sistema_fuzzy()`

Constrói o sistema completo de inferência fuzzy usando `skfuzzy.control`.

#### Variáveis Antecedentes (universo 0–10)

**genero, diretor, ator** — mesmo conjunto de termos:
| Termo | Função | Parâmetros trimf |
|-------|--------|-----------------|
| baixa | triangular | [0, 0, 5] |
| media | triangular | [2, 5, 8] |
| alta  | triangular | [5, 10, 10] |

**nota**:
| Termo | Função | Parâmetros trimf |
|-------|--------|-----------------|
| ruim      | triangular | [0, 0, 5] |
| boa       | triangular | [4, 6, 8] |
| excelente | triangular | [7, 10, 10] |

#### Variável Consequente — `recomendacao` (universo 0–100)

| Termo | Função | Parâmetros trimf |
|-------|--------|-----------------|
| baixa     | triangular | [0, 0, 40] |
| media     | triangular | [30, 50, 70] |
| alta      | triangular | [60, 80, 100] |
| muito_alta | triangular | [80, 100, 100] |

#### Base de Regras (19 regras)

| # | Grupo | Condição SE | Conclusão ENTÃO |
|---|-------|-------------|-----------------|
| R1 | MUITO_ALTA | genero_alta **E** diretor_alta **E** ator_alta | muito_alta |
| R2 | MUITO_ALTA | genero_alta **E** diretor_alta **E** nota_excelente | muito_alta |
| R3 | MUITO_ALTA | genero_alta **E** ator_alta **E** nota_excelente | muito_alta |
| R4 | MUITO_ALTA | diretor_alta **E** ator_alta **E** nota_excelente | muito_alta |
| R5 | ALTA | (genero_alta **OU** diretor_alta **OU** ator_alta) **E** nota_excelente | alta |
| R6 | ALTA | genero_alta **E** nota_boa | alta |
| R7 | ALTA | diretor_alta **E** nota_boa | alta |
| R8 | ALTA | ator_alta **E** nota_boa | alta |
| R9 | ALTA | genero_alta **E** (diretor_media **OU** ator_media) **E** nota_boa | alta |
| R10 | ALTA | genero_media **E** (diretor_alta **OU** ator_alta) **E** nota_boa | alta |
| R11 | MEDIA | (genero_media **OU** diretor_media **OU** ator_media) **E** nota_boa | media |
| R12 | MEDIA | (genero_alta **OU** diretor_alta **OU** ator_alta) **E** nota_ruim | media |
| R13 | MEDIA | genero_media **E** (diretor_media **OU** ator_media) | media |
| R14 | MEDIA | (genero_media **OU** diretor_media **OU** ator_media) **E** nota_excelente | media |
| R15 | MEDIA | genero_baixa **E** (diretor_baixa **OU** ator_baixa) **E** nota_boa | media |
| R16 | BAIXA | genero_baixa **E** diretor_baixa **E** ator_baixa | baixa |
| R17 | BAIXA | genero_baixa **E** nota_ruim | baixa |
| R18 | BAIXA | diretor_baixa **E** ator_baixa **E** nota_ruim | baixa |
| R19 | BAIXA | (genero_media **OU** diretor_media **OU** ator_media) **E** nota_ruim | baixa |

**Nota sobre rebuild por cenário:** O skfuzzy armazena `activation_value` internamente nas regras do `ControlSystem`. Reutilizar o mesmo objeto em múltiplas simulações consecutivas faz o estado de uma rodada vazar para a próxima. Por isso `avaliar_cenarios()` chama `construir_sistema_fuzzy()` a cada iteração.

**Saída:** tupla `(sistema_controle, recomendacao, genero, diretor, ator, nota)`

---

### `plotar_pertinencia(variaveis_entrada, consequente, valores_entrada, valor_saida, titulo, output_dir)`

Gera e salva um PNG com 5 subgráficos mostrando o estado interno do sistema fuzzy para uma rodada específica.

**Entradas:**
- `variaveis_entrada` — `{'Genero': Antecedent, 'Ator': Antecedent, 'Diretor': Antecedent, 'Nota': Antecedent}`
- `consequente` — objeto `Consequent` de recomendação
- `valores_entrada` — `{'Genero': float, ...}` — valores reais desta rodada
- `valor_saida` — score defuzzificado (0–100)
- `titulo` — nome do filme (usado no título do gráfico e no nome do arquivo)

**Para cada antecedente:**
- Plota as curvas triangulares de pertinência
- Desenha linha vertical no valor de entrada atual
- Anota o grau de pertinência em cada conjunto (ponto preto + label numérico)

**Para o consequente:**
- Plota as 4 curvas triangulares
- Marca o valor defuzzificado com linha vertical
- Preenche a área `[0, valor_saida]` com `axvspan` translúcido

**Saída:** arquivo `fuzzy_plots/<titulo>.png`

---

## Matriz de Confusão

### `score_para_categoria(score, recomendacao_var)`

Converte o score contínuo (0–100) em uma das 4 categorias discretas, usando argmax de pertinência.

**Entrada:** `score: float` (saída defuzzificada), `recomendacao_var: Consequent`

**Processamento:**
```python
pertinencias = {
    termo: fuzz.interp_membership(universo, obj.mf, score)
    for termo, obj in recomendacao_var.terms.items()
}
return max(pertinencias, key=pertinencias.get)
```

Para cada termo, avalia quanto o score "pertence" àquele conjunto com `fuzz.interp_membership`. Retorna o termo com maior grau de pertinência.

**Exemplos:**

| Score | baixa | media | alta | muito_alta | Resultado |
|-------|-------|-------|------|-----------|-----------|
| 15% | 0.625 | 0.000 | 0.000 | 0.000 | **baixa** |
| 42% | 0.000 | 0.600 | 0.000 | 0.000 | **media** |
| 73% | 0.000 | 0.000 | 0.650 | 0.000 | **alta** |
| 90% | 0.000 | 0.000 | 0.500 | 0.500 | **alta** ¹ |

¹ Empate resolvido pelo `max` do Python com a primeira ocorrência na ordem de inserção do dict (`baixa → media → alta → muito_alta`). Em scores > 90%, `muito_alta` passa a ter pertinência maior que `alta` e vence.

**Saída:** `str` — uma das quatro categorias

---

### `calcular_score_usuario_filme(user_name, movie, sistema_controle, recomendacao_var)`

Pipeline completo de cálculo para um par (usuário, filme).

**Entradas:**
- `user_name: str`
- `movie: RealDictRow` — retorno de `get_movie_by_id`
- `sistema_controle: ctrl.ControlSystem`
- `recomendacao_var: ctrl.Consequent`

**Pipeline:**

```
user_name  →  get_user_id_by_name()  →  user_id
user_id    →  get_history()          →  history
user_id    →  get_user_profile()     →  profile
                                         │
                            calcular_afinidade(verbose=False)
                            ├─ gênero   → afinidade_genero  (0–1)
                            ├─ ator     → afinidade_ator    (0–1)
                            └─ diretor  → afinidade_diretor (0–1)
                                         │
                       calcular_input_com_perfil()
                       ├─ input_genero  (0–10)
                       ├─ input_ator    (0–10)
                       ├─ input_diretor (0–10)
                       └─ input_nota = float(movie['average'])  ← float() obrigatório!
                                         │
                    ctrl.ControlSystemSimulation.compute()
                                         │
                              score = output['recomendacao']  (0–100)
                                         │
                          score_para_categoria()
                                         │
                                    categoria
```

**Detalhe sobre `float(movie['average'])`:** o psycopg2 retorna `Decimal` para colunas SQL `NUMERIC`. O `np.interp` interno do skfuzzy rejeita `Decimal` com `TypeError`. A conversão explícita para `float` evita essa falha silenciosa.

**Saída:** tupla `(score: float, categoria: str)`

---

### `avaliar_cenarios(cenarios)`

Itera sobre todos os cenários de teste e coleta predição vs. esperado.

**Entrada:** lista de `{'usuario': str, 'movie_id': int, 'esperado': str}`

**Processamento:**

1. `cache_filmes: dict` — evita múltiplas consultas ao banco para o mesmo filme. Os 3 filmes de teste (ids 4, 27, 43) são buscados no máximo uma vez cada, independentemente de quantos usuários os referenciam.

2. Para cada cenário:
   - Busca o filme do cache (ou do banco na primeira ocorrência)
   - Chama `construir_sistema_fuzzy()` — sistema **isolado por cenário** para evitar state leaking do skfuzzy
   - Chama `calcular_score_usuario_filme`
   - Compara `previsto == esperado` → booleano `correto`

3. Imprime tabela em tempo real:
   ```
   Usuário      Filme ID   Esperado     Previsto      Score  Status
   Ana                 4   muito_alta   muito_alta    91.2%  OK
   Carlos              4   alta         alta          73.5%  OK
   ...
   ```

**Saída:** lista de 15 dicts `{usuario, movie_id, esperado, previsto, score, correto}`

---

### `plotar_matriz_confusao(resultados, output_dir)`

Constrói e renderiza o heatmap da matriz de confusão.

**Entrada:** lista de resultados de `avaliar_cenarios`

**Construção da matriz:**

```python
matriz = np.zeros((4, 4), dtype=int)
# CLASSES_RECOMENDACAO = ['baixa', 'media', 'alta', 'muito_alta']
# idx = {'baixa': 0, 'media': 1, 'alta': 2, 'muito_alta': 3}

for r in resultados:
    matriz[idx[r['esperado']]][idx[r['previsto']]] += 1
```

Linhas = classe real (esperada). Colunas = classe prevista pelo sistema.

**Como ler:**

```
                  PREVISTO →
                baixa  media  alta  muito_alta
REAL  baixa   [  TP     FP     FP      FP   ]
↓     media   [  FN     TP     FP      FP   ]
      alta    [  FN     FN     TP      FP   ]
      m_alta  [  FN     FN     FN      TP   ]
```

- **Diagonal principal** (TP): acertos — o sistema previu a classe correta
- **Fora da diagonal**: erros — qual classe foi confundida com qual
- Erros nas células **adjacentes à diagonal** (ex: alta → muito_alta) são menos graves do que erros distantes (ex: baixa → muito_alta)

**Acurácia:** `acertos / total × 100%` (impressa no terminal após salvar o PNG)

**Saída:** arquivo `fuzzy_plots/matriz_confusao.png`

---

## Bloco `__main__`

```python
modo_avaliacao = '--avaliar' in sys.argv
sistema_controle, recomendacao, genero, diretor, ator, nota = construir_sistema_fuzzy()
```

### Modo Normal (`python recommendation.py`)

- Usuário fixo: `"João"`
- Filme fixo: `query_get_movies` (WHERE m.id = 280)
- Para o filme retornado:
  - Calcula afinidade por gênero, ator e diretor (verbose=True — imprime debug)
  - Aplica boost de perfil declarado
  - Roda inferência fuzzy e `plotar_pertinencia`
  - Armazena no dict `resultados`
- Ordena resultados por `recommendation_score` (decrescente)
- Imprime tabela final e salva no banco via `save_recommendations`

### Modo Avaliação (`python recommendation.py --avaliar`)

- Chama `avaliar_cenarios(CENARIOS_TESTE)` — 15 pares (3 filmes × 5 usuários)
- Chama `plotar_matriz_confusao` → heatmap + acurácia no terminal
- O sistema fuzzy é reconstruído dentro de `avaliar_cenarios` a cada iteração (não usa o instanciado aqui)

---

## Cenários de Teste

| Filme | id | Usuário | Esperado | Motivo principal |
|-------|----|---------|----------|-----------------|
| The Dark Knight | 4 | Ana | muito_alta | Todos os 3 pilares altos (R1–R4) |
| The Dark Knight | 4 | Carlos | alta | Só gênero alto via OU (R5) |
| The Dark Knight | 4 | Beatriz | alta | Só ator alto via boost favorito (R5) |
| The Dark Knight | 4 | Diego | media | Gênero médio sem boost (R14) |
| The Dark Knight | 4 | Elena | baixa | Todos os pilares baixos (R16) |
| The Green Mile | 27 | Ana | media | Sem match Action/Nolan/Bale em Drama (R14) |
| The Green Mile | 27 | Carlos | media | Sem match Action em Crime/Drama (R14) |
| The Green Mile | 27 | Beatriz | media | Sem match Mystery em Drama/Crime (R14) |
| The Green Mile | 27 | Diego | muito_alta | Drama/Tom Hanks/Darabont = match perfeito (R1–R4) |
| The Green Mile | 27 | Elena | alta | Drama/Tom Hanks/Darabont com boost (R5) |
| The Usual Suspects | 43 | Ana | media | Crime/Mystery parcial, sem boost Action (R14) |
| The Usual Suspects | 43 | Carlos | media | Crime parcial, sem boost Action (R14) |
| The Usual Suspects | 43 | Beatriz | alta | Mystery + boost fav=Mystery eleva gênero (R5) |
| The Usual Suspects | 43 | Diego | media | Crime fraco, sem boost Drama (R14) |
| The Usual Suspects | 43 | Elena | baixa | Todos os pilares baixos (R16) |
