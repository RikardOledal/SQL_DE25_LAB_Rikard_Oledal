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
        category;