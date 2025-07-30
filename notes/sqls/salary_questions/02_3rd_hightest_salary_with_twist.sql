-- type: 
-- category: complex
-- resource :ankit bansal


v32 : I Asked This SQL Question in an Amazon Interview | Most Asked SQL Problem with a Twist

find 3rd hightest salary IN EACH department
IN CASE there ARE less THEN 3 emp RETURN lowest salary IN that department WITH emp details

CREATE TABLE emp (
 emp_id int NULL,
 emp_name varchar(50) NULL,
 salary int NULL,
 manager_id int NULL,
 emp_age int NULL,
 dep_id int NULL,
 dep_name varchar(20) NULL,
 gender varchar(10) NULL
) ;

insert into emp values(1,'A  nkit',14300,4,39,100,'Analytics','Female'),(2,'Mohit',14000,5,48,200,'IT','Male'),(3,'Vikas',12100,4,37,100,'Analytics','Female'),(4,'Rohit',7260,2,16,100,'Analytics','Female'),(5,'Mudit',15000,6,55,200,'IT','Male'),(6,'Agam',15600,2,14,200,'IT','Male'),(7,'Sanjay',12000,2,13,200,'IT','Male'),(8,'Ashish',7200,2,12,200,'IT','Male'),(9,'Mukesh',7000,6,51,300,'HR','Male'),(10,'Rakesh',8000,6,50,300,'HR','Male'),(11,'Akhil',4000,1,31,500,'Ops','Male')

+--------+----------+--------+------------+---------+--------+-----------+--------+
| emp_id | emp_name | salary | manager_id | emp_age | dep_id | dep_name  | gender |
+--------+----------+--------+------------+---------+--------+-----------+--------+
|      1 | Ankit    |  14300 |          4 |      39 |    100 | Analytics | Female |
|      2 | Mohit    |  14000 |          5 |      48 |    200 | IT        | Male   |
|      3 | Vikas    |  12100 |          4 |      37 |    100 | Analytics | Female |
|      4 | Rohit    |   7260 |          2 |      16 |    100 | Analytics | Female |
|      5 | Mudit    |  15000 |          6 |      55 |    200 | IT        | Male   |
|      6 | Agam     |  15600 |          2 |      14 |    200 | IT        | Male   |
|      7 | Sanjay   |  12000 |          2 |      13 |    200 | IT        | Male   |
|      8 | Ashish   |   7200 |          2 |      12 |    200 | IT        | Male   |
|      9 | Mukesh   |   7000 |          6 |      51 |    300 | HR        | Male   |
|     10 | Rakesh   |   8000 |          6 |      50 |    300 | HR        | Male   |
|     11 | Akhil    |   4000 |          1 |      31 |    500 | Ops       | Male   |
+--------+----------+--------+------------+---------+--------+-----------+--------+

with cte as (

SELECT emp_id,
       emp_name,
       salary,
       dep_id,
       dep_name,
       RANK() OVER (PARTITION BY dep_id ORDER BY salary DESC) AS rn,
       COUNT(*) OVER (PARTITION BY dep_id) AS emp_count
FROM emp e

) 

select * from cte 
where rn = 3 
or (emp_count < 3 and rn = emp_count) -- this is a twist
------------  --------------

CREATE TABLE emp_sal (
  emp_name VARCHAR(50),
  emp_salary DECIMAL(10,2)
);

INSERT INTO emp_sal (emp_name, emp_salary) VALUES
('Shubham Thakur', 50000.00),
('Aman Chopra', 60000.50),
('Naveen Tulasi', 75000.75),
('Bhavika uppala', 45000.25),
('Nishant jain', 80000.00);



SELECT emp_name,emp_salary from emp_sal
order by emp_salary desc;


SELECT emp_name,emp_salary from emp_sal e1 where 
3-1 = (SELECT COUNT(DISTINCT emp_salary)from emp_sal e2 where e2.emp_salary > e1.emp_salary) 


------------ OR --------------


SELECT salery,name
 FROM employ
 ORDER BY salery DESC limit 1, OFFSET n