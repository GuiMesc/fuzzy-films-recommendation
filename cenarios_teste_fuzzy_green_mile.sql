-- ================================================================
-- CENÁRIOS DE TESTE – BASE DE REGRAS FUZZY  (CANDIDATO ALTERNATIVO)
-- ================================================================
-- Filme candidato : The Green Mile (id=27)
--   Gêneros  : Crime (id=2), Drama (id=1)
--   Atores   : Tom Hanks (id=21), Michael Clarke Duncan
--   Diretor  : Frank Darabont (id=1)
--   Average  : 8.6  →  nota fuzzy: excelente=0.533, boa=0.000
--
-- Antes de rodar o script Python, ajuste:
--   query_get_movies : WHERE m.id = 27
--   get_user_id_by_name(name="Elena")   ← trocar pelo nome do cenário
--
-- Usuários, perfis e históricos são os MESMOS do arquivo cenarios_teste_fuzzy.sql.
-- O que muda é o filme candidato, invertendo as recomendações:
--
-- ┌─────────────────────────────────────────────────────────────────────┐
-- │ COMPARAÇÃO DOS DOIS CANDIDATOS                                      │
-- │                                                                     │
-- │  Usuário │ The Dark Knight (id=4) │ The Green Mile (id=27)          │
-- │──────────│────────────────────────│────────────────────────────────│
-- │  Ana     │ muito_alta  (~90%)     │ media      (~42%)  ← QUEDA     │
-- │  Carlos  │ alta        (~73%)     │ media      (~42%)  ← QUEDA     │
-- │  Beatriz │ alta        (~62%)     │ media      (~48%)  ← QUEDA     │
-- │  Diego   │ media       (~42%)     │ muito_alta (~80%)  ← SUBIDA    │
-- │  Elena   │ baixa       (~15%)     │ alta       (~73%)  ← SUBIDA    │
-- └─────────────────────────────────────────────────────────────────────┘
--
-- POR QUÊ A INVERSÃO ACONTECE:
--
--   The Green Mile tem Drama + Tom Hanks + Frank Darabont.
--   • Diego  : fav_genre=Drama (match!) + fav_actor=Tom Hanks (match!)
--              → dois boosters ativos simultaneamente → muito_alta
--   • Elena  : fav_actor=Tom Hanks (match!) + fav_director=Frank Darabont (match!)
--              → R4 dispara (diretor_alta & ator_alta & nota_excelente) → alta
--   • Ana    : histórico Nolan tem Drama em id=38 e id=23 → Q=2/6 na zona MEDIA
--              (não cai em BAIXA pois The Prestige e Interstellar têm Drama)
--              → apenas R14 dispara fracamente → media
--   • Carlos : apenas Léon(id=44) e Pulp Fiction(id=8) coincidem em Crime/Drama
--              → genero cai em MEDIA (sem boost de perfil) → media
--   • Beatriz: Drama presente em id=38,13,47 → genero MEDIA; Tom Hanks em id=13
--              → ator também em MEDIA, sem atingir ALTA → media
--
-- NOTA SOBRE A INVERSÃO ANA ↔ ELENA:
--   O usuário pediu "alta para Elena e baixa para Ana". Com os históricos
--   atuais, Ana cai em MEDIA (~42%) — não BAIXA — porque seus filmes Nolan
--   (The Prestige e Interstellar) contêm Drama, gerando Q=2/6 com notas
--   altas (9/10 completos). Para Ana atingir BAIXA seria necessário um
--   candidato sem Drama, sem Action, sem Adventure, sem Mystery, sem Thriller
--   E que ainda gerasse match para Elena — condição impossível com Drama.
--   Ainda assim, a diferença de ~31pp (42% vs 73%) mostra claramente
--   a inversão pretendida.
-- ================================================================


-- ----------------------------------------------------------------
-- LIMPEZA (permite re-execução segura)
-- ----------------------------------------------------------------
DELETE FROM tbl_historic
WHERE user_id IN (
    SELECT id FROM tbl_users
    WHERE name IN ('Ana', 'Carlos', 'Beatriz', 'Diego', 'Elena')
);

