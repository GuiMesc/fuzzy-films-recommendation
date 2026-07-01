-- ================================================================
-- CENÁRIOS DE TESTE – BASE DE REGRAS FUZZY
-- ================================================================
-- Filme candidato : The Usual Suspects (id=43)
--   Gêneros  : Crime (id=2), Mystery (id=14)
--   Atores   : Kevin Spacey (id=66), Gabriel Byrne (id=67)
--   Diretor  : Bryan Singer (id=32)
--   Average  : 8.5  →  nota fuzzy: excelente=0.500, boa=0
--
-- Antes de rodar o script Python, ajuste:
--   query_get_movies : WHERE m.id = 43
--   get_user_id_by_name(name="Beatriz")   ← trocar pelo nome do cenário
--
-- Cenários e saída esperada do sistema fuzzy:
--   C1 Ana     → media   (~41%)  R14 (genero_media + nota_excelente)
--   C2 Carlos  → media   (~40%)  R14 (genero_media + nota_excelente)
--   C3 Beatriz → alta    (~78%)  R5  (genero_alta via fav_genre=Mystery BOOST)
--   C4 Diego   → media   (~38%)  R14 vs R16 parcial (zona media-baixa)
--   C5 Elena   → baixa   (~13%)  R16 (todos os três pilares baixos, ativação=1.0)
--
-- ┌──────────┬─────────────────┬─────────────────┬─────────────────┐
-- │ Usuário  │ The Dark Knight │  The Green Mile │ The Usual Susp. │
-- ├──────────┼─────────────────┼─────────────────┼─────────────────┤
-- │ Ana      │ muito_alta ~90% │   media  ~42%   │   media  ~41%   │
-- │ Carlos   │ alta       ~73% │   media  ~42%   │   media  ~40%   │
-- │ Beatriz  │ alta       ~62% │   media  ~48%   │   ALTA   ~78%   │
-- │ Diego    │ media      ~42% │ muito_alta ~80% │   media  ~38%   │
-- │ Elena    │ baixa      ~15% │   alta   ~73%   │   BAIXA  ~13%   │
-- └──────────┴─────────────────┴─────────────────┴─────────────────┘
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
-- USUÁRIOS (mesmos dos cenários anteriores)
-- ================================================================
--
--  C1 Ana     – fav: Action(3), Christian Bale(5), Christopher Nolan(3)
--  C2 Carlos  – fav: Action(3), Brad Pitt(18), Quentin Tarantino(6)
--  C3 Beatriz – fav: Mystery(14), Christian Bale(5), David Fincher(8)
--               fav_genre=Mystery é o PILAR CHAVE para este cenário
--  C4 Diego   – fav: Drama(1), Tom Hanks(21), Steven Spielberg(7)
--  C5 Elena   – fav: Romance(6), Tom Hanks(21), Frank Darabont(1)
-- ----------------------------------------------------------------
INSERT INTO tbl_users (name, favorite_gender_id, favorite_actor_id, favorite_director_id)
VALUES
    ('Ana',     3,   5,  3),
    ('Carlos',  3,  18,  6),
    ('Beatriz', 14,  5,  8),
    ('Diego',   1,  21,  7),
    ('Elena',   6,  21,  1);


