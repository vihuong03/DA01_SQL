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
