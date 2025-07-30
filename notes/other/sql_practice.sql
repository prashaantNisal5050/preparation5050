

SELECT DISTINCT Salary FROM Worker ORDER BY Salary DESC;



SELECT COUNT( DISTINCT ( W2.Salary ) )
 FROM Worker w2;

1(5000) = 5 6 7 8 k
2(7000) = 7000,8000,7500

Select distinct W.WORKER_ID, W.FIRST_NAME, W.Salary 
from Worker W, Worker W1 
where W.Salary = W1.Salary
and W.WORKER_ID != W1.WORKER_ID;


select FIRST_NAME, DEPARTMENT from worker W where W.DEPARTMENT='HR' 
union all 
select FIRST_NAME, DEPARTMENT from Worker W1 where W1.DEPARTMENT='HR';



SELECT *
FROM WORKER;
WHERE WORKER_ID <= (SELECT count(WORKER_ID)/2 from Worker);


SELECT DEPARTMENT, COUNT(WORKER_ID) as 'Number of Workers' FROM Worker GROUP BY DEPARTMENT;


SELECT * FROM Worker WHERE WORKER_ID <=5
UNION
SELECT * FROM (SELECT * FROM Worker W order by W.WORKER_ID DESC) AS W1 WHERE W1.WORKER_ID <=5;


SELECT t.DEPARTMENT,t.FIRST_NAME,t.Salary 
from (SELECT max(Salary) as TotalSalary,DEPARTMENT from Worker group by DEPARTMENT) as TempNew 
Inner Join Worker t on TempNew.DEPARTMENT=t.DEPARTMENT 
and TempNew.TotalSalary=t.Salary;

SELECT max(Salary) as TotalSalary,DEPARTMENT from Worker group by DEPARTMENT;
SELECT distinct Salary from worker a WHERE 3 >= (SELECT count(distinct Salary) from worker b WHERE a.Salary >= b.Salary) order by a.Salary desc;

SELECT distinct Salary from worker a WHERE 3 >= (SELECT count(distinct Salary) from worker b WHERE a.Salary <= b.Salary) order by a.Salary desc;



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



SELECT gold as player_name,COUNT(1) as no_of_medals 
from ORG.events e
where gold not in ( select SILVER from ORG.events union all select BRONZE from ORG.events)
group by gold;



create table hospital ( emp_id int
, action varchar(10)
, time datetime);


insert into hospital values ('1', 'in', '2019-12-22 09:00:00')
insert into hospital values ('1', 'out', '2019-12-22 09:15:00');
insert into hospital values ('2', 'in', '2019-12-22 09:00:00');
insert into hospital values ('2', 'out', '2019-12-22 09:15:00');
insert into hospital values ('2', 'in', '2019-12-22 09:30:00');
insert into hospital values ('3', 'out', '2019-12-22 09:00:00');
insert into hospital values ('3', 'in', '2019-12-22 09:15:00');
insert into hospital values ('3', 'out', '2019-12-22 09:30:00');
insert into hospital values ('3', 'in', '2019-12-22 09:45:00');
insert into hospital values ('4', 'in', '2019-12-22 09:45:00');
insert into hospital values ('5', 'out', '2019-12-22 09:40:00');


with latest_time as
(select emp_id, max(time) as max_latest_time from hospital h
group by emp_id),
latest_in_time as
(select emp_id, max(time) as max_latest_in_time from hospital h
where action = "in"
group by emp_id)
select * from latest_time lt
inner join latest_in_time lit on lt.emp_id = lit.emp_id
and lt.max_latest_time = lit.max_in_time



create table purchases(
	user_id int,
	product_id int,
	quantity int,
	purchase_date datetime
);



@MrMarkgyuro
1 year ago
create table purchases(
	user_id int,
	product_id int,
	quantity int,
	purchase_date datetime
);

DELETE from purchases;

INSERT INTO purchases VALUES(536, 3223, 6, '2022-11-01 12:33:44');
insert into purchases values(827, 3585, 35,'2022-02-20 14:05:26');
insert into purchases values(536, 3223, 5, '2022-03-02- 09:33:28');
insert into purchases values(536, 1435, 10, '03-02-2022 08:40:00');
insert into purchases values(827, 2452, 45, '04-09-2022 00:00:00');



create table employee 
(
emp_name varchar(10),
dep_id int,
salary int
);
delete from employee;
insert into employee values  ('Siva',1,30000),('Ravi',2,40000),('Prasad',1,50000),('Sai',2,20000)

------
create table employee1 
(
emp_name varchar(10),
email_id varchar(20)
);
delete from employee1;

insert into employee1(emp_name,email_id) values  ('jhon', 'jo.da@abc.com');
insert into employee1(emp_name,email_id) values  ('Tom', 'jo.da@abc.com');
insert into employee1(emp_name,email_id) values  ('Sushant', 'JO.DA@ABC.COM');



#A - 65, a - 97 
with cte as (SELECT *,
       ASCII(email_id) AS ascii_value,
       RANK() OVER (PARTITION BY email_id ORDER BY ASCII(email_id) DESC) AS rn
FROM employee1 e) 
select * from cte where rn =1;

------

CREATE TABLE users (
    USER_ID INT PRIMARY KEY,
    USER_NAME VARCHAR(20) NOT NULL,
    USER_STATUS VARCHAR(20) NOT NULL
);


CREATE TABLE logins (
    USER_ID INT,
    LOGIN_TIMESTAMP DATETIME NOT NULL,
    SESSION_ID INT PRIMARY KEY,
    SESSION_SCORE INT,
    FOREIGN KEY (USER_ID) REFERENCES USERS(USER_ID)
);


INSERT INTO USERS VALUES (1, 'Alice', 'Active');
INSERT INTO USERS VALUES (2, 'Bob', 'Inactive');
INSERT INTO USERS VALUES (3, 'Charlie', 'Active');
INSERT INTO USERS  VALUES (4, 'David', 'Active');
INSERT INTO USERS  VALUES (5, 'Eve', 'Inactive');
INSERT INTO USERS  VALUES (6, 'Frank', 'Active');
INSERT INTO USERS  VALUES (7, 'Grace', 'Inactive');
INSERT INTO USERS  VALUES (8, 'Heidi', 'Active');
INSERT INTO USERS VALUES (9, 'Ivan', 'Inactive');
INSERT INTO USERS VALUES (10, 'Judy', 'Active');


select * , DATEADD(MONTH,-5,GETDATE())  from logins;

SELECT DATE_SUB(CURDATE(), INTERVAL 5 MONTH);

SELECT ADDDATE(CURDATE(), INTERVAL 10 DAY);    
CURDATE();

----








