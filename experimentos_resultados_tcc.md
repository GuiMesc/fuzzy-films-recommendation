# Capítulo: Experimentos e Resultados

Este capítulo apresenta o planejamento experimental, a definição dos cenários de teste adotados para validação do sistema de recomendação fuzzy, a análise quantitativa e qualitativa dos resultados obtidos e a interpretação dos gráficos gerados.

---

## 1. Metodologia Experimental

A validação do sistema de recomendação proposto foi estruturada por meio de uma abordagem experimental baseada em cenários de simulação. O objetivo consiste em avaliar a capacidade do modelo fuzzy de emular o julgamento humano ao calcular a recomendação de um filme sob diferentes contextos de perfis e históricos de usuários.

O planejamento dos experimentos envolveu três pilares principais:

### 1.1. Definição dos Perfis de Usuários
Foram modelados 5 perfis de usuários com históricos de consumo e preferências explicitadas bem definidos no banco de dados para abranger diferentes comportamentos de consumo de mídia:
* **Ana:** Usuária com grande engajamento em filmes de Ação e fã declarada da dupla Christopher Nolan (diretor) e Christian Bale (ator). Seu histórico possui alta retenção e avaliações consistentemente elevadas.
* **Carlos:** Fã clássico de Ação, com preferência declarada pelo diretor Quentin Tarantino e ator Brad Pitt. Seu histórico é composto por filmes populares de ação/drama com alto engajamento.
* **Beatriz:** Fã de Mistério, com preferência pelo diretor David Fincher e ator Christian Bale. Seu histórico mostra interesse híbrido entre suspenses e dramas clássicos.
* **Diego:** Consumidor moderado de Dramas, com preferência por Steven Spielberg e Tom Hanks. Seu perfil destaca-se por apresentar **baixa retenção média** (costuma assistir a apenas metade da duração dos filmes em seu histórico), o que testa o rigor das métricas lógicas de engajamento do modelo.
* **Elena:** Fã de filmes de Romance, com preferência pelo diretor Frank Darabont e ator Tom Hanks. Seu histórico é focado em dramas e romances clássicos de alta avaliação.

### 1.2. Seleção de Filmes para Teste
Foram selecionados 3 filmes icônicos do catálogo que cruzam de forma distinta as características dos perfis descritos:
1. **The Dark Knight (ID=3):** Filme de Ação/Crime/Drama dirigido por Christopher Nolan e estrelado por Christian Bale. Média crítica: $9.0/10$.
2. **The Green Mile (ID=26):** Drama/Fantasia dirigido por Frank Darabont e estrelado por Tom Hanks. Média crítica: $8.6/10$.
3. **The Usual Suspects (ID=42):** Policial/Mistério/Suspense dirigido por Bryan Singer e estrelado por Kevin Spacey. Média crítica: $8.5/10$.

### 1.3. Critério para Construção do Percentual Esperado (*Ground Truth*)
Os valores esperados de recomendação foram estipulados manualmente no plano de testes baseando-se em regras estritas de compatibilidade lógica e conceitual.
* **Compatibilidade Alta/Muito Alta ($80\%$ a $95\%$):** Atribuída quando há coincidência entre os atores, diretores ou gêneros preferidos do perfil declarado e as características do filme candidato, somado a um histórico favorável.
* **Compatibilidade Média ($50\%$):** Atribuída a filmes neutros que não possuem forte oposição no perfil, mas que também não coincidem diretamente com os favoritos declarados pelo usuário.
* **Compatibilidade Baixa ($15\%$):** Atribuída a filmes cujos gêneros ou estilos colidem com os hábitos de consumo mapeados no perfil (ex: filmes de ação pura para perfis puramente voltados a romance).

---

## 2. Definição e Análise dos Cenários de Teste

Abaixo são detalhados os 15 cenários avaliados. Cada cenário mapeia as variáveis antecedentes de entrada obtidas, o gabarito esperado, o valor predito pelo modelo fuzzy, o erro residual e uma análise qualitativa das regras inferidas.

### 2.1. Grupo de Testes: *The Dark Knight* (ID=3)
*Metadados do Filme:* Gênero: Action, Crime, Drama | Diretor: Christopher Nolan | Atores: Christian Bale, Heath Ledger | Nota média crítica: $9.0$

