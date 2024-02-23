---bai 1
select 
sum(case 
  when device_type = 'laptop' then 1 
  else 0
  end) as laptop_views,
sum(case 
  when device_type IN ('tablet','phone') then 1 
  else 0
  end) as mobile_views
from viewership
--- bai 2
select x, y, z,
case
    when x < y+z and y<x+z and z<x+y then 'Yes'
    else 'No'
end as triangle
from Triangle
---bai 3
select round(count(case_id)*100/count(*),1) as uncategorised_call
from callers
where call_category = 'n/a'
or call_category IS NULL
---bai 4
select name from Customer
where referee_id <> 2 OR referee_id is NULL
order by name
--- bai 5
select  survived,
    sum(case when pclass =1 then 1 else 0 end) as first_class,
    sum(case when pclass =2 then 1 else 0 end) as second_class,
    sum(case when pclass=3 then 1 else 0 end) as third_class
from titanic
group by survived
