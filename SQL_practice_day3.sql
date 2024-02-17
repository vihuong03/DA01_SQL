---bai1
select NAME from CITY
where POPULATION > 120000 and COUNTRYCODE = 'USA'
---bai2
select * from CITY
where COUNTRYCODE = 'JPN'
---bai3
select CITY, STATE from STATION
---bai4
select distinct CITY from STATION
where CITY like 'a%'
OR CITY like 'e%'
OR CITY like 'i%'
OR CITY like 'o%'
OR CITY like 'u%'
---bai5
select distinct CITY from STATION
where CITY like '%a'
OR CITY like '%e'
OR CITY like '%i'
OR CITY like '%o'
OR CITY like '%u'
---bai6
select distinct CITY from STATION
where CITY not like 'a%'
and CITY not like 'i%'
and CITY not like 'o%'
and CITY not like 'u%'
and CITY not like 'e%'
---bai7
select name from Employee
order by name 
---bai8
select name from Employee
where salary > 2000 and months <10
order by employee_id
---bai9
select product_id from Products
where low_fats = 'Y' and recyclable = 'Y'
order by product_id
---bai10
select name from Customer
where referee_id <> 2 OR referee_id is NULL
order by name
---bai11
select name, population, area from World
where area >= 3000000 or population >= 25000000
---bai12
select distinct author_id AS id from Views
where article_id >=1 and author_id = viewer_id
order by id
---bai13
select distinct author_id AS id from Views
where article_id >=1 and author_id = viewer_id
order by id
---bai14
select * from lyft_drivers
where yearly_salary <=30000 or yearly_salary >= 70000
---bai15
select advertising_channel from uber_advertising
where money_spent > 100000 and year = 2019
