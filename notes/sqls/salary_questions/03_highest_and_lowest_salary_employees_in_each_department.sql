-- type: joins, window_functions
-- category: medium_complex
-- resource: 


highest_and_lowest_salary_employees_in_each_department


11.L&T SQL Interview Problem | Print Highest and Lowest Salary Employees in Each Department

create table employee2 
(
emp_name varchar(10),
dep_id int,
salary int
);

insert into employee2 values  ('Siva',1,30000),('Ravi',2,40000),('Prasad',1,50000),('Sai',2,20000)


select * from employee2;

approch 1

with cte as (select dep_id,min(salary) as min_sal, max(salary) as max_sal
from employee2
group by dep_id)

select employee2.dep_id ,
max(case when salary = min_sal then emp_name end) as min_sal_emp,
max(case when salary = max_sal then emp_name end) as max_sal_emp
from employee2
inner join cte on employee2.dep_id = cte.dep_id
group by employee2.dep_id;


approch 2
with cte as (select *,
row_number() over(partition by dep_id order by salary desc) as max_salary_emp,
row_number() over(partition by dep_id order by salary) as min_salary_emp
from employee2)

select dep_id ,
max(case when max_salary_emp = 1 then emp_name end)as  highest_salary,
max(case when min_salary_emp = 1 then emp_name end) as  lowest_salary
from cte
group by dep_id
