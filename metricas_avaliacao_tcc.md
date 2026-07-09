# Métricas de Avaliação do Sistema de Recomendação

Esta seção descreve os fundamentos teóricos e práticos adotados para avaliar o desempenho do sistema de recomendação desenvolvido, detalhando a natureza do modelo, a estratégia de teste e validação formulada, as equações das métricas estatísticas aplicadas e a interpretação dos resultados visuais gerados.

---

## 1. Proposta do Sistema: Modelo de Pontuação (*Scoring*)

Ao contrário de sistemas puramente classificadores — cujo objetivo principal é catalogar elementos em categorias discretas e mutuamente exclusivas (como "recomendar" versus "não recomendar") —, a proposta deste sistema de recomendação baseia-se em um **modelo de pontuação (*scoring model*)**.

O controlador lógico fuzzy implementado atua na predição de um índice contínuo de afinidade estruturado em uma escala de $0\%$ a $100\%$, em que a magnitude da saída indica a intensidade da recomendação. Essa modelagem matemática aproxima-se de um problema de **regressão**, no qual se busca estimar um valor numérico real. A preferência por um modelo de pontuação em detrimento de uma classificação discreta justifica-se pelos seguintes pontos:
* **Granularidade da Recomendação:** Permite ao usuário ordenar a fila de exibição com base em uma escala contínua de preferência, refinando a ordenação de filmes que, sob uma classificação binária, receberiam rótulos idênticos.
* **Transparência e Explicabilidade:** O percentual contínuo gerado permite expressar nuances lógicas que auxiliam a justificar o porquê de um determinado título ser ligeiramente mais recomendado que outro.

---

## 2. Estratégia de Validação

A estratégia de validação do sistema consiste na definição e execução de um conjunto representativo de casos de teste controlados. Para isso, são utilizados perfis de usuários simulados e filmes do catálogo com atributos previamente mapeados, permitindo isolar e testar as respostas do sistema frente a diferentes dinâmicas de histórico e preferência.

A validação ocorre por meio das seguintes etapas:
1. **Definição de Cenários de Teste:** O arquivo de configuração contém casos de teste explícitos associando uma tupla `(Usuário, Filme)` a um percentual de recomendação ideal esperado (*ground truth*), previamente calibrado por especialistas ou com base em análises heurísticas.
2. **Execução Isolada da Simulação:** Para cada cenário, o motor fuzzy do sistema calcula o score predito com base no histórico de visualização do usuário específico, nos pesos do seu perfil declarado e nos metadados do filme.
3. **Avaliação dos Desvios:** O valor predito ($\hat{y}$) é contrastado com o valor de referência esperado ($y$), gerando uma diferença residual absoluta. Esse conjunto de resíduos alimenta o cálculo das métricas de regressão globais.

---

## 3. Métricas de Avaliação Lógica (MAE e RMSE)

A avaliação estatística do desempenho baseia-se no cálculo do erro entre os percentuais esperados e previstos. Foram adotadas duas métricas complementares consagradas na literatura de sistemas de recomendação e regressão: **MAE** (*Mean Absolute Error*) e **RMSE** (*Root Mean Squared Error*).

### 3.1. Erro Médio Absoluto (MAE)

O MAE mede a magnitude média dos erros em um conjunto de previsões, sem considerar sua direção (sinal positivo ou negativo). Ele representa a média das diferenças absolutas entre as previsões e os valores reais.

#### Equação:
$$\text{MAE} = \frac{1}{n} \sum_{i=1}^{n} |y_i - \hat{y}_i|$$

#### Significado dos Termos:
* $n$: Número total de cenários avaliados no teste.
* $\sum_{i=1}^{n}$: Operador de somatório, que acumula o erro individual de cada cenário $i$ de $1$ até $n$.
* $y_i$: O percentual de recomendação esperado (*ground truth*) definido para o cenário $i$.
* $\hat{y}_i$: O percentual de recomendação previsto (*score* defuzzificado) pelo sistema para o cenário $i$.
* $|y_i - \hat{y}_i|$: O valor absoluto do resíduo (erro residual positivo), impedindo que erros positivos e negativos se cancelem mutuamente no somatório.

