-- type: 
-- category: complex
-- resource :ankit bansal

v51: 
q1. 
	logic 
		step 1: segament wise user
		step 2: join with booking to get booking data
		step 3: count of users who book flight(condition1) in given date range (condition2)
		step 4: 1 user has multiple booking for that day , so use distinct.
	q2.
	 logic user's booking  order by date, who have rank 1 and type is hotel.

		or don't forget we have first_value function also
 
q3   

select user daydiff (days,fisrt_booking , last booking )
from bookings
group by USER 
order by booking_date
	 


logic 1 
firstvalue(date) over(partition by user_id order by booking date) as f
lastvalue(date) over(partition by user_id order by booking date) as l

logic 2:  min max functions if dont want to use rank


q4

logic:
 

sum of line_of_business when flight,count of line_of_business when hotel

group by user_id or segment, whicherver as problem STATEMENT   

join needed as we need segment data and get line_of_business and segment 