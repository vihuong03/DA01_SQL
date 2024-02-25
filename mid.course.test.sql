---cau 1
select min(distinct replacement_cost)
from film
---cau 2
select 
case
	when replacement_cost between 9.99 and 19.99 then 'low'
	when replacement_cost between 20.00 and 24.99 then 'medium'
	else 'high'
end as type,
count(*)
from film
group by type
---cau 3
select a.title, a.length, c.name
from film as a
left join film_category as b on a.film_id=b.film_id
left join category as c on b.category_id=c.category_id
where name = 'Drama'or name='Sports'
order by a.length desc
limit 1
--- cau 4
select count(a.film_id),c.name
from film as a
left join film_category as b on a.film_id=b.film_id
left join category as c on b.category_id=c.category_id
group by c.name
order by count(a.film_id) desc
--- cau 5
select a.first_name||' '|| a.last_name as actor, 
count(b.film_id) as num_of_films
from actor as a
left join film_actor as b
on a.actor_id=b.actor_id
group by a.first_name, a.last_name
order by count(b.film_id) desc
---cau 6
select count(distinct a.address_id)
from address as a
left join customer as b
on a.address_id=b.address_id
where customer_id is null
---bai 7
select distinct a.city, 
sum(d.amount) as sales
from city as a
inner join address as b on a.city_id=b.city_id
inner join customer as c on c.address_id=b.address_id
inner join payment as d on d.customer_id=c.customer_id
group by a.city
order by sum(d.amount) desc
---bai 8
select a.city ||', '||e.country as place,
sum(d.amount) as total_amount
from city as a
inner join address as b on a.city_id=b.city_id
inner join customer as c on c.address_id=b.address_id
inner join payment as d on d.customer_id=c.customer_id
inner join country as e on e.country_id=a.country_id
group by a.city ||', '||e.country
order by sum(d.amount) desc
