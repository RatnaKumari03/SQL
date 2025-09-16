-- Date: 25 August 2025

-- ALTER:
   -- Add a column
   -- Remove a column
   -- Alter a column

select * from Employee
-- Add a column:
   -- we cannot add a new column in an existing table with a NOT NULL constraint
   -- Whenever we add a new column to a table, the column stores NULL in it for all the existing rows
   -- If we set it to NOT NULL, SQL server wouldn't know as to what data should be in the new column
   -- We can add a new column with NOT NULL, only when it has a DEFAULT constraint attached to it

create table Canteen_Access
(
   E_id int,
   Name char(50)
)
insert into Canteen_Access
select 1, 'Ratna' union all
select 2, 'Sravan' union all
select 3, 'Mani'

select * from Canteen_Access

ALTER table Canteen_Access
ADD Limit int not null Default(100) 

insert into Canteen_Access
select 4,'Chitti',200 
insert into Canteen_Access
select 5,'Shalu',100

-- Date: 26 August 2025

-- Drop a column
   -- for columns which do not have a constraint, you can directly drop the column
   -- for column with constraints, you need to drop the constraint first and the the column
   -- Exceptions - (NOT NULL,IDENTITY)

select * from Canteen_Access

create table Canteen
(
   E_id int,
   Name char(15),
   Salary int check(Salary>0),
)
alter table Canteen 
ADD Address varchar(50) 
insert into Canteen
select 1,'Ratna',2000,'Banglore' union all
select 2,'Sravan',3000,'Mumbai' union all
select 3,'Mani',4000,'Chennai' union all
select 4,'Chitti',5000,'Pune'

select * from Canteen

Alter table Canteen
Drop Column E_id

Alter table Canteen
drop column Salary

alter table Canteen
drop CONSTRAINT CK__Canteen__Salary__73BA3083

-- fn + alt + f1 - to see metadata

-- How to alter a column
  -- make sure that the data in the column clearly obeys the constraint or key rules that you apply
  
select * from Employee
alter table Employee
Alter column first_name char(50) not null

Alter table Employee
alter column Emp_Id int not null

alter table Employee
add constraint Ck_Emp_Id primary key(Emp_Id)


-- Temporary Tables
  -- These are temp storage units to stotre and transform data from the source before
  -- it is moved to the destination/displayed on the application
  -- these are created in tempdb
  -- two types of Temp tables:
     -- local temp table
     -- global temp table

-- Local Temp Table:
  -- available in particular session only where it got created
  -- it is identified by single # before the name of the table
  -- we can create indexes,keys,constraints exactly like a physical table in DB
  -- we can create n number of local temp tables with same names in different sessions
  -- we can either manually drop the local temp table or
  -- it gets dropped automatically once the session is closed

create table #LocalTempTable
(
  Id int,
  Name varchar(100)
)
insert into #LocalTempTable
select 1, 'Ratna' union all
select 2,'Sravan' union all
select 3,'Mani'

select * from #LocalTempTable

select * from #LocalTempTable as X
inner join Employee as emp
on emp.Emp_Id=X.Id

drop table #LocalTempTable

-- Global Temp Tables:
   -- These are identified by double ## before the name of the table
   -- we can create indexes,keys,constraints exactly like a physical table in DB
   -- scope of a global temp table is across all the sessions and for all users who have access to the database
   -- we can either manually drop the local temp table or
   -- it gets dropped automatically once the parent session is closed

create table ##GlobalTempTable
(
   Id int,
   Name varchar(100)
)
insert into ##GlobalTempTable
select 1, 'Ratna' union all
select 2,'Sravan' union all
select 3,'Mani'

select * from ##GlobalTempTable

drop table ##GlobalTempTable

-- Date: 28 August 2025

-- Functions
  -- It is a database object which has a set of SQL Statements that accepts input 
  -- parameters and returns the result
	-- At a given point in time, function will definitely return something
	-- It can be a scalar value or a table valued
	-- We cannot use a function to Insert, Update or Delete records from physical
		-- tables in the database
  
  -- Two types of functions
    -- 1. System Defined Functions
       -- a. Scalar functions
       -- b. Aggregate functions
    -- 2. User Defined Functions
       -- a. Scalar functions
       -- b. Table-Valued functions
          -- i. Inline table-valued function
          -- ii. multiline table-valued function

-- 1. System Defined Functions
  -- A. Scalar Functions:
    -- These functions operate on none

-- DateTime functions
  -- date time functions are really helpful when you want to build date range metrics

