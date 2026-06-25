-- ================================================================
-- CENÁRIOS DE TESTE – BASE DE REGRAS FUZZY
-- ================================================================
-- Filme candidato : The Dark Knight (id=4)
--   Gêneros  : Action (id=3), Crime (id=2)
--   Atores   : Christian Bale (id=5), Heath Ledger (id=6)
--   Diretor  : Christopher Nolan (id=3)
--   Average  : 9.0  →  nota fuzzy: excelente (~0.67)
--
-- Antes de rodar o script Python, ajuste:
--   query_get_movies : WHERE m.id = 4
--   get_user_id_by_name(name="Ana")   ← trocar pelo nome do cenário
--
-- Cenários e saída esperada do sistema fuzzy:
--   C1 Ana     → muito_alta (~90%)  R1+R2+R3+R4 (todos os três pilares altos)
--   C2 Carlos  → alta       (~73%)  R5 (genero_alta via OU + nota_excelente)
--   C3 Beatriz → alta       (~62%)  R5 (ator_alta via OU) + R13 (genero E diretor médios)
--   C4 Diego   → media      (~42%)  R14 (genero_media E nota_excelente) vs R16
--   C5 Elena   → baixa      (~15%)  R16 (todos os três pilares baixos)
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
-- USUÁRIOS
-- ================================================================
--
--  C1 Ana     – perfil coincide com os TRÊS pilares do candidato
--               genre=Action(3), actor=Christian Bale(5), dir=Christopher Nolan(3)
--
--  C2 Carlos  – apenas gênero coincide (Action)
--               genre=Action(3), actor=Brad Pitt(18), dir=Quentin Tarantino(6)
--
--  C3 Beatriz – apenas ator coincide (Christian Bale)
--               genre=Mystery(14), actor=Christian Bale(5), dir=David Fincher(8)
--
--  C4 Diego   – nenhum perfil coincide; histórico com afinidade MÉDIA em gênero
--               genre=Drama(1), actor=Tom Hanks(21), dir=Steven Spielberg(7)
--
--  C5 Elena   – nenhum perfil coincide; histórico sem qualquer match
--               genre=Romance(6), actor=Tom Hanks(21), dir=Frank Darabont(1)
-- ----------------------------------------------------------------
INSERT INTO tbl_users (name, favorite_gender_id, favorite_actor_id, favorite_director_id)
VALUES
    ('Ana',     3,   5,  3),
    ('Carlos',  3,  18,  6),
    ('Beatriz', 14,  5,  8),
    ('Diego',   1,  21,  7),
    ('Elena',   6,  21,  1);


-- ================================================================
-- C1: ANA – muito_alta
-- ================================================================
-- Objetivo: acionar R1 (genero E diretor E ator altos) + R2/R3/R4 (pares altos E nota_excelente)
--
-- 6 filmes: todos Christopher Nolan; 3 com Christian Bale; 3 com Action no gênero
-- Todos assistidos por completo, notas 8–10, todos curtidos
--
-- Cálculo de afinidade esperado:
--   genero  (Action ou Crime): filmes id=65,10,156  → Q=3/6=0.50
--           N=avg(10,9,10)/10=0.967, T=1.0, C=1.0
--           afinidade=0.4·0.50+0.3·0.967+0.2·1+0.1·1 = 0.79
--           input=7.9  →  boost(fav=Action match): 0.6·7.9+0.4·10 = 8.74  (ALTA)
--
--   ator    (Bale ou Ledger):   filmes id=65,38,156  → Q=3/6=0.50
--           N=avg(10,9,10)/10=0.967, T=1.0, C=1.0
--           afinidade=0.79
--           input=7.9  →  boost(fav=Bale match): 8.74  (ALTA)
--
--   diretor (Christopher Nolan): TODOS 6 filmes     → Q=6/6=1.0
--           N=avg(10,9,9,10,8,9)/10=0.917, T=1.0, C=1.0
--           afinidade=0.4·1.0+0.3·0.917+0.2·1+0.1·1 = 0.975
--           input=9.75 → boost(fav=Nolan match): 0.6·9.75+0.4·10 = 9.85  (ALTA quase máxima)
--
--   nota=9.0  →  excelente=0.667
--
-- Regras que disparam com alta ativação:
--   R1: genero_alta(0.75) E diretor_alta(0.97) E ator_alta(0.75)       → muito_alta (0.75)
--   R2: genero_alta(0.75) E diretor_alta(0.97) E nota_excelente(0.67)  → muito_alta (0.67)
--   R3: genero_alta(0.75) E ator_alta(0.75)    E nota_excelente(0.67)  → muito_alta (0.67)
--   R4: diretor_alta(0.97) E ator_alta(0.75)   E nota_excelente(0.67)  → muito_alta (0.67)
--   R5: (genero_alta OU diretor_alta OU ator_alta) E nota_excelente     → alta (0.67)
-- ----------------------------------------------------------------
INSERT INTO tbl_historic (user_id, movie_id, minutes_watched, user_average, liked)
SELECT u.id, h.movie_id, h.minutes_watched, h.user_average, h.liked
FROM tbl_users u,
     (VALUES
        (65,  164, 10.0, true ),  -- The Dark Knight Rises (Action, Christian Bale, Christopher Nolan)
        (10,  148,  9.0, true ),  -- Inception             (Action, Christopher Nolan)
        (38,  130,  9.0, true ),  -- The Prestige          (Drama/Mystery, Christian Bale, Christopher Nolan)
        (156, 140, 10.0, true ),  -- Batman Begins         (Action, Christian Bale, Christopher Nolan)
        (71,  113,  8.0, true ),  -- Memento               (Mystery/Thriller, Christopher Nolan)
        (23,  169,  9.0, true )   -- Interstellar          (Adventure/Drama, Christopher Nolan)
     ) AS h(movie_id, minutes_watched, user_average, liked)
