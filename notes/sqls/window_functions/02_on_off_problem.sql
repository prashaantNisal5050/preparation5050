-- type: window_functions
-- category: complex
-- resource :ankit bansal


V29: Solving A Hard SQL Problem | SQL ON OFF Problem | Magic of SQL

find "on count" 

create table event_status
(
event_time varchar(10),
status varchar(10)
);

insert into event_status 
values
('10:01','on'),('10:02','on'),('10:03','on'),('10:04','off'),('10:07','on'),('10:08','on'),('10:09','off')
,('10:11','on'),('10:12','off');


- make a group by  (on after off)


with cte as (

select *, sum(case when status = 'on' and prev_status = 'off' then 1 else 0 end ) over(order by event_time) as flag
 from (select *,
 lag(status,1,status) over(order by event_time asc) as prev_status #lag(column, lag_by ,default_value)
 from event_status) a)
 
--  SELECT * from cte;

 select 
 	min(event_time) as 'login',
 	max(event_time) as 'logout',
 	count(*) -1 as 'on_count' # there is a one off in each group hence delete that.
 from cte
 group by flag;