-- ================================================================
-- C1: ANA – media (~41%)
-- ================================================================
-- Objetivo: gênero cai em zona MÉDIA sem boost de perfil; ator e diretor = baixa
--
-- 6 filmes Nolan: 2 têm Mystery (The Prestige, Memento) → Q=2/6=0.333
-- Candidato tem Crime+Mystery, mas fav=Action ≠ Crime/Mystery → SEM boost
--
-- Cálculo de afinidade esperado:
--   genero (Crime ou Mystery): filmes id=38 (The Prestige=Drama/Mystery) e id=71 (Memento=Mystery/Thriller)
--           N=avg(9.0,8.0)/10=0.85, T=avg(1.0,1.0)=1.0, C=avg(1,1)=1.0
--           afinidade=0.4*0.333+0.3*0.85+0.2*1+0.1*1 = 0.133+0.255+0.200+0.100 = 0.688
--           input_hist=6.88 → boost(fav=Action, sem match): 0.6*6.88 = 4.13
--           trimf[2,5,8]: media=(4.13-2)/3=0.71; baixa=(5-4.13)/5=0.17; alta=0
--
--   ator    (Kevin Spacey ou Gabriel Byrne): nenhum filme → afinidade=0
--           input=0 → boost(fav=Bale, sem match): 0 → baixa=1.0
--
--   diretor (Bryan Singer): nenhum filme → afinidade=0
--           input=0 → boost(fav=Nolan, sem match): 0 → baixa=1.0
--
--   nota=8.5 → excelente=0.500, boa=0
--
-- Regras que disparam:
--   R14: max(genero_media=0.71, dir_media=0, ator_media=0) E nota_excelente=0.500
--         → min(0.71, 0.50)=0.50 → media  (dominante)
--   R16: genero_baixa(0.17) E diretor_baixa(1.0) E ator_baixa(1.0) = 0.17 → baixa (fraca)
--   Centróide estimado: (50*área_media + 13*área_baixa) / total ≈ 41%
-- ----------------------------------------------------------------
INSERT INTO tbl_historic (user_id, movie_id, minutes_watched, user_average, liked)
SELECT u.id, h.movie_id, h.minutes_watched, h.user_average, h.liked
FROM tbl_users u,
     (VALUES
        (65,  164, 10.0, true ),  -- The Dark Knight Rises (Action/Adventure, Christian Bale, Nolan)
        (10,  148,  9.0, true ),  -- Inception             (Action/Adventure, Nolan)
        (38,  130,  9.0, true ),  -- The Prestige          (Drama/Mystery, Bale, Nolan) ← Mystery match
        (156, 140, 10.0, true ),  -- Batman Begins         (Action/Adventure, Bale, Nolan)
        (71,  113,  8.0, true ),  -- Memento               (Mystery/Thriller, Nolan)    ← Mystery match
        (23,  169,  9.0, true )   -- Interstellar          (Adventure/Drama, Nolan)
     ) AS h(movie_id, minutes_watched, user_average, liked)
WHERE u.name = 'Ana';


-- ================================================================
-- C2: CARLOS – media (~40%)
-- ================================================================
-- Objetivo: gênero cai em zona MÉDIA via Crime; ator e diretor = baixa
--
-- 5 filmes: 2 com Crime (Léon, Pulp Fiction) → Q=2/5=0.40
-- Candidato tem Crime+Mystery, mas fav=Action ≠ Crime/Mystery → SEM boost
-- Kevin Spacey e Bryan Singer não estão na história → ator e dir ficam baixos
--
-- Cálculo de afinidade esperado:
--   genero (Crime ou Mystery): filmes id=44 (Léon=Action/Crime), id=8 (Pulp Fiction=Crime/Drama)
--           N=avg(8.0,9.0)/10=0.85, T=avg(110/110,154/154)=1.0, C=avg(1,1)=1.0
--           afinidade=0.4*0.4+0.3*0.85+0.2*1+0.1*1 = 0.160+0.255+0.200+0.100 = 0.715
--           input_hist=7.15 → boost(fav=Action, sem match): 0.6*7.15 = 4.29
--           trimf[2,5,8]: media=(4.29-2)/3=0.763; baixa=(5-4.29)/5=0.142; alta=0
--
--   ator    (Spacey ou Byrne): nenhum → input=0 → baixa=1.0
--   diretor (Singer): nenhum → input=0 → baixa=1.0
--
--   nota=8.5 → excelente=0.500
--
-- Regras que disparam:
--   R14: max(genero_media=0.763, 0, 0) E nota_excelente=0.500
--         → min(0.763, 0.50)=0.50 → media  (dominante)
--   R16: genero_baixa(0.142) E diretor_baixa(1.0) E ator_baixa(1.0) = 0.142 → baixa (fraca)
--   Centróide estimado: ≈ 40%
-- ----------------------------------------------------------------
INSERT INTO tbl_historic (user_id, movie_id, minutes_watched, user_average, liked)
SELECT u.id, h.movie_id, h.minutes_watched, h.user_average, h.liked
FROM tbl_users u,
     (VALUES
        (41,  155, 9.0, true ),  -- Gladiator            (Action/Adventure) ← sem match
        (74,  115, 9.0, true ),  -- Raiders of the Lost Ark (Action/Adventure) ← sem match
        (44,  110, 8.0, true ),  -- Léon                 (Action/Crime) ← Crime match
        (16,  136, 9.0, true ),  -- The Matrix            (Action/Sci-Fi) ← sem match
        (8,   154, 9.0, true )   -- Pulp Fiction          (Crime/Drama, Tarantino) ← Crime match
     ) AS h(movie_id, minutes_watched, user_average, liked)
