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
