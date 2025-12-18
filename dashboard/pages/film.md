---
title: Film
---

<Details title='Wordsearch'>
  With this wordsearch you can do searches by your self and se the titles. You can also do partly search by using %
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
  FROM sakila.film
  WHERE
    title LIKE UPPER('% '||'${inputs.ts_textin}') OR
    title LIKE UPPER('${inputs.ts_textin}'||' %') OR
    title LIKE UPPER('% '||'${inputs.ts_textin}'||' %');
```

<DataTable data={ts_title_search}/>

## Witch films exeeds 180 min?

<Details title='Slider'>
  With this slider you can choose the length yourself.
</Details>

<Slider
    title="Film length exceeds"
    name=fle_slider
    defaultValue=180
    min=50
    max=180
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

```sql fls_categories
  SELECT DISTINCT
      category
  from sakila.film
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
  FROM sakila.film
  WHERE category LIKE '${inputs.category.value}';
```

<DataTable data={fls_film_length_stat}/>
