SELECT
    p.payment_id,
    p.customer_id,
    p.staff_id,
    p.rental_id,
    p.amount,
    p.payment_date,
    c.store_id,
    c.first_name || ' ' || c.last_name AS customer,
    c.email,
    c.active,
    c.create_date,
    a.address,
    ci.city,
    co.country
FROM
    staging.payment p
    LEFT JOIN staging.customer c ON c.customer_id = p.customer_id
    LEFT JOIN staging.address a ON a.address_id = c.address_id
    LEFT JOIN staging.city ci ON ci.city_id = a.city_id
    LEFT JOIN staging.country co ON co.country_id = ci.country_id;