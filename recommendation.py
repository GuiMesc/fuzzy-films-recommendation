import numpy as np
import skfuzzy as fuzz
from skfuzzy import control as ctrl
import matplotlib.pyplot as plt
import psycopg2
import psycopg2.extras
import os
import sys

from queries import (
    GET_USER_ID_BY_NAME,
    GET_USER_PROFILE,
    GET_HISTORY,
    GET_MOVIE_BY_ID,
    GET_MOVIES,
    SAVE_RECOMMENDATION,
)

DB_CONFIG = {
    "host": "localhost",
    "port": 5432,
    "database": "recommendation_films_db",
    "user": "postgres",
    "password": "root"
}

CLASSES_RECOMENDACAO = ['baixa', 'media', 'alta', 'muito_alta']

CENARIOS_TESTE = [
    # The Dark Knight (id=3)
    {'usuario': 'Ana',     'movie_id': 3,  'esperado': 95.0},
    {'usuario': 'Carlos',  'movie_id': 3,  'esperado': 80.0},
    {'usuario': 'Beatriz', 'movie_id': 3,  'esperado': 80.0},
    {'usuario': 'Diego',   'movie_id': 3,  'esperado': 50.0},
    {'usuario': 'Elena',   'movie_id': 3,  'esperado': 15.0},
    # The Green Mile (id=26)
    {'usuario': 'Ana',     'movie_id': 26, 'esperado': 50.0},
    {'usuario': 'Carlos',  'movie_id': 26, 'esperado': 50.0},
    {'usuario': 'Beatriz', 'movie_id': 26, 'esperado': 50.0},
    {'usuario': 'Diego',   'movie_id': 26, 'esperado': 95.0},
    {'usuario': 'Elena',   'movie_id': 26, 'esperado': 80.0},
    # The Usual Suspects (id=42)
    {'usuario': 'Ana',     'movie_id': 42, 'esperado': 50.0},
    {'usuario': 'Carlos',  'movie_id': 42, 'esperado': 50.0},
    {'usuario': 'Beatriz', 'movie_id': 42, 'esperado': 80.0},
    {'usuario': 'Diego',   'movie_id': 42, 'esperado': 50.0},
    {'usuario': 'Elena',   'movie_id': 42, 'esperado': 15.0},
]


def get_db_connection():
    return psycopg2.connect(**DB_CONFIG)

def get_user_id_by_name(name="Guilherme"):
    conn = get_db_connection()
    try:
        with conn.cursor() as cursor:
            cursor.execute(GET_USER_ID_BY_NAME, (name,))
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
            cursor.execute(GET_HISTORY, (user_id,))
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
                    SAVE_RECOMMENDATION,
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
    conn = get_db_connection()
    try:
        with conn.cursor(cursor_factory=psycopg2.extras.RealDictCursor) as cursor:
            cursor.execute(GET_USER_PROFILE, (user_id,))
            row = cursor.fetchone()
            return dict(row) if row else {}
    except Exception as e:
        print(f"Erro ao buscar perfil do usuário: {e}")
        return {}
    finally:
        conn.close()

def get_movie_by_id(movie_id):
    conn = get_db_connection()
    try:
        with conn.cursor(cursor_factory=psycopg2.extras.RealDictCursor) as cursor:
            cursor.execute(GET_MOVIE_BY_ID, (movie_id,))
            return cursor.fetchone()
    except Exception as e:
        print(f"Erro ao buscar filme: {e}")
        return None
    finally:
        conn.close()


def calcular_input_com_perfil(score_historico, nome_favorito, lista_itens_filme, peso_historico=0.6, peso_perfil=0.4):
    perfil_score = 10.0 if (nome_favorito and any(
        item['name'] == nome_favorito for item in lista_itens_filme
    )) else 0.0
    return round(peso_historico * score_historico + peso_perfil * perfil_score, 2)


