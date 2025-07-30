-- type: 
-- category: complex
-- resource :ankit bansal


v30: LeetCode Hard SQL problem | Students Reports By Geography | Pivot Ka Baap


select * from players_location;
create table players_location
(
name varchar(20),
city varchar(20)
);
delete from players_location;
insert into players_location
values ('Sachin','Mumbai'),('Virat','Delhi') , ('Rahul','Bangalore'),('Rohit','Mumbai'),('Mayank','Bangalore');

# notes: In SQL, when you use the MAX() function on a column that contains string values, it evaluates them based on their alphabetical order rather than their numeric value.
SELECT MAX(num)
FROM (SELECT "A" AS num FROM dual
      UNION ALL
      SELECT "B" AS num FROM dual) as s; 

MAX(num)|
--------+
B       |


select player_groups,
max(case when city = 'Bangalore' then name end) as Bangalore,
max(case when city = 'Delhi' then name end) as Delhi,
max(case when city = 'Mumbai' then name end) as Mumbai
from (

select name, city,row_number() over (partition by city order by name asc) as player_groups
from players_location) a

group by player_groups
order by player_groups;