WHERE u.name = 'Ana';


-- ================================================================
-- C2: CARLOS – alta (R5: genero_alta via OU + nota_excelente)
-- ================================================================
-- Objetivo: acionar R5 pelo pilar de gênero (OU) sem ator nem diretor
--
-- 5 filmes: todos Action/Crime; NENHUM com Christian Bale; NENHUM com Christopher Nolan
-- Todos assistidos por completo, notas 8–9, todos curtidos
--
-- Cálculo de afinidade esperado:
--   genero  (Action ou Crime): TODOS 5 filmes → Q=5/5=1.0
--           N=avg(9,9,8,9,9)/10=0.88, T=1.0, C=1.0
--           afinidade=0.4·1.0+0.3·0.88+0.2·1+0.1·1 = 0.964
--           input=9.64 → boost(fav=Action match): 0.6·9.64+0.4·10 = 9.78  (ALTA máxima)
--
--   ator    (Bale ou Ledger): nenhum filme → afinidade=0
--           input=0  →  boost(fav=Brad Pitt, sem match): 0  (BAIXA)
--
--   diretor (Christopher Nolan): nenhum filme → afinidade=0
--           input=0  →  boost(fav=Tarantino, sem match): 0  (BAIXA)
--
--   nota=9.0  →  excelente=0.667
--
-- Regras que disparam:
--   R5: (genero_alta=0.957 OU diretor_alta=0 OU ator_alta=0) E nota_excelente=0.667
--        max=0.957 → min(0.957, 0.667) = 0.667  →  alta
--   R16: genero_baixa(0) E diretor_baixa(1.0) E ator_baixa(1.0) = 0  →  não dispara
-- ----------------------------------------------------------------
INSERT INTO tbl_historic (user_id, movie_id, minutes_watched, user_average, liked)
SELECT u.id, h.movie_id, h.minutes_watched, h.user_average, h.liked
FROM tbl_users u,
     (VALUES
        (41,  155, 9.0, true ),  -- Gladiator            (Action/Adventure, Ridley Scott)
        (74,  115, 9.0, true ),  -- Raiders of the Lost Ark (Action/Adventure, Steven Spielberg)
        (44,  110, 8.0, true ),  -- Léon                 (Action/Crime, Luc Besson)
        (16,  136, 9.0, true ),  -- The Matrix            (Action/Sci-Fi, Lana Wachowski)
        (8,   154, 9.0, true )   -- Pulp Fiction          (Crime/Drama, Quentin Tarantino) ← Crime match
     ) AS h(movie_id, minutes_watched, user_average, liked)
WHERE u.name = 'Carlos';


