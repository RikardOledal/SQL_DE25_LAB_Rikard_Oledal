-- Movies lenght more than 180 min
SELECT
    title,
    length
FROM
    refined.film
WHERE
    length > 180;

-- Movies with love in the title

SELECT
    title,
    rating,
    length,
    description
FROM
    refined.film
WHERE
    title LIKE '% LOVE' OR
    title LIKE 'LOVE %' OR
    title LIKE '% LOVE %';

-- Movie lenght statistics

SELECT
    MIN(length) AS Shortest_min,
    round(AVG(length), 0) AS Average_min,
    round(MEDIAN (length), 0) AS Median_min,
    MAX(length) AS Longest_min
FROM
    refined.film;

-- Rate per day

SELECT
    title,
    ROUND((rental_rate / rental_duration), 2) AS Rent_per_day
FROM
    refined.film
ORDER BY
    Rent_per_day DESC,
    title ASC
LIMIT
    10;

-- Actor in most movies
SELECT
    actor_name,
    COUNT(*) AS Nr_films
FROM
    refined.actor
GROUP BY
    actor_name
ORDER BY
    Nr_films DESC
LIMIT
    10;

-- Most spent
SELECT
    customer_id,
    customer_name,
    SUM(amount) AS total_spend
FROM
    refined.rental_pay
GROUP BY
    customer_name,
    customer_id
ORDER BY
    total_spend DESC
LIMIT
    5;



-- Best rev/film grouped by category
SELECT
    i.category,
    COUNT(DISTINCT i.inventory_id) AS nr_film,
    COUNT(i.inventory_id) AS rental_film,
    SUM(rp.amount) AS revenue,
    ROUND(SUM(rp.amount) / COUNT(DISTINCT i.inventory_id),2) AS Rev_Film
FROM
    refined.inventory i
    LEFT JOIN refined.rental_pay rp ON rp.inventory_id = i.inventory_id
GROUP BY
    i.category
ORDER BY
    Rev_Film DESC;

-- Most popular Actor in the Comedy category
SELECT
    category,
    actor_name,
    COUNT(actor_id) AS nr_films
FROM
    refined.actor
WHERE
    category = 'Comedy'
GROUP BY
    actor_name,
    category
ORDER BY
    nr_films DESC,
    actor_name ASC
LIMIT
    5;

-- Least revenue per film
SELECT
    title AS film,
    COUNT(DISTINCT inventory_id) AS nr_films,
    COUNT(rental_id) AS nr_rental,
    SUM(amount) AS revenue
FROM
    refined.rental_pay
GROUP BY
    film
ORDER BY
    revenue ASC,
    nr_rental ASC
LIMIT
    10;

-- Most Revenue per customer
SELECT
    customer_id,
    customer_name,
    SUM(amount) AS total_spend
FROM
    refined.rental_pay
GROUP BY
    customer_name,
    customer_id
ORDER BY
    total_spend DESC
LIMIT
    5;

-- Most money per category
SELECT
    category,
    SUM(amount) total_sum,
FROM
    refined.rental_pay
GROUP BY
    category
ORDER BY
    total_sum DESC;