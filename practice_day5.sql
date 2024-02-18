---bai 1
select distinct CITY
from STATION
where ID%2 =0
---bai 2
select count(CITY) - count(distinct CITY)
from STATION
---bai 3

---bai 4 (ko chac)
SELECT sum(item_count*order_occurrences)/sum(order_occurrences) as mean_num_of_items_per_order
FROM items_per_order
---bai 5
SELECT candidate_id 
FROM candidates
where skill in ('Python', 'Tableau', 'PostgreSQL')
group by candidate_id
having count(skill) = 3
--- bai 6 (ko chac)
select user_id,
count(post_id) as num_of_posts,
max(date(post_date))-min(date(post_date)) as num_of_days
from posts
group by user_id
having count(post_id) >=2
--- bai 7
select distinct card_name, 
max(issued_amount)-min(issued_amount)
from monthly_cards_issued
group by card_name
--- bai 8
SELECT
  manufacturer,
  COUNT(drug) AS drug_count, 
  SUM(cogs - total_sales) AS total_loss
FROM pharmacy_sales
where cogs > total_sales
GROUP BY manufacturer
order by total_loss desc
--- bai 9 
select  *
from Cinema
where id % 2 <> 0 and description <> 'boring'
---bai 10
select teacher_id,
count(distinct subject_id) as num_of_subjects
from Teacher
group by teacher_id
---bai 11
select distinct user_id,
count(follower_id) as number_of_followers
from Followers
group by user_id
--- bai 12
select class,
count(student) as num_of_students
from Courses
group by class
having count(student) >=5
