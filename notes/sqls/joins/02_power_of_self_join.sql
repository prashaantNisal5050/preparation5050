-- type: 
-- category: complex
-- resource :ankit bansal

v34 : Very Interesting SQL Interview Question Asked by Udaan | Power of Self Join | Data Analytics

+---------------+---------+
| business_date | city_id |
+---------------+---------+
| 2020-01-02    |       3 |
| 2020-07-01    |       7 |
| 2021-01-01    |       3 |
| 2021-02-03    |      19 |
| 2022-12-01    |       3 |
| 2022-12-15    |       3 |
| 2022-02-28    |      12 |
+---------------+---------+


create table business_city (
business_date date,
city_id int
);
delete from business_city;
insert into business_city
values(cast('2020-01-02' as date),3),(cast('2020-07-01' as date),7),(cast('2021-01-01' as date),3),(cast('2021-02-03' as date),19)
,(cast('2022-12-01' as date),3),(cast('2022-12-15' as date),3),(cast('2022-02-28' as date),12);


with cte as (select year(business_date) as b_year ,city_id from business_city)

select *
-- count(case when right_table.city_id is null then business_city.city_id) as new_cities 
from business_city c1
left join cte c2 on c1.city_id = c2.city_id
and year(c1.business_date) > c2.b_year 
group by c1.year1

--

WITH cte AS (
    SELECT YEAR(business_date) AS b_year, city_id 
    FROM business_city
)
SELECT 
    YEAR(c1.business_date) AS year1,
    COUNT(CASE WHEN c2.city_id IS NULL THEN c1.city_id END) AS new_cities 
FROM 
    business_city c1
LEFT JOIN 
    cte c2 
ON 
    c1.city_id = c2.city_id
    AND YEAR(c1.business_date) > c2.b_year
GROUP BY 
    YEAR(c1.business_date);