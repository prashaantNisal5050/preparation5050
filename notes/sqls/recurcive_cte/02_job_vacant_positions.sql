-- type: 
-- category: complex
-- resource :ankit bansal

v56:

create table job_positions (id  int,
title varchar(100),
 groupss varchar(10),
 levels varchar(10),     
  payscale int, 
  totalpost int );

insert into job_positions values (1, 'General manager', 'A', 'l-15', 10000, 1); 
insert into job_positions values (2, 'Manager', 'B', 'l-14', 9000, 5); 
insert into job_positions values (3, 'Asst. Manager', 'C', 'l-13', 8000, 10);  

  create table job_employees ( id  int, 
    name   varchar(100),
     position_id  int 
   ) 
insert into job_employees values (1, 'John Smith', 1) 
, (2, 'Jane Doe', 2)
, (3, 'Michael Brown', 2)
, (4, 'Emily Johnson', 2) 
, (5, 'William Lee', 3) 
, (6, 'Jessica Clark', 3) 
, (7, 'Christopher Harris', 3)
, (8, 'Olivia Wilson', 3)
, (9, 'Daniel Martinez', 3)
, (10, 'Sophia Miller', 3)


select * from job_positions;
select * from job_employees;

# using aam jindagi and recursive cte

with recursive cte as (
    select id, title, groupss, levels, payscale, totalpost, 1 as rn 
    from job_positions
    union all
    select jp.id, jp.title, jp.groupss, jp.levels, jp.payscale, jp.totalpost, cte.rn + 1 
    from cte
    join job_positions jp on cte.title = jp.title and cte.rn + 1 <= jp.totalpost
),
emp as (
select *,ROW_NUMBER() over(PARTITION by POSITION_id) as rn from job_employees
)
select cte.*, COALESCE (emp.name,"open") as name  
from cte 
left join emp on cte.id = emp.position_id and cte.rn = emp.rn
order by cte.id,cte.rn

#mentos jindagi

dynamic generate the table 
then SUBSTRING(customer_name, 1st_space_position + 1, LENGTH(customer_name) - 1st_space_position)
