--Date: 16 September 2025

-- Stored Procedures
-- creation of store procedures
create or alter PROCEDURE csp_GetData
as
BEGIN
   select * from Employee
END

-- Execution of store procedure
EXEC csp_GetData

-- ALTERING SP to add/remove columns
create or alter PROCEDURE dbo.csp_GetData
as
BEGIN
   select Emp_Id,First_name,Last_name
   from Employee
END

EXEC csp_GetData

-- Adding a Parameter
alter PROCEDURE dbo.csp_GetData
(
   @EmployeeID int= 0  -- default value to a parameter makes it optional
)
as
BEGIN
   select emp.Emp_Id,dbo.fn_GetEmployeeFullName(First_name,Last_name) as FullName,
          Address,Emp_DOB
   from Employee as emp
   LEFT JOIN EmployeeDOB as edob ON edob.Emp_Id=emp.Emp_Id
   WHERE emp.Emp_Id=@EmployeeID OR @EmployeeID=0 --True/False
END

EXEC csp_GetData @EmployeeID=5

-- Date: 17 September 2025

select * from EmployeeDOB

create or alter PROCEDURE dbo.csp_GetData
(
   @EmployeeID int=0,  -- optional parameter
   @EmployeeAddress varchar(100)  -- Mandatory Parameter
)
as
BEGIN 
  select Emp_Id,dbo.fn_GetEmployeeFullName(First_name,Last_name) as FullName,
          Address
  from Employee
  WHERE (Emp_Id=@EmployeeID or @EmployeeID=0)
  and Address=@EmployeeAddress
END

EXEC csp_GetData @EmployeeAddress='India',@EmployeeID=5

select * from Employee

-- To view the definition of the SP
sp_helptext csp_GetData

create or alter PROCEDURE csp_GetData
(
   @EmployeeID int,
   @EmployeeFirtsName varchar(100),
   @EmployeeLastName varchar(100),
   @Salary int,
   @Address varchar(200)
)
as
BEGIN
    IF NOT EXISTS(SELECT * from Employee where Emp_Id=@EmployeeID)
       INSERT into Employee(Emp_Id,First_name,Last_name,salary,Address)
       SELECT @EmployeeID,@EmployeeFirtsName,@EmployeeLastName,@Salary,@Address
    ELSE
       PRINT 'EmployeeID Already exists!! Please choose a new ID'
END

EXEC csp_GetData 13,'Hema','Nepal',25000,'Nepal'

select * from Employee

-- Views
   -- View could be looked as an additional layer on top of a table 
   -- which enables us to protect sensitive information on our needs
   -- View is just a query on top of a table
   -- As this is just a layer on top of a table,views do not store any data physically in the server
   -- Instead, the data when requested , the query is executed and data is returned

-- Date: 18 September 2025

-- create a new View
create or alter VIEW vw_EmployeeData
as
   SELECT * from Employee
use August_Batch_SQL
-- Fetch data from a view
select * from vw_EmployeeData

-- Restrict to specific columns
create or alter VIEW vw_GetEmployeeData
as
   select Emp_Id,First_name,Last_name,Address
   from Employee
   where Emp_Id>3

select * from vw_GetEmployeeData

-- joining tables to view the data
create or alter VIEW vw_GetEmployeeData
as
  select emp.Emp_Id,dbo.fn_GetEmployeeFullName(First_name,Last_name) as FullName,
  Address,Emp_DOB
  from Employee as emp
  LEFT JOIN EmployeeDOB as edob ON edob.Emp_Id=emp.Emp_Id
  where emp.Emp_Id>3

select * from vw_GetEmployeeData
where Emp_Id in (5,6)

select * from world_population

-- create a view t0 view details of population of asian countries
create or alter VIEW vw_world_population
as
   select * from world_population
   where Continent='Asia'
select * from vw_world_population
where Continent='Asia'

-- create a view to view details of population of asian continent and india country
create or alter VIEW vw_world_population
as
  select * from world_population
  where Continent='Asia' and Country_Territory='India'
select * from vw_world_population
where Continent='Asia' and Country_Territory='India'

-- create a store procedure to view details of population of asia,india
create or alter PROCEDURE csp_GetWorldData
as
BEGIN
  select * from world_population
  where Continent='Asia' and Country_Territory='India'
END

EXEC csp_GetWorldData

-- Orphan View
   -- Views for which the base table/column has changed/altered is called an orphan view
   -- To prevent such scenarios and to not make our views orphan, we schemabind the view
   -- Schemabinding binds our views to the dependent physical column and tables in the views
   -- Schemabinding is only applicable for columns that are binded in the view
   
-- Date: 19 September 2025

-- Query Optimization: to reduce the runtime
-- Indexes:
  -- They are routers to better performance in SQL Server
  -- Index's helps in faster access by providing swift access to rows in data
  -- This is very similar to an index page in a book
  -- Microsoft very often make changes to the way Indexes are organized and managed

-- Index Structure:
  -- basically created on tables(columns)
  -- faster access to data using the column
      -- on which the index is created(indexed column)
  -- Indexes are basically B-Tree(Binary Tree) structures which helps us in flattening our table
      -- and hence providing easy access to the data rows
  -- without an index, a table is called a heap
  -- we can create indexes on most data tables
  -- we cannot create indexes on imagw data,video data,etc...
  -- two types of indexes:
     -- Clustered index
     -- Non Clustered index

create table IndexTest
(
   id int primary key,
   name varchar(50)
);
-- Insert values into the table
DECLARE @i int=1;
WHILE @i<=10000
BEGIN
     INSERT into IndexTest(id,name)
     values (@i,'Ratna' + CAST(@i as varchar(5)));
     SET @i=@i+1;
END;

select * from IndexTest

-- Date: 20 September 2025

select * from IndexTest
where id=10000

-- when getting the o/p of above query, it checks the records 10000 times 
   -- and get the o/p. It takes some time
   -- To reduce that time, we are creating Clustered Index

select * into IndexTest_CI from IndexTest  -- backup table

select * from IndexTest
select * from IndexTest_CI

select * from IndexTest_CI
where id=2738

/* WITHOUT INDEX:
operation: Table scan
no of rows read: 10000
I/O: 0.027
CPU: 0.011
*/
/* WITH CLUSTERED INDEX:
operation: index seek
no of rows read: 1
I/O: 0.003125
CPU: 0.0001581
*/

create CLUSTERED INDEX IX_IndexTest_CI_Id on IndexTest_CI(Id)
select * from IndexTest_CI
where Id=7346

-- select * from IndexTest

create or alter VIEW vw_GetEmployeeBackupData
with SCHEMABINDING 
as
    select Emp_Id,First_name,Address
    from dbo.Employee_Backup

drop view vw_GetEmployeeBackupData

alter table Employee_Backup
drop column Emp_Id

alter table Employee_Backup
drop column First_name

alter table Employee_Backup
drop column salary

-- Emp_Id,First_name cannot be dropped because we schemabinded them
-- salary is not applicable to this 'cause we didn't schema binded it

-- DML Operations on a view:
  -- Insert
  -- Update
  -- Delete

select * from vw_GetEmployeeBackupData  -- view

select * from Employee_Backup  -- Base Table
select * from vw_GetEmployeeBackupData

-- INSERT 
insert into vw_GetEmployeeBackupData(Emp_Id,First_name,Address)
select 999,'Tom','US'

select * from Employee

-- UPDATE
update vw_GetEmployeeBackupData
set Address='India'
where Emp_Id=999

--DELETE
delete from vw_GetEmployeeBackupData
where Emp_Id=999


