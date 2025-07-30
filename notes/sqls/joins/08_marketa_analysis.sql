-- type: 
-- category: complex
-- resource :ankit bansal


-- Q9. Market Analysis
-- 
-- WAQ to find for each seller , whether the branch of second Item (by date) they sold is thier favoraite brand or not?
-- if seller sold less than 2 items, report the anser for that seller as no.
-- 
-- o/p
-- seller_id 2nd_item_fav_branch
-- 1			yes/no		
-- 2			yes/no	

create table users (
user_id         int     ,
 join_date       date    ,
 favorite_brand  varchar(50));

 create table orders (
 order_id       int     ,
 order_date     date    ,
 item_id        int     ,
 buyer_id       int     ,
 seller_id      int 
 );

 create table items
 (
 item_id        int     ,
 item_brand     varchar(50)
 );


 insert into users values (1,'2019-01-01','Lenovo'),(2,'2019-02-09','Samsung'),(3,'2019-01-19','LG'),(4,'2019-05-21','HP');

 insert into items values (1,'Samsung'),(2,'Lenovo'),(3,'LG'),(4,'HP');

 insert into orders values (1,'2019-08-01',4,1,2),(2,'2019-08-02',2,1,3),(3,'2019-08-03',3,2,3),(4,'2019-08-04',1,4,2)
 ,(5,'2019-08-04',1,3,4),(6,'2019-08-05',2,2,4);


answer
step 1: get the second order details using order details for each seller.
step 2: get the item brand using join with items table
step 3: check brand from second order is sellers favoraite brand or not
step 4: letf join with user as we want all sellers from users

with rnk_orders as (
select *,
RANK() OVER (PARTITION BY seller_id  order by order_date ASC ) as rn
from orders)
select u.user_id, ro.seller_id, i.item_brand, u.favorite_brand as seller_fav_brand,
case when i.item_brand = u.favorite_brand then "yes" else "no" end as 2nd_item_fav_branch
from users u 
left join rnk_orders ro on ro.seller_id=u.user_id and rn=2
left join items i on ro.item_id=i.item_id; 
-- where rn=2;