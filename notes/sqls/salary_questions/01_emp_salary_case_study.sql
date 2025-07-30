-- type: joins
-- category: medium_complex
-- resource: 



-- 5 SQL Interview Question for Senior Data Engineer Position in Poland | Data Engineering

with sal_dept as (
select dept_id, salary
from emp_salary
group by  dept_id, salary
having count(*) > 1
)
select emp_id, name, es.salary, es.dept_id from emp_salary es
inner join sal_dept sd on sd.dept_id = es.dept_id and  sd.salary = es.salary
order by dept_id


OR
																												 LEFT TABLE
emp_id|name  |salary|dept_id|dept_id|salary|
------+------+------+-------+-------+------+
   101|sohan |3000  |     11|       |      |
   102|rohan |4000  |     12|       |      |
   103|mohan |5000  |     13|     13|5000  |
   104|cat   |3000  |     11|       |      |
   105|suresh|4000  |     12|       |      |
   109|mahesh|7000  |     12|     12|7000  |
   108|kamal |8000  |     11|     11|8000  |


with sal_dept as (
select dept_id, salary
from emp_salary
group by  dept_id, salary
having count(*) = 1   # get records for unique salaries, it means other records has duplicate salary
)
select es.emp_id, es.name, es.salary, es.dept_id, sd.* from emp_salary es
left join sal_dept sd on sd.dept_id = es.dept_id and  sd.salary = es.salary
where sd.dept_id is null
order by es.dept_id



CREATE TABLE emp_salary (
    emp_id INT NOT NULL,
    name VARCHAR(20) NOT NULL,
    salary VARCHAR(30),
    dept_id INT
);

INSERT INTO emp_salary
(emp_id, name, salary, dept_id)
VALUES(101, 'sohan', '3000', '11'),
(102, 'rohan', '4000', '12'),
(103, 'mohan', '5000', '13'),
(104, 'cat', '3000', '11'),
(105, 'suresh', '4000', '12'),
(109, 'mahesh', '7000', '12'),
(108, 'kamal', '8000', '11');

select * from emp_salary