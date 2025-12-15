---
title: Manager report
---
## Witch films exeeds 180 min?
```sql fle_max_min
  SELECT
    MAX(length) AS max,
    MIN(length) AS min
  FROM sakila.film_list
```

<Details title='Slider'>
  With this slider you can choose the length yourself.
</Details>

<Slider
    title="Film length exceeds"
    name=fle_slider
    defaultValue=180
    min={fle_max_min[0].min}
    max={fle_max_min[0].max}
    showMaxMin=true
/>

```sql fle_film_length_exceeds
  SELECT
    title,
    length
  from sakila.film_list
  WHERE length > ${inputs.fle_slider}
```

<DataTable data={fle_film_length_exceeds}/>

<Details title='Textsearch'>
  With this slider you can choose the length yourself.
</Details>

<TextInput
    name=ts_textin
    title="Search the title for"
    defaultValue="LOVE"
/>

Searchword: {inputs.ts_textin}

```sql ts_title_search
  SELECT
    title,
    rating,
    length,
    description
  FROM sakila.film_list
  WHERE
    title LIKE UPPER('% '||'${inputs.ts_textin}') OR
    title LIKE UPPER('${inputs.ts_textin}'||' %') OR
    title LIKE UPPER('% '||'${inputs.ts_textin}'||' %');
```

<DataTable data={ts_title_search}/>

```sql fls_categories
  SELECT DISTINCT
      category
  from sakila.films_with_category
```
<Dropdown
  data={fls_categories}
  name=category
  value=category
  defaultValue="%">
    <DropdownOption value="%" valueLabel="All Categories"/>
</Dropdown>

```sql fls_film_length_stat
  SELECT
    MIN(length) AS Shortest,
    ROUND(AVG(length),0) AS Average,
    ROUND(MEDIAN(length),0) AS Median,
    MAX(length) AS Longest
  FROM sakila.films_with_category
  WHERE category LIKE '${inputs.category.value}';
```

<DataTable data={fls_film_length_stat}/>


```sql tcp_stores
  SELECT
      store_id,
      CONCAT('Store ',store_id::INT) AS store_label
  FROM sakila.store_list
```
<div style="display: flex; gap: 20px;">
  <Dropdown
    data={tcp_stores}
    name=stores
    value=store_id
    label=store_label
    defaultValue={undefined}>
      <DropdownOption value={null} valueLabel="All Stores"/>
  </Dropdown>

  <Dropdown name=TopCustomers>
      <DropdownOption valueLabel="Top 5" value="5" />
      <DropdownOption valueLabel="Top 10" value="10" />
      <DropdownOption valueLabel="Top 20" value="20" />
  </Dropdown>

</div>


```sql tcp_top_customer_pay
  SELECT
    customer,
    ROUND(SUM(amount),0) AS spent
  FROM sakila.customerspay
  WHERE
    (${inputs.stores.value} IS null OR store_id = ${inputs.stores.value})
  GROUP BY
    customer
  ORDER BY
    spent DESC
  LIMIT
    ${inputs.TopCustomers.value}
```

<BarChart 
    data={tcp_top_customer_pay}
    x=customer
    y=spent
    swapXY=true
    yFmt=usd0
/>

Hej

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
    total_sum
  FROM sakila.film_rev_by_cat
  ORDER BY
    total_sum DESC
  LIMIT
    ${inputs.TopCategorys.value}
```

<BarChart 
    data={rbc_rev_by_cat}
    x=category
    y=total_sum
/>


