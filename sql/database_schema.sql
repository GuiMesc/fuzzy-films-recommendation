--- Toda a estrutura do banco de dados ---

CREATE TABLE tbl_users (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    favorite_actor_id BIGINT,
    favorite_director_id BIGINT,
    favorite_gender_id BIGINT,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE tbl_actors (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE tbl_genders (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE tbl_directors (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE tbl_movies (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    duration INTEGER NOT NULL,
    released_year INTEGER NOT NULL DEFAULT 0,
    average DOUBLE PRECISION NOT NULL DEFAULT 0
);

ALTER TABLE tbl_users
    ADD CONSTRAINT fk_users_actor
    FOREIGN KEY (favorite_actor_id)
    REFERENCES tbl_actors(id);

ALTER TABLE tbl_users
    ADD CONSTRAINT fk_users_director
    FOREIGN KEY (favorite_director_id)
    REFERENCES tbl_directors(id);

ALTER TABLE tbl_users
    ADD CONSTRAINT fk_users_gender
    FOREIGN KEY (favorite_gender_id)
    REFERENCES tbl_genders(id);

CREATE TABLE tbl_movie_actor (
    movie_id BIGINT NOT NULL,
    actor_id BIGINT NOT NULL,

    PRIMARY KEY (movie_id, actor_id),

    CONSTRAINT fk_movie_actor_movie
        FOREIGN KEY (movie_id)
        REFERENCES tbl_movies(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_movie_actor_actor
        FOREIGN KEY (actor_id)
        REFERENCES tbl_actors(id)
);

CREATE TABLE tbl_movie_director (
    movie_id BIGINT NOT NULL,
    director_id BIGINT NOT NULL,

    PRIMARY KEY (movie_id, director_id),

    CONSTRAINT fk_movie_director_movie
        FOREIGN KEY (movie_id)
        REFERENCES tbl_movies(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_movie_director_director
        FOREIGN KEY (director_id)
        REFERENCES tbl_directors(id)
);

CREATE TABLE tbl_movie_gender (
    movie_id BIGINT NOT NULL,
    gender_id BIGINT NOT NULL,

    PRIMARY KEY (movie_id, gender_id),

    CONSTRAINT fk_movie_gender_movie
        FOREIGN KEY (movie_id)
        REFERENCES tbl_movies(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_movie_gender_gender
        FOREIGN KEY (gender_id)
        REFERENCES tbl_genders(id)
);

CREATE TABLE tbl_recommendations (
    user_id BIGINT NOT NULL,
    movie_id BIGINT NOT NULL,
    recommendation_score DOUBLE PRECISION,

    PRIMARY KEY (user_id, movie_id),

    CONSTRAINT fk_recommendations_user
        FOREIGN KEY (user_id)
        REFERENCES tbl_users(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_recommendations_movie
        FOREIGN KEY (movie_id)
        REFERENCES tbl_movies(id)
        ON DELETE CASCADE
);

CREATE TABLE tbl_historic (
    user_id BIGINT NOT NULL,
    movie_id BIGINT NOT NULL,
    minutes_watched INTEGER NOT NULL,
    user_average DOUBLE PRECISION,
    liked BOOLEAN NOT NULL DEFAULT FALSE,

    PRIMARY KEY (user_id, movie_id),

    CONSTRAINT fk_historic_user
        FOREIGN KEY (user_id)
        REFERENCES tbl_users(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_historic_movie
        FOREIGN KEY (movie_id)
        REFERENCES tbl_movies(id)
        ON DELETE CASCADE
);

CREATE INDEX idx_movie_actor_actor_id
    ON tbl_movie_actor (actor_id);

CREATE INDEX idx_movie_director_director_id
    ON tbl_movie_director (director_id);

CREATE INDEX idx_movie_gender_gender_id
    ON tbl_movie_gender (gender_id);

CREATE INDEX idx_recommendations_movie_id
    ON tbl_recommendations (movie_id);

CREATE INDEX idx_historic_movie_id
    ON tbl_historic (movie_id);

CREATE INDEX idx_historic_liked
    ON tbl_historic (liked);