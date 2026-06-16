import numpy as np
import skfuzzy as fuzz
from skfuzzy import control as ctrl
import matplotlib.pyplot as plt
import psycopg2
import psycopg2.extras

DB_CONFIG = {
    "host": "localhost",
    "port": 5432,
    "database": "recommendation_films_db",
    "user": "postgres",
    "password": "root"
}

def get_db_connection():
    return psycopg2.connect(**DB_CONFIG)

def get_user_id_by_name(name="Guilherme"):
    conn = get_db_connection()
    try:
        with conn.cursor() as cursor:
            cursor.execute("SELECT id FROM tbl_users WHERE name = %s LIMIT 1;", (name,))
            row = cursor.fetchone()
            return row[0] if row else None
    except Exception as e:
        print(f"Erro ao buscar usuário: {e}")
        return None
    finally:
        conn.close()

def get_history(user_id):
    conn = get_db_connection()
    try:
        with conn.cursor(cursor_factory=psycopg2.extras.RealDictCursor) as cursor:
            cursor.execute(
                """
                SELECT 
                    h.user_average,
                    h.minutes_watched,
                    h.liked,
                    m.duration,
                    COALESCE(
                        (SELECT json_agg(json_build_object('name', g.name)) 
                         FROM tbl_movie_gender mg 
                         JOIN tbl_genders g ON mg.gender_id = g.id 
                         WHERE mg.movie_id = m.id), 
                        '[]'::json
                    ) as genders,
                    COALESCE(
                        (SELECT json_agg(json_build_object('name', a.name)) 
                         FROM tbl_movie_actor ma 
                         JOIN tbl_actors a ON ma.actor_id = a.id 
                         WHERE ma.movie_id = m.id), 
                        '[]'::json
                    ) as actors,
                    COALESCE(
                        (SELECT json_agg(json_build_object('name', d.name)) 
                         FROM tbl_movie_director md 
                         JOIN tbl_directors d ON md.director_id = d.id 
                         WHERE md.movie_id = m.id), 
                        '[]'::json
                    ) as directors
                FROM tbl_historic h
                JOIN tbl_movies m ON h.movie_id = m.id
                WHERE h.user_id = %s;
                """,
                (user_id,)
            )
            rows = cursor.fetchall()
            
            history_data = []
            for row in rows:
                history_data.append({
                    'user_average': row['user_average'],
                    'minutes_watched': row['minutes_watched'],
                    'like': row['liked'],
                    'movies': {
                        'duration': row['duration'],
                        'genders': row['genders'],
                        'actors': row['actors'],
                        'directors': row['directors']
                    }
                })
            return history_data
    except Exception as e:
        print(f"Erro ao buscar histórico: {e}")
        return None
    finally:
        conn.close()

def get_movies():
    conn = get_db_connection()
    try:
        with conn.cursor(cursor_factory=psycopg2.extras.RealDictCursor) as cursor:
            cursor.execute(
                """
                SELECT 
                    m.id,
                    m.title,
                    m.description,
                    m.duration,
                    m.released_year,
                    m.average,
                    COALESCE(
                        (SELECT json_agg(json_build_object('name', g.name)) 
                         FROM tbl_movie_gender mg 
                         JOIN tbl_genders g ON mg.gender_id = g.id 
                         WHERE mg.movie_id = m.id), 
                        '[]'::json
                    ) as genders,
                    COALESCE(
                        (SELECT json_agg(json_build_object('name', a.name)) 
                         FROM tbl_movie_actor ma 
                         JOIN tbl_actors a ON ma.actor_id = a.id 
                         WHERE ma.movie_id = m.id), 
                        '[]'::json
                    ) as actors,
                    COALESCE(
                        (SELECT json_agg(json_build_object('name', d.name)) 
                         FROM tbl_movie_director md 
                         JOIN tbl_directors d ON md.director_id = d.id 
                         WHERE md.movie_id = m.id), 
                        '[]'::json
                    ) as directors
                FROM tbl_movies m;
                """
            )
            return cursor.fetchall()
    except Exception as e:
        print(f"Erro ao buscar filmes: {e}")
        return None
    finally:
        conn.close()

