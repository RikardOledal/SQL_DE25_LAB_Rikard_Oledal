SELECT
    f.film_id,
    f.title,
    c.category_id,
    c.name AS category,
    f.description,
    f.release_year,
    f.rental_duration,
    f.rental_rate,
    f.length,
    f.replacement_cost,
    f.rating,
    f.special_features,
    f.last_update
FROM
    staging.film f
LEFT JOIN staging.film_category fc ON fc.film_id = f.film_id
LEFT JOIN staging.category c ON c.category_id = fc.category_id;