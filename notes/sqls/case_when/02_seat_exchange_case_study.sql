-- type: case_when, update
-- category: medium_complex
28. Commonly Asked SQL Interview Question | Exchange Seats | SQL for Data Analytics
CREATE TABLE seats (
    id INT,
    student VARCHAR(10)
);

delete * from seats;

INSERT INTO seats VALUES 
(1, 'Amit'),
(2, 'Deepa'),
(3, 'Rohit'),
(4, 'Anjali'),
(5, 'Neha'),
(6, 'Sanjay'),
(7, 'Priya');

select * from seats;

UPDATE seats
JOIN (
    SELECT id,
           CASE 
               WHEN id = (SELECT MAX(id) FROM seats) AND id % 2 = 1 THEN id -- last row and that row id is odd then keep as it is 
               WHEN id % 2 = 0 THEN id - 1
               ELSE id + 1
           END AS new_id
    FROM seats
) AS new_seats
ON seats.id = new_seats.id
SET seats.id = new_seats.new_id;