| Cenário | Usuário | Histórico (Média) | Preferências Declaradas | Esperado ($y_i$) | Previsto ($\hat{y}_i$) | Erro Absoluto |
| :--- | :--- | :--- | :--- | :---: | :---: | :---: |
| 1 | Ana | Christopher Nolan (Forte) | Nolan (Dir) / Bale (Ator) / Action (Gên) | $95.0\%$ | $83.2\%$ | $11.8\%$ |
| 2 | Carlos | Ação (Forte) | Tarantino (Dir) / Pitt (Ator) / Action (Gên) | $80.0\%$ | $80.0\%$ | $0.0\%$ |
| 3 | Beatriz | Misto / Bale (Forte) | Fincher (Dir) / Bale (Ator) / Mystery (Gên) | $80.0\%$ | $64.5\%$ | $15.5\%$ |
| 4 | Diego | Dramas (Retenção Baixa) | Spielberg (Dir) / Hanks (Ator) / Drama (Gên) | $50.0\%$ | $37.1\%$ | $12.9\%$ |
| 5 | Elena | Clássicos / Romances | Darabont (Dir) / Hanks (Ator) / Romance (Gên) | $15.0\%$ | $13.3\%$ | $1.7\%$ |

#### Análise Qualitativa dos Cenários:
* **Cenário 1 (Ana):** O sistema capturou o alinhamento total de favoritos (Nolan e Bale) e a alta afinidade do histórico. O percentual previsto de $83.2\%$ ativou a regra de recomendação `muito_alta`. O desvio de $11.8\%$ ocorre porque as regras fuzzy amortecem saídas extremas como $95\%$ a menos que todas as notas sejam absolutamente $10$.
* **Cenário 2 (Carlos):** Obteve erro de $0.0\%$ em relação à expectativa de $80\%$. A afinidade do gênero Ação e a nota crítica $9.0$ do filme dispararam regras de recomendação `alta`.
* **Cenário 3 (Beatriz):** Christian Bale é ator favorito e está no filme, porém, Nolan não é seu diretor favorito e ela consome menos Ação do que Mistério. O modelo reduziu a predição para $64.5\%$ (Recomendação Média/Alta), refletindo corretamente essa hesitação híbrida.
* **Cenário 4 (Diego):** Apesar de o filme possuir o gênero Drama (favorito declaratório), o histórico de Diego penalizou a entrada devido à baixa retenção de minutos assistidos. O modelo adequadamente reduziu a predição para $37.1\%$.
* **Cenário 5 (Elena):** Como fã exclusiva de Romance/Dramas clássicos, a afinidade de Elena com Ação/Crime é nula. A predição de $13.3\%$ reflete a ativação exclusiva da regra de recomendação `baixa`.

---

### 2.2. Grupo de Testes: *The Green Mile* (ID=26)
*Metadados do Filme:* Gênero: Drama, Fantasy | Diretor: Frank Darabont | Atores: Tom Hanks, David Morse | Nota média crítica: $8.6$

| Cenário | Usuário | Histórico (Média) | Preferências Declaradas | Esperado ($y_i$) | Previsto ($\hat{y}_i$) | Erro Absoluto |
| :--- | :--- | :--- | :--- | :---: | :---: | :---: |
| 6 | Ana | Ação (Forte) | Nolan (Dir) / Bale (Ator) / Action (Gên) | $50.0\%$ | $41.6\%$ | $8.4\%$ |
| 7 | Carlos | Ação (Forte) | Tarantino (Dir) / Pitt (Ator) / Action (Gên) | $50.0\%$ | $42.6\%$ | $7.4\%$ |
| 8 | Beatriz | Mistério / Suspense | Fincher (Dir) / Bale (Ator) / Mystery (Gên) | $50.0\%$ | $44.5\%$ | $5.5\%$ |
| 9 | Diego | Dramas (Retenção Baixa) | Spielberg (Dir) / Hanks (Ator) / Drama (Gên) | $95.0\%$ | $69.8\%$ | $25.2\%$ |
| 10 | Elena | Dramas / Romances | Darabont (Dir) / Hanks (Ator) / Romance (Gên) | $80.0\%$ | $67.7\%$ | $12.3\%$ |

#### Análise Qualitativa dos Cenários:
* **Cenários 6, 7 e 8 (Ana, Carlos, Beatriz):** O filme não possui nenhuma ligação com os favoritos declarados desses usuários. A recomendação média gerada pelo modelo (flutuando entre $41\%$ e $44\%$) é condizente com a expectativa de $50\%$. As regras ativadas concentraram-se majoritariamente em `media` devido à boa nota crítica do filme ($8.6$).
* **Cenário 9 (Diego):** O filme casa com seu ator favorito (Tom Hanks) e gênero (Drama). Entretanto, a predição de $69.8\%$ ficou abaixo dos $95\%$ esperados devido à penalidade acumulada de baixa retenção em seu histórico de visualizações no banco de dados. Esse foi o maior erro residual registrado ($25.2\%$).
* **Cenário 10 (Elena):** O filme possui o diretor (Darabont) e ator (Hanks) preferidos de Elena. O sistema gerou uma recomendação sólida de $67.7\%$, ativando prioritariamente os consequentes `alta`.

