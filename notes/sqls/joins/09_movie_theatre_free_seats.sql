-- type: 
-- category: complex
-- resource :ankit bansal

v35:PharmEasy SQL  Question | Consecutive Seats in a Movie Theatre | Data Analytics

Q: sql to find consicative empty seats (4 seats in same row)

create table movie(
seat varchar(50),occupancy int
);
insert into movie values('a1',1),('a2',1),('a3',0),('a4',0),('a5',0),('a6',0),('a7',1),('a8',1),('a9',0),('a10',0),
('b1',0),('b2',0),('b3',0),('b4',1),('b5',1),('b6',1),('b7',1),('b8',0),('b9',0),('b10',0),
('c1',0),('c2',1),('c3',0),('c4',1),('c5',1),('c6',0),('c7',1),('c8',0),('c9',0),('c10',1);


select * from movie;

seat|occupancy|
----+---------+
a1  |        1|
a2  |        1|
a3  |        0|
a4  |        0|
a5  |        0|
a6  |        0|
a7  |        1|
a8  |        1|
a9  |        0|
a10 |        0|
b1  |        0|
b2  |        0|
b3  |        0|
b4  |        1|
b5  |        1|
b6  |        1|
b7  |        1|
b8  |        0|
b9  |        0|
b10 |        0|
c1  |        0|
c2  |        1|
c3  |        0|
c4  |        1|
c5  |        1|
c6  |        0|
c7  |        1|
c8  |        0|
c9  |        0|
c10 |        1|

0/p
seat|occupancy|
----+---------+
a3  |        0|
a4  |        0|
a5  |        0|
a6  |        0|
note: SELECT substring("prashant",5,4);   from 5th char give me 4 charecter.

WITH cte1 AS (
    SELECT *,
           LEFT(seat, 1) AS row_id,
           CAST(SUBSTRING(seat, 2) AS UNSIGNED) AS seat_id
    FROM movie
)  ,
 cte2 AS (
    SELECT *,
           Max(occupancy) OVER (PARTITION BY row_id ORDER BY seat_id ROWS BETWEEN CURRENT ROW AND 3 FOLLOWING) AS is_4_empty,
           COUNT(occupancy) OVER (PARTITION BY row_id ORDER BY seat_id ROWS BETWEEN CURRENT ROW AND 3 FOLLOWING) AS empty_seats_count
    FROM cte1
) ,
 cte3 AS (
    SELECT * 
    FROM cte2 
    WHERE is_4_empty = 0 AND empty_seats_count = 4
)

SELECT cte2.seat, cte2.occupancy
FROM cte2
INNER JOIN cte3 
    ON cte2.row_id = cte3.row_id
    AND cte2.seat_id BETWEEN cte3.seat_id AND cte3.seat_id + 3;

   
Explanation:
cte1: Extracts the row and seat number from the seat column.
cte2: Determines if there are four consecutive empty seats using the MIN(occupancy) and counts the seats.
cte3: Filters to find only the seats that start a block of four consecutive empty seats.
Final SELECT: Joins cte2 with cte3 on the row_id and ensures that the seat_id in cte2 is within the range of four consecutive seats identified in cte3.
This query will return all the rows in cte2 that belong to the four consecutive empty seats identified in cte3.