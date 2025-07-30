-- type: case_when, gropu_by
-- category: complex
-- resource :ankit bansal


-- V20 Data Analyst Spotify Case Study

CREATE table activity
(
user_id varchar(20),
event_name varchar(20),
event_date date,
country varchar(20)
);
delete from activity;
insert into activity values (1,'app-installed','2022-01-01','India')
,(1,'app-purchase','2022-01-02','India')
,(2,'app-installed','2022-01-01','USA')
,(3,'app-installed','2022-01-01','USA')
,(3,'app-purchase','2022-01-03','USA')
,(4,'app-installed','2022-01-03','India')
,(4,'app-purchase','2022-01-03','India')
,(5,'app-installed','2022-01-03','SL')
,(5,'app-purchase','2022-01-03','SL')
,(6,'app-installed','2022-01-04','Pakistan')
,(6,'app-purchase','2022-01-04','Pakistan');


-- user_id|event_name   |event_date|country |
-- -------+-------------+----------+--------+
-- 1      |app-installed|2022-01-01|India   |
-- 1      |app-purchase |2022-01-02|India   |
-- 2      |app-installed|2022-01-01|USA     |
-- 3      |app-installed|2022-01-01|USA     |
-- 3      |app-purchase |2022-01-03|USA     |
-- 4      |app-installed|2022-01-03|India   |
-- 4      |app-purchase |2022-01-03|India   |
-- 5      |app-installed|2022-01-03|SL      |
-- 5      |app-purchase |2022-01-03|SL      |
-- 6      |app-installed|2022-01-04|Pakistan|
-- 6      |app-purchase |2022-01-04|Pakistan|

-- Q1. find total active users each day

-- event_date active_user
-- 2022-01-01 3
-- 2022-01-02 1
-- 2022-01-03 3
-- 2022-01-04 1

select event_date, count(DISTINCT user_id) as active_user from activity a  
group by event_date

-- q2.  Find total active users each week
-- 
-- week_number active_users
-- 1			3	
-- 2			5


select WEEK(event_date)+1 as week, count(DISTINCT user_id) from activity a 
group by week

-- q3. date wise total number of users who made the purchese on same day hey install the app.
-- 
-- event_date users
-- 2022-01-01 0
-- 2022-01-02 0
-- 2022-01-03 2
-- 2022-01-04 1


-- step 1: 
select event_date, user_id, count(DISTINCT event_name) as number_of_activities  
from activity a
group by event_date, user_id
having number_of_activities = 2 -- problem is we will not get those row having number_of_activities = 1  

-- step 2: insted of having use case logic to solve the problem 
select user_id, event_date,
case	when count(DISTINCT event_name) = 2 
		then user_id 
 		else 
  			null 
		end as new_user
from activity a
group by user_id, event_date
-- having number_of_activities = 2

-- step3: use sub query
select event_date, count(new_user)
from (
select user_id, event_date,
	  case when count(DISTINCT event_name) = 2 then user_id else null end as new_user
from activity a
group by user_id, event_date ) a
group by event_date

-- Q4.  percentage of paid user in india, USA and any other countries should be tagged as others
-- country user_percentage
-- INDIA   40
-- USA		20
-- Others	40


with country_wise_users as 
(select 
case 
	when country in ("USA","INDIA")
	then country 
	else "others" end as new_country,
	count(DISTINCT user_id) as user_count 
from activity a
where event_name ="app-purchase"
group by new_country),

total as (select sum( user_count) as total from country_wise_users) 

select new_country, 1.0* user_count/total*100 from country_wise_users,total;


-- Q5: Among  all the users who installed the app on given day, how many did app puchese on very next day, day wise result

WITH prev_data AS (
    SELECT *,
           LAG(event_name, 1) OVER (PARTITION BY user_id ORDER BY event_date) AS prev_e_name,
           LAG(event_date, 1) OVER (PARTITION BY user_id ORDER BY event_date) AS prev_e_date
    FROM activity a
)
-- SELECT *
SELECT event_date, count(DISTINCT user_id)
FROM prev_data
WHERE event_name = 'app-purchase' 
  AND prev_e_name = 'app-installed'
  AND DATEDIFF(event_date, prev_e_date) = 1
group by event_date ;