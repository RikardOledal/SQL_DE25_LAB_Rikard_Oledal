CREATE SCHEMA IF NOT EXISTS refined;

CREATE TABLE
    IF NOT EXISTS refined.film AS (
        SELECT
            f.film_id,
            f.title,
            c.name AS category,
            f.description,
            f.release_year,
            f.rental_duration,
            f.rental_rate,
            f.length,
            f.replacement_cost,
            f.rating,
            f.special_features,
            l.name AS language
        FROM
            staging.film f
            LEFT JOIN staging.film_category fc ON fc.film_id = f.film_id
            LEFT JOIN staging.category c ON c.category_id = fc.category_id
            LEFT JOIN staging.language l ON l.language_id = f.language_id
    );

CREATE TABLE
    IF NOT EXISTS refined.actor AS (
            SELECT
                fa.actor_id,
                a.first_name|| ' ' ||a.last_name AS actor_name,
                fa.film_id,
                f.title,
                c.name AS category,
                f.description,
                f.release_year,
                f.length AS film_length,
                f.rating,
                l.name AS film_language
            FROM
                staging.film_actor fa
            LEFT JOIN staging.actor a ON a.actor_id = fa.actor_id
            LEFT JOIN staging.film f ON f.film_id = fa.film_id
            LEFT JOIN staging.film_category fc ON fc.film_id = f.film_id
            LEFT JOIN staging.category c ON c.category_id = fc.category_id
            LEFT JOIN staging.language l ON l.language_id = f.language_id
    );

CREATE TABLE
    IF NOT EXISTS refined.inventory AS (
            SELECT
                i.inventory_id,
                i.store_id,
                'Store ' || store_id AS store_name,
                f.film_id,
                f.title,
                c.name AS category,
                f.description,
                f.release_year,
                f.rental_duration,
                f.rental_rate,
                f.length,
                f.replacement_cost,
                f.rating,
                f.special_features,
                l.name AS language
            FROM
                staging.inventory i
            LEFT JOIN staging.film f ON f.film_id = i.film_id    
            LEFT JOIN staging.film_category fc ON fc.film_id = f.film_id
            LEFT JOIN staging.category c ON c.category_id = fc.category_id
            LEFT JOIN staging.language l ON l.language_id = f.language_id
    );

CREATE TABLE
    IF NOT EXISTS refined.customer AS (
        SELECT
            c.customer_id,
            c.first_name,
            c.last_name,
            c.first_name || ' ' || c.last_name AS customer_name,
            c.email,
            c.store_id,
            c.active,
            c.create_date,
            a.address,
            a.postal_code,
            ci.city,
            co.country
        FROM
            staging.customer c
            LEFT JOIN staging.address a ON a.address_id = c.address_id
            LEFT JOIN staging.city ci ON ci.city_id = a.city_id
            LEFT JOIN staging.country co ON co.country_id = ci.country_id
    );

CREATE TABLE
    IF NOT EXISTS refined.staff AS (
        SELECT
            s.staff_id,
            s.first_name,
            s.last_name,
            s.first_name || ' ' || s.last_name AS staff_name,
            s.email,
            s.store_id,
            s.active,
            s.username,
            s.password,
            a.address,
            ci.city,
            co.country
        FROM
            staging.staff s
            LEFT JOIN staging.address a ON a.address_id = s.address_id
            LEFT JOIN staging.city ci ON ci.city_id = a.city_id
            LEFT JOIN staging.country co ON co.country_id = ci.country_id
    );

CREATE TABLE
    IF NOT EXISTS refined.store AS (
        SELECT
            s.store_id,
            'Store ' || s.store_id AS store_name,
            st.first_name|| ' ' ||st.last_name AS manager,
            st.email,
            a.address,
            ci.city,
            co.country
        FROM
            staging.store s
            LEFT JOIN staging.staff st ON st.staff_id = s.manager_staff_id
            LEFT JOIN staging.address a ON a.address_id = s.address_id
            LEFT JOIN staging.city ci ON ci.city_id = a.city_id
            LEFT JOIN staging.country co ON co.country_id = ci.country_id
    );
CREATE TABLE
    IF NOT EXISTS refined.rental_pay AS (
        SELECT
            r.customer_id,
            cu.first_name||' '||cu.last_name AS customer_name,
            r.rental_id,
            r.rental_date,
            r.inventory_id,
            r.return_date,
            p.payment_id,
            p.amount,
            p.payment_date,
            i.store_id,
            'Store ' || i.store_id AS store_name,
            f.film_id,
            f.title,
            c.name AS category
        FROM
            staging.rental r
        LEFT JOIN staging.payment p ON p.rental_id = r.rental_id 
        LEFT JOIN staging.customer cu ON cu.customer_id = r.customer_id
        LEFT JOIN staging.inventory i ON i.inventory_id = r.inventory_id
        LEFT JOIN staging.film f ON f.film_id = i.film_id    
        LEFT JOIN staging.film_category fc ON fc.film_id = f.film_id
        LEFT JOIN staging.category c ON c.category_id = fc.category_id
    );