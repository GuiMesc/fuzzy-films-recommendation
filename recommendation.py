import numpy as np
import skfuzzy as fuzz
from skfuzzy import control as ctrl
import matplotlib.pyplot as plt
import requests

def login():
    login_body = {
        "email": "guilherme@mail.com",
        "password": "12345678"
    }

    login_request = requests.post("http://localhost:3000/auth/login", json=login_body)
    login_data = login_request.json()

    access_token = login_data.get('access_token')
    if access_token:
        return access_token
    else:
        print("Token não encontrado")
        return None

def get_history(token):
    headers = {
        'Authorization': f'Bearer {token}'
    }

    history_request = requests.get("http://localhost:3000/historic", headers=headers)
    history_data = history_request.json()

    if history_data:
        return history_data
    else:
        print("Histórico não encontrado")
        return None

def get_movies(token):
    headers = {
        'Authorization': f'Bearer {token}'
    }

    movies_request = requests.get("http://localhost:3000/movie", headers=headers)
    movies_data = movies_request.json()

    if movies_data:
        return movies_data
    else:
        print("Filmes não encontrados")
        return None

# Valor alvo é um atributo do filme candidato
def calcular_afinidade(historico_filmes, chave, valor_alvo, index):
    movie = []
    for h in historico_filmes:
        movie.append(h.get("movies"))
        #print("Historico: ", h)

    filmes_filtrados = [h for h in historico_filmes if h["movies"][chave][index]["name"] == valor_alvo]
    print("Filmes filtrados: ", filmes_filtrados)

    #filmes_filtrados = [filme for filme in historico_filmes if filme[chave] == valor_alvo]

    if len(filmes_filtrados) == 0:
        return 0

    qtd_total = len(historico_filmes)
    qtd_filtrada = len(filmes_filtrados)
    Q = qtd_filtrada / qtd_total
    print("Quantidade total de filmes no histórico: ", qtd_total)
    print("Quantidade de filmes filtrados: ", qtd_filtrada)
    print("Porcentagem de filmes filtrados: ", Q)

    media_notas = np.mean([h['movies']['average'] for h in filmes_filtrados])
    N = media_notas / 10
    print("Média de notas dos filmes filtrados: ", media_notas)
    print("Porcentagem da média de notas: ", N)

    media_tempo = np.mean([h['minutes_watched'] / h['movies']['duration'] for h in filmes_filtrados])
    print("Média de tempo dos filmes filtrados: ", media_tempo)
    T = min(media_tempo, 1)
    print("Porcentagem da média de tempo: ", T)

    media_curtidas = np.mean([h['like'] for h in filmes_filtrados])
    C = media_curtidas
    print("Média de curtidas dos filmes filtrados: ", media_curtidas)
    print("Porcentagem da média de curtidas: ", C)

    afinidade = 0.4 * Q + 0.3 * N + 0.2 * T + 0.1 * C
    print("Afinidade: ", afinidade)

    return round(afinidade, 2)

def plotar_pertinencia(universo, baixo, medio, alto, valor, titulo):
    plt.figure(figsize=(10,5))
    plt.plot(universo, baixo.mf, label='Baixa')
    plt.plot(universo, medio.mf, label='Média')
    plt.plot(universo, alto.mf, label='Alta')
    plt.axvline(valor, color='black', linestyle='--', label=f'Valor={valor:.2f}')
    plt.title(titulo)
    plt.xlabel("Valor")
    plt.ylabel("Pertinência")

    plt.grid()
    plt.legend()

    plt.show()

