SELECT
    rp.customer_name,
    c.email,
    rp.amount,
    rp.store_id
FROM
    refined.rental_pay rp
    LEFT JOIN refined.customer c ON c.customer_id = rp.customer_id;