def calcular_afinidade(historico_filmes, chave, valores_alvo, verbose=True):
    nomes_alvo = {item['name'] for item in valores_alvo}
    if verbose:
        print("\n\nNomes alvo: ", nomes_alvo)

    filmes_filtrados = [
        h for h in historico_filmes
        if any(item['name'] in nomes_alvo for item in h["movies"].get(chave, []))
    ]
    if verbose:
        print("Filmes filtrados: ", filmes_filtrados)

    if len(filmes_filtrados) == 0:
        return 0

    qtd_total    = len(historico_filmes)
    qtd_filtrada = len(filmes_filtrados)
    Q = qtd_filtrada / qtd_total
    if verbose:
        print("Quantidade total de filmes no histórico: ", qtd_total)
        print("Quantidade de filmes filtrados: ", qtd_filtrada)
        print("Porcentagem de filmes filtrados: ", Q)

    media_notas = np.mean([h['user_average'] for h in filmes_filtrados])
    N = media_notas / 10
    if verbose:
        print("Média de notas dos filmes filtrados: ", media_notas)
        print("Porcentagem da média de notas: ", N)

    media_tempo = np.mean([h['minutes_watched'] / h['movies']['duration'] for h in filmes_filtrados])
    T = min(media_tempo, 1)
    if verbose:
        print("Média de tempo dos filmes filtrados: ", media_tempo)
        print("Porcentagem da média de tempo: ", T)

    media_curtidas = np.mean([h['like'] for h in filmes_filtrados])
    C = media_curtidas
    if verbose:
        print("Média de curtidas dos filmes filtrados: ", media_curtidas)
        print("Porcentagem da média de curtidas: ", C)

    afinidade = 0.4 * Q + 0.3 * N + 0.2 * T + 0.1 * C
    if verbose:
        print("Afinidade: ", afinidade)

    return round(afinidade, 2)


def plotar_pertinencia(variaveis_entrada, consequente, valores_entrada, valor_saida, titulo, output_dir="fuzzy_plots"):
    """
    Gera e salva um PNG com os conjuntos fuzzy de todas as variáveis
    e as operações realizadas na inferência
    """
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

    # ── Consequente (saída)
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

    # ── Título geral e salvamento
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


