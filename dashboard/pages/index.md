---
title: Manager report
---

This page is made to get an overview of what is selling best for the purpose of buying new movies. Therefore, you can also see which actor is most popular in each category to buy something popular. There is also information about which movies are selling worst that you should get rid of.

<Dropdown 
  name=TopCategorys
  defaultValue={10}
  >
    <DropdownOption valueLabel="Top 5" value={5} />
    <DropdownOption valueLabel="Top 10" value={10} />
    <DropdownOption valueLabel="All" value={20} />
</Dropdown>


```sql rbc_rev_by_cat
  SELECT
    category,
    SUM(amount) AS total_sum
  FROM sakila.rental_pay
  GROUP BY
    category
  ORDER BY
    total_sum DESC
  LIMIT
    ${inputs.TopCategorys.value}

```


<BarChart 
    data={rbc_rev_by_cat}
    x=category
    y=total_sum
    title="Revenue per category"
/>

<Details title='Revenue in relation to inventory'>
  The fact that a category sells a lot may be because we have a lot of films in that category. In this diagram, we show the relationship between revenue and the number of films in that category.
</Details>

```sql mrfc_most_rev_film_cat
    SELECT
        category,
        COUNT(DISTINCT inventory_id) AS nr_films,
        COUNT(inventory_id) AS nr_rentals,
        SUM(amount) AS revenue,
        ROUND(SUM(amount) / COUNT(DISTINCT inventory_id),2) AS "Revenue/Film"
    FROM
        sakila.rental_pay
    GROUP BY
        category
    ORDER BY
        "Revenue/Film" DESC
    LIMIT
      ${inputs.TopCategorys.value};
```

<BarChart 
    data={mrfc_most_rev_film_cat}
    x=category
    y="Revenue/Film"
    title="Revenue per category relation to inventory"
/>

<DataTable data={mrfc_most_rev_film_cat}/>

```sql mpa_categories
  SELECT DISTINCT
      category
  from sakila.film
```

<Dropdown
  data={mpa_categories}
  name=category
  value=category
  defaultValue="%">
    <DropdownOption value="%" valueLabel="All Categories"/>
</Dropdown>

```sql mpa_most_popular_actor
    SELECT
        actor_name,
        COUNT(actor_id) AS nr_films
    FROM
        sakila.actor
    WHERE
        category LIKE '${inputs.category.value}'
    GROUP BY
        actor_name
    ORDER BY
        nr_films DESC,
        actor_name ASC
    LIMIT
        5;
```

<BarChart 
    data={mpa_most_popular_actor}
    title="Most popular actor"
    x=actor_name
    y=nr_films
/>

```sql lrf_least_rev_film
    SELECT
        title AS film,
        COUNT(DISTINCT inventory_id) AS nr_films,
        COUNT(rental_id) AS nr_rental,
        SUM(amount) AS revenue
    FROM
        sakila.rental_pay
    GROUP BY
        film
    ORDER BY
        revenue ASC,
        nr_rental ASC
    LIMIT
        5;
```
<DataTable title="Films with least revenue" data={lrf_least_rev_film}/>

