---yc 1
select  FORMAT_DATE('%Y-%m', created_at) AS order_month,
count(user_id) as total_user,
count(order_id) as total_order 
from bigquery-public-data.thelook_ecommerce.orders
where status ="Complete" and FORMAT_DATE('%Y-%m', created_at) between '2019-01' and '2022-04'
group by 1

---yc 2
  SELECT 
  FORMAT_DATE('%Y-%m', created_at) AS order_month,
  COUNT(DISTINCT user_id) AS distinct_users,
  SUM(sale_price) / COUNT(order_id) AS avg_order_value
FROM 
  bigquery-public-data.thelook_ecommerce.order_items
WHERE 
  FORMAT_DATE('%Y-%m', created_at) BETWEEN '2019-01' AND '2022-04'
GROUP BY 
  1
ORDER BY 
  order_month;
---yc 3

CREATE TEMP TABLE youngestnoldest AS (
  WITH cte AS (
    SELECT
      first_name,
      last_name,
      gender,
      age,
      'youngest' AS tag
    FROM
      bigquery-public-data.thelook_ecommerce.users
    WHERE
      age IN (SELECT MIN(age) FROM bigquery-public-data.thelook_ecommerce.users GROUP BY gender)

    UNION ALL

    SELECT
      first_name,
      last_name,
      gender,
      age,
      'oldest' AS tag
    FROM
      bigquery-public-data.thelook_ecommerce.users
    WHERE
      age IN (SELECT MAX(age) FROM bigquery-public-data.thelook_ecommerce.users GROUP BY gender)
  )

  SELECT
    first_name,
    last_name,
    gender,
    age,
    tag
  FROM
    cte
);

SELECT
  first_name,
  last_name,
  gender,
  age,
  tag
FROM
  youngestnoldest;
---yc 4
WITH cte AS (
SELECT
  FORMAT_DATE('%Y-%m', created_at) as order_date,
  a.product_id,
  b.name AS product_name,
  SUM(a.sale_price) AS total_sales,
  SUM(b.cost) AS total_cost,
  SUM(a.sale_price - b.cost) AS total_profit,
  DENSE_RANK() OVER (PARTITION BY FORMAT_DATE('%Y-%m', created_at) ORDER BY SUM(a.sale_price - b.cost) DESC) AS rank_per_month
FROM
  bigquery-public-data.thelook_ecommerce.order_items as a
JOIN
  bigquery-public-data.thelook_ecommerce.products as b ON a.product_id = b.id
GROUP BY
  1, 2, 3, created_at
)

SELECT
order_date AS month_year,
product_id,
product_name,
total_sales,
total_cost,
total_profit,
rank_per_month
FROM
cte
WHERE
rank_per_month <= 5;
---yc5
select FORMAT_DATE('%Y-%m-%d', created_at) as order_date,
b.category as product_category,
sum(a.sale_price) as revenue
from bigquery-public-data.thelook_ecommerce.order_items as a
join bigquery-public-data.thelook_ecommerce.products as b on a.product_id=b.id
where FORMAT_DATE('%Y-%m-%d', created_at) between '2022-01-15' and '2022-04-15'
group by FORMAT_DATE('%Y-%m-%d', created_at),b.category
order by 1 desc,2