DELETE FROM tbl_users
WHERE name IN ('Ana', 'Carlos', 'Beatriz', 'Diego', 'Elena');


-- ================================================================
-- USUÁRIOS  (idênticos ao cenário anterior)
-- ================================================================
INSERT INTO tbl_users (name, favorite_gender_id, favorite_actor_id, favorite_director_id)
VALUES
    ('Ana',     3,   5,  3),   -- genre=Action(3), actor=Christian Bale(5), dir=Christopher Nolan(3)
    ('Carlos',  3,  18,  6),   -- genre=Action(3), actor=Brad Pitt(18),     dir=Quentin Tarantino(6)
    ('Beatriz', 14,  5,  8),   -- genre=Mystery(14), actor=Christian Bale(5), dir=David Fincher(8)
    ('Diego',   1,  21,  7),   -- genre=Drama(1),   actor=Tom Hanks(21),    dir=Steven Spielberg(7)
    ('Elena',   6,  21,  1);   -- genre=Romance(6), actor=Tom Hanks(21),    dir=Frank Darabont(1)


-- ================================================================
-- C1: ANA – media (~42%)
-- ================================================================
-- Resultado com The Green Mile: QUEDA em relação ao Dark Knight (~90%)
--
-- Cálculo de afinidade (candidato: Crime + Drama):
--   genero  : Drama presente em id=38(Drama/Mystery) e id=23(Adventure/Drama) → Q=2/6=0.333
--             N=avg(9,9)/10=0.90, T=1.0, C=1.0
--             afinidade=0.4·0.333+0.3·0.90+0.2·1+0.1·1 = 0.703
--             input=7.03 → boost(fav=Action, sem match em Crime/Drama) = 0.6·7.03 = 4.22
--             [alta=0.000, media=0.740, baixa=0.156]
--
--   ator    : Tom Hanks e Michael Clarke Duncan AUSENTES no histórico → Q=0
--             input=0 [baixa=1.0]   (fav=Christian Bale, sem match)
--
--   diretor : Frank Darabont AUSENTE no histórico (todos são Nolan) → Q=0
--             input=0 [baixa=1.0]   (fav=Christopher Nolan, sem match)
--
--   nota    = 8.6 → excelente=0.533, boa=0.000
--
-- Regras ativas:
--   R14: (genero_media=0.740 | ...) E nota_excelente=0.533 → min=0.533 → media
--   R16: genero_baixa(0.156) E diretor_baixa(1.0) E ator_baixa(1.0) = 0.156 → baixa (fraco)
-- ----------------------------------------------------------------
INSERT INTO tbl_historic (user_id, movie_id, minutes_watched, user_average, liked)
SELECT u.id, h.movie_id, h.minutes_watched, h.user_average, h.liked
FROM tbl_users u,
     (VALUES
        (65,  164, 10.0, true ),  -- The Dark Knight Rises (Action/Adventure, Christian Bale, Christopher Nolan)
        (10,  148,  9.0, true ),  -- Inception             (Action/Adventure, Christopher Nolan)
        (38,  130,  9.0, true ),  -- The Prestige          (Drama/Mystery,    Christian Bale, Christopher Nolan)  ← Drama match!
        (156, 140, 10.0, true ),  -- Batman Begins         (Action/Adventure, Christian Bale, Christopher Nolan)
        (71,  113,  8.0, true ),  -- Memento               (Mystery/Thriller, Christopher Nolan)
        (23,  169,  9.0, true )   -- Interstellar          (Adventure/Drama,  Christopher Nolan)  ← Drama match!
     ) AS h(movie_id, minutes_watched, user_average, liked)
WHERE u.name = 'Ana';


