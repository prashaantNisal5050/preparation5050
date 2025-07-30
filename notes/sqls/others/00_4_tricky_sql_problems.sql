-- type: 
-- category: complex
-- resource :ankit bansal


V27: Solving 4 Tricky SQL Problems


CREATE TABLE students_marks (
  studentid INT NULL,
  studentname VARCHAR(255) NULL,
  subject VARCHAR(255) NULL,
  marks INT NULL,
  testid INT NULL,
  testdate DATE NULL
);

insert into students_marks values (2,'Max Ruin','Subject1',63,1,'2022-01-02'), (3,'Arnold','Subject1',95,1,'2022-01-02'), (4,'Krish Star','Subject1',61,1,'2022-01-02'), (5,'John Mike','Subject1',91,1,'2022-01-02'), (4,'Krish Star','Subject2',71,1,'2022-01-02'), (3,'Arnold','Subject2',32,1,'2022-01-02'), (5,'John Mike','Subject2',61,2,'2022-11-02'), (1,'John Deo','Subject2',60,1,'2022-01-02'), (2,'Max Ruin','Subject2',84,1,'2022-01-02'), (2,'Max Ruin','Subject3',29,3,'2022-01-03'), (5,'John Mike','Subject3',98,2,'2022-11-02');

-- Q1 get the list of students who scored above the averge marks in each subject

with avg_cte as (
select subject ,avg(marks) as avg_marks 
from students_marks
group by subject)

select * 
from students_marks sm 
inner join avg_cte ac on sm.subject = ac.subject
where sm.marks  > ac.avg_marks
;

-- Q2 get the % of students who score more than 90 in any subject amonegst the total student

# SELECT * from students_marks sm  WHERE marks > 90

# select count(distinct(studentid)) from students_marks sm 

SELECT count(DISTINCT case when marks > 90 then studentid  else null end)  / count(distinct(studentid)) as perc from students_marks sm  # dont forget to applu distinct
 
-- Q3 second highest marks and second lowest marks for each subjects

with cte as (select  subject, marks, rank() over(PARTITION by subject order by marks asc) as l_rn, rank() over(PARTITION by subject order by marks desc) as h_rn from students_marks sm )

select subject, sum(case when h_rn = 2 then marks else null end)  as '2nd_highest', sum(case when l_rn = 2 then marks else null end)  as '2nd_lowest' 
from cte
group by subject;

Q4  for each student and test , identify if their marks increased or decrease from prev test

select * from students_marks sm 
order by studentid, testdate ,subject

select *, 
case when marks < prev_marks then "dec" else "inc" end as "status"
from (
select *,
lag(marks,1,marks) over (PARTITION by studentid order by testdate )  as prev_marks
from students_marks sm
) a