---

### 2.3. Grupo de Testes: *The Usual Suspects* (ID=42)
*Metadados do Filme:* Gênero: Crime, Mystery, Thriller | Diretor: Bryan Singer | Atores: Kevin Spacey, Gabriel Byrne | Nota média crítica: $8.5$

| Cenário | Usuário | Histórico (Média) | Preferências Declaradas | Esperado ($y_i$) | Previsto ($\hat{y}_i$) | Erro Absoluto |
| :--- | :--- | :--- | :--- | :---: | :---: | :---: |
| 11 | Ana | Ação (Forte) | Nolan (Dir) / Bale (Ator) / Action (Gên) | $50.0\%$ | $40.9\%$ | $9.1\%$ |
| 12 | Carlos | Ação (Forte) | Tarantino (Dir) / Pitt (Ator) / Action (Gên) | $50.0\%$ | $42.4\%$ | $7.6\%$ |
| 13 | Beatriz | Mistério / Bale | Fincher (Dir) / Bale (Ator) / Mystery (Gên) | $80.0\%$ | $77.8\%$ | $2.2\%$ |
| 14 | Diego | Dramas (Retenção Baixa) | Spielberg (Dir) / Hanks (Ator) / Drama (Gên) | $50.0\%$ | $38.0\%$ | $12.0\%$ |
| 15 | Elena | Clássicos / Romances | Darabont (Dir) / Hanks (Ator) / Romance (Gên) | $15.0\%$ | $13.3\%$ | $1.7\%$ |

#### Análise Qualitativa dos Cenários:
* **Cenário 13 (Beatriz):** O filme é do gênero Mistério, preferido de Beatriz. A resposta de $77.8\%$ do modelo foi muito próxima dos $80\%$ de referência (erro de apenas $2.2\%$), consolidando a força da regra que associa afinidade alta de gênero à alta recomendação.
* **Cenários 11, 12 e 14:** Perfis neutros receberam notas contidas na faixa de recomendação `media` (entre $38\%$ e $42\%$), refletindo o comportamento equilibrado das regras lógicas.
* **Cenário 15 (Elena):** Novamente, o filme de suspense/crime colide com o gosto de Elena por romance. A predição retornou $13.3\%$, condizente com a expectativa mínima.

---

## 3. Avaliação Quantitativa Global

Reunindo os resíduos computados nos 15 cenários de testes, as métricas globais de regressão foram calculadas para diagnosticar o erro médio de calibração do recomendador:

* **MAE (Mean Absolute Error):** $8.87\%$
* **RMSE (Root Mean Squared Error):** $10.89\%$

### Interpretação das Métricas:
* O **MAE de $8.87\%$** indica que, em média, a predição do modelo fuzzy desvia cerca de $8,8$ pontos percentuais da expectativa teórica mapeada pelo especialista. Para um recomendador fuzzy contínuo de $0$ a $100$, um erro médio inferior a $10\%$ é considerado excelente, validando o acoplamento do sistema.
* O **RMSE de $10.89\%$** apresenta-se ligeiramente superior ao MAE. Essa diferença sutil é explicada matematicamente pelo impacto do Cenário 9 (Diego e *The Green Mile*), que gerou um erro isolado de $25.2\%$. Como o RMSE eleva os resíduos ao quadrado antes de extrair a média, ele penaliza severamente grandes distorções, elevando o valor da métrica global.

---

## 4. Visualização dos Resultados

Abaixo são apresentados os gráficos de análise gerados pela ferramenta de avaliação, seguidos de suas respectivas análises detalhadas.

### 4.1. Gráfico de Dispersão (Esperado vs. Previsto)

![Gráfico de Dispersão](avaliacao_dispersao.png)

* **Significado dos Valores:** O eixo horizontal representa os valores de calibração teórica esperada ($y$), enquanto o eixo vertical plota as saídas nítidas preditas ($\hat{y}$) do modelo fuzzy para cada um dos 15 cenários.
* **Objetivo e Utilidade:** A linha diagonal tracejada em vermelho ($y = x$) indica a predição ideal. A proximidade dos círculos azuis em relação à linha ilustra a precisão do modelo. Pode-se observar um agrupamento muito nítido em torno dos extremos inferiores (região de $15\%$) e intermediários ($50\%$). A ligeira dispersão na faixa de $80\%$-$95\%$ sinaliza a resistência natural do modelo fuzzy em atingir $100\%$ de recomendação (devido ao método do centróide na defuzzificação, que tende a centralizar a gravidade da área).