-- ================================================================
-- C3: BEATRIZ – alta (R5: ator_alta via OU + R13: genero E diretor médios)
-- ================================================================
-- Objetivo: acionar R5 pelo pilar de ATOR (OU); gênero e diretor ficam na zona média
--
-- 5 filmes: 3 com Christian Bale (todos também Nolan); 2 sem match nenhum
-- Todos assistidos por completo, notas 7–9
--
-- Cálculo de afinidade esperado:
--   genero  (Action ou Crime): filmes id=65,156 (Action) → Q=2/5=0.40
--           N=avg(8.0,9.0)/10=0.85, T=1.0, C=1.0
--           afinidade=0.4·0.40+0.3·0.85+0.2·1+0.1·1 = 0.715
--           input=7.15 → boost(fav=Mystery, sem match): 0.6·7.15 = 4.29
--           trimf[2,5,8]: media=(4.29-2)/3=0.76; alta=0
--
--   ator    (Bale ou Ledger): filmes id=38,65,156 (Bale) → Q=3/5=0.60
--           N=avg(9,8,9)/10=0.867, T=1.0, C=1.0
--           afinidade=0.4·0.60+0.3·0.867+0.2·1+0.1·1 = 0.80
--           input=8.0  →  boost(fav=Bale, match!): 0.6·8+0.4·10 = 8.8  (ALTA: 0.76)
--
--   diretor (Christopher Nolan): filmes id=38,65,156 (Nolan) → Q=3/5=0.60
--           afinidade=0.80 (mesma composição)
--           input=8.0  →  boost(fav=Fincher, sem match): 0.6·8.0 = 4.8
--           trimf[2,5,8]: media=(4.8-2)/3=0.93; alta=0
--
--   nota=9.0  →  excelente=0.667
--
-- Regras que disparam:
--   R5:  (genero_alta=0 OU diretor_alta=0 OU ator_alta=0.76) E nota_excelente=0.667
--         → min(0.76, 0.667)=0.667  →  alta
--   R13: genero_media(0.76) E (diretor_media(0.93) OU ator_media=0)
--         → min(0.76, 0.93)=0.76    →  media
--   R14: (genero_media=0.76 OU diretor_media=0.93 OU ...) E nota_excelente=0.667
--         → min(0.93, 0.667)=0.667  →  media
-- ----------------------------------------------------------------
INSERT INTO tbl_historic (user_id, movie_id, minutes_watched, user_average, liked)
SELECT u.id, h.movie_id, h.minutes_watched, h.user_average, h.liked
FROM tbl_users u,
     (VALUES
        (38,  130, 9.0, true ),  -- The Prestige          (Drama/Mystery, Christian Bale, Christopher Nolan)
        (65,  164, 8.0, true ),  -- The Dark Knight Rises (Action, Christian Bale, Christopher Nolan)
        (156, 140, 9.0, true ),  -- Batman Begins         (Action, Christian Bale, Christopher Nolan)
        (13,  142, 8.0, true ),  -- Forrest Gump          (Drama/Romance, Tom Hanks) ← sem match
        (47,  155, 7.0, false)   -- Nuovo Cinema Paradiso (Drama/Romance) ← sem match
     ) AS h(movie_id, minutes_watched, user_average, liked)
WHERE u.name = 'Beatriz';


-- ================================================================
-- C4: DIEGO – media (R14 vs R16)
-- ================================================================
-- Objetivo: gênero cai na zona MÉDIA (sem boost de perfil); ator e diretor = 0
--           R14 (genero_media E nota_excelente → media) vence R16 (all_baixa → baixa)
--
-- 5 filmes: 2 com Action/Crime (parcialmente assistidos, notas moderadas); 3 sem match
-- Nenhum perfil coincide com o filme candidato
--
-- Cálculo de afinidade esperado:
--   genero  (Action ou Crime): filmes id=44(Action/Crime), id=16(Action) → Q=2/5=0.40
--           N=avg(8.0,7.0)/10=0.75
--           T=avg(110/110, 68/136)=avg(1.0, 0.50)=0.75
--           C=avg(true, false)=0.50
--           afinidade=0.4·0.40+0.3·0.75+0.2·0.75+0.1·0.50 = 0.585
--           input=5.85 → boost(fav=Drama, sem match): 0.6·5.85 = 3.51
--           trimf[2,5,8]: media=(3.51-2)/3=0.50; baixa=(5-3.51)/5=0.30; alta=0
--
--   ator    (Bale ou Ledger): nenhum filme → afinidade=0  →  baixa=1.0
--   diretor (Christopher Nolan): nenhum filme → afinidade=0  →  baixa=1.0
--
--   nota=9.0  →  excelente=0.667
--
-- Regras que disparam:
--   R14: (genero_media=0.50 OU ...) E nota_excelente=0.667
--         → min(0.50, 0.667)=0.50  →  media  (ativação maior)
--   R16: genero_baixa(0.30) E diretor_baixa(1.0) E ator_baixa(1.0)=0.30  →  baixa
-- ----------------------------------------------------------------
INSERT INTO tbl_historic (user_id, movie_id, minutes_watched, user_average, liked)
SELECT u.id, h.movie_id, h.minutes_watched, h.user_average, h.liked
FROM tbl_users u,
     (VALUES
        (44,  110, 8.0, true ),  -- Léon         (Action/Crime) ← match; completo
        (16,   68, 7.0, false),  -- The Matrix   (Action/Sci-Fi) ← Action match; 50%
        (13,  142, 9.0, true ),  -- Forrest Gump (Drama/Romance) ← sem match; completo
        (2,    71, 8.0, true ),  -- Shawshank    (Drama) ← sem match; 50%
        (47,   78, 7.0, false)   -- Nuovo Cinema Paradiso (Drama/Romance) ← sem match; 50%
     ) AS h(movie_id, minutes_watched, user_average, liked)
