-- type: join, cte, date
-- category: complex
-- resource :ankit bansal


-- Complex SQL 2 | find new and repeat customers 

-- hint:  min(order_date) is customer's first visit. comapare first_visit with order_date. if matched means its a new customer. 

create table customer_orders (
order_id integer,
customer_id integer,
order_date date,
order_amount integer
);
 

insert into customer_orders values(1,100,cast('2022-01-01' as date),2000),(2,200,cast('2022-01-01' as date),2500),(3,300,cast('2022-01-01' as date),2100)
,(4,100,cast('2022-01-02' as date),2000),(5,400,cast('2022-01-02' as date),2200),(6,500,cast('2022-01-02' as date),2700)
,(7,100,cast('2022-01-03' as date),3000),(8,400,cast('2022-01-03' as date),1000),(9,600,cast('2022-01-03' as date),3000)
;

select * from customer_orders;


with fisrt_visit as (select customer_id, min(order_date) as first_visit from customer_orders
group by customer_id)
SELECT co.*, case when co.order_date = fv.first_visit then 1 else 0 end as first_visit_flag,
case when co.order_date != fv.first_visit then 1 else 0 end as repeat_visit_flag
from customer_orders co
inner join fisrt_visit fv on fv.customer_id = co.customer_id 

---


SELECT u.*
FROM users u
LEFT JOIN orders o ON u.id = o.user_id
WHERE o.user_id IS NULL;