def construir_sistema_fuzzy():
    genero       = ctrl.Antecedent(np.arange(0, 11, 1), 'genero')
    diretor      = ctrl.Antecedent(np.arange(0, 11, 1), 'diretor')
    ator         = ctrl.Antecedent(np.arange(0, 11, 1), 'ator')
    nota         = ctrl.Antecedent(np.arange(0, 11, 1), 'nota')
    recomendacao = ctrl.Consequent(np.arange(0, 101, 1), 'recomendacao')

    for variavel in [genero, diretor, ator]:
        variavel['baixa'] = fuzz.trimf(variavel.universe, [0, 0, 5])
        variavel['media'] = fuzz.trimf(variavel.universe, [2, 5, 8])
        variavel['alta']  = fuzz.trimf(variavel.universe, [5, 10, 10])

    nota['ruim']      = fuzz.trimf(nota.universe, [0, 0, 5])
    nota['boa']       = fuzz.trimf(nota.universe, [4, 6, 8])
    nota['excelente'] = fuzz.trimf(nota.universe, [7, 10, 10])

    recomendacao['baixa']      = fuzz.trimf(recomendacao.universe, [0,  0,   40])
    recomendacao['media']      = fuzz.trimf(recomendacao.universe, [30, 50,  70])
    recomendacao['alta']       = fuzz.trimf(recomendacao.universe, [60, 80, 100])
    recomendacao['muito_alta'] = fuzz.trimf(recomendacao.universe, [80, 100, 100])

    # ── MUITO ALTA ──
    regra1  = ctrl.Rule(genero['alta'] & diretor['alta'] & ator['alta'], recomendacao['muito_alta'])
    regra2  = ctrl.Rule(genero['alta'] & diretor['alta'] & nota['excelente'], recomendacao['muito_alta'])
    regra3  = ctrl.Rule(genero['alta'] & ator['alta'] & nota['excelente'], recomendacao['muito_alta'])
    regra4  = ctrl.Rule(diretor['alta'] & ator['alta'] & nota['excelente'], recomendacao['muito_alta'])

    # ── ALTA ──
    regra5  = ctrl.Rule((genero['alta'] | diretor['alta'] | ator['alta']) & nota['excelente'], recomendacao['alta'])
    regra6  = ctrl.Rule(genero['alta'] & nota['boa'], recomendacao['alta'])
    regra7  = ctrl.Rule(diretor['alta'] & nota['boa'], recomendacao['alta'])
    regra8  = ctrl.Rule(ator['alta'] & nota['boa'], recomendacao['alta'])
    regra9  = ctrl.Rule(genero['alta'] & (diretor['media'] | ator['media']) & nota['boa'], recomendacao['alta'])
    regra10 = ctrl.Rule(genero['media'] & (diretor['alta'] | ator['alta']) & nota['boa'], recomendacao['alta'])

    # ── MEDIA ──
    regra11 = ctrl.Rule((genero['media'] | diretor['media'] | ator['media']) & nota['boa'], recomendacao['media'])
    regra12 = ctrl.Rule((genero['alta'] | diretor['alta'] | ator['alta']) & nota['ruim'], recomendacao['media'])
    regra13 = ctrl.Rule(genero['media'] & (diretor['media'] | ator['media']), recomendacao['media'])
    regra14 = ctrl.Rule((genero['media'] | diretor['media'] | ator['media']) & nota['excelente'], recomendacao['media'])
    regra15 = ctrl.Rule(genero['baixa'] & (diretor['baixa'] | ator['baixa']) & nota['boa'], recomendacao['media'])

    # ── BAIXA ──
    regra16 = ctrl.Rule(genero['baixa'] & diretor['baixa'] & ator['baixa'], recomendacao['baixa'])
    regra17 = ctrl.Rule(genero['baixa'] & nota['ruim'], recomendacao['baixa'])
    regra18 = ctrl.Rule(diretor['baixa'] & ator['baixa'] & nota['ruim'], recomendacao['baixa'])
    regra19 = ctrl.Rule((genero['media'] | diretor['media'] | ator['media']) & nota['ruim'], recomendacao['baixa'])

    sistema_controle = ctrl.ControlSystem([
        regra1,  regra2,  regra3,  regra4,
        regra5,  regra6,  regra7,  regra8,  regra9,  regra10,
        regra11, regra12, regra13, regra14, regra15,
        regra16, regra17, regra18, regra19,
    ])

    return sistema_controle, recomendacao, genero, diretor, ator, nota


def score_para_categoria(score, recomendacao_var):
    """Converte score defuzzificado (0–100) para categoria usando argmax de pertinência."""
    universo = recomendacao_var.universe
    pertinencias = {
        termo: fuzz.interp_membership(universo, obj.mf, score)
        for termo, obj in recomendacao_var.terms.items()
    }
    return max(pertinencias, key=pertinencias.get)


def calcular_score_usuario_filme(user_name, movie, sistema_controle, recomendacao_var):
    """Calcula o score de recomendação fuzzy para um usuário e um filme específicos."""
    user_id = get_user_id_by_name(user_name)
    if user_id is None:
        print(f"  [AVISO] Usuário '{user_name}' não encontrado.")
        return 0.0, 'baixa'

    history = get_history(user_id)
    profile = get_user_profile(user_id)

    if not history:
        print(f"  [AVISO] Histórico vazio para '{user_name}'.")
        return 0.0, 'baixa'

    afinidade_genero  = calcular_afinidade(history, 'genders',   movie['genders'],   verbose=False) if movie.get('genders')   else 0
    afinidade_ator    = calcular_afinidade(history, 'actors',    movie['actors'],     verbose=False) if movie.get('actors')    else 0
    afinidade_diretor = calcular_afinidade(history, 'directors', movie['directors'],  verbose=False) if movie.get('directors') else 0

    input_genero  = calcular_input_com_perfil(afinidade_genero  * 10, profile.get('favorite_gender'),   movie.get('genders',   []))
    input_ator    = calcular_input_com_perfil(afinidade_ator    * 10, profile.get('favorite_actor'),    movie.get('actors',    []))
    input_diretor = calcular_input_com_perfil(afinidade_diretor * 10, profile.get('favorite_director'), movie.get('directors', []))
    input_nota    = float(movie['average'])  # float() evita Decimal do psycopg2 que quebra o np.interp do skfuzzy

    sistema = ctrl.ControlSystemSimulation(sistema_controle)
    sistema.input['genero']  = input_genero
    sistema.input['diretor'] = input_diretor
    sistema.input['ator']    = input_ator
    sistema.input['nota']    = input_nota

    try:
        sistema.compute()
        score = round(sistema.output['recomendacao'], 2)
    except Exception as e:
        print(f"  [ERRO compute] '{user_name}' (g={input_genero}, d={input_diretor}, a={input_ator}, n={input_nota}): {e}")
        score = 0.0

    categoria = score_para_categoria(score, recomendacao_var)
    return score, categoria