#### Vantagens e Desvantagens:
* **Vantagens:** É de fácil interpretação intuitiva, pois a unidade do erro permanece na mesma escala percentual dos dados avaliados. Além disso, o MAE é linear e robusto a valores discrepantes (*outliers*), atribuindo o mesmo peso relativo a todos os erros individuais.
* **Desvantagens:** Por ser linear, o MAE não penaliza erros de grande magnitude de forma diferenciada. Um erro de $40\%$ possui o mesmo peso relativo que quatro erros individuais de $10\%$, embora uma discrepância de $40\%$ no mundo real costume ser muito mais prejudicial à experiência do usuário.

---

### 3.2. Raiz do Erro Quadrático Médio (RMSE)

O RMSE é uma métrica quadrática que mede a raiz da média das diferenças ao quadrado entre a previsão do modelo e o valor real.

#### Equação:
$$\text{RMSE} = \sqrt{\frac{1}{n} \sum_{i=1}^{n} (y_i - \hat{y}_i)^2}$$

#### Significado dos Termos:
* $n$: Número total de cenários avaliados no teste.
* $\sum_{i=1}^{n}$: Operador de somatório de todos os erros quadráticos individuais.
* $y_i$: O percentual de recomendação esperado para o cenário $i$.
* $\hat{y}_i$: O percentual de recomendação previsto pelo sistema para o cenário $i$.
* $(y_i - \hat{y}_i)^2$: O erro residual individual elevado ao quadrado. Esta operação garante que todos os termos sejam positivos e atribui pesos progressivamente maiores a erros maiores.
* $\sqrt{\dots}$: A extração da raiz quadrada retorna a métrica à unidade dimensional original (percentual).

#### Vantagens e Desvantagens:
* **Vantagens:** Altamente sensível a grandes desvios e erros severos de previsão, uma vez que a elevação ao quadrado penaliza desproporcionalmente as previsões muito distantes do gabarito. É a métrica mais indicada quando desvios grandes são considerados críticos e inaceitáveis no sistema.
* **Desvantagens:** É muito vulnerável a ruídos e *outliers*. Um único erro de grande magnitude pode inflacionar consideravelmente o índice final, mascarando um modelo que, na maior parte dos cenários, apresenta erros baixos.

---

## 4. Apresentação Visual dos Resultados

A fim de fornecer um diagnóstico completo da distribuição do erro e do comportamento da inferência lógica, a ferramenta de avaliação gera automaticamente três representações visuais complementares:

### 4.1. Gráfico de Dispersão (Scatter Plot: Esperado vs. Previsto)
* **Motivo:** Permite correlacionar o comportamento do modelo em toda a sua amplitude de escala (de $0\%$ a $100\%$).
* **Utilidade:** O gráfico apresenta cada par avaliado como um ponto bidimensional em relação a uma reta ideal tracejada onde $y = x$ (reta da perfeição). Pontos muito distantes da diagonal revelam cenários específicos de falha de calibração ou regras lógicas em conflito. A dispersão ajuda a diagnosticar visualmente a tendência do sistema em subestimar ou superestimar predições de forma global.

### 4.2. Gráfico de Barras de Erros por Perfil
* **Motivo:** O sistema fuzzy consome perfis de usuários com históricos de engajamento heterogêneos. Faz-se necessário mapear a consistência do sistema de forma segmentada.
* **Utilidade:** Apresenta barras lado a lado mostrando o MAE e o RMSE médio individualizados para cada usuário de teste (ex: Ana, Carlos, Beatriz, etc.). Este gráfico ajuda a identificar se há perfis de comportamento em que o modelo falha consistentemente mais (sugerindo a necessidade de novas variáveis lógicas ou novos graus de pertinência fuzzy para cobrir determinados comportamentos de consumo).

### 4.3. Mapa de Calor (Heatmap) das Recomendações
* **Motivo:** Avaliar a matriz cruzada global de inferências de maneira agregada.
* **Utilidade:** Cruza os usuários no eixo vertical e os filmes de teste no eixo horizontal, exibindo o score final previsto em cada célula acompanhado de um gradiente de cor. A análise visual do mapa de calor ajuda a validar se os mecanismos de preferência e afinidade de perfil estão se propagando corretamente no sistema (ex: confirmando se o sistema atribui percentuais de recomendação elevados apenas para títulos que realmente correspondem ao perfil de consumo do indivíduo).
