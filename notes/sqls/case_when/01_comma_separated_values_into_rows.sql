-- type: union_all, string


-- 4. Airbnb SQL Interview Question | Convert Comma Separated Values into Rows | Data Analytic



create table airbnb_searches 
(
user_id int,
date_searched date,
filter_room_types varchar(200)
);


insert into airbnb_searches values
(1,'2022-01-01','entire home,private room')
,(2,'2022-01-02','entire home,shared room')
,(3,'2022-01-02','private room,shared room')
,(4,'2022-01-03','private room')
;

select * from airbnb_searches;

with room as
(
select sum(case when filter_room_types like '%entire%' then 1 else 0 end) as en,
sum(case when filter_room_types like '%private%' then 1 else 0 end) as pr,
sum(case when filter_room_types like '%shared%' then 1 else 0 end) as sh
from airbnb_searches)
select 'entire home' as  value,en cnt from room
union all
select 'private room' as value,pr cnt from room
union all
select 'shared room' as value,sh cnt from room
order by cnt desc;