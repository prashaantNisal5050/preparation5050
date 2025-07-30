notes:

- non aggrigated column should be grouped by



-- --------*********-----------
# midium complex problems
-- --------*********-----------


-- 1 find player with no of gold medals won by them only for players who won only gold medals.


CREATE TABLE ORG.events (
ID int,
event varchar(255),
YEAR INt,
GOLD varchar(255),
SILVER varchar(255),
BRONZE varchar(255)
);

INSERT INTO org.events VALUES (1,'100m',2016, 'Amthhew Mcgarray','donald','barbara');
INSERT INTO org.events VALUES (2,'200m',2016, 'Nichole','Alvaro org.Eaton','janet Smith');
INSERT INTO org.events VALUES (3,'500m',2016, 'Charles','Nichole','Susana');
INSERT INTO org.events VALUES (4,'100m',2016, 'Ronald','maria','paula');
INSERT INTO org.events VALUES (5,'200m',2016, 'Alfred','carol','Steven');
INSERT INTO org.events VALUES (6,'500m',2016, 'Nichole','Alfred','Brandon')
INSERT INTO org.events VALUES (7,'100m',2016, 'Charles','Dennis','Susana');
INSERT INTO org.events VALUES (8,'200m',2016, 'Thomas','Dawn','catherine');
INSERT INTO org.events VALUES (9,'500m',2016, 'Thomas','Dennis','paula');
INSERT INTO org.events VALUES (10,'100m',2016, 'Charles','Dennis','Susana');
INSERT INTO org.events VALUES (11,'200m',2016, 'jessica','Donald','Stefeney');
INSERT INTO org.events VALUES (12,'500m',2016,'Thomas','Steven','Catherine');

-- using subquery
SELECT gold as player_name,COUNT(1) as no_of_medals 
from ORG.events e
where gold not in ( select SILVER from ORG.events union all select BRONZE from ORG.events)
group by gold;


-- using union all 3  12(rows)*3(type) = 36 rows # not working in mysql

with cte as (
select gold as 'player name' ,'gold' as medal_type from events
union all select SILVER ,'silver' as medal_type from events
union all select BRONZE ,'bronze' as medal_type from events
)
select player_name, count(1) as no_of_gold_medals from cte
group by player_name
having count(distinct medal_type) =1 and max(medal_type) = 'gold'

-- --------*********-----------
-- 2. find difference between 2 dates excluding weekends and public holidays  . Basically we need to find business days between 2 given dates using SQL.

create table tickets1
(
ticket_id varchar(10),
create_date date,
resolved_date date
);


insert into tickets1 values
(1,'2022-08-01','2022-08-03')
,(2,'2022-08-01','2022-08-12')
,(3,'2022-08-01','2022-08-16');


create table holidays
(
holiday_date date
,reason varchar(100)
);

insert into holidays values
('2022-08-11','Rakhi'),('2022-08-15','Independence day');


 2022-08-01|MON   2022-08-03|wednesday
 2022-08-01|MON   2022-08-12|friday
 2022-08-01|MON   2022-08-16|tuesday
 
-- SELECT *, 
-- DATEDIFF(resolved_date, create_date) AS days_difference, 
-- WEEK(create_date) as week_start,week(resolved_date) as end_week ,
-- TIMESTAMPDIFF(WEEK, create_date, resolved_date) AS weeks_difference
-- FROM tickets1;
 
--  ticket_id|create_date|resolved_date|days_difference|week_start|end_week|weeks_difference|
-- ---------+-----------+-------------+---------------+----------+--------+----------------+
-- 1        | 2022-08-01|   2022-08-03|              2|        31|      31|               0|
-- 2        | 2022-08-01|   2022-08-12|             11|        31|      32|               1|
-- 3        | 2022-08-01|   2022-08-16|             15|        31|      33|               2|

 

-- SELECT *, 
-- DATEDIFF(resolved_date, create_date) AS actual_days,
-- DATEDIFF(resolved_date, create_date) - 2*TIMESTAMPDIFF(WEEK, create_date, resolved_date) as working_days # 2 days off in every weeks
-- from tickets1
-- left join holidays on holiday_date between create_date and resolved_date;


SELECT ticket_id, 
       create_date, 
       resolved_date, 
       holidays, 
       actual_days,
       actual_days - (2 * TIMESTAMPDIFF(WEEK, create_date, resolved_date) + holidays) AS working_days # 2 days off in every week
