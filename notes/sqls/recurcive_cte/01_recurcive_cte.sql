-- type: recursive_cte
-- category: complex
-- resource :ankit bansal



CREATE TABLE STORES (
Store varchar(10),
Quarter varchar(10),
Amount int);

INSERT INTO STORES (Store, Quarter, Amount)
VALUES ('S1', 'Q1', 200),
('S1', 'Q2', 300),
('S1', 'Q4', 400),
('S2', 'Q1', 500),
('S2', 'Q3', 600),
('S2', 'Q4', 700),
('S3', 'Q1', 800),
('S3', 'Q2', 750),
('S3', 'Q3', 900);

way 1:
select store , 10 - sum(right(QUARTER,1)) from STORES 
group by store;

way 2: recursive cte

with cte as (
	select DISTINCT store, 1 as 1_no from stores
	union all
	select store, q_no+1 as q_no from cte
	where q_no < 4
)
select * from cte;


WITH RECURSIVE cte AS (
    SELECT DISTINCT store, 1 AS q_no FROM stores
    UNION ALL
    SELECT store, q_no + 1 FROM cte
    WHERE q_no < 4
)
SELECT * FROM cte;