-- Assignment 3

  -- 1. Creating an Orders Table
create table Orders_Table
(
   order_id int primary key,
   order_date Date,
   amount int,
   customer_id int
)
select * from CustomerTable
 
  -- 2. Insert 5 records
insert into Orders_Table
values(101,'2022-06-19',1500,2345),
(102,'2022-10-20',550,1575),
(103,'2023-01-01',1200,2345),
(104,'2024-06-01',2000,3747),
(105,'2025-06-19',3500,4004)

select * from Orders_Table

  -- 3. inner join on Customer and order tables on the customer_id
select o.*,c.*
from Orders_Table as o
INNER JOIN CustomerTable as c
ON c.CustomerId=o.customer_id
  
  -- 4. left and right joins on Customer and order Tables using customer_id column
select * 
from CustomerTable as c
LEFT JOIN Orders_Table as o
ON o.customer_id=c.CustomerId

select * 
from CustomerTable as c
RIGHT JOIN Orders_Table as o
ON o.customer_id=c.CustomerId

  -- 5. Full outer join on customer and order tables using customer_id
select * from CustomerTable as c
FULL OUTER JOIN Orders_Table as o
ON o.customer_id=c.CustomerId

  -- 6. update orders table and set amount to 100 where customer_id is 3
UPDATE o
SET amount=100
from Orders_Table as o
where customer_id=2345

select * from Orders_Table
