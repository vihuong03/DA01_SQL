--- bai 1
select Name
from STUDENTS
where Marks > 75
order by right(Name,3), ID
--- bai 2
select user_id,
concat(upper(left(name,1)),'',lower(right(name, length(name)-1))) as name
from Users
--- bai 3
SELECT manufacturer,
'$' || round(sum(total_sales)/1000000) || ' ' || 'million' as sale
FROM pharmacy_sales
group by manufacturer
order by sum(total_sales) DESC
--- bai 4
SELECT extract(month from submit_date) as month,
product_id as product,
round(avg(stars),2) as avg_stars
FROM reviews
group by extract(month from submit_date), product_id
order by month, product_id
--- bai 5
SELECT sender_id,
count(message_id) as message_count
FROM messages
where extract(month from sent_date)=08 and extract(year from sent_date)=2022
group by sender_id
order by count(message_id) DESC
limit 2
--- bai 6
select tweet_id
from Tweets
where length(content) >15
--- bai 7
select activity_date as day, 
count( distinct user_id) as active_users
from Activity
where  activity_type in ('open_session', 'end_session', 'scroll_down', 'send_message')
and activity_date > '2019-06-28'
group by activity_date
--- bai 8
select count(id)
from employees
where joining_date between '2022-01-01' and '2022-08-01'
--- bai 9
select position('a' in first_name)
from worker
where first_name = 'Amitah'
--- bai10 
select substring(title, length(winery)+2,4)
from winemag_p2
where country ='Macedonia'
