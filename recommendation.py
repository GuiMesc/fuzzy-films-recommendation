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

query_get_movies = """
SELECT 
    m.id,
    m.title,
    m.description,
    m.duration,
    m.released_year,
    m.average,
    COALESCE(
        (
            SELECT json_agg(json_build_object('name', g.name))
            FROM tbl_movie_gender mg
            INNER JOIN tbl_genders g
                ON mg.gender_id = g.id
            WHERE mg.movie_id = m.id
        ),
        '[]'::json
    ) AS genders,
    COALESCE(
        (
            SELECT json_agg(json_build_object('name', a.name))
            FROM tbl_movie_actor ma
            INNER JOIN tbl_actors a
                ON ma.actor_id = a.id
            WHERE ma.movie_id = m.id
        ),
        '[]'::json
    ) AS actors,
    COALESCE(
        (
            SELECT json_agg(json_build_object('name', d.name))
            FROM tbl_movie_director md
            INNER JOIN tbl_directors d
                ON md.director_id = d.id
            WHERE md.movie_id = m.id
        ),
        '[]'::json
    ) AS directors
FROM tbl_movies m
WHERE m.id = 280;
"""

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

def get_movies(query):
    conn = get_db_connection()
    try:
        with conn.cursor(cursor_factory=psycopg2.extras.RealDictCursor) as cursor:
            cursor.execute(query)
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

def get_user_profile(user_id):
    """Retorna o perfil declarado do usuário (favoritos de ator, diretor e gênero)."""
    conn = get_db_connection()
    try:
        with conn.cursor(cursor_factory=psycopg2.extras.RealDictCursor) as cursor:
            cursor.execute(
                """
                SELECT
                    g.name  AS favorite_gender,
                    a.name  AS favorite_actor,
                    d.name  AS favorite_director
                FROM tbl_users u
                LEFT JOIN tbl_genders   g ON g.id = u.favorite_gender_id
                LEFT JOIN tbl_actors    a ON a.id = u.favorite_actor_id
                LEFT JOIN tbl_directors d ON d.id = u.favorite_director_id
                WHERE u.id = %s;
                """,
                (user_id,)
            )
            row = cursor.fetchone()
            return dict(row) if row else {}
    except Exception as e:
        print(f"Erro ao buscar perfil do usuário: {e}")
        return {}
    finally:
        conn.close()


def calcular_input_com_perfil(score_historico, nome_favorito, lista_itens_filme,
                              peso_historico=0.6, peso_perfil=0.4):
    """
    Combina o score do histórico (0-10) com o sinal do perfil declarado.
    Quando o favorito do usuário está no filme, o sinal de perfil vale 10;
    caso contrário, vale 0. A média ponderada garante que o match de perfil
    sempre eleva o input para a zona correta das funções de pertinência fuzzy.
    """
    perfil_score = 10.0 if (nome_favorito and any(
        item['name'] == nome_favorito for item in lista_itens_filme
    )) else 0.0
    return round(peso_historico * score_historico + peso_perfil * perfil_score, 2)


# valores_alvo é a lista completa de atributos do filme candidato (ex: todos os gêneros)
def calcular_afinidade(historico_filmes, chave, valores_alvo):
    nomes_alvo = {item['name'] for item in valores_alvo}
    print("\n\nNomes alvo: ", nomes_alvo)

    filmes_filtrados = [
        h for h in historico_filmes
        if any(item['name'] in nomes_alvo for item in h["movies"].get(chave, []))
    ]
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

