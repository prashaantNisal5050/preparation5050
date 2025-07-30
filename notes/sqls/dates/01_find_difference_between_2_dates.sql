
-- type: ,dates, joins
-- category: medium_complex
-- resource:  


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
 
SELECT *, 
DATEDIFF(resolved_date, create_date) AS days_difference, 
WEEK(create_date) as week_start,week(resolved_date) as end_week ,
TIMESTAMPDIFF(WEEK, create_date, resolved_date) AS weeks_difference
FROM tickets1;
 
--  ticket_id|create_date|resolved_date|days_difference|week_start|end_week|weeks_difference|
-- ---------+-----------+-------------+---------------+----------+--------+----------------+
-- 1        | 2022-08-01|   2022-08-03|              2|        31|      31|               0|
-- 2        | 2022-08-01|   2022-08-12|             11|        31|      32|               1|
-- 3        | 2022-08-01|   2022-08-16|             15|        31|      33|               2|

 

SELECT *, 
DATEDIFF(resolved_date, create_date) AS actual_days,
DATEDIFF(resolved_date, create_date) - 2*TIMESTAMPDIFF(WEEK, create_date, resolved_date) as working_days # 2 days off in every weeks
from tickets1
left join holidays on holiday_date between create_date and resolved_date;


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