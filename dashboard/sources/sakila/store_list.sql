SELECT
  so.store_id,
  so.manager_staff_id,
  st.first_name || ' ' || st.last_name AS manager_name,
  ad.address,
  city,
  country
FROM staging.store so
LEFT JOIN staging.staff st ON st.staff_id = so.manager_staff_id
LEFT JOIN staging.address ad ON ad.address_id = so.address_id
LEFT JOIN staging.city ci ON ci.city_id = ad.city_id
LEFT JOIN staging.country co ON co.country_id = ci.country_id;