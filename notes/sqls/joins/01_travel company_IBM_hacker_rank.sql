/* type: joins
category: medium_complex
resource: 23. IBM Data Engineer SQL Interview Question (ankit bansal) */

/* 23 . IBM Data Engineer SQL Interview Question (Hacker Rank Online Test)

travel company has two table related to customers.each tour offer a discount if a minium number of people booked at the same time.  

learning: when there no id column to join, we have to find somthing else for join condition(we can join based on a range condition)
tweak : what if there is a condition of max_size (like min_size) 
CREATE TABLE FAMILIES (
    ID VARCHAR(50),
    NAME VARCHAR(50),
    FAMILY_SIZE INT
);

 CREATE TABLE COUNTRIES (
    ID VARCHAR(50),
    NAME VARCHAR(50),
    MIN_SIZE INT,
 MAX_SIZE INT
);


INSERT INTO FAMILIES (ID, NAME, FAMILY_SIZE)
VALUES 
    ('c00dac11bde74750b4d207b9c182a85f', 'Alex Thomas', 9),
    ('eb6f2d3426694667ae3e79d6274114a4', 'Chris Gray', 2),
  ('3f7b5b8e835d4e1c8b3e12e964a741f3', 'Emily Johnson', 4),
    ('9a345b079d9f4d3cafb2d4c11d20f8ce', 'Michael Brown', 6),
    ('e0a5f57516024de2a231d09de2cbe9d1', 'Jessica Wilson', 3);


INSERT INTO COUNTRIES (ID, NAME, MIN_SIZE,MAX_SIZE)
VALUES 
    ('023fd23615bd4ff4b2ae0a13ed7efec9', 'Bolivia', 2 , 4),
    ('be247f73de0f4b2d810367cb26941fb9', 'Cook Islands', 4,8),
    ('3e85ab80a6f84ef3b9068b21dbcc54b3', 'Brazil', 4,7),
    ('e571e164152c4f7c8413e2734f67b146', 'Australia', 5,9),
    ('f35a7bb7d44342f7a8a42a53115294a8', 'Canada', 3,5),
    ('a1b5a4b5fc5f46f891d9040566a78f27', 'Japan', 10,12); */
   
   
-- Q. write a query for maximum number of discounted tours any 1 family in the families table can be chose from.

   select count(*)
from COUNTRIES
where MIN_SIZE < (
    select max(FAMILY_SIZE)
    from FAMILIES
  );
-- Bolivia ,Cook Islands, Brazil ,Australia , Canada  
--    tweak: what if there is a condition of max_size (like min_size)
   
select f.name,
  count(*)
from COUNTRIES c
  join FAMILIES f on f.FAMILY_SIZE between c.MIN_SIZE and c.MAX_SIZE
group by f.name; 
 -- you can select max from this table:
