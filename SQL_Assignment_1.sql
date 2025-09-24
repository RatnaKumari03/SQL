-- Assignment 1

-- creating salesman table
create table SalesmanTable
(
    SalesmanId int,
    SalesmanName varchar(50),
    Commission int,
    City varchar(50),
    Age int
)
insert into SalesmanTable
values(101,'Joe',50,'California',17),
(102,'Simon',75,'Texas',25),
(103,'Jessie',105,'Florida',35),
(104,'Danny',100,'Texas',22),
(105,'Lia',65,'New Jersy',30)

-- creating customer table
create table CustomerTable
(
    SalesmanId int,
    CustomerId int,
    CustomerName varchar(50),
    PurchaseAmount int
)
insert into CustomerTable
select 101,2345,'Andrew',550 union all
select 103,1575,'Lucky',4500 union all
select 104,2345,'Andrew',4000 union all
select 107,3747,'Remona',2700 union all
select 110,4004,'Julia',4545

-- creating Orders table
create table OrdersTable
(
   OrderId int,
   CustomerId int,
   SalesmanId int,
   OrderDate Date,
   Amount int
)
insert into OrdersTable
values(5001,2345,101,'2021-07-04',550),
(5003,1234,105,'2022-02-15',1500)

select * from SalesmanTable
select * from CustomerTable
select * from OrdersTable

-- Tasks to be performed
   -- 1.inserting a new record into Orders table
insert into OrdersTable
select 5002,3456,106,'2023-06-19',1000
   
   -- 2.adding primary key constraint for SalesmanId column in Salesman table
alter table SalesmanTable
alter column SalesmanId int not null

alter table SalesmanTable
add constraint Pk_SalesmanTable primary key(SalesmanId)
   -- adding default constraint for city column in Salesman table
alter table SalesmanTable
add constraint Df_SalesmanTable default 'Manhattan' for City
   -- adding foreign key constraint for SalesmanId column in Customer table
/*
alter table CustomerTable
add constraint Fk_CustomerTable  foreign key(SalesmanId)
references SalesmanTable(SalesmanId) 
*/ 
-- The SalesmanId in both tables are not same,
-- so we cannot add foreign key constraint here
-- if we want to add foreign key constraint to this, 
-- we have update salesmanId column same in both tables
   -- adding not null constraint in CustomerName column for the customer table
alter table CustomerTable
alter column CustomerName varchar(50) not null
   
   -- 3. fetching data where customer's name is ending with 'N'
        -- and also purchase amount value >500
select * from CustomerTable
where CustomerName like '%N' and PurchaseAmount > 500

select * from CustomerTable
where PurchaseAmount>500
  
  -- 4. SET operators
  -- Getting Unique values from all the 3 tables
select SalesmanId from SalesmanTable
union 
select SalesmanId from CustomerTable
union 
select SalesmanId from OrdersTable
  -- Getting all duplicate values from 3 tables
select SalesmanId from SalesmanTable
union all
select SalesmanId from CustomerTable
union all
select SalesmanId from OrdersTable
  
  -- 5. displaying matching data
select OrderDate,SalesmanName,CustomerName,Commission, City
from OrdersTable
Join SalesmanTable s on s.SalesmanId=s.SalesmanId
Join CustomerTable c on c.SalesmanId=c.SalesmanId
where PurchaseAmount between 500 and 1500
 
  -- 6. using right join to fetch all the results from salesman and orders table
select * from SalesmanTable as s
right join OrdersTable as o
on s.SalesmanId=o.SalesmanId