if __name__ == '__main__':
    token = login()
    if token:
        history = get_history(token)
        movies = get_movies(token)

        # if movies:
        #     for movie in movies:
        #         print("Filme do Catálogo: ", movie)
        # else:
        #     print("Não foi possível buscar os filmes")

        # if history:
        #     for h in history:
        #         print("Filme do Histórico: ", h)
        # else:
        #     print("Não foi possível buscar o histórico")
    else:
        print("Não foi possível fazer login")
    
    for index, movie in enumerate(movies):
        if index == len(movie.get("genders")):
            break
        afinidade_genero = calcular_afinidade(history, 'genders', movie['genders'][index]['name'], index)
        afinidade_ator = calcular_afinidade(history, 'actors', movie['actors'][index]['name'], index)
        afinidade_diretor = calcular_afinidade(history, 'directors', movie['directors'][index]['name'], index)
        #calcular_afinidade(history, 'average', movie['average'], index)
    
    genero_valor = afinidade_genero * 10
    diretor_valor = afinidade_diretor * 10
    ator_valor = afinidade_ator * 10

    # Variáveis Fuzzy
    genero = ctrl.Antecedent(np.arange(0, 11, 1),'genero')
    diretor = ctrl.Antecedent(np.arange(0, 11, 1), 'diretor')
    ator = ctrl.Antecedent(np.arange(0, 11, 1), 'ator')
    #nota = ctrl.Antecedent(np.arange(0, 11, 1), 'nota')

    recomendacao = ctrl.Consequent(np.arange(0, 101, 1),'recomendacao')

    # Funções de Pertinência
    variaveis = [genero, diretor, ator]

    for variavel in variaveis:
        variavel['baixa'] = fuzz.trimf(variavel.universe,[0, 0, 5])
        variavel['media'] = fuzz.trimf(variavel.universe,[2, 5, 8])
        variavel['alta'] = fuzz.trimf(variavel.universe,[5, 10, 10])

    # Nota

    # nota['ruim'] = fuzz.trimf(nota.universe,[0, 0, 5])
    # nota['boa'] = fuzz.trimf(nota.universe,[4, 6, 8])
    # nota['excelente'] = fuzz.trimf(nota.universe,[7, 10, 10])

    # Recomendação

    recomendacao['baixa'] = fuzz.trimf(recomendacao.universe,[0, 0, 40])
    recomendacao['media'] = fuzz.trimf(recomendacao.universe,[30, 50, 70])
    recomendacao['alta'] = fuzz.trimf(recomendacao.universe,[60, 80, 100])
    recomendacao['muito_alta'] = fuzz.trimf(recomendacao.universe,[80, 100, 100])

    # Regras Fuzzy

    regra1 = ctrl.Rule(genero['alta'] & diretor['alta'] & nota['excelente'],recomendacao['muito_alta'])
    regra2 = ctrl.Rule(genero['alta'] & nota['boa'],recomendacao['alta'])
    regra3 = ctrl.Rule(diretor['media'] & nota['boa'],recomendacao['media'])
    regra4 = ctrl.Rule(genero['baixa'] & nota['ruim'],recomendacao['baixa'])
    regra5 = ctrl.Rule(nota['excelente'],recomendacao['alta'])
    regra6 = ctrl.Rule(ator['alta'] & nota['excelente'],recomendacao['muito_alta'])
    regra7 = ctrl.Rule(genero['alta'] & diretor['alta'] & ator['alta'],recomendacao['muito_alta'])

    # SISTEMA FUZZY

    sistema_controle = ctrl.ControlSystem([regra1, regra2, regra3, regra4, regra5, regra6, regra7])

    sistema = ctrl.ControlSystemSimulation(sistema_controle)

    # ENTRADAS DO SISTEMA

    sistema.input['genero'] = genero_valor
    sistema.input['diretor'] = diretor_valor
    sistema.input['ator'] = ator_valor
    # sistema.input['nota'] = nota_valor

    # PROCESSAMENTO

    sistema.compute()

    # RESULTADO

    resultado = sistema.output['recomendacao']

    print("\n====================================================")
    print("RESULTADO FINAL")
    print("====================================================")

    print(f"\nPercentual de recomendação: {resultado:.2f}%")
    