-- type: union_all
-- category: medium_complex


-- 1 find player with no of gold medals won by them only for players who won only gold medals.

notes : UNION does not contain duplicate rows
        UNION all contains duplicate rows

CREATE TABLE ORG.events (
ID int,
event varchar(255),
YEAR INt,
GOLD varchar(255),
SILVER varchar(255),
BRONZE varchar(255)
);

INSERT INTO org.events VALUES (1,'100m',2016, 'Amthhew Mcgarray','donald','barbara'),
 (2,'200m',2016, 'Nichole','Alvaro org.Eaton','janet Smith'),
 (3,'500m',2016, 'Charles','Nichole','Susana'),
 (4,'100m',2016, 'Ronald','maria','paula'),
 (5,'200m',2016, 'Alfred','carol','Steven'),
 (6,'500m',2016, 'Nichole','Alfred','Brandon'),
 (7,'100m',2016, 'Charles','Dennis','Susana'),
 (8,'200m',2016, 'Thomas','Dawn','catherine'),
 (9,'500m',2016, 'Thomas','Dennis','paula'),
 (10,'100m',2016, 'Charles','Dennis','Susana'),
 (11,'200m',2016, 'jessica','Donald','Stefeney'),
 (12,'500m',2016,'Thomas','Steven','Catherine');

expected: 
player_name     |no_of_medals|
----------------+------------+
Amthhew Mcgarray|           1|
Charles         |           3|
Ronald          |           1|
Thomas          |           3|
jessica         |           1|


select * from events;

-- using subquery
SELECT gold as player_name,COUNT(1) as no_of_medals 
from ORG.events e
where gold not in ( select SILVER from ORG.events union select BRONZE from ORG.events)
group by gold;


-- using union all 3  12(rows)*3(type) = 36 rows # not working in mysql

with cte as (
  select gold as 'player_name',
    'gold' as medal_type
  from events
  union all
  select SILVER,
    'silver' as medal_type
  from events
  union all
  select BRONZE,
    'bronze' as medal_type
  from events
)
select player_name,
  count(*) as no_of_gold_medals
from cte
group by player_name,
  medal_type
having count(distinct medal_type) = 1 -- any 1 kind of medal
  and medal_type = 'gold' -- that type should be gold