FROM (
    SELECT t.ticket_id, 
           t.create_date, 
           t.resolved_date, 
           COUNT(h.holiday_date) AS holidays,
           DATEDIFF(t.resolved_date, t.create_date) AS actual_days
    FROM tickets1 t
    LEFT JOIN holidays h 
           ON h.holiday_date BETWEEN t.create_date AND t.resolved_date
           AND WEEKDAY(h.holiday_date) NOT IN (5, 6) -- Exclude holidays that fall on weekends (Saturday=5, Sunday=6) -- to remove this drawback : what if public holiday is on weekend.
    GROUP BY t.ticket_id, t.create_date, t.resolved_date
) AS sub;
 
select * from holidays; 

-- --------*********-----------
# Complex sql problems 
-- --------*********-----------

-- 1. Derive Points table for ICC tournament

create table icc_world_cup
(
Team_1 Varchar(20),
Team_2 Varchar(20),
Winner Varchar(20)
);


INSERT INTO icc_world_cup values('India','SL','India'),('SL','Aus','Aus'),('SA','Eng','Eng'),('Eng','NZ','NZ'),('Aus','India','India');

select team_name, count(1) as no_of_matches_played, sum(win_flag) as win_matches, count(1) - sum(win_flag) as losses  from 
(
select team_1 as team_name, 
case 	when team_1 = winner then 1 
		else 0 end as win_flag
from icc_world_cup
union all
select team_2 as team_name, 
case 	when team_2 = winner then 1 
		else 0 end as win_flag
from icc_world_cup ) A
group by team_name
order by win_matches desc;

-- Expected Output : 
-- team_name|no_of_matches_played|win_matches|losses|
-- ---------+--------------------+-----------+------+
-- India    |                   2|          2|     0|
-- SL       |                   2|          0|     2|
-- SA       |                   1|          0|     1|
-- Eng      |                   2|           1|     1|
-- Aus      |                   2|          1|     1|
-- NZ       |                   1|          1|     0|

-- --------*********-----------

-- Complex SQL 2 | find new and repeat customers 

-- hint:  min(order_date) is customer's first visit. comapare first_visit with order_date. if matched means its a new customer. 

create table customer_orders (
order_id integer,
customer_id integer,
order_date date,
order_amount integer
);
 

insert into customer_orders values(1,100,cast('2022-01-01' as date),2000),(2,200,cast('2022-01-01' as date),2500),(3,300,cast('2022-01-01' as date),2100)
,(4,100,cast('2022-01-02' as date),2000),(5,400,cast('2022-01-02' as date),2200),(6,500,cast('2022-01-02' as date),2700)
,(7,100,cast('2022-01-03' as date),3000),(8,400,cast('2022-01-03' as date),1000),(9,600,cast('2022-01-03' as date),3000)
;

select * from customer_orders;


with fisrt_visit as (select customer_id, min(order_date) as first_visit from customer_orders
group by customer_id)
SELECT co.*, case when co.order_date = fv.first_visit then 1 else 0 end as first_visit_flag,
case when co.order_date != fv.first_visit then 1 else 0 end as repeat_visit_flag
from customer_orders co
inner join fisrt_visit fv on fv.customer_id = co.customer_id 
 
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


---
-- 6. WAQ to find PersonID,name,number of friends who have friends with total score > 100

drop table friend 
Create table friend (pid int, fid int)

insert into friend (pid , fid ) values ('1','2'), ('1','3'), ('2','1'), ('2','3'), ('3','5'), ('4','2'), ('4','3'), ('4','5');

insert into person(PersonID,Name ,Score) values ('1','Alice','88'), ('2','Bob','11'), ('3','Devis','27'), ('4','Tara','45'), ('5','John','63');
drop table person
create table person (PersonID int,	Name varchar(50),	Score int)

select * from person
select * from friend

  
select p.personid, p.name,  count(f.fid)  as number_of_friends, sum(pp.score) as friends_total_score
  from person p 
  right join friend f on f.pid = p.personid
  left join person pp on pp.personid = f.fid
  group by p.personid, p.name
  having sum(pp.score) > 100

-- expected 
-- personid|name|number_of_friends|friends_total_score|
-- --------+----+-----------------+-------------------+
--        2|Bob |                2|                115|
--        4|Tara|                3|                101|


  
  




