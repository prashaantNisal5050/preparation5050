-- type: join, window_functions
-- category: complex
-- resource :ankit bansal

-- Complex SQL 3 | Scenario based Interviews Question for Product companies

 create table entries ( 
name varchar(20),
address varchar(20),
email varchar(20),
floor int,
resources varchar(10));

insert into entries 
values ('A','Bangalore','A@gmail.com',1,'CPU'),('A','Bangalore','A1@gmail.com',1,'CPU'),('A','Bangalore','A2@gmail.com',2,'DESKTOP')
,('B','Bangalore','B@gmail.com',2,'DESKTOP'),('B','Bangalore','B1@gmail.com',2,'DESKTOP'),('B','Bangalore','B2@gmail.com',1,'MONITOR')


-- find count of floor visit of the person

WITH 
distinct_resources AS (
    SELECT DISTINCT name, resources  
    FROM entries
),
agg_resources AS (
    SELECT name, GROUP_CONCAT(DISTINCT resources) AS resources_used
    FROM distinct_resources
    GROUP BY name
),
total_visits AS (
    SELECT name, 
           COUNT(floor) AS total_visits 
    FROM entries e 
    GROUP BY name
),
floor_visits AS (
    SELECT name, 
           floor, 
           COUNT(1) AS visit_count,
           RANK() OVER(PARTITION BY name ORDER BY COUNT(1) DESC) rnk
    FROM entries e 
    GROUP BY name, floor
)


SELECT fv.name,
       fv.floor AS most_visited_floor, 
       tv.total_visits, 
       ar.resources_used 
FROM floor_visits fv
INNER JOIN total_visits tv ON fv.name = tv.name
INNER JOIN agg_resources ar ON tv.name = ar.name
WHERE fv.rnk = 1;


-- approch


SELECT name, resources FROM entries
name|resources|
----+---------+
A   |CPU      |
A   |CPU      |
A   |DESKTOP  |
B   |DESKTOP  |
B   |DESKTOP  |
B   |MONITOR  |


SELECT DISTINCT name, resources FROM entries
name|resources|
----+---------+
A   |CPU      |
A   |DESKTOP  |
B   |DESKTOP  |
B   |MONITOR  |


select * from agg_resources
name|resources_used |
----+---------------+
A   |CPU,DESKTOP    |
B   |DESKTOP,MONITOR|


total_visits
name|total_visits|
----+------------+
A   |           3|
B   |           3|

floor_visits
name|floor|visit_count|rnk|
----+-----+-----------+---+
A   |    1|          2|  1|
A   |    2|          1|  2|
B   |    2|          2|  1|
B   |    1|          1|  2|