def avaliar_cenarios(cenarios):
    """Roda o sistema fuzzy para cada cenário e coleta predição vs. esperado."""
    cache_filmes = {}

    print(f"\n{'Usuário':<12} {'Filme':<25} {'Esperado %':>10} {'Previsto %':>10} {'Erro %':>8}")
    print("-" * 70)

    resultados = []
    for c in cenarios:
        movie_id = c['movie_id']
        if movie_id not in cache_filmes:
            cache_filmes[movie_id] = get_movie_by_id(movie_id)
        movie = cache_filmes[movie_id]
        if not movie:
            print(f"  [AVISO] Filme id={movie_id} não encontrado, cenário ignorado.")
            continue

        # Cada cenário usa um sistema fuzzy isolado para evitar cache de estado interno do skfuzzy
        sistema_controle, recomendacao_var, *_ = construir_sistema_fuzzy()

        score, previsto_str = calcular_score_usuario_filme(
            c['usuario'], movie, sistema_controle, recomendacao_var
        )
        
        esperado_pct = float(c['esperado'])
        esperado_str = score_para_categoria(esperado_pct, recomendacao_var)
        erro = abs(esperado_pct - score)
        
        resultados.append({
            'usuario':      c['usuario'],
            'movie_id':     movie_id,
            'movie_title':  movie['title'],
            'esperado_str': esperado_str,
            'esperado_pct': esperado_pct,
            'previsto_str': previsto_str,
            'previsto_pct': score,
            'erro':         erro,
        })
        print(f"{c['usuario']:<12} {movie['title'][:25]:<25} {esperado_pct:>9.1f}% {score:>9.1f}% {erro:>7.1f}%")

    return resultados


