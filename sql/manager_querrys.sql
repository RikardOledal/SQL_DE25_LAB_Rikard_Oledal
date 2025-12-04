-- Movies lenght more than 180 min

SELECT
    title,
    length
FROM
    film
WHERE
    length > 180;

-- Movies with love in the title

SELECT
    title,
    rating,
    length,
    description
FROM
    film
WHERE
    title LIKE '% LOVE' OR
    title LIKE 'LOVE %' OR
    title LIKE '% LOVE %';

-- Movie lenght statistics

SELECT
    MIN(length) AS Shortest_min,
    round(AVG(length),0) AS Average_min,
    round(MEDIAN(length),0) AS Median_min,
    MAX(length) AS Longest_min
FROM
    film;

-- Rate per day

SELECT
    title,
    ROUND((rental_rate / rental_duration),2) AS Rent_per_day
FROM
    film
ORDER BY
    Rent_per_day DESC,
    title ASC
LIMIT
    10;

-- Actor in most movies

SELECT
    a.first_name || ' ' || a.last_name AS Actor,
    COUNT(*) AS Nr_movies
FROM
    film_actor fa
LEFT JOIN actor a ON a.actor_id = fa.actor_id
GROUP BY
    Actor
ORDER BY
    Nr_movies DESC
LIMIT
    10;