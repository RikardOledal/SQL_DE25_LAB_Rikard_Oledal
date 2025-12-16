---
title: Manager report
---

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


