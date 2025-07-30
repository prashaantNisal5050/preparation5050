-- type: union_all
-- category: medium_complex

3. Amazon SQL Interview Question for Data Analyst Position [2-3 Year Of Experience ] | Data Analytics
find number of employees inside the hospital

1- out
2- in
3- in
4- in
5 -out

create table hospital ( emp_id int
, action varchar(10)
, time datetime);


INSERT INTO hospital VALUES 
    ('1', 'in', '2019-12-22 09:00:00'),
    ('1', 'out', '2019-12-22 09:15:00'),
    ('2', 'in', '2019-12-22 09:00:00'),
    ('2', 'out', '2019-12-22 09:15:00'),
    ('2', 'in', '2019-12-22 09:30:00'),
    ('3', 'out', '2019-12-22 09:00:00'),
    ('3', 'in', '2019-12-22 09:15:00'),
    ('3', 'out', '2019-12-22 09:30:00'),
    ('3', 'in', '2019-12-22 09:45:00'),
    ('4', 'in', '2019-12-22 09:45:00'),
    ('5', 'out', '2019-12-22 09:40:00');

select * from hospital;


method 1 : 
with cte as (select emp_id,
max(case when action = 'in' then time end )as "in_t",
max(case when action = 'out' then time end) as "out_t"
from hospital
group by emp_id)

select * from cte
where in_t > out_t OR out_t is NULL 
;
method 2 :