select GETDATE() -- returns the current server date time
select GETUTCDATE()  -- gets us the UTC date and time (Universal Time Coordinated/Greenwich Mean Time)
select GETDATE()+2  -- will add 2 days to my current date
select GETDATE()-2  -- will subtract 2 days from my current date
select DATEADD(hour,2,GETDATE()) -- adds 2 hours to now
select DATEADD(year,2,GETDATE()) -- adds 2 years to now
select DATEADD(hour,-2,GETDATE()) -- will subtract 2 hours to now
select DATEADD(year,-2,GETDATE()) -- subtracts 2 years to now
select DATEADD(month,2,GETDATE()) -- adds 2 months to now
select DATEADD(month,3,'2003-06-19') -- adds 3 months to the given date
select DATEADD(month,2,DATEADD(hour,3,GETDATE()))
select YEAR(GETDATE()) -- returns the year of the specified date
select MONTH(GETDATE())
select DATEPART(day,GETDATE())  -- returns the date part of the current datetime
select DAY(GETDATE())
select DATEPART(hour,GETDATE())
select DATEPART(minute,GETDATE())
select DATEDIFF(day,'2022-09-01','2022-09-07') -- returns the difference in days between start and end dates given
select DATEDIFF(hour,'2022-09-01','2022-09-07')
select DATEDIFF(minute,'2022-09-01','2022-09-07')
select DATENAME(MONTH,GETDATE())
select DATENAME(WEEKDAY,GETDATE())

-- Date: 29 August 2025

create table StudentsTable
(
  StudentID int Primary key identity(1,1),
  FirstName varchar(50) not null,
  LastName varchar(50) not null,
  Email varchar(100) unique,
  Age int check(Age>=18),
  Course varchar(50) default('General'),
  AdmissionDate date not null
)
insert into StudentsTable
select 'Ratna','Perugu','ratna123@gmail.com',22,'General','2025-07-21' union all
select 'Sravan','Sai','sravan123@gmail.com',18,'General','2025-07-13' union all
select 'Mani','Prabhandha','mani123@gmail.com',24,'General','2025-07-18' union all
select 'Chitti','Machavaram','chitti123@gmail.com',23,'General','2025-07-22' union all
select 'Anju','Shaan','anju123@gmail.com',21,'General','2025-07-21' union all
select 'Charitha','Pilli','chari123@gmail.com',21,'General','2025-07-01' union all
select 'Shalu','Chettipalli','shalu123@gmail.com',20,'General','2025-07-12'

select * from StudentsTable

alter table StudentsTable
add PhoneNumber varchar(15)

select * 
into StudentsTable_Backup
from StudentsTable

update stu
set Age=22
from StudentsTable as stu
where StudentID=5

select * from StudentsTable_Backup

select * from StudentsTable_Backup

update StudentsTable
set PhoneNumber=8326372779

select * from StudentsTable

update StudentsTable_Backup
set StudentsTable_Backup.PhoneNumber=StudentsTable.PhoneNumber
from StudentsTable_Backup
join StudentsTable
on StudentsTable_Backup.StudentID=StudentsTable.StudentID

select * from StudentsTable_Backup

-- Date: 01 Sept 2025

select * from EmployeeDOB

-- filtering by year
select * from EmployeeDOB
where YEAR(Emp_DOB)>=2000

--select * from EmployeeDOB where YEAR(Emp_DOB)>=2010

select * from Employee 

--people born between March and September
select * from EmployeeDOB
where MONTH(Emp_DOB) between 3 and 9

-- To identify all Employees who have DOB in the current month
select * from EmployeeDOB
where MONTH(Emp_DOB)=MONTH(GETDATE())

-- String Functions in SQL
select UPPER('Ratna') as Upper_Case_Eg  -- converts the text to uppercase
select LOWER('RAtNa') as Lower_Case_Eg  -- converts the text to lowercase
select LEN('    ratna03   ') as LengthOfString -- gives length of the string
-- in 'len' function it counts spaces from the start of the string but not the end of the string
-- string Concatenation
select 'Ratna'+ ' '+'Kumari'
select LEFT('Ratna',2)  -- returns the 2 chars for the left of the string
select RIGHT('Ratna',2) --returns the 2 chars for the right of the string
select TRIM('  ratna    kumari   ')  -- removes the unnecessary spaces before and after the string but not between the words
select REPLACE('Ratna','t','A') as OP -- replaces a part of the string with given characters
select REVERSE('ratna')  --  reverses the string
select SUBSTRING('ratna',1,4) -- substring returns the part of string from starting position to the specified position of the string
-- In python indexing starts from 0
-- In SQL indexing starts from 1
select CHARINDEX('t','ratna') -- tries to search for the character in the string
select CONCAT('Ratna',null,'Kumari')