WHERE u.name = 'Diego';


-- ================================================================
-- C5: ELENA – baixa (R16: todos os três pilares baixos)
-- ================================================================
-- Objetivo: acionar R16 (genero_baixa E diretor_baixa E ator_baixa) com ativação máxima
--
-- 5 filmes: APENAS Drama/Family/Romance; SEM Action, SEM Crime
--           SEM Christian Bale; SEM Heath Ledger; SEM Christopher Nolan
-- Todos assistidos por completo, bem avaliados (não interfere: Q=0 retorna imediatamente)
-- Nenhum perfil coincide com o filme candidato
--
-- Cálculo de afinidade esperado:
--   genero  (Action ou Crime): nenhum filme filtrado → afinidade=0 → input=0 → baixa=1.0
--   ator    (Bale ou Ledger) : nenhum filme filtrado → afinidade=0 → input=0 → baixa=1.0
--   diretor (Christopher Nolan): nenhum filme filtrado → afinidade=0 → input=0 → baixa=1.0
--
--   nota=9.0  →  excelente=0.667
--
-- Regras que disparam:
--   R16: genero_baixa(1.0) E diretor_baixa(1.0) E ator_baixa(1.0) = 1.0  →  baixa (ativação plena)
--   R5:  max(0, 0, 0) E nota_excelente = 0  →  não dispara
-- ----------------------------------------------------------------
INSERT INTO tbl_historic (user_id, movie_id, minutes_watched, user_average, liked)
SELECT u.id, h.movie_id, h.minutes_watched, h.user_average, h.liked
FROM tbl_users u,
     (VALUES
        (2,   142, 9.0, true ),  -- The Shawshank Redemption (Drama, Frank Darabont)
        (13,  142, 8.0, true ),  -- Forrest Gump             (Drama/Romance, Tom Hanks)
        (47,  155, 7.0, true ),  -- Nuovo Cinema Paradiso    (Drama/Romance)
        (52,  102, 8.0, true ),  -- Casablanca               (Drama/Romance)
        (34,  130, 8.0, true )   -- It's a Wonderful Life    (Drama/Family)
     ) AS h(movie_id, minutes_watched, user_average, liked)
WHERE u.name = 'Elena';


-- ================================================================
-- VERIFICAÇÃO PÓS-INSERÇÃO
-- ================================================================
SELECT
    u.name                                        AS usuario,
    u.id                                          AS user_id,
    g.name                                        AS fav_genero,
    a.name                                        AS fav_ator,
    d.name                                        AS fav_diretor,
    COUNT(h.movie_id)                             AS qtd_historico
FROM tbl_users u
LEFT JOIN tbl_genders   g ON g.id = u.favorite_gender_id
LEFT JOIN tbl_actors    a ON a.id = u.favorite_actor_id
LEFT JOIN tbl_directors d ON d.id = u.favorite_director_id
LEFT JOIN tbl_historic  h ON h.user_id = u.id
WHERE u.name IN ('Ana', 'Carlos', 'Beatriz', 'Diego', 'Elena')
GROUP BY u.id, u.name, g.name, a.name, d.name
ORDER BY u.id;