def plotar_metricas_e_graficos(resultados, output_dir="fuzzy_plots"):
    """Gera métricas de erro (MAE/RMSE), gráfico de dispersão, erros por perfil e mapa de calor."""
    os.makedirs(output_dir, exist_ok=True)
    
    # ── Mapeamento de dados
    esperados = [r['esperado_pct'] for r in resultados]
    previstos = [r['previsto_pct'] for r in resultados]
    erros = [r['erro'] for r in resultados]
    
    # ── Cálculo das métricas gerais
    mae = np.mean(erros)
    rmse = np.sqrt(np.mean([e**2 for e in erros]))
    
    print("\n====================================================")
    print("MÉTRICAS GERAIS DE AVALIAÇÃO DE REGRESSÃO")
    print("====================================================")
    print(f"  MAE (Erro Médio Absoluto): {mae:.2f}%")
    print(f"  RMSE (Raiz do Erro Quadrático Médio): {rmse:.2f}%")
    print("====================================================\n")
    
    # ── 1. GRÁFICO DE DISPERSÃO (Scatter Plot)
    fig, ax = plt.subplots(figsize=(6, 6))
    ax.scatter(esperados, previstos, color='#3498db', alpha=0.8, edgecolors='black', s=80, label='Cenários de Teste')
    
    # Linha ideal y = x
    lims = [0, 100]
    ax.plot(lims, lims, color='#e74c3c', linestyle='--', linewidth=1.5, label='Ideal (y = x)')
    
    ax.set_xlim(lims)
    ax.set_ylim(lims)
    ax.set_xlabel('Esperado (%)', fontsize=11, fontweight='bold')
    ax.set_ylabel('Previsto (%)', fontsize=11, fontweight='bold')
    ax.set_title('Esperado vs. Previsto (Porcentagem de Recomendação)', fontsize=12, fontweight='bold', pad=12)
    ax.legend(loc='upper left')
    ax.grid(True, linestyle=':', alpha=0.5)
    
    # Caixa de texto com métricas no gráfico
    textstr = f"MAE: {mae:.2f}%\nRMSE: {rmse:.2f}%"
    props = dict(boxstyle='round', facecolor='white', alpha=0.85, edgecolor='gray')
    ax.text(0.05, 0.05, textstr, transform=ax.transAxes, fontsize=10,
            verticalalignment='bottom', bbox=props)
            
    caminho_dispersao = os.path.join(output_dir, 'avaliacao_dispersao.png')
    fig.savefig(caminho_dispersao, dpi=150, bbox_inches='tight')
    plt.close(fig)
    print(f"[PLOT] Gráfico de dispersão salvo: {caminho_dispersao}")

    # ── 2. GRÁFICO DE BARRAS DE ERRO POR PERFIL
    erros_por_usuario = {}
    for r in resultados:
        user = r['usuario']
        erros_por_usuario.setdefault(user, []).append(r['erro'])
        
    usuarios_unicos = sorted(erros_por_usuario.keys())
    maes_usuarios = [np.mean(erros_por_usuario[u]) for u in usuarios_unicos]
    rmses_usuarios = [np.sqrt(np.mean([e**2 for e in erros_por_usuario[u]])) for u in usuarios_unicos]
    
    fig, ax = plt.subplots(figsize=(8, 5))
    x = np.arange(len(usuarios_unicos))
    width = 0.35
    
    rects1 = ax.bar(x - width/2, maes_usuarios, width, label='MAE', color='#3498db', edgecolor='black', alpha=0.85)
    rects2 = ax.bar(x + width/2, rmses_usuarios, width, label='RMSE', color='#e74c3c', edgecolor='black', alpha=0.85)
    
    ax.set_ylabel('Erro (%)', fontsize=11, fontweight='bold')
    ax.set_title('Erro Médio de Recomendação por Perfil de Usuário', fontsize=12, fontweight='bold', pad=12)
    ax.set_xticks(x)
    ax.set_xticklabels(usuarios_unicos, fontsize=10, fontweight='bold')
    ax.legend(loc='upper right')
    ax.grid(True, linestyle=':', alpha=0.5)
    ax.set_ylim(0, max(max(maes_usuarios), max(rmses_usuarios)) + 5)
    
    # Adicionar rótulos de valores em cima das barras
    for rect in rects1:
        h = rect.get_height()
        ax.annotate(f'{h:.1f}%', xy=(rect.get_x() + rect.get_width()/2, h),
                    xytext=(0, 3), textcoords="offset points", ha='center', va='bottom', fontsize=8)
    for rect in rects2:
        h = rect.get_height()
        ax.annotate(f'{h:.1f}%', xy=(rect.get_x() + rect.get_width()/2, h),
                    xytext=(0, 3), textcoords="offset points", ha='center', va='bottom', fontsize=8)
                    
    caminho_erros = os.path.join(output_dir, 'avaliacao_erros_perfil.png')
    fig.savefig(caminho_erros, dpi=150, bbox_inches='tight')
    plt.close(fig)
    print(f"[PLOT] Gráfico de erros por perfil salvo: {caminho_erros}")

    # ── 3. MAPA DE CALOR (HEATMAP) DE RECOMENDAÇÕES POR PERFIL E FILME
    usuarios_ord = sorted(list(set(r['usuario'] for r in resultados)))
    
    movie_ids_ord = []
    movie_titles = {}
    for r in resultados:
        m_id = r['movie_id']
        if m_id not in movie_ids_ord:
            movie_ids_ord.append(m_id)
            movie_titles[m_id] = r['movie_title']
            
    heatmap_matrix = np.zeros((len(usuarios_ord), len(movie_ids_ord)))
    for r in resultados:
        u_idx = usuarios_ord.index(r['usuario'])
        m_idx = movie_ids_ord.index(r['movie_id'])
        heatmap_matrix[u_idx, m_idx] = r['previsto_pct']
        
    fig, ax = plt.subplots(figsize=(9, 6))
    im = ax.imshow(heatmap_matrix, cmap='YlGnBu', aspect='auto', vmin=0, vmax=100)
    
    # Eixos e Título
    ax.set_yticks(range(len(usuarios_ord)))
    ax.set_yticklabels(usuarios_ord, fontsize=10, fontweight='bold')
    
    movie_labels = [movie_titles[m_id] for m_id in movie_ids_ord]
    ax.set_xticks(range(len(movie_ids_ord)))
    ax.set_xticklabels(movie_labels, rotation=20, ha='right', fontsize=9, fontweight='bold')
    ax.set_title('Percentuais de Recomendação por Perfil e Filme', fontsize=12, fontweight='bold', pad=15)
    
    # Anotações numéricas nas células
    for i in range(len(usuarios_ord)):
        for j in range(len(movie_ids_ord)):
            val = heatmap_matrix[i, j]
            color = 'white' if val > 60 else 'black'
            ax.text(j, i, f"{val:.1f}%", ha='center', va='center', fontsize=10, color=color, fontweight='bold')
            
    fig.colorbar(im, ax=ax, label='Recomendação (%)')
    plt.tight_layout()
    
    caminho_heatmap = os.path.join(output_dir, 'avaliacao_heatmap.png')
    fig.savefig(caminho_heatmap, dpi=150, bbox_inches='tight')
    plt.close(fig)
    print(f"[PLOT] Mapa de calor de recomendações salvo: {caminho_heatmap}")


