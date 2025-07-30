-- type: window_functions, case_when
-- category: medium_complex


-- 1 find player with no of gold medals won by them only for players who won only gold medals.

26 EXL Analytics SQL Interview Question | 2 Different Ways of using Window Functions


output
state      |lowest_population_city|highest_population_city|
-----------+----------------------+-----------------------+
haryana    |ambala                |gurgaon                |
karnataka  |mangalore             |bangalore              |
maharashtra|nagpur                |mumbai                 |
punjab     |amritsar              |ludhiana               |


way 1

with cte as (select *,
min(population) over(partition by state) as lowest_population,
max(population) over(partition by state) as highest_population
from city_population) 

select state,
max(case when population = lowest_population then city end ) as lowest_population_city,
max(case when population = highest_population then city end ) as highest_population_city
from  cte
group by state
;

way 2

with cte as (select *,
row_number() over(partition by state order by population asc) as lowest_population,
row_number() over(partition by state order by population desc) as highest_population
from city_population) 

select state, 
max(case when lowest_population = 1 then city else null end  )as lowest_population_city,
max(case when highest_population = 1 then city else null end  )as highest_population_city
from  cte
group by state
;