def save_recommendations(user_id, recommendations):
    conn = get_db_connection()
    try:
        with conn.cursor() as cursor:
            for rec in recommendations:
                cursor.execute(
                    """
                    INSERT INTO tbl_recommendations (user_id, movie_id, recommendation_score)
                    VALUES (%s, %s, %s)
                    ON CONFLICT (user_id, movie_id)
                    DO UPDATE SET recommendation_score = EXCLUDED.recommendation_score;
                    """,
                    (user_id, rec['movieId'], rec['recommendation_score'])
                )
        conn.commit()
        print("Recomendações registradas com sucesso no banco de dados!")
    except Exception as e:
        conn.rollback()
        print(f"Erro ao salvar recomendações no banco: {e}")
    finally:
        conn.close()

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

    media_notas = np.mean([h['user_average'] for h in filmes_filtrados])
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
    user_id = get_user_id_by_name("Guilherme") or 1

    history = get_history(user_id)
    movies = get_movies()

    if not history or not movies:
        print("Não foi possível buscar os dados do banco de dados")
        exit(1)

    # ── Variáveis Fuzzy (construídas uma única vez) ──────────────────────────
    genero = ctrl.Antecedent(np.arange(0, 11, 1), 'genero')
    diretor = ctrl.Antecedent(np.arange(0, 11, 1), 'diretor')
    ator = ctrl.Antecedent(np.arange(0, 11, 1), 'ator')
    nota = ctrl.Antecedent(np.arange(0, 11, 1), 'nota')

    recomendacao = ctrl.Consequent(np.arange(0, 101, 1), 'recomendacao')

    # Funções de Pertinência
    for variavel in [genero, diretor, ator]:
        variavel['baixa'] = fuzz.trimf(variavel.universe, [0, 0, 5])
        variavel['media'] = fuzz.trimf(variavel.universe, [2, 5, 8])
        variavel['alta'] = fuzz.trimf(variavel.universe, [5, 10, 10])

    nota['ruim']      = fuzz.trimf(nota.universe, [0, 0, 5])
    nota['boa']       = fuzz.trimf(nota.universe, [4, 6, 8])
    nota['excelente'] = fuzz.trimf(nota.universe, [7, 10, 10])

    recomendacao['baixa']      = fuzz.trimf(recomendacao.universe, [0,  0,   40])
    recomendacao['media']      = fuzz.trimf(recomendacao.universe, [30, 50,  70])
    recomendacao['alta']       = fuzz.trimf(recomendacao.universe, [60, 80, 100])
    recomendacao['muito_alta'] = fuzz.trimf(recomendacao.universe, [80, 100, 100])

    # Regras Fuzzy
    regra1 = ctrl.Rule(genero['alta'] & diretor['alta'] & nota['excelente'], recomendacao['muito_alta'])
    regra2 = ctrl.Rule(genero['alta'] & nota['boa'],                         recomendacao['alta'])
    regra3 = ctrl.Rule(diretor['media'] & nota['boa'],                       recomendacao['media'])
    regra4 = ctrl.Rule(genero['baixa'] & nota['ruim'],                       recomendacao['baixa'])
    regra5 = ctrl.Rule(nota['excelente'],                                    recomendacao['alta'])
    regra6 = ctrl.Rule(ator['alta'] & nota['excelente'],                     recomendacao['muito_alta'])
    regra7 = ctrl.Rule(genero['alta'] & diretor['alta'] & ator['alta'],      recomendacao['muito_alta'])

    sistema_controle = ctrl.ControlSystem([regra1, regra2, regra3, regra4, regra5, regra6, regra7])

    # ── Loop por cada filme do catálogo ─────────────────────────────────────
    resultados = []

    for movie in movies:
        # Usa sempre o índice 0 (primeiro gênero/ator/diretor do filme)
        attr_index = 0

        afinidade_genero  = calcular_afinidade(history, 'genders',   movie['genders'][attr_index]['name'],   attr_index) if movie.get('genders')   else 0
        afinidade_ator    = calcular_afinidade(history, 'actors',    movie['actors'][attr_index]['name'],    attr_index) if movie.get('actors')    else 0
        afinidade_diretor = calcular_afinidade(history, 'directors', movie['directors'][attr_index]['name'], attr_index) if movie.get('directors') else 0
        nota_filme        = movie['average'] / 10

        sistema = ctrl.ControlSystemSimulation(sistema_controle)
        sistema.input['genero']  = afinidade_genero  * 10
        sistema.input['diretor'] = afinidade_diretor * 10
        sistema.input['ator']    = afinidade_ator    * 10
        sistema.input['nota']    = nota_filme        * 10

        try:
            sistema.compute()
            percentual = round(sistema.output['recomendacao'], 2)
        except Exception as e:
            print(f"[AVISO] Nenhuma regra ativada para '{movie['title']}': {e}")
            percentual = 0.0

        resultados.append({
            'id':                 movie['id'],
            'title':              movie['title'],
            'description':        movie.get('description', ''),
            'average':            movie['average'],
            'genders':            movie.get('genders', []),
            'actors':             movie.get('actors', []),
            'directors':          movie.get('directors', []),
            'recommendation_score': percentual
        })

    # Ordena do mais recomendado para o menos recomendado
    resultados.sort(key=lambda x: x['recommendation_score'], reverse=True)

    # ── Resultado final ──────────────────────────────────────────────────────
    print("\n====================================================")
    print("RESULTADO FINAL - RECOMENDAÇÕES POR FILME")
    print("====================================================\n")

    for r in resultados:
        generos   = ', '.join(g['name'] for g in r['genders'])
        diretores = ', '.join(d['name'] for d in r['directors'])
        atores    = ', '.join(a['name'] for a in r['actors'])
        print(f"   {r['title']}")
        print(f"   Gênero(s)  : {generos}")
        print(f"   Diretor(es): {diretores}")
        print(f"   Ator(es)   : {atores}")
        print(f"   Nota média : {r['average']}")
        print(f"   Recomendação: {r['recommendation_score']:.2f}%")
        print()

    # ── Salvar recomendações no banco ────────────────
    if resultados:
        movies_payload = [
            {
                "movieId": r['id'],
                "recommendation_score": round(float(r['recommendation_score']), 2)
            }
            for r in resultados
        ]

        print("=====================================================")
        print("SALVANDO RECOMENDAÇÃO NO BANCO DE DADOS")
        print("=====================================================")
        for m in movies_payload:
            print(f"  movieId: {m['movieId']}  |  score: {m['recommendation_score']}")

        save_recommendations(user_id, movies_payload)