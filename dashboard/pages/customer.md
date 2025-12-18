---
title: Customers
---

This page is made to see which customers have spent the most money. This is so that we can email them special offers.

```sql tcp_stores
  SELECT
      store_id,
      store_name
  FROM sakila.store
```
<div style="display: flex; gap: 20px;">
  <Dropdown
    data={tcp_stores}
    name=stores
    value=store_id
    label=store_name
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
    customer_name,
    email,
    ROUND(SUM(amount),0) AS spent
  FROM sakila.rental_pay_email
  WHERE
    (${inputs.stores.value} IS null OR store_id = ${inputs.stores.value})
  GROUP BY
    customer_name,
    email
  ORDER BY
    spent DESC
  LIMIT
    ${inputs.TopCustomers.value}
```

<BarChart 
    data={tcp_top_customer_pay}
    title="Top customers"
    x=customer_name
    y=spent
    swapXY=true
    yFmt=usd0
/>

<DataTable data={tcp_top_customer_pay}/>