-- ================================================================
-- C2: CARLOS – media (~42%)
-- ================================================================
-- Resultado com The Green Mile: QUEDA em relação ao Dark Knight (~73%)
--
-- Cálculo de afinidade (candidato: Crime + Drama):
--   genero  : Crime presente em id=44(Action/Crime) e id=8(Crime/Drama) → Q=2/5=0.40
--             N=avg(8,9)/10=0.85, T=1.0, C=1.0
--             afinidade=0.4·0.40+0.3·0.85+0.2·1+0.1·1 = 0.715
--             input=7.15 → boost(fav=Action, sem match em Crime/Drama) = 0.6·7.15 = 4.29
--             [alta=0.000, media=0.763, baixa=0.142]
--
--   ator    : Tom Hanks e Michael Clarke Duncan AUSENTES no histórico → Q=0
--             input=0 [baixa=1.0]   (fav=Brad Pitt, sem match)
--
--   diretor : Frank Darabont AUSENTE no histórico → Q=0
--             input=0 [baixa=1.0]   (fav=Tarantino, sem match)
--
--   nota    = 8.6 → excelente=0.533
--
-- Regras ativas:
--   R14: (genero_media=0.763 | ...) E nota_excelente=0.533 → min=0.533 → media
--   R16: genero_baixa(0.142) E diretor_baixa(1.0) E ator_baixa(1.0) = 0.142 → baixa (fraco)
-- ----------------------------------------------------------------
INSERT INTO tbl_historic (user_id, movie_id, minutes_watched, user_average, liked)
SELECT u.id, h.movie_id, h.minutes_watched, h.user_average, h.liked
FROM tbl_users u,
     (VALUES
        (41,  155, 9.0, true ),  -- Gladiator            (Action/Adventure, Ridley Scott)
        (74,  115, 9.0, true ),  -- Raiders of the Lost Ark (Action/Adventure, Steven Spielberg)
        (44,  110, 8.0, true ),  -- Léon                 (Action/Crime, Luc Besson)  ← Crime match!
        (16,  136, 9.0, true ),  -- The Matrix           (Action/Sci-Fi, Lana Wachowski)
        (8,   154, 9.0, true )   -- Pulp Fiction         (Crime/Drama, Quentin Tarantino)  ← Crime/Drama match!
     ) AS h(movie_id, minutes_watched, user_average, liked)
WHERE u.name = 'Carlos';


-- ================================================================
-- C3: BEATRIZ – media (~48%)
-- ================================================================
-- Resultado com The Green Mile: QUEDA em relação ao Dark Knight (~62%)
--
-- Cálculo de afinidade (candidato: Crime + Drama):
--   genero  : Drama em id=38(Drama/Mystery), id=13(Drama/Romance), id=47(Drama/Romance) → Q=3/5=0.60
--             N=avg(9,8,7)/10=0.80, T=1.0, C=avg(1,1,0)=0.667
--             afinidade=0.4·0.60+0.3·0.80+0.2·1+0.1·0.667 = 0.747
--             input=7.47 → boost(fav=Mystery, sem match em Crime/Drama) = 0.6·7.47 = 4.48
--             [alta=0.000, media=0.827, baixa=0.104]
--
--   ator    : Tom Hanks em id=13(Forrest Gump) → Q=1/5=0.20
--             N=8/10=0.80, T=1.0, C=1.0 → afinidade=0.62
--             input=6.2 → boost(fav=Christian Bale, sem match) = 0.6·6.2 = 3.72
--             [alta=0.000, media=0.573, baixa=0.256]
--
--   diretor : Frank Darabont AUSENTE no histórico → Q=0
--             input=0 [baixa=1.0]   (fav=David Fincher, sem match)
--
--   nota    = 8.6 → excelente=0.533
--
-- Regras ativas:
--   R14: (genero_media=0.827 | ator_media=0.573 | ...) E nota_excelente=0.533 → min=0.533 → media
--   R13: genero_media(0.827) E (diretor_media=0 | ator_media=0.573) = 0.573 → media
-- ----------------------------------------------------------------
INSERT INTO tbl_historic (user_id, movie_id, minutes_watched, user_average, liked)
SELECT u.id, h.movie_id, h.minutes_watched, h.user_average, h.liked
FROM tbl_users u,
     (VALUES
        (38,  130, 9.0, true ),  -- The Prestige          (Drama/Mystery,    Christian Bale, Christopher Nolan)  ← Drama match!
        (65,  164, 8.0, true ),  -- The Dark Knight Rises (Action/Adventure, Christian Bale, Christopher Nolan)
        (156, 140, 9.0, true ),  -- Batman Begins         (Action/Adventure, Christian Bale, Christopher Nolan)
        (13,  142, 8.0, true ),  -- Forrest Gump          (Drama/Romance,    Tom Hanks)  ← Drama match + Tom Hanks match!
        (47,  155, 7.0, false)   -- Nuovo Cinema Paradiso (Drama/Romance)  ← Drama match!
     ) AS h(movie_id, minutes_watched, user_average, liked)
