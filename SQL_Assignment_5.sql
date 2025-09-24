-- Assignment 5

-- Tasks to be performed

  -- 1. Arrange the ‘Orders’ dataset in decreasing order of amount
select * from Orders_Table
Order by amount DESC

  -- 2. Create a table with the name ‘Employee_details1’ consisting of these
    --columns: ‘Emp_id’, ‘Emp_name’, ‘Emp_salary’. 
    --Create another table with the name 
    --‘Employee_details2’ consisting of the same columns as the first table.
create table Employee_details1
(
   Emp_id int primary key,
   Emp_name varchar(15),
   Emp_salary int
)
insert into Employee_details1
values(1,'Ratna',50000),
(2,'Damien',45000),
(3,'Kirill',30000)

create table Employee_details2
(
  Emp_id int primary key,
  Emp_name varchar(15),
  Emp_salary int
)
insert into Employee_details2
values(1,'Ratna',50000),
(2,'Kyle',40000),
(3,'Rai',60000)

select * from Employee_details1
select * from Employee_details2

  -- 3. Apply the UNION operator on these two tables
select * from Employee_details1
UNION 
select * from Employee_details2
-- union operator returns unique records from the tables

select * from Employee_details1
UNION ALL
select * from Employee_details2
-- union all operator returns all records regardless of duplicates or not

  -- 4. Apply the INTERSECT operator on these two tables
select * from Employee_details1
INTERSECT 
select * from Employee_details2
-- returns common records from both tables

  -- 5. Apply the EXCEPT operator on these two tables
select * from Employee_details1
EXCEPT
select * from Employee_details2
-- EXCEPT returns records which present in first SELECT but missing in second SELECT
select * from Employee_details2
EXCEPT
select * from Employee_details1