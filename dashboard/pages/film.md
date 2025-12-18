---
title: Film
---

This page is made to be able to find information about films. You can see statistics about film lengths and there is also a filmsearch where you can search for words in filmtitles.

<Details title='Filmsearch'>
  With this filmsearch you can do searches by your self and se the titles. You can also do wildcard search by using %
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

# Film lenght

<Details title='Film lenght'>
  With this slider you can choose the length yourself.
</Details>

<Slider
    title="Exceeds"
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
  from sakila.film
  WHERE length > ${inputs.fle_slider}
```

<DataTable
    title="Film length exceeds {inputs.fle_slider}"
    data={fle_film_length_exceeds}/>

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

<DataTable
    title={inputs.category.value === '%' 
        ? "Film length statistics on all categories" 
        : `Film length statistics on ${inputs.category.value}`}
    data={fls_film_length_stat}/>