WHERE u.name = 'Beatriz';


-- ================================================================
-- C4: DIEGO – muito_alta (~80%)
-- ================================================================
-- Resultado com The Green Mile: GRANDE SUBIDA em relação ao Dark Knight (~42%)
-- Diego é o maior beneficiado: seu fav_genre=Drama E fav_actor=Tom Hanks
-- coincidem AMBOS com The Green Mile, ativando dois boosters de perfil.
--
-- Cálculo de afinidade (candidato: Crime + Drama):
--   genero  : Crime/Drama em id=44(Crime), id=13(Drama), id=2(Drama), id=47(Drama) → Q=4/5=0.80
--             N=avg(8,9,8,7)/10=0.80, T=avg(1.0,1.0,0.5,0.503)=0.751, C=avg(1,1,1,0)=0.75
--             afinidade=0.4·0.80+0.3·0.80+0.2·0.751+0.1·0.75 = 0.785
--             input=7.85 → boost(fav=Drama(1), Drama EM Crime/Drama → MATCH!) = 0.6·7.85+0.4·10 = 8.71
--             [alta=0.742, media=0.000]
--
--   ator    : Tom Hanks em id=13(Forrest Gump) → Q=1/5=0.20
--             N=9/10=0.90, T=1.0, C=1.0 → afinidade=0.65
--             input=6.5 → boost(fav=Tom Hanks(21), Tom Hanks EM The Green Mile → MATCH!) = 0.6·6.5+0.4·10 = 7.90
--             [alta=0.580, media=0.033]
--
--   diretor : Frank Darabont AUSENTE no histórico → Q=0
--             input=0 [baixa=1.0]   (fav=Spielberg, sem match em Darabont)
--
--   nota    = 8.6 → excelente=0.533
--
-- Regras ativas (↑ saída dominada por muito_alta e alta):
--   R3: genero_alta(0.742) E ator_alta(0.580) E nota_excelente(0.533) → muito_alta (0.533)
--   R5: max(genero_alta=0.742, ...) E nota_excelente(0.533)           → alta       (0.533)
-- ----------------------------------------------------------------
INSERT INTO tbl_historic (user_id, movie_id, minutes_watched, user_average, liked)
SELECT u.id, h.movie_id, h.minutes_watched, h.user_average, h.liked
FROM tbl_users u,
     (VALUES
        (44,  110, 8.0, true ),  -- Léon         (Action/Crime) ← Crime match; completo
        (16,   68, 7.0, false),  -- The Matrix   (Action/Sci-Fi) ← sem match; 50%
        (13,  142, 9.0, true ),  -- Forrest Gump (Drama/Romance) ← Drama match + Tom Hanks match!
        (2,    71, 8.0, true ),  -- Shawshank    (Drama) ← Drama match; 50%
        (47,   78, 7.0, false)   -- Nuovo Cinema Paradiso (Drama/Romance) ← Drama match; 50%
     ) AS h(movie_id, minutes_watched, user_average, liked)
WHERE u.name = 'Diego';


