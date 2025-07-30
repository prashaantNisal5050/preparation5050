-- type: union
-- category: medium_complex
-- resource: 

-- I have been asked this question in pattern company.

24 Angel One Easy-Peasy SQL Interview Question for a Data Science Position 

			find busiest route along with total ticket count
			oneway round : o --> one way trip
			oneway round : R --> Round trip
			
			note : DEL-->BOM is different route from BOM --> DEL
			
			highest ticket count is the busiest route

CREATE TABLE tickets (
    airline_number VARCHAR(10),
    origin VARCHAR(3),
    destination VARCHAR(3),
    oneway_round CHAR(1),
    ticket_count INT
);

INSERT INTO tickets (airline_number, origin, destination, oneway_round, ticket_count)
VALUES
    ('DEF456', 'BOM', 'DEL', 'O', 150),
    ('GHI789', 'DEL', 'BOM', 'R', 50),
    ('JKL012', 'BOM', 'DEL', 'R', 75),
    ('MNO345', 'DEL', 'NYC', 'O', 200),
    ('PQR678', 'NYC', 'DEL', 'O', 180),
    ('STU901', 'NYC', 'DEL', 'R', 60),
    ('ABC123', 'DEL', 'BOM', 'O', 100),
    ('VWX234', 'DEL', 'NYC', 'R', 90);
   
 SELECT origin, destination, sum(ticket_count)  as tc
 from tickets
 group by origin, destination
 order by tc desc;



 SELECT origin, destination, sum(ticket_count)  as tc
 from (  SELECT origin, destination, ticket_count
  from tickets
  union all
  SELECT destination as origin , origin as destination, ticket_count
  from tickets 
  where oneway_round = "R") as a 
 group by origin, destination
 order by tc desc;
  
  # sub query is 
  SELECT origin, destination, ticket_count
  from tickets
  union all
  SELECT destination as origin , origin as destination, ticket_count
  from tickets 
  where oneway_round = "R"
  
origin|destination|ticket_count|
------+-----------+------------+
BOM   |DEL        |         150|
DEL   |BOM        |          50|
BOM   |DEL        |          75|
DEL   |NYC        |         200| DN
NYC   |DEL        |         180|
NYC   |DEL        |          60|
DEL   |BOM        |         100|
DEL   |NYC        |          90| DN
BOM   |DEL        |          50|
DEL   |BOM        |          75|
DEL   |NYC        |          60| DN
NYC   |DEL        |          90|
   
expected 
origin|destination|tc |
------+-----------+---+
DEL   |NYC        |350| <-- this row is expected. 
NYC   |DEL        |330|
BOM   |DEL        |275|
DEL   |BOM        |225|