def plotar_pertinencia(variaveis_entrada, consequente, valores_entrada, valor_saida, titulo, output_dir="fuzzy_plots"):
    """
    Gera e salva um PNG com os conjuntos fuzzy de todas as variáveis
    e as operações realizadas na inferência:
      - Funções de pertinência de cada antecedente e do consequente
      - Valor de entrada de cada antecedente (linha vertical tracejada)
      - Grau de pertinência em cada conjunto para o valor de entrada
      - Valor defuzzificado de saída destacado no consequente
    """
    import os
    os.makedirs(output_dir, exist_ok=True)

    entradas_items = list(variaveis_entrada.items())
    n = len(entradas_items) + 1  # antecedentes + 1 consequente
    fig, axes = plt.subplots(1, n, figsize=(5 * n, 4))
    if n == 1:
        axes = [axes]

    # ── Antecedentes ────────────────────────────────────────────────────────
    for ax, (nome, variavel) in zip(axes[:-1], entradas_items):
        universo = variavel.universe
        valor = valores_entrada.get(nome)

        for termo_nome, termo in variavel.terms.items():
            ax.plot(universo, termo.mf, linewidth=2, label=termo_nome)

        if valor is not None:
            ax.axvline(valor, color='black', linestyle='--', linewidth=1.5,
                       label=f'Entrada = {valor:.2f}')
            for termo_nome, termo in variavel.terms.items():
                grau = fuzz.interp_membership(universo, termo.mf, valor)
                if grau > 0.02:
                    ax.plot(valor, grau, 'ko', markersize=5)
                    ax.annotate(
                        f'{grau:.2f}',
                        xy=(valor, grau),
                        xytext=(valor + 0.25, grau + 0.05),
                        fontsize=8,
                        color='black'
                    )

        ax.set_title(nome, fontsize=11, fontweight='bold')
        ax.set_xlabel("Valor")
        ax.set_ylabel("Pertinência")
        ax.set_ylim(-0.05, 1.2)
        ax.legend(fontsize=8)
        ax.grid(True, alpha=0.3)

    # ── Consequente (saída) ─────────────────────────────────────────────────
    ax_out = axes[-1]
    universo_saida = consequente.universe

    for termo_nome, termo in consequente.terms.items():
        ax_out.plot(universo_saida, termo.mf, linewidth=2, label=termo_nome)

    if valor_saida is not None:
        ax_out.axvline(valor_saida, color='black', linestyle='--', linewidth=1.5,
                       label=f'Saída = {valor_saida:.2f}%')
        ax_out.axvspan(0, valor_saida, alpha=0.08, color='black')

    ax_out.set_title(consequente.label.capitalize(), fontsize=11, fontweight='bold')
    ax_out.set_xlabel("Valor")
    ax_out.set_ylabel("Pertinência")
    ax_out.set_ylim(-0.05, 1.2)
    ax_out.legend(fontsize=8)
    ax_out.grid(True, alpha=0.3)

    # ── Título geral e salvamento ────────────────────────────────────────────
    fig.suptitle(titulo, fontsize=13, fontweight='bold')
    plt.tight_layout()

    nome_seguro = (
        titulo.replace(" ", "_")
               .replace("/", "-")
               .replace(":", "")
               .replace("\\", "")
    )
    caminho = os.path.join(output_dir, f"{nome_seguro}.png")
    plt.savefig(caminho, dpi=150, bbox_inches='tight')
    plt.close(fig)
    print(f"  [PLOT] Gráfico salvo: {caminho}")
    return caminho

