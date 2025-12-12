---
title: Manager report
---

<Slider
    title="Film length exceeds"
    name=FilmLengthIn
    defaultValue=180
    min=50
    max=180
    showMaxMin=true
/>

<DataTable data={film_length}/>

```sql film_length
  SELECT
    title,
    length
  from sakila.film_list
  WHERE length > ${inputs.FilmLengthIn}
```

<TextInput
    name=searchword
    title="Search the title for"
    defaultValue="LOVE"
/>

Selected: {inputs.searchword}

<DataTable data={title_search}/>

```sql title_search
  SELECT
    title,
    rating,
    length,
    description
  FROM sakila.film_list
  WHERE
    title LIKE UPPER('% '||'${inputs.searchword}') OR
    title LIKE UPPER('${inputs.searchword}'||' %') OR
    title LIKE UPPER('% '||'${inputs.searchword}'||' %');
```

<Dropdown
  data={categories}
  name=category
  value=category
  defaultValue="All Categories">
    <DropdownOption value="%" valueLabel="All Categories"/>
</Dropdown>

```sql film_length_stat
  SELECT
    MIN(length) AS Shortest,
    ROUND(AVG(length),0) AS Average,
    ROUND(MEDIAN(length),0) AS Median,
    MAX(length) AS Longest
  FROM sakila.films_with_category
  WHERE category LIKE '${inputs.category.value}';
```


```sql categories
  SELECT DISTINCT
      category
  from sakila.films_with_category
```