---
title: Customers
---

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
    email,
    ROUND(SUM(amount),0) AS spent
  FROM sakila.customerspay
  WHERE
    (${inputs.stores.value} IS null OR store_id = ${inputs.stores.value})
  GROUP BY
    customer,
    email
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

<DataTable data={tcp_top_customer_pay}/>