if __name__ == '__main__':
    modo_avaliacao = '--avaliar' in sys.argv

    sistema_controle, recomendacao, genero, diretor, ator, nota = construir_sistema_fuzzy()

    if modo_avaliacao:
        resultados_eval = avaliar_cenarios(CENARIOS_TESTE)
        plotar_metricas_e_graficos(resultados_eval)

    else:
        user_id = get_user_id_by_name("Guilherme")

        profile = get_user_profile(user_id)
        print("\n=====================================================")
        print("PERFIL DECLARADO DO USUÁRIO")
        print("=====================================================")
        print(f"  Gênero favorito  : {profile.get('favorite_gender')  or '(não definido)'}")
        print(f"  Ator favorito    : {profile.get('favorite_actor')    or '(não definido)'}")
        print(f"  Diretor favorito : {profile.get('favorite_director') or '(não definido)'}")

        history = get_history(user_id)
        movies  = get_movies(GET_MOVIES)

        if not history or not movies:
            print("Não foi possível buscar os dados do banco de dados")
            exit(1)

        resultados = []

        for movie in movies:
            afinidade_genero  = calcular_afinidade(history, 'genders',   movie['genders'])   if movie.get('genders')   else 0
            afinidade_ator    = calcular_afinidade(history, 'actors',    movie['actors'])     if movie.get('actors')    else 0
            afinidade_diretor = calcular_afinidade(history, 'directors', movie['directors'])  if movie.get('directors') else 0
            nota_filme        = movie['average'] / 10

            sistema = ctrl.ControlSystemSimulation(sistema_controle)

            input_genero  = afinidade_genero  * 10
            input_ator    = afinidade_ator    * 10
            input_diretor = afinidade_diretor * 10

            input_genero_boosted  = calcular_input_com_perfil(input_genero,  profile.get('favorite_gender'),    movie.get('genders',   []))
            input_ator_boosted    = calcular_input_com_perfil(input_ator,    profile.get('favorite_actor'),     movie.get('actors',    []))
            input_diretor_boosted = calcular_input_com_perfil(input_diretor, profile.get('favorite_director'),  movie.get('directors', []))

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
                'id':                   movie['id'],
                'title':                movie['title'],
                'description':          movie.get('description', ''),
                'average':              movie['average'],
                'genders':              movie.get('genders', []),
                'actors':               movie.get('actors', []),
                'directors':            movie.get('directors', []),
                'recommendation_score': percentual
            })

        resultados.sort(key=lambda x: x['recommendation_score'], reverse=True)

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