WHERE u.name = 'Carlos';


-- ================================================================
-- C3: BEATRIZ – alta (~78%)
-- ================================================================
-- Objetivo: acionar R5 (genero_alta via OU) pelo pilar de GÊNERO
--           fav_genre=Mystery(14) == Mystery do candidato → BOOST eleva genero para zona ALTA
--
-- MECANISMO CHAVE: mesmo com apenas Q=1/5 (só The Prestige tem Mystery),
--   o boost de fav_genre transforma input_hist=6.5 em input_final=7.9
--   (0.6*6.5 + 0.4*10 = 7.9) → entra na zona alta (trimf[5,10,10])
--
-- Cálculo de afinidade esperado:
--   genero (Crime ou Mystery): apenas id=38 (The Prestige = Drama/Mystery)
--           N=9.0/10=0.90, T=130/130=1.0, C=1.0
--           afinidade=0.4*0.2+0.3*0.9+0.2*1+0.1*1 = 0.080+0.270+0.200+0.100 = 0.650
--           input_hist=6.5 → boost(fav=Mystery MATCH!): 0.6*6.5+0.4*10 = 3.9+4.0 = 7.9
--           trimf[5,10,10]: alta=(7.9-5)/5=0.58; trimf[2,5,8]: media=(8-7.9)/3≈0.03; baixa=0
--
--   ator    (Spacey ou Byrne): nenhum filme na história
--           input=0 → boost(fav=Bale, sem match em candidato): 0 → baixa=1.0
--
--   diretor (Bryan Singer): nenhum filme na história
--           input=0 → boost(fav=Fincher, sem match em candidato): 0 → baixa=1.0
--
--   nota=8.5 → excelente=0.500
--
-- Regras que disparam:
--   R5: max(genero_alta=0.58, diretor_alta=0, ator_alta=0) E nota_excelente=0.500
--        → min(0.58, 0.500) = 0.500 → ALTA  (ativação dominante; sem concorrência real)
--   R14: max(genero_media≈0.03, 0, 0) E nota_excelente → min(0.03,0.5)=0.03 → desprezível
--   Centróide: trimf[60,80,100] clipado em 0.5 → centróide ≈ 80%
--              (apenas R5 dispara com força; resultado limpo em alta)
-- ----------------------------------------------------------------
INSERT INTO tbl_historic (user_id, movie_id, minutes_watched, user_average, liked)
SELECT u.id, h.movie_id, h.minutes_watched, h.user_average, h.liked
FROM tbl_users u,
     (VALUES
        (38,  130, 9.0, true ),  -- The Prestige          (Drama/Mystery, Bale, Nolan) ← único Mystery match
        (65,  164, 8.0, true ),  -- The Dark Knight Rises (Action/Adventure, Bale, Nolan)
        (156, 140, 9.0, true ),  -- Batman Begins         (Action/Adventure, Bale, Nolan)
        (13,  142, 8.0, true ),  -- Forrest Gump          (Drama/Romance, Tom Hanks)
        (47,  155, 7.0, false)   -- Nuovo Cinema Paradiso (Drama/Romance)
     ) AS h(movie_id, minutes_watched, user_average, liked)
WHERE u.name = 'Beatriz';


-- ================================================================
-- C4: DIEGO – media (~38%)
-- ================================================================
-- Objetivo: gênero cai em zona MÉDIA BAIXA; R14 e R16 disparam em competição,
--           puxando o centróide para a fronteira media/baixa
--
-- 5 filmes: apenas Léon tem Crime → Q=1/5=0.20 (fraca afinidade)
-- Candidato tem Crime/Mystery ≠ fav=Drama → SEM boost de perfil
-- R16 (all_baixa) dispara com 0.256 porque ator e dir ficam em baixa
--
-- Cálculo de afinidade esperado:
--   genero (Crime ou Mystery): apenas id=44 (Léon = Action/Crime) → Q=1/5
--           N=8.0/10=0.80, T=110/110=1.0, C=1.0
--           afinidade=0.4*0.2+0.3*0.8+0.2*1+0.1*1 = 0.080+0.240+0.200+0.100 = 0.620
--           input_hist=6.2 → boost(fav=Drama, sem match): 0.6*6.2 = 3.72
--           trimf[2,5,8]: media=(3.72-2)/3=0.573; baixa=(5-3.72)/5=0.256; alta=0
--
--   ator    (Spacey ou Byrne): nenhum → input=0 → baixa=1.0
--   diretor (Singer): nenhum → input=0 → baixa=1.0
--
--   nota=8.5 → excelente=0.500
--
-- Regras que disparam:
--   R14: max(genero_media=0.573, 0, 0) E nota_excelente=0.500
--         → min(0.573, 0.50)=0.50 → media
--   R16: genero_baixa(0.256) E diretor_baixa(1.0) E ator_baixa(1.0)
--         → 0.256 → baixa (moderada — mais forte que nos demais)
--   Centróide: competição entre media (área=15) e baixa (área≈8.9) → ≈ 38%
-- ----------------------------------------------------------------
INSERT INTO tbl_historic (user_id, movie_id, minutes_watched, user_average, liked)
SELECT u.id, h.movie_id, h.minutes_watched, h.user_average, h.liked
FROM tbl_users u,
     (VALUES
        (44,  110, 8.0, true ),  -- Léon         (Action/Crime) ← único Crime match; assistido completo
        (16,   68, 7.0, false),  -- The Matrix   (Action/Sci-Fi) ← sem match; 50% assistido
        (13,  142, 9.0, true ),  -- Forrest Gump (Drama/Romance) ← sem match; completo
        (2,    71, 8.0, true ),  -- Shawshank    (Drama) ← sem match; 50% assistido
        (47,   78, 7.0, false)   -- Nuovo Cinema Paradiso (Drama/Romance) ← sem match; 50%
     ) AS h(movie_id, minutes_watched, user_average, liked)
WHERE u.name = 'Diego';


-- ================================================================
-- C5: ELENA – baixa (~13%)
-- ================================================================
-- Objetivo: acionar R16 (genero_baixa E diretor_baixa E ator_baixa) com ATIVAÇÃO MÁXIMA
--           Todos os três pilares retornam baixa=1.0 → resultado mais limpo possível
--
-- 5 filmes: todos Drama/Family/Romance; ZERO Crime, ZERO Mystery
--           NENHUM com Kevin Spacey ou Gabriel Byrne; NENHUM com Bryan Singer
-- Perfil:  fav=Romance ≠ Crime/Mystery; fav_ator=TomHanks ≠ candidato; fav_dir=Darabont ≠ Singer
--
-- Cálculo de afinidade esperado:
--   genero (Crime ou Mystery): Q=0 → input=0 → baixa=1.0
--   ator    (Spacey ou Byrne) : Q=0 → input=0 → baixa=1.0
--   diretor (Singer)          : Q=0 → input=0 → baixa=1.0
--
--   nota=8.5 → excelente=0.500
--
-- Regras que disparam:
--   R16: genero_baixa(1.0) E diretor_baixa(1.0) E ator_baixa(1.0) = 1.0 → BAIXA (máxima)
--   R5:  max(0, 0, 0) E nota_excelente = 0 → NÃO dispara
--   R14: max(0, 0, 0) E nota_excelente = 0 → NÃO dispara
--   Centróide: trimf[0,0,40] clipado em 1.0 → triângulo inteiro → centróide ≈ 13%
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
