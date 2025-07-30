-- type: 
-- category: complex
-- resource :ankit bansal

v61 : First Name , Middle Name and Last Name of a Customer | Famous SQL Interview Question

create table customers  (customer_name varchar(30))
insert into customers values ('Ankit Bansal')
,('Vishal Pratap Singh')
,('Michael');


select LOCATE(' ', "prashantnisal");

 -- LOCATE(substring, string, (start))
 -- REPLACE(string, from_string, new_string)


	WITH cte AS (
    SELECT 
        customer_name, 
        LENGTH(customer_name) - LENGTH(REPLACE(customer_name, ' ', '')) AS spaces_count, 
        LOCATE(' ', customer_name) AS 1st_space_position,
        LOCATE(' ', customer_name, LOCATE(' ', customer_name) + 1) AS 2nd_space_position
    FROM 
        customers
)

SELECT 
    customer_name,
    spaces_count,
    1st_space_position,
    2nd_space_position,
    
    CASE 
        WHEN spaces_count = 0 THEN customer_name
        ELSE SUBSTRING(customer_name, 1, 1st_space_position - 1) 
    END AS f_name,
    CASE 
        WHEN spaces_count <= 1 THEN NULL
        ELSE SUBSTRING(customer_name, 1st_space_position + 1, 2nd_space_position-1 - 1st_space_position) 
    END AS m_name,
   
    CASE
    			WHEN spaces_count =0 then null
    			WHEN spaces_count =1 then SUBSTRING(customer_name, 1st_space_position + 1, LENGTH(customer_name) - 1st_space_position)
    			WHEN spaces_count =2 then SUBSTRING(customer_name, 2nd_space_position + 1, LENGTH(customer_name) - 2nd_space_position)
    			end as l_name
    
FROM 
    cte;
   
   
notes: SUBSTRING(string, start_position, length)
string: The original string from which you want to extract a substring.
start_position: The position within the string where the substring begins.
Positions are 1-based, meaning the first character in the string is at position 1.
If start_position is negative, the function counts from the end of the string.
length (optional): The number of characters to return.
If omitted, the substring will run from the start_position to the end of the string.