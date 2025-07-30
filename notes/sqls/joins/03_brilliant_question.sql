-- type: brilliant_question
-- category: complex
-- resource :ankit bansal


v28: Brilliant Question | Solve it without using CTE, Sub Query, Window functions

find the largest order by value for each salesperson and display order in details. Solve it without using CTE, Sub Query, Window functions

CREATE TABLE int_orders (
  order_number INT NOT NULL,
  order_date DATE NOT NULL,
  cust_id INT NOT NULL,
  salesperson_id INT NOT NULL,
  amount FLOAT NOT NULL,
  PRIMARY KEY (order_number),
  KEY idx_cust_id (cust_id),
  KEY idx_salesperson_id (salesperson_id)
) ENGINE=InnoDB;

INSERT INTO int_orders (order_number, order_date, cust_id, salesperson_id, amount) values
(30, '1995-07-14', 9, 1, 460), 
(10, '1996-08-02', 4, 2, 540), 
(40, '1998-01-29', 7, 2, 2400), 
(50, '1998-02-03', 6, 7, 600), 
(60, '1998-03-02', 6, 7, 720), 
(70, '1998-05-06', 9, 7, 150), 
(20, '1999-01-30', 4, 8, 1800);


SELECT a.order_number, a.order_date, a.cust_id, a.salesperson_id, a.amount
from int_orders a
left join int_orders b on a.salesperson_id = b.salesperson_id
group by a.order_number, a.order_date, a.cust_id, a.salesperson_id, a.amount # removed duplicate rows
having a.amount >= max(b.amount) # to remove unwanted rows (select largest value row from table a)
;


SELECT a.order_number, a.salesperson_id, a.amount, b.order_number, b.salesperson_id, b.amount
from int_orders a
left join int_orders b on a.salesperson_id = b.salesperson_id
order by a.salesperson_id
having a.amount >= max(b.amount) # to remove duplicate or unwanted rows
												A																					|																												B	
order_number|salesperson_id|amount|														order_number|salesperson_id|amount|
------------+--------------+------+														------------+--------------+------+
          10|             2| 540.0|>= 2400  no   	 				    10|             2| 540.0| 
          10|             2| 540.0|>= 2400  no    	    				40|             2|2400.0| 
          40|             2|2400.0|>= 2400  yes        				10|             2| 540.0| -- GROUP BY ON salesperson_id WILL WILL GIVE ONE ROW ONLY 
          40|             2|2400.0|>= 2400  yes        				40|             2|2400.0| 
          
       
-- IF ONLY WANT SALES PERSON AND AMOUNT           
select salesperson_id,MAX(amount) from           
 (SELECT a.order_number, a.order_date, a.cust_id, a.salesperson_id, a.amount
from int_orders a
left join int_orders b on a.salesperson_id = b.salesperson_id
group by a.order_number, a.order_date, a.cust_id, a.salesperson_id, a.amount) A
)
GROUP BY salesperson_id