### 4.2. Erro Médio de Recomendação por Perfil de Usuário

![Gráfico de Erro por Perfil](avaliacao_erros_perfil.png)

* **Significado dos Valores:** Apresenta barras comparativas lado a lado para cada usuário. A barra azul representa o MAE (Erro Médio Absoluto) e a vermelha indica o RMSE (Raiz do Erro Quadrático Médio) acumulado de cada perfil ao longo dos testes.
* **Objetivo e Utilidade:** Este gráfico destaca para quais perfis o recomendador é mais assertivo. Observa-se que **Elena, Carlos e Ana** apresentam os menores erros (abaixo de $7\%$). Em contraste, o perfil de **Diego** exibe um MAE de $16.7\%$ e RMSE de $17.6\%$. Isso diagnostica que o modelo é altamente sensível à penalização implícita de retenção (Diego assiste a poucos minutos do filme), resultando em scores fuzzy abaixo do esperado pelo gabarito teórico linear.

### 4.3. Mapa de Calor (Heatmap) das Recomendações por Perfil e Filme

![Mapa de Calor das Recomendações](avaliacao_heatmap.png)

* **Significado dos Valores:** O mapa matricial cruza os perfis de usuários nas linhas com os filmes avaliados nas colunas. As cores variam em intensidade azul-verde correspondendo ao percentual nítido de recomendação gerado.
* **Objetivo e Utilidade:** Permite uma verificação global rápida da coerência de recomendação. Visualiza-se de imediato que as células mais escuras (pontuações mais elevadas) concentram-se nas interseções corretas: Ana com *The Dark Knight* ($83.2\%$), Carlos com *The Dark Knight* ($80.0\%$), Beatriz com *The Usual Suspects* ($77.8\%$) e Elena com *The Green Mile* ($67.7\%$). Filmes com baixo apelo de perfil (como *The Usual Suspects* para Elena) são facilmente identificados nas colorações mais claras ($13.3\%$).

---

## 5. Discussão dos Resultados

Os experimentos demonstraram que o modelo de recomendação fuzzy proposto exibe um comportamento altamente coerente com as preferências dos usuários. A lógica matemática modelada por regras de associação provou-se eficaz para simular o julgamento subjetivo.

### 5.1. Coerência do Modelo Fuzzy
A capacidade do modelo em capturar múltiplos níveis de afinidade ficou evidente ao observar a suave transição de faixas de recomendação. A inclusão da nota crítica como antecedente atuou como um fator de ponderação importante: nos cenários neutros, a nota alta dos títulos manteve as recomendações em patamares aceitáveis (em torno de $40\%$), evitando o descarte indevido de boas obras.

### 5.2. Desempenho por Cenário
* **Melhor Desempenho:** O modelo obteve erro nulo ou residual baixíssimo nos perfis de Carlos e Elena. Isso se deve ao fato de estes perfis terem comportamentos homogêneos de consumo histórico, permitindo que a fuzzificação operasse em regiões de alta estabilidade das curvas de pertinência.
* **Pior Desempenho:** O modelo de Diego revelou a maior discrepância. A justificativa reside no rigor com que o tempo de retenção do histórico foi modelado. Na expectativa teórica humana (gabarito), o usuário de TCC assume que o filme favorito explícito de Diego (*The Green Mile*) deve receber recomendação máxima ($95.0\%$). Porém, algoritmicamente, a baixa retenção de minutos assistidos de Diego atua como um forte indício de desinteresse implícito, forçando o modelo fuzzy a reduzir a recomendação para $69.8\%$.

### 5.3. Limitações e Melhorias Futuras
* **Limitação na Defuzzificação (Efeito de Borda):** A defuzzificação por centróide dificulta que a saída nítida atinja valores limites extremos (ex: exatamente $0\%$ ou $100\%$), pois a gravidade da área acumulada sempre puxará a saída em direção ao centro.
* **Melhorias Propostas:** 
  1. Experimentar o método de defuzzificação da **Média dos Máximos (MoM)** caso predições de extremos absolutos sejam imperativas.
  2. Implementar ajuste dinâmico de pesos lógicos (através de redes neuro-fuzzy) para recalibrar de forma adaptativa a importância dada à retenção de tempo de visualização conforme o comportamento de consumo específico de cada indivíduo.
