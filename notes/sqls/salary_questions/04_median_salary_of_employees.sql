-- type: 
-- category: complex
-- resource :ankit bansal

v31: LeetCode Hard SQL Problem to find median salary of employees for each company. 


median: 2 3 4 5 4 : 4 is median 
								2 5 6 7 8 9 : (6+7)/2 --> 6.5 is median


create table employee 
(
emp_id int,
company varchar(10),
salary int
);

insert into employee values (1,'A',2341), (2,'A',341), (3,'A',15), (4,'A',15314), (5,'A',451), (6,'A',513), (7,'B',15), (8,'B',13), (9,'B',1154), (10,'B',1345), (11,'B',1221), (12,'B',234), (13,'C',2345), (14,'C',2645), (15,'C',2645), (16,'C',2652), (17,'C',65);

> select * from employee;
+--------+---------+--------+
| emp_id | company | salary |
+--------+---------+--------+
|      1 | A       |   2341 |
|      2 | A       |    341 |
|      3 | A       |     15 |
|      4 | A       |  15314 |
|      5 | A       |    451 |
|      6 | A       |    513 |
|      7 | B       |     15 |
|      8 | B       |     13 |
|      9 | B       |   1154 |
|     10 | B       |   1345 |
|     11 | B       |   1221 |
|     12 | B       |    234 |
|     13 | C       |   2345 |
|     14 | C       |   2645 |
|     15 | C       |   2645 |
|     16 | C       |   2652 |
|     17 | C       |     65 |
+--------+---------+--------+
17 rows in set (0.00 sec)


select *, total_count*1.0/2 as top , total_count*1.0/2 + 1 as bottom 								
from (select *,
	ROW_NUMBER() over(partition by company order by salary ) as rn,
	count(1) over (PARTITION by company) as total_count
from employee e) as a  
where rn between top, bottom


SELECT company, AVG(salary)  
FROM (
    SELECT *,
           total_count * 1.0 / 2 AS top,
           total_count * 1.0 / 2 + 1 AS bottom
    FROM (
        SELECT *,
               ROW_NUMBER() OVER (PARTITION BY company ORDER BY salary) AS rn,
               COUNT(1) OVER (PARTITION BY company) AS total_count
        FROM employee e
    ) AS a
) AS b
WHERE rn BETWEEN top AND bottom
group by company;