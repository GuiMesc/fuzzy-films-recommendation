"""Queries SQL utilizadas por recommendation.py."""

GET_USER_ID_BY_NAME = """
SELECT id FROM tbl_users WHERE name = %s LIMIT 1;
"""

GET_USER_PROFILE = """
SELECT
    g.name  AS favorite_gender,
    a.name  AS favorite_actor,
    d.name  AS favorite_director
FROM tbl_users u
LEFT JOIN tbl_genders   g ON g.id = u.favorite_gender_id
LEFT JOIN tbl_actors    a ON a.id = u.favorite_actor_id
LEFT JOIN tbl_directors d ON d.id = u.favorite_director_id
WHERE u.id = %s;
"""

GET_HISTORY = """
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
"""

GET_MOVIE_BY_ID = """
SELECT
    m.id, m.title, m.description, m.duration,
    m.released_year, m.average,
    COALESCE(
        (SELECT json_agg(json_build_object('name', g.name))
         FROM tbl_movie_gender mg
         JOIN tbl_genders g ON mg.gender_id = g.id
         WHERE mg.movie_id = m.id), '[]'::json
    ) AS genders,
    COALESCE(
        (SELECT json_agg(json_build_object('name', a.name))
         FROM tbl_movie_actor ma
         JOIN tbl_actors a ON ma.actor_id = a.id
         WHERE ma.movie_id = m.id), '[]'::json
    ) AS actors,
    COALESCE(
        (SELECT json_agg(json_build_object('name', d.name))
         FROM tbl_movie_director md
         JOIN tbl_directors d ON md.director_id = d.id
         WHERE md.movie_id = m.id), '[]'::json
    ) AS directors
FROM tbl_movies m
WHERE m.id = %s;
"""

GET_MOVIES = """
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
WHERE m.id = 64;
"""

SAVE_RECOMMENDATION = """
INSERT INTO tbl_recommendations (user_id, movie_id, recommendation_score)
VALUES (%s, %s, %s)
ON CONFLICT (user_id, movie_id)
DO UPDATE SET recommendation_score = EXCLUDED.recommendation_score;
"""