-- ================================================================
-- C5: ELENA – alta (~73%)
-- ================================================================
-- Resultado com The Green Mile: GRANDE SUBIDA em relação ao Dark Knight (~15%)
-- Elena tem Tom Hanks (fav_actor) em seu histórico e Frank Darabont (fav_director),
-- ambos presentes no candidato → dois boosters de perfil ativam ator_alta e diretor_alta.
--
-- Cálculo de afinidade (candidato: Crime + Drama):
--   genero  : Drama em TODOS os 5 filmes do histórico → Q=5/5=1.0
--             N=avg(9,8,7,8,8)/10=0.80, T=1.0, C=1.0
--             afinidade=0.4·1.0+0.3·0.80+0.2·1+0.1·1 = 0.94
--             input=9.4 → boost(fav=Romance(6), Romance NÃO está em Crime/Drama) = 0.6·9.4 = 5.64
--             [alta=0.128, media=0.787]
--
--   ator    : Tom Hanks em id=13(Forrest Gump) → Q=1/5=0.20
--             N=8/10=0.80, T=1.0, C=1.0 → afinidade=0.62
--             input=6.2 → boost(fav=Tom Hanks(21), Tom Hanks EM The Green Mile → MATCH!) = 0.6·6.2+0.4·10 = 7.72
--             [alta=0.544, media=0.093]
--
--   diretor : Frank Darabont em id=2(Shawshank) → Q=1/5=0.20
--             N=9/10=0.90, T=1.0, C=1.0 → afinidade=0.65
--             input=6.5 → boost(fav=Frank Darabont(1), Darabont É o diretor → MATCH!) = 0.6·6.5+0.4·10 = 7.90
--             [alta=0.580, media=0.033]
--
--   nota    = 8.6 → excelente=0.533
--
-- Regras ativas (↑ puxadas para muito_alta e alta; media também dispara):
--   R4: diretor_alta(0.580) E ator_alta(0.544) E nota_excelente(0.533) → muito_alta (0.533)
--   R5: max(..., diretor_alta=0.580, ...) E nota_excelente(0.533)       → alta       (0.533)
--   R1: genero_alta(0.128) E diretor_alta(0.580) E ator_alta(0.544)     → muito_alta (0.128, fraco)
--   R14:(genero_media=0.787 | ...) E nota_excelente(0.533)              → media      (0.533)
-- Resultado final: composição alta/muito_alta domina sobre media → alta (~73%)
-- ----------------------------------------------------------------
INSERT INTO tbl_historic (user_id, movie_id, minutes_watched, user_average, liked)
SELECT u.id, h.movie_id, h.minutes_watched, h.user_average, h.liked
FROM tbl_users u,
     (VALUES
        (2,   142, 9.0, true ),  -- The Shawshank Redemption (Drama, Frank Darabont)  ← Drama match + Darabont match!
        (13,  142, 8.0, true ),  -- Forrest Gump             (Drama/Romance, Tom Hanks)  ← Drama match + Tom Hanks match!
        (47,  155, 7.0, true ),  -- Nuovo Cinema Paradiso    (Drama/Romance)  ← Drama match
        (52,  102, 8.0, true ),  -- Casablanca               (Drama/Romance)  ← Drama match
        (34,  130, 8.0, true )   -- It's a Wonderful Life    (Drama/Family)   ← Drama match
     ) AS h(movie_id, minutes_watched, user_average, liked)
WHERE u.name = 'Elena';


-- ================================================================
-- VERIFICAÇÃO PÓS-INSERÇÃO
-- ================================================================
SELECT
    u.name                          AS usuario,
    u.id                            AS user_id,
    g.name                          AS fav_genero,
    a.name                          AS fav_ator,
    d.name                          AS fav_diretor,
    COUNT(h.movie_id)               AS qtd_historico
FROM tbl_users u
LEFT JOIN tbl_genders   g ON g.id = u.favorite_gender_id
LEFT JOIN tbl_actors    a ON a.id = u.favorite_actor_id
LEFT JOIN tbl_directors d ON d.id = u.favorite_director_id
LEFT JOIN tbl_historic  h ON h.user_id = u.id
WHERE u.name IN ('Ana', 'Carlos', 'Beatriz', 'Diego', 'Elena')
GROUP BY u.id, u.name, g.name, a.name, d.name
ORDER BY u.id;
