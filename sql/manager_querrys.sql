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

-- Most spent
SELECT
    c.customer_id,
    c.first_name || ' ' || c.last_name AS customer,
    sum(p.amount) AS total_spend
FROM
    staging.payment p
    LEFT JOIN staging.customer c ON c.customer_id = p.customer_id
    LEFT JOIN staging.store s ON s.store_id = c.store_id
GROUP BY
  customer, c.customer_id
ORDER BY
  total_spend DESC;

-- Most money per category
SELECT
    c.name AS category,
    SUM(p.amount) total_sum,
FROM
    staging.payment p
    LEFT JOIN staging.rental r ON p.rental_id = r.rental_id
    INNER JOIN staging.inventory i ON i.inventory_id = r.inventory_id
    INNER JOIN staging.film f ON f.film_id = i.film_id
    INNER JOIN staging.film_category fc ON fc.film_id = f.film_id
    INNER JOIN staging.category c ON c.category_id = fc.category_id
GROUP BY
    category
ORDER BY
    total_sum DESC;