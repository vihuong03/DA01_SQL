---bai 1
select b.CONTINENT, 
floor(avg(a.POPULATION)) as avg_city_population
from CITY as a
join COUNTRY as b
on a.COUNTRYCODE=b.CODE
group by b.CONTINENT
---bai 2 
SELECT round(1.0*count(b.email_id)/count(distinct a.email_id),2) as activation_rate
FROM emails as a  
left join texts as b 
on a.email_id=b.email_id
where b.signup_action='Confirmed'
--- bai3
SELECT b.age_bucket in ('21-25', '26-30', '31-25'),
round(100.0*sum(CASE when a.activity_type = 'send' then a.time_spent else 0 end)/sum(time_spent),2) as send_perc,
round(100.0*sum(case when a.activity_type = 'open' then a.time_spent else 0 end)/sum(time_spent),2) as open_perc
FROM activities as a
join age_breakdown as b 
on a.user_id=b.user_id
where a.activity_type in ('open','send')
group by b.age_bucket
--- bai 4
SELECT distinct customer_id
FROM customer_contracts as a  
inner join products as b  
on a.product_id=b.product_id
where product_category in ('Analytics','Containers','Compute')
group by customer_id
having count(distinct product_category)=3
---bai 5
  
---bai 6
select a.product_name,
sum(b.unit) as unit
from Products as a
join Orders as b
on a.product_id=b.product_id
where extract(month from b.order_date)='02' and extract(year from b.order_date)='2020'
group by a.product_name
having sum(b.unit) >=100
---bai 7
SELECT a.page_id
FROM pages as a  
left join page_likes as b  
on a.page_id=b.page_id
where liked_date is null
