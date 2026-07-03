import re
import pandas as pd
import psycopg2
from psycopg2.extras import execute_values

CSV_FILE = "imdb_top_1000.csv"

DB_CONFIG = {
    "host": "localhost",
    "port": 5432,
    "database": "recommendation_films_db",
    "user": "postgres",
    "password": "root"
}


def normalize(value):
    if value is None:
        return None

    value = str(value).strip()

    if not value or value.lower() == "nan":
        return None

    return value


def extract_duration(runtime):
    if not runtime:
        return 0

    match = re.search(r"(\d+)", str(runtime))

    if not match:
        return 0

    return int(match.group(1))


def get_or_create_actor(cursor, cache, actor_name):
    actor_name = normalize(actor_name)

    if not actor_name:
        return None

    if actor_name in cache:
        return cache[actor_name]

    cursor.execute(
        """
        SELECT id
        FROM tbl_actors
        WHERE name = %s
        """,
        (actor_name,)
    )

    result = cursor.fetchone()

    if result:
        cache[actor_name] = result[0]
        return result[0]

    cursor.execute(
        """
        INSERT INTO tbl_actors (name)
        VALUES (%s)
        RETURNING id
        """,
        (actor_name,)
    )

    actor_id = cursor.fetchone()[0]
    cache[actor_name] = actor_id

    return actor_id


def get_or_create_director(cursor, cache, director_name):
    director_name = normalize(director_name)

    if not director_name:
        return None

    if director_name in cache:
        return cache[director_name]

    cursor.execute(
        """
        SELECT id
        FROM tbl_directors
        WHERE name = %s
        """,
        (director_name,)
    )

    result = cursor.fetchone()

    if result:
        cache[director_name] = result[0]
        return result[0]

    cursor.execute(
        """
        INSERT INTO tbl_directors (name)
        VALUES (%s)
        RETURNING id
        """,
        (director_name,)
    )

    director_id = cursor.fetchone()[0]
    cache[director_name] = director_id

    return director_id


def get_or_create_gender(cursor, cache, gender_name):
    gender_name = normalize(gender_name)

    if not gender_name:
        return None

    if gender_name in cache:
        return cache[gender_name]

    cursor.execute(
        """
        SELECT id
        FROM tbl_genders
        WHERE name = %s
        """,
        (gender_name,)
    )

    result = cursor.fetchone()

    if result:
        cache[gender_name] = result[0]
        return result[0]

    cursor.execute(
        """
        INSERT INTO tbl_genders (name)
        VALUES (%s)
        RETURNING id
        """,
        (gender_name,)
    )

    gender_id = cursor.fetchone()[0]
    cache[gender_name] = gender_id

    return gender_id


def movie_exists(cursor, title):
    cursor.execute(
        """
        SELECT id
        FROM tbl_movies
        WHERE title = %s
        """,
        (title,)
    )

    result = cursor.fetchone()

    return result[0] if result else None


def main():
    df = pd.read_csv(CSV_FILE)

    conn = psycopg2.connect(**DB_CONFIG)
    conn.autocommit = False

    actor_cache = {}
    director_cache = {}
    gender_cache = {}

    try:
        with conn.cursor() as cursor:

            for _, row in df.iterrows():

                title = normalize(row["Series_Title"])

                if not title:
                    continue

                movie_id = movie_exists(cursor, title)

                if movie_id:
                    continue

                description = normalize(row["Overview"]) or ""

                duration = extract_duration(row["Runtime"])

                average = float(row["IMDB_Rating"])

                released_year_raw = str(row["Released_Year"]).strip()

                if released_year_raw == "PG":
                    released_year = 1995
                else:
                    try:
                        released_year = int(released_year_raw)
                    except (ValueError, TypeError):
                        released_year = 0

                cursor.execute(
                    """
                    INSERT INTO tbl_movies (
                        title,
                        description,
                        duration,
                        released_year,
                        average
                    )
                    VALUES (
                        %s,
                        %s,
                        %s,
                        %s,
                        %s
                    )
                    RETURNING id
                    """,
                    (
                        title,
                        description,
                        duration,
                        released_year,
                        average
                    )
                )
                movie_id = cursor.fetchone()[0]

                director_id = get_or_create_director(
                    cursor,
                    director_cache,
                    row["Director"]
                )

                cursor.execute(
                    """
                    INSERT INTO tbl_movie_director (
                        movie_id,
                        director_id
                    )
                    VALUES (%s, %s)
                    ON CONFLICT DO NOTHING
                    """,
                    (
                        movie_id,
                        director_id
                    )
                )

                actors = [
                    row["Star1"],
                    row["Star2"]
                ]

                for actor in actors:

                    actor_id = get_or_create_actor(
                        cursor,
                        actor_cache,
                        actor
                    )

                    cursor.execute(
                        """
                        INSERT INTO tbl_movie_actor (
                            movie_id,
                            actor_id
                        )
                        VALUES (%s, %s)
                        ON CONFLICT DO NOTHING
                        """,
                        (
                            movie_id,
                            actor_id
                        )
                    )

                genres = [
                    genre.strip()
                    for genre in str(row["Genre"]).split(",")
                    if genre.strip()
                ][:2]

                for genre in genres:

                    gender_id = get_or_create_gender(
                        cursor,
                        gender_cache,
                        genre
                    )

                    cursor.execute(
                        """
                        INSERT INTO tbl_movie_gender (
                            movie_id,
                            gender_id
                        )
                        VALUES (%s, %s)
                        ON CONFLICT DO NOTHING
                        """,
                        (
                            movie_id,
                            gender_id
                        )
                    )

        conn.commit()

        print("Importação concluída.")

    except Exception as ex:
        conn.rollback()
        raise ex

    finally:
        conn.close()


if __name__ == "__main__":
    main()
