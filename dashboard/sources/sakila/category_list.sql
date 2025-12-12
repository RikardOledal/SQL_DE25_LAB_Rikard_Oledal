SELECT
    *
FROM
    staging.category;
LEFT JOIN staging.film_category fc ON fc.film_id = f.film_id
LEFT JOIN staging.category c ON c.category_id = fc.category_id