--use case of String Functions
create table EmpTbl
(
  ID int,EmailID varchar(200)
)
insert into EmpTbl
select 1,'ratna@gmail.com' union all
select 2,'chitti@gmail.com' union all
select 3,'charitha@gmail.com' union all
select 4,'shalu@gmail.com' union all
select 5,'anjitha@gmail.com'

select * from EmpTbl

-- Date: 02 September 2025

select *
,SUBSTRING(EmailID,1,CHARINDEX('@',EmailID)-1) as UserName
,SUBSTRING(EmailID,CHARINDEX('@',EmailID)+1,LEN(EmailID)) as DomainName
from EmpTbl

-- Important Scalar Functions
-- Converting Integer to String

select 'ratna'+'kumari' -- concatenation happens
select 21+21  -- o/p will 42
select '21'+'21'  --o/p will be 2121
select 'ratna'+21  -- error because both are not of same datatypes

/* select Emp_Id,Address+ city + state+CAST(PinCode as varchar) as CompleteAddress
from Employee */

-- NUll values cannot be compared in SQL server
select * from Employee

select Emp_Id,first_name from Employee
where ISNULL(Emp_Id,0)<1

-- B. Aggregate Functions
  -- These Functions operate on a collection of values and returns a single value

select MAX(Salary) as MaximumSalary from Employee
select MIN(Salary) as MinimumSalary from Employee
select AVG(Salary) from Employee
select SUM(Salary)/COUNT(Emp_Id) from Employee -- Avg another type

-- Date: 04 September 2025

-- 2. User Defined Functions(UDF):
  -- 1. Scalar Valued UDF:
    -- Functions which we write,that accepts i/p parameters and returns a single value
    -- it can return any data type
    -- A single function at a single point in time will return only one data type
create function fn_GetEmployeeFullName  -- we can use create or alter
(
   @FirstName varchar(50),
   @LastName varchar(50)
)
RETURNS varchar(101)
AS
BEGIN
    RETURN (CONCAT(TRIM(@FirstName),' ',TRIM(@LastName)))
END

-- call scalar valued UDF
-- you need to specify the dbo(schema name) before your UD scalar valued function call 
select dbo.fn_GetEmployeeFullName('Ratna','Perugu') as FullName

create or alter function fn_AddNumbers
(
   @number1 int,
   @number2 int
)
returns int
as
begin
   return (isnull(@number1,0)+isnull(@number2,0))
end

select dbo.fn_AddNumbers(1,2)
select dbo.fn_AddNumbers(20,25)
select dbo.fn_AddNumbers(10,Null)

-- Use scalar valued function in a SELECT way
select Emp_Id,first_name,last_name,
dbo.fn_GetEmployeeFullName(first_name,last_name) as FullName
from Employee as emp
where dbo.fn_GetEmployeeFullName(first_name,last_name)='Ratna Perugu'


create or alter function fn_GetEmployeeDetails
(
   @Address varchar(50)
)
returns Table
as
  return (select dbo.fn_GetEmployeeFullName(first_name,last_name) as FullName,
       Salary,
       Address,
       Emp_DOB
       from Employee as emp
       left join EmployeeDOB as edob
       on edob.Emp_Id=emp.Emp_Id
       where emp.Address=@Address
)

-- Date: 05 September 2025

-- Importing flat files in SQL

-- 2.B. Multi Line/Multi Statement table valued function 

create or alter FUNCTION fn_GetEmployeeDetailsML
( @EmployeeID int)
returns @Emp table
( 
  EmployeeID int,
  EmployeeFullName varchar(101),
  Salary int
)
as
begin
Insert into @Emp(EmployeeID,EmployeeFullName,Salary)
select emp.Emp_Id,dbo.fn_GetEmployeeFullName(first_name,last_name),Salary
from Employee as emp
where emp.Emp_Id<>@EmployeeID

update @Emp
set Salary=5000
where EmployeeID in (6,3)

delete from @Emp
where EmployeeID in (2,5)

insert into @Emp
select 100,'Ratna Kumari',2000

return
end

SELECT * FROM fn_GetEmployeeDetailsML(4)
SELECT * FROM Employee 

sp_helptext fn_GetEmployeeDetailsML


-- case statements
select * 
  , CASE WHEN Emp_Id%2=1 THEN 'Odd' ELSE 'Even' as EvenOROdd
from Employee

SELECT *
	, CASE WHEN Salary <= 1000 THEN '0 to 1000'
		WHEN Salary > 1000 AND Salary <=3000 THEN '1000 to 3000'
		WHEN Salary >3000 AND Salary <= 4000 THEN '3000 to 4000'
		ELSE '> 4000' END AS SalaryGrade
FROM Employee
