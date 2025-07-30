
-- type: union, group_by, case_when 
-- category: complex
-- resource :ankit bansal

-- learning: non aggrigated column should be grouped by


-- 1. Derive Points table for ICC tournament

create table icc_world_cup
(
Team_1 Varchar(20),
Team_2 Varchar(20),
Winner Varchar(20)
);


INSERT INTO icc_world_cup values('India','SL','India'),('SL','Aus','Aus'),('SA','Eng','Eng'),('Eng','NZ','NZ'),('Aus','India','India');

select * from icc_world_cup;

select * from icc_world_cup;
select team_name, count(*) as no_of_matches_played, sum(win_flag) as win_matches, count(1) - sum(win_flag) as losses  from 
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