---bai 1
with cte as(
SELECT company_id,title,description,
count(job_id)
from job_listings
group by company_id, title,description)
select count(distinct company_id) as duplicate
from cte 
where count=2
---bai 2
with ranking_cte as(
SELECT category,product,
sum(spend) as total_spending,
rank() over( 
partition by category 
order by sum(spend) desc) as rank
from product_spend
where extract(year from transaction_date)=2022
group by category,product)
select category, product, total_spending
from ranking_cte
where rank<3
---bai 3
with cte as (
SELECT policy_holder_id, count(*) as num_of_calls
FROM callers
group by policy_holder_id
having count(*)>=3)
select count(policy_holder_id) as member_count
from cte
---bai 4
SELECT a.page_id
FROM pages as a  
left join page_likes as b  
on a.page_id=b.page_id
where b.liked_date is null
order by a.page_id
---bai 5
with cte as( 
SELECT user_id
FROM user_actions
WHERE 
EXTRACT(MONTH FROM event_date) IN (6, 7) -- Filter for June and July
AND EXTRACT(YEAR FROM event_date) = 2022
AND event_type IN ('sign-in', 'like', 'comment')  
GROUP BY user_id  
HAVING COUNT(DISTINCT EXTRACT(MONTH FROM event_date)) = 2)
select count(distinct user_id)
from cte
---bai6 
/* CACH MIINH LAM SAI RUI
with cte_1 as (
select extract(month from trans_date) as month,
country, sum(amount) as trans_total_amount,count(*) as trans_count
from Transactions
group by extract(month from trans_date),
country),
cte_2 as(
select count(state) as approved_count,sum(amount) as approved_total_amount,extract(month from trans_date) as month,country 
from Transactions
where state='approved'
group by extract(month from trans_date),country )
select a.month, a.country, a.trans_count,b.approved_count, a.trans_total_amount, b.approved_total_amount
from cte_1 as a
join cte_2 as b on a.country=b.country
group by a.month, a.country */
/* CHỮA
select extract(month from trans_date) as month, country, count(*) as transcount,
sum(case when state='approved' then 1 else 0 end) as approved_count,
sum(amount) as trans_total_amount,
sum(case when state= 'approved' then amount else 0 end) as approved_total_amount
from Transactions
group by month, country
---bai 7
with cte as(
select product_id, year, quantity, price,
rank() over(
partition by product_id order by year asc) as xephang
from Sales)
select product_id, year as first_year, quantity, price
from cte 
where xephang =1
---bai 8
/* sai vì có trg hợp có nhiều hơn 2 product key mà mình ko đếm dc
select a.customer_id
from Customer as a
join Product as b on a.product_key=b.product_key
group by customer_id
having count(distinct b.product_key)=2
/* chữa
select a.customer_id
from Customer as a
join Product as b on a.product_key=b.product_key
group by customer_id
having count(b.product_key)=(select count(distinct product_key) from product)
---bai 9
/* sai roi
select b.employee_id
from Employees a, Employees b
where a.manager_id=b.employee_id
and b.salary<30000
/* chua
select employee_id
from Employees
where manager_id not in (select employee_id from Employees)
and salary<30000
--- bai 10
with cte as(
SELECT company_id,title,description,
count(job_id)
from job_listings
group by company_id, title,description)
select count(distinct company_id) as duplicate
from cte 
where count=2
---bai 11
/* saiiii
with cte as
((select b.name,
count(rating)
from MovieRating as a
join Users as b on a.user_id=b.user_id
group by b.name
order by name asc
limit 1)
union all
(select a.title,
avg(b.rating)
from Movies a
join MovieRating b on a.movie_id=b.movie_id
where extract(month from created_at)=02 and extract(year from created_at)=2020
group by a.title
having avg(b.rating)>=3.5
order by title asc
limit 1))
select name as results from cte
/* CHUA
with cte as
((select b.name,
count(rating)
from MovieRating as a
join Users as b on a.user_id=b.user_id
group by b.name
order by name asc
limit 1)
union all
(select a.title,
avg(b.rating)
from Movies a
join MovieRating b on a.movie_id=b.movie_id
where extract(month from created_at)=02 and extract(year from created_at)=2020
group by a.title
order by avg(b.rating) desc, title asc
limit 1))
select name as results from cte
---bai 12
with cte as
(select requester_id as id from RequestAccepted
union all
select accepter_id as id from RequestAccepted)
select id, count(*) as num
from cte
group by id
order by num desc
limit 1



