import numpy as np
import skfuzzy as fuzz
from skfuzzy import control as ctrl
import matplotlib.pyplot as plt
from movies import movies
from historico import historico

count_acao = 0
for h in historico:
    print(h)
    if (h['acao'] == 10):
        count_acao+=1

# Valor entr 0.0 e 1.0
interesse_usuario = count_acao / len(historico)
deslocamento = round(interesse_usuario * 3, 2)

acao = ctrl.Antecedent(np.arange(0,11,1), 'ACAO')
recomendacao = ctrl.Consequent(np.arange(0,101,1), 'RECOMENDACAO')

acao['BAIXA'] = fuzz.trimf(acao.universe, [0, 0, max(1, 5 - deslocamento)])
acao['MÉDIA'] = fuzz.trimf(acao.universe, [max(0, 2 - deslocamento), 5, 8])
acao['ALTA']  = fuzz.trimf(acao.universe, [max(0, 5 - deslocamento), 10, 10])

recomendacao['NÃO RECOMENDAR'] = fuzz.trimf(recomendacao.universe, [0,0,50])
recomendacao['RECOMENDAR'] = fuzz.trimf(recomendacao.universe, [25,50,80])
recomendacao['RECOMENDAR MUITO'] = fuzz.trimf(recomendacao.universe, [50,100,100])

acao.view()
plt.savefig("grafico.png")

print("O numero de filmes de Ação assistidos foi de: ", count_acao)
print("O interesse do usuário em filmes de ação é de: ", interesse_usuario)

rule1 = ctrl.Rule(acao['ALTA'], recomendacao['RECOMENDAR MUITO'])
rule2 = ctrl.Rule(acao['MÉDIA'], recomendacao['RECOMENDAR'])
rule3 = ctrl.Rule(acao['BAIXA'], recomendacao['NÃO RECOMENDAR'])

recomendacao_ctrl = ctrl.ControlSystem([rule1, rule2, rule3])
recomendacao_simulador = ctrl.ControlSystemSimulation(recomendacao_ctrl)

filme = movies[3]
print("Filmes dado para análise: ", filme)
recomendacao_simulador.input['ACAO'] = filme['acao']
recomendacao_simulador.compute()
acao.view(sim=recomendacao_simulador)
plt.savefig("grafico_resultado.png")

print("Recomendação:", recomendacao_simulador.output['RECOMENDACAO'], "%")