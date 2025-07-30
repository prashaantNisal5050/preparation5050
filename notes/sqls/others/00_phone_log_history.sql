-- type: 
-- category: complex
-- resource :ankit bansal

v40: we will discuss a very interesting problem where from a phone log history 
we need to find if the caller had done first and last call for the day to the same person.

create table phonelog(
    Callerid int, 
    Recipientid int,
    Datecalled datetime
);


insert into phonelog(Callerid, Recipientid, Datecalled)
values(1, 2, '2019-01-01 09:00:00.000'),
       (1, 3, '2019-01-01 17:00:00.000'),
       (1, 4, '2019-01-01 23:00:00.000'),
       (2, 5, '2019-07-05 09:00:00.000'),
       (2, 3, '2019-07-05 17:00:00.000'),
       (2, 3, '2019-07-05 17:20:00.000'),
       (2, 5, '2019-07-05 23:00:00.000'),
       (2, 3, '2019-08-01 09:00:00.000'),
       (2, 3, '2019-08-01 17:00:00.000'),
       (2, 5, '2019-08-01 19:30:00.000'),
       (2, 4, '2019-08-02 09:00:00.000'),
       (2, 5, '2019-08-02 10:00:00.000'),
       (2, 5, '2019-08-02 10:45:00.000'),
       (2, 4, '2019-08-02 11:00:00.000');
      

      
      
insert into phonelog(Callerid, Recipientid, Datecalled) values(2, 6, '2019-01-01 09:00:00.000');


select * from   phonelog;

with calls as (select callerid, cast(Datecalled as date) as called_date, min(Datecalled) as first_call ,max(Datecalled) as last_call
from phonelog
group by callerid,called_date)
 
select *, p1.Recipientid from calls c
inner join phonelog p1 on  c.callerid = p1.callerid and c.first_call = p1.Datecalled
inner join phonelog p2 on  c.callerid = p2.callerid and c.last_call = p2.Datecalled
where p1.Recipientid = p2.Recipientid;



-- check this approch: 
with cte as (
select *, min(Datecalled) over(partition by date(Datecalled)) as first_call, max(Datecalled) over(partition by date(Datecalled)) as last_call from phonelog),
cte1 as(
select *, lag(Recipientid) over() as lags from cte where Datecalled=first_call or Datecalled=last_call)
select Callerid, Recipientid, Datecalled, first_call, last_call from cte1 where Recipientid=lags;

-- check this approch: 
with A as (
select *,
date(datecalled) as called_date,
row_number() over (partition by Callerid,date(datecalled) order by datecalled asc) as firstcall,
row_number() over (partition by Callerid,date(datecalled) order by datecalled desc) as  lastcall
from phonelog
)

select callerid,called_date,Recipientid 
from A 
where firstcall=1 or lastcall=1
group by callerid,called_date,Recipientid 
having count(1)>1