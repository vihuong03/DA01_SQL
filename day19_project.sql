---Chuyển đổi kiểu dữ liệu phù hợp cho các trường ( sử dụng câu lệnh ALTER) 
ALTER TABLE sales_dataset_rfm_prj
ALTER COLUMN ordernumber TYPE integer USING ordernumber::integer,
ALTER COLUMN quantityordered TYPE integer USING quantityordered::integer,
ALTER COLUMN priceeach TYPE numeric USING priceeach::numeric,
ALTER COLUMN orderlinenumber TYPE integer USING orderlinenumber::integer,
ALTER COLUMN sales TYPE numeric USING sales::numeric,
ALTER COLUMN orderdate TIMESTAMP USING orderdate::TIMESTAMP,
ALTER COLUMN msrp TYPE numeric USING msrp::numeric
---check null/blank
select * from sales_dataset_rfm_prj
WHERE 
  ordernumber IS NULL
  OR quantityordered IS NULL 
  OR priceeach IS NULL  
  OR orderlinenumber IS NULL 
  OR sales IS NULL 
  OR orderdate IS NULL 
--- thêm cột,viết tên,viết hoa
ALTER TABLE sales_dataset_rfm_prj
ADD COLUMN contactfirstname VARCHAR,
ADD COLUMN contactlastname VARCHAR

UPDATE sales_dataset_rfm_prj
SET
  contactfirstname = SUBSTRING(contactfullname FROM 1 FOR POSITION('-' IN contactfullname) - 1),
  contactlastname = SUBSTRING(contactfullname FROM POSITION('-' IN contactfullname) + 1)

UPDATE sales_dataset_rfm_prj
SET
  contactfirstname = UPPER(LEFT(contactfirstname, 1)) || LOWER(RIGHT(contactfirstname, LENGTH(contactfirstname) - 1)),
  contactlastname = UPPER(LEFT(contactlastname, 1)) || LOWER(RIGHT(contactlastname, LENGTH(contactlastname) - 1))
--- thêm cột quý tháng năm
ALTER TABLE sales_dataset_rfm_prj
ADD COLUMN qtr_id INT,
ADD COLUMN month_id INT,
ADD COLUMN year_id INT
  
UPDATE sales_dataset_rfm_prj
SET
  qtr_id = EXTRACT(QUARTER FROM orderdate),
  month_id = EXTRACT(MONTH FROM orderdate),
  year_id = EXTRACT(YEAR FROM orderdate)
---tìm outliers
with cte as(
select q1-1.5*IQR as min_value,
q3+1.5*IQR as max_value
from(
select
percentile_cont(0.25) within group (order by quantityordered) as q1,
percentile_cont(0.75) within group (order by quantityordered) as q3,
percentile_cont(0.75) within group (order by quantityordered)-percentile_cont(0.25) within group (order by quantityordered) as IQR
from sales_dataset_rfm_prj) as a)

select * from sales_dataset_rfm_prj
where quantityordered<(select min_value from cte)
or quantityordered>(select max_value from cte) 
--- xóa outliers
WITH cte AS (
SELECT
percentile_cont(0.25) WITHIN GROUP (ORDER BY quantityordered) AS q1,
percentile_cont(0.75) WITHIN GROUP (ORDER BY quantityordered) AS q3,
percentile_cont(0.75) WITHIN GROUP (ORDER BY quantityordered) - percentile_cont(0.25) WITHIN GROUP (ORDER BY quantityordered) AS IQR
FROM
sales_dataset_rfm_prj
)
DELETE FROM sales_dataset_rfm_prj
WHERE quantityordered < (SELECT q1 - 1.5 * IQR FROM cte)
OR quantityordered > (SELECT q3 + 1.5 * IQR FROM cte)
--- lưu bảng mới
CREATE TABLE sales_dataset_rfm_prj_clean AS
SELECT *
FROM sales_dataset_rfm_prj;

