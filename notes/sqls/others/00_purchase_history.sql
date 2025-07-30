-- type: 
-- category: complex
-- resource :ankit bansal


v47: Amazon for a Business Intelligence Engineer Position.

# user who purchese diffent products on differnt dates 
create table purchase_history
(userid int
,productid int
,purchasedate date
);

insert into purchase_history values
(1,1,STR_TO_DATE('23/01/2012', '%d/%m/%Y'))
,(1,2,STR_TO_DATE('23/01/2012', '%d/%m/%Y'))
,(1,3,STR_TO_DATE('25/01/2012', '%d/%m/%Y'))
,(2,1,STR_TO_DATE('23/01/2012', '%d/%m/%Y'))
,(2,2,STR_TO_DATE('23/01/2012', '%d/%m/%Y'))
,(2,2,STR_TO_DATE('25/01/2012', '%d/%m/%Y'))
,(2,4,STR_TO_DATE('25/01/2012', '%d/%m/%Y'))
,(3,4,STR_TO_DATE('23/01/2012', '%d/%m/%Y'))
,(3,1,STR_TO_DATE('23/01/2012', '%d/%m/%Y'))
,(4,1,STR_TO_DATE('23/01/2012', '%d/%m/%Y'))
,(4,2,STR_TO_DATE('25/01/2012', '%d/%m/%Y'));

select * from purchase_history;

truncate table  purchase_history;

select userid, count(purchasedate) as no_of_dates,count(DISTINCT purchasedate) as dis_dates, count(productid) as products,count(DISTINCT productid) as dist_products
from purchase_history
group by userid
having dis_dates > 1 # This filters out users who have only made purchases on a single date.
and dist_products >=  dis_dates and products = dist_products # user is buying at least one unique product on each distinct purchase date.

userid|no_of_dates|dis_dates|products|dist_products|
------+-----------+---------+--------+-------------+
     1|          3|        2|       3|            3|
     4|          2|        2|       2|            2|
----