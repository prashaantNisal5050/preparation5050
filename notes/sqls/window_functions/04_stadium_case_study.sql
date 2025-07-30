-- type: window_function, group_by
-- category: complex
-- resource :ankit bansal

v33: Human Traffic of Stadium

display records wich have 3 or more consicative rows
with the amont of peple more than 100(inclusive) each day
create table stadium (
id int,
visit_date date,
no_of_people int
);

insert into stadium
values (1,'2017-07-01',10)
,(2,'2017-07-02',109)
,(3,'2017-07-03',150)
,(4,'2017-07-04',99)
,(5,'2017-07-05',145)
,(6,'2017-07-06',1455)
,(7,'2017-07-07',199)
,(8,'2017-07-08',188);

select * from stadium;
id|visit_date|no_of_people|
--+----------+------------+
 1|2017-07-01|          10|
 2|2017-07-02|         109|
 3|2017-07-03|         150|
 4|2017-07-04|          99|
 5|2017-07-05|         145|
 6|2017-07-06|        1455|
 7|2017-07-07|         199|
 8|2017-07-08|         188|

with cte as (select *, 
-- row_number() over (order by visit_date)
id - row_number() over (order by visit_date) as grp  # trick strick | diff should be same for consicative rows
from stadium 
where no_of_people >= 100)

select grp, count(*) as consicative_rows
from cte
group by grp having consicative_rows >=   3
----


 -- main query
with cte as (select *, 
-- row_number() over (order by visit_date)
id - row_number() over (order by visit_date) as grp  -- trick strick | diff should be same for consicative rows
from stadium 
where no_of_people >= 100)
select * from cte  
where grp in (
select grp from cte group by grp having count(*) >=3
)