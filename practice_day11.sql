---bai 1
select b.CONTINENT, 
floor(avg(a.POPULATION)) as avg_city_population
from CITY as a
join COUNTRY as b
on a.COUNTRYCODE=b.CODE
group by b.CONTINENT
---bai 2 (THAC MAC CHO WHERE)
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
