SELECT
    p.payment_id,
    p.amount,
    p.payment_date,
    cu.store_id,
    cu.first_name || ' ' || cu.last_name AS customer_name,
    cu.email,
    cu.active,
    cu.create_date,
    a.address AS customer_address,
    r.rental_date,
    r.return_date,
    c.name AS category,
    f.title,
    f.release_year,
    f.rental_duration,
    f.rental_rate,
    f.length,
    f.replacement_cost,
    f.rating,
    f.special_features
FROM
    staging.payment p
LEFT JOIN staging.rental r ON p.rental_id = r.rental_id
LEFT JOIN staging.customer cu ON p.customer_id = cu.customer_id
LEFT JOIN staging.address a ON cu.address_id = a.address_id
LEFT JOIN staging.inventory i ON i.inventory_id = r.inventory_id
LEFT JOIN staging.film f ON f.film_id = i.film_id
LEFT JOIN staging.film_category fc ON fc.film_id = f.film_id
LEFT JOIN staging.category c ON c.category_id = fc.category_id;