if __name__ == '__main__':
    user_id = get_user_id_by_name("João")

    profile = get_user_profile(user_id)
    print("\n=====================================================")
    print("PERFIL DECLARADO DO USUÁRIO")
    print("=====================================================")
    print(f"  Gênero favorito  : {profile.get('favorite_gender')  or '(não definido)'}")
    print(f"  Ator favorito    : {profile.get('favorite_actor')    or '(não definido)'}")
    print(f"  Diretor favorito : {profile.get('favorite_director') or '(não definido)'}")

    history = get_history(user_id)
    movies = get_movies(query_get_movies)

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

    # Regras Fuzzy (base abrangente com conectores E e OU)

    # ── MUITO ALTA ────────────────────────────────────────────────────────────
    # R1: Os três pilares com alta afinidade (match completo de perfil)
    regra1 = ctrl.Rule(
        genero['alta'] & diretor['alta'] & ator['alta'],
        recomendacao['muito_alta']
    )
    # R2: Gênero E Diretor com alta afinidade E nota excelente
    regra2 = ctrl.Rule(
        genero['alta'] & diretor['alta'] & nota['excelente'],
        recomendacao['muito_alta']
    )
    # R3: Gênero E Ator com alta afinidade E nota excelente
    regra3 = ctrl.Rule(
        genero['alta'] & ator['alta'] & nota['excelente'],
        recomendacao['muito_alta']
    )
    # R4: Diretor E Ator com alta afinidade E nota excelente
    regra4 = ctrl.Rule(
        diretor['alta'] & ator['alta'] & nota['excelente'],
        recomendacao['muito_alta']
    )

    # ── ALTA ──────────────────────────────────────────────────────────────────
    # R5: Qualquer pilar com alta afinidade (OU) E nota excelente
    regra5 = ctrl.Rule(
        (genero['alta'] | diretor['alta'] | ator['alta']) & nota['excelente'],
        recomendacao['alta']
    )
    # R6: Gênero com alta afinidade E nota boa
    regra6 = ctrl.Rule(
        genero['alta'] & nota['boa'],
        recomendacao['alta']
    )
    # R7: Diretor com alta afinidade E nota boa
    regra7 = ctrl.Rule(
        diretor['alta'] & nota['boa'],
        recomendacao['alta']
    )
    # R8: Ator com alta afinidade E nota boa
    regra8 = ctrl.Rule(
        ator['alta'] & nota['boa'],
        recomendacao['alta']
    )
    # R9: Gênero alto E (Diretor OU Ator médios) E nota boa
    regra9 = ctrl.Rule(
        genero['alta'] & (diretor['media'] | ator['media']) & nota['boa'],
        recomendacao['alta']
    )
    # R10: Gênero médio E (Diretor OU Ator altos) E nota boa
    regra10 = ctrl.Rule(
        genero['media'] & (diretor['alta'] | ator['alta']) & nota['boa'],
        recomendacao['alta']
    )

    # ── MEDIA ─────────────────────────────────────────────────────────────────
    # R11: Qualquer pilar com afinidade média (OU) E nota boa
    regra11 = ctrl.Rule(
        (genero['media'] | diretor['media'] | ator['media']) & nota['boa'],
        recomendacao['media']
    )
    # R12: Qualquer pilar com alta afinidade (OU) E nota ruim (perfil ok, avaliação fraca)
    regra12 = ctrl.Rule(
        (genero['alta'] | diretor['alta'] | ator['alta']) & nota['ruim'],
        recomendacao['media']
    )
    # R13: Gênero médio E (Diretor OU Ator médios) — dois pilares medianos
    regra13 = ctrl.Rule(
        genero['media'] & (diretor['media'] | ator['media']),
        recomendacao['media']
    )
    # R14: Qualquer afinidade média (OU) E nota excelente (nota compensa afinidade mediana)
    regra14 = ctrl.Rule(
        (genero['media'] | diretor['media'] | ator['media']) & nota['excelente'],
        recomendacao['media']
    )
    # R15: Gênero baixo E (Diretor OU Ator baixos) E nota boa (nota salva parcialmente)
    regra15 = ctrl.Rule(
        genero['baixa'] & (diretor['baixa'] | ator['baixa']) & nota['boa'],
        recomendacao['media']
    )

    # ── BAIXA ─────────────────────────────────────────────────────────────────
    # R16: Os três pilares com baixa afinidade (nenhum indicador positivo)
    regra16 = ctrl.Rule(
        genero['baixa'] & diretor['baixa'] & ator['baixa'],
        recomendacao['baixa']
    )
    # R17: Gênero com baixa afinidade E nota ruim (principal pilar negativo)
    regra17 = ctrl.Rule(
        genero['baixa'] & nota['ruim'],
        recomendacao['baixa']
    )
    # R18: Diretor E Ator com baixa afinidade E nota ruim
    regra18 = ctrl.Rule(
        diretor['baixa'] & ator['baixa'] & nota['ruim'],
        recomendacao['baixa']
    )
    # R19: Qualquer afinidade média (OU) E nota ruim (indicadores mistos com nota negativa)
    regra19 = ctrl.Rule(
        (genero['media'] | diretor['media'] | ator['media']) & nota['ruim'],
        recomendacao['baixa']
    )

    sistema_controle = ctrl.ControlSystem([
        regra1,  regra2,  regra3,  regra4,
        regra5,  regra6,  regra7,  regra8,  regra9,  regra10,
        regra11, regra12, regra13, regra14, regra15,
        regra16, regra17, regra18, regra19,
    ])

    # ── Loop por cada filme do catálogo ─────────────────────────────────────
    resultados = []

    for movie in movies:
        # Passa a lista completa de atributos para verificar todas as posições
        afinidade_genero  = calcular_afinidade(history, 'genders',   movie['genders'])   if movie.get('genders')   else 0
        afinidade_ator    = calcular_afinidade(history, 'actors',    movie['actors'])     if movie.get('actors')    else 0
        afinidade_diretor = calcular_afinidade(history, 'directors', movie['directors'])  if movie.get('directors') else 0
        nota_filme        = movie['average'] / 10

        sistema = ctrl.ControlSystemSimulation(sistema_controle)

        # ── Entradas base (somente histórico) ───────────────────────────────
        input_genero  = afinidade_genero  * 10
        input_ator    = afinidade_ator    * 10
        input_diretor = afinidade_diretor * 10

        # ── Boost histórico + perfil declarado ────────────────────────────
        input_genero_boosted  = calcular_input_com_perfil(input_genero,  profile.get('favorite_gender'),    movie.get('genders',   []))
        input_ator_boosted    = calcular_input_com_perfil(input_ator,    profile.get('favorite_actor'),     movie.get('actors',    []))
        input_diretor_boosted = calcular_input_com_perfil(input_diretor, profile.get('favorite_director'),  movie.get('directors', []))

                # ── Log de boosting (exibe somente quando houve alteração) ───────────
        boost_lines = []
        if input_genero_boosted != input_genero:
            boost_lines.append(f"    gênero  : {input_genero:.2f} → {input_genero_boosted:.2f} [favorito: {profile.get('favorite_gender')}]")
        if input_ator_boosted != input_ator:
            boost_lines.append(f"    ator    : {input_ator:.2f} → {input_ator_boosted:.2f} [favorito: {profile.get('favorite_actor')}]")
        if input_diretor_boosted != input_diretor:
            boost_lines.append(f"    diretor : {input_diretor:.2f} → {input_diretor_boosted:.2f} [favorito: {profile.get('favorite_director')}]")

        if boost_lines:
            print(f"\n  [BOOSTING DE PERFIL] '{movie['title']}'")
            for line in boost_lines:
                print(line)

        sistema.input['genero']  = input_genero_boosted
        sistema.input['diretor'] = input_diretor_boosted
        sistema.input['ator']    = input_ator_boosted
        sistema.input['nota']    = nota_filme * 10

        try:
            sistema.compute()
            percentual = round(sistema.output['recomendacao'], 2)
        except Exception as e:
            print(f"[AVISO] Nenhuma regra ativada para '{movie['title']}': {e}")
            percentual = 0.0

        plotar_pertinencia(
            variaveis_entrada={
                'Genero':  genero,
                'Ator':    ator,
                'Diretor': diretor,
                'Nota':    nota,
            },
            consequente=recomendacao,
            valores_entrada={
                'Genero':  input_genero_boosted,
                'Ator':    input_ator_boosted,
                'Diretor': input_diretor_boosted,
                'Nota':    nota_filme * 10,
            },
            valor_saida=percentual,
            titulo=movie['title'],
        )

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