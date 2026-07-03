--Comandos SQL para a criação dos usuários de testes e seus respectivos históricos de visualização--

INSERT INTO tbl_users (name, favorite_gender_id, favorite_actor_id, favorite_director_id)
VALUES
    ('Ana',     3,   5,  3),
    ('Carlos',  3,  18,  6),
    ('Beatriz', 14,  5,  8),
    ('Diego',   1,  21,  7),
    ('Elena',   6,  21,  1);


-- ================================================================
INSERT INTO tbl_historic (user_id, movie_id, minutes_watched, user_average, liked)
SELECT u.id, h.movie_id, h.minutes_watched, h.user_average, h.liked
FROM tbl_users u,
     (VALUES
        (64,  164, 10.0, true ),  -- The Dark Knight Rises (Action, Christian Bale, Christopher Nolan)
        (9,   148,  9.0, true ),  -- Inception             (Action, Christopher Nolan)
        (37,  130,  9.0, true ),  -- The Prestige          (Drama/Mystery, Christian Bale, Christopher Nolan)
        (155, 140, 10.0, true ),  -- Batman Begins         (Action, Christian Bale, Christopher Nolan)
        (70,  113,  8.0, true ),  -- Memento               (Mystery/Thriller, Christopher Nolan)
        (22,  169,  9.0, true )   -- Interstellar          (Adventure/Drama, Christopher Nolan)
     ) AS h(movie_id, minutes_watched, user_average, liked)
WHERE u.name = 'Ana';

-- ================================================================
INSERT INTO tbl_historic (user_id, movie_id, minutes_watched, user_average, liked)
SELECT u.id, h.movie_id, h.minutes_watched, h.user_average, h.liked
FROM tbl_users u,
     (VALUES
        (40,  155, 9.0, true ),  -- Gladiator            (Action/Adventure, Ridley Scott)
        (73,  115, 9.0, true ),  -- Raiders of the Lost Ark (Action/Adventure, Steven Spielberg)
        (43,  110, 8.0, true ),  -- Léon                 (Action/Crime, Luc Besson)
        (15,  136, 9.0, true ),  -- The Matrix            (Action/Sci-Fi, Lana Wachowski)
        (7,   154, 9.0, true )   -- Pulp Fiction          (Crime/Drama, Quentin Tarantino) ← Crime match
     ) AS h(movie_id, minutes_watched, user_average, liked)
WHERE u.name = 'Carlos';

-- ================================================================
INSERT INTO tbl_historic (user_id, movie_id, minutes_watched, user_average, liked)
SELECT u.id, h.movie_id, h.minutes_watched, h.user_average, h.liked
FROM tbl_users u,
     (VALUES
        (37,  130, 9.0, true ),  -- The Prestige          (Drama/Mystery, Christian Bale, Christopher Nolan)
        (64,  164, 8.0, true ),  -- The Dark Knight Rises (Action, Christian Bale, Christopher Nolan)
        (155, 140, 9.0, true ),  -- Batman Begins         (Action, Christian Bale, Christopher Nolan)
        (12,  142, 8.0, true ),  -- Forrest Gump          (Drama/Romance, Tom Hanks) ← sem match
        (46,  155, 7.0, false)   -- Nuovo Cinema Paradiso (Drama/Romance) ← sem match
     ) AS h(movie_id, minutes_watched, user_average, liked)
WHERE u.name = 'Beatriz';


-- ================================================================
INSERT INTO tbl_historic (user_id, movie_id, minutes_watched, user_average, liked)
SELECT u.id, h.movie_id, h.minutes_watched, h.user_average, h.liked
FROM tbl_users u,
     (VALUES
        (43,  110, 8.0, true ),  -- Léon         (Action/Crime) ← match; completo
        (15,   68, 7.0, false),  -- The Matrix   (Action/Sci-Fi) ← Action match; 50%
        (12,  142, 9.0, true ),  -- Forrest Gump (Drama/Romance) ← sem match; completo
        (1,    71, 8.0, true ),  -- Shawshank    (Drama) ← sem match; 50%
        (46,   78, 7.0, false)   -- Nuovo Cinema Paradiso (Drama/Romance) ← sem match; 50%
     ) AS h(movie_id, minutes_watched, user_average, liked)
WHERE u.name = 'Diego';


-- ================================================================
INSERT INTO tbl_historic (user_id, movie_id, minutes_watched, user_average, liked)
SELECT u.id, h.movie_id, h.minutes_watched, h.user_average, h.liked
FROM tbl_users u,
     (VALUES
        (1,   142, 9.0, true ),  -- The Shawshank Redemption (Drama, Frank Darabont)
        (12,  142, 8.0, true ),  -- Forrest Gump             (Drama/Romance, Tom Hanks)
        (46,  155, 7.0, true ),  -- Nuovo Cinema Paradiso    (Drama/Romance)
        (51,  102, 8.0, true ),  -- Casablanca               (Drama/Romance)
        (33,  130, 8.0, true )   -- It's a Wonderful Life    (Drama/Family)
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
