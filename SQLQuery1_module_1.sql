
-- Date: 5 August 2025

-- Line numbers are important
-- to get line numbers: tools-options-text editor-transact SQL
/*
multi line
comments
*/
-- single line comments
-- Three options to execute a query
    -- Execute button at the top of the query window
    -- Use f5 (fn+f5)
    -- ctrl+E
-- To hide/unhide the results/console window/pane : ctrl+R
-- To comment a line of code : ctrl+K+C
-- To uncomment : ctrl+K+U


-- Date: 6 August 2025

-- To create a database using Transact-SQL(TSQL)
Create database Excel_practice

-- Whenever we create a database there are two files that are created:
    -- MDF (Master Data File)- it holds data that is stored
    -- LDF (Log Data File)- it holds the log of all the changes that is performed on the database

-- change the database connection
Use Excel_practice 

-- Remove or delete database
drop Excel_practice

-- Data types in SQL Server
  -- Numeric
     -- bigint -> 10 digits(8 bytes)
     -- int -> 1 digit < > 10 digits(4 bytes)
     -- smallint -> -32768 to 32767 (2 bytes)
     -- tinyint -> 0 to 225(1)
     -- bit -> 0 and 1
     -- decimal(7,3) -> 7 digit whole numbers and 3 digits after decimal(XXXX.XXX)
  -- Text
      -- char -> 255
      -- varchar -> 8000  -> Alphanumeric
      -- nvarchar -> 4000 -> Special Characters
      -- text -> 62000+ chars(Product Feedback,Comment)
  -- Datetime(YYYY-MM-DD)
      -- Date -> YYYY-MM-DD
      -- Datetime -> YYYY-MM-DD HH:MM:SS -precision upto seconds
      -- Dtaetime2 -> YYYY-MM-DD HH:MM:SS:XXXXXX -precision upto milliseconds


-- Date:  12 August 2025

-- How can we create a table
create table Employee
-- when we are creating column, first column name -> datatype(mandatory)->constraint
(Emp_Id int,
First_name char(20),
Last_name char(20),
salary int,
Address nvarchar(100))


-- Creating a family table
create table Family
(S_no tinyint,
First_name char(20),
Last_name char(20),
relation char(20))

select * from Employee -- select is used to select table and view

-- Two methods to insert values in the table
     -- values
     -- select

insert into Employee  --insert is used to insert values in table
(Emp_Id,First_name,Last_name,salary,Address)  -- optional when giving values for all columns
Values(1,'Ratna','Perugu',50000,'London'),
(2,'Sunitha','Perumalla',40000,'India'),
(3,'Bhavana','Mungara',30000,'Indonesia'),
(4,'Gayathri','Dude',20000,'Australia')


insert into Employee
(Emp_Id,First_name,Last_name,salary,Address)
select 5,'Anjitha','Golla',5000,'India' union all 
select 6,'Chitti','Machavaram',6000,'Ongole' union all
select 7,'Charitha','Papa',8000,'Ananthpur' union all
select 8,'Kajal','Barnawal',25000,'Bihar'

select * from Employee

-- Alt + f1 -- to view the metadata
-- Metadata is nothing but data about data


-- Practice Queries

-- Date: 13 August 2025

-- 2. Products Table
create table Products
(ProductID int,
ProductName varchar(50),
Category varchar(50),
Price decimal(8,2))
-- Inserting 4 product records into the table
insert into Products
Values(1,'Treseme','Shampoo',329.00),
(2,'Vaseline','Bodylotion',500),
(3,'Dell','Laptop',60000),
(4,'Vivo','Mobile',27000)

select * from Products


-- 3. Students Table
create table Students
(RollNo int,
Name varchar(40),
Course varchar(30),
Marks int)
--inserting 3 student records into the table
insert into Students
(RollNo,Name,Course,Marks)
select 1,'Ratna','ECE',81 union all
select 2,'Sunitha','ECE',90 union all
select 3,'Bhavana','ECE',79

select * from Students


-- 4. Orders Table
create table Orders
(orderID int,
CustomerName varchar(50),
orderDate Date,
TotalAmount decimal(10,2))
-- inserting 5 order records into the table
insert into Orders
--(orderID,CustomerName,orderDate,TotalAmount)
Values(101,'Ratna','2025-08-05',100000),
(102,'Anjitha','2025-06-02',20000),
(103,'Chitti','2024-09-10',250000),
(104,'Shalu','2025-01-02',30000),
(105,'Charitha','2023-12-12',40000)


select * from Orders

-- we should add ' ' for dates, otherwise it shows errors



-- 5.Books Table
create table Books
(BookID int,
Title varchar(100),
Author varchar(50),
Price decimal(8,2))
-- inserting 4 book records into the table
insert into Books
select 201,'THE SUBTLE ART OF NOT GIVING A F*CK','Mark Manson',500 union all
select 202,'GOOD VIBES GOOD LIFE','Vex King',600 union all
select 203,'AMMA DIARY LO KONNI PAGEELU','Ravi Mantri',700 union all
select 204,'CHIKLIT','Kadali',800


select * from Books

-- Date: 14 August 2025

-- Constraints in SQL
    -- These are rules that we apply on the column of a table(while creating)
    -- to restrict the data that can be stored in the column
       -- 1. NOT NULL:
          -- cannot leave any value in the column empty
          -- By default when we create table it is set to nullable
-- Notnull Table
create table NotNullTest
(
   Id int not null, --Mandatory
   Name varchar(100)  -- not mandatory/optional
)
insert into NotNullTest(Id,Name)
select 1,'Ratna'
select Null,'Anjitha'

select * from NotNullTest

      -- 2. UNIQUE:
         -- helps is in maintaining unique data in a column
         -- there is also one null value that is allowed per unique column
create table UniqueTest
(
  Id int Unique,
  Name varchar(100)
)
insert into UniqueTest(Id,Name)
select 1,'Ratna'

insert into UniqueTest(Id,Name)
select 2,'Anjitha'

insert into UniqueTest(Id,Name)
select null,'Kadali'

insert into UniqueTest(Id,Name)
select null,'Mantri'

insert into UniqueTest(Id,Name)
select 3,'Mark'

select * from UniqueTest

      -- 3. PRIMARY KEY:
         -- uniquely identifying a row in the table
         -- combination of unique and not null constarint
create table PrimaryKeyTest
(
   Id int Primary key,
   Name varchar(100)
)
insert into PrimaryKeyTest
select 1,'Ratna' 
insert into PrimaryKeyTest
select 2,'Anjitha'
insert into PrimaryKeyTest
select 3,'Kadali'
insert into PrimaryKeyTest
select null,'Mantri'
select * from PrimaryKeyTest

     -- 4. CHECK constraint
        -- helps us in checking the value that is inserted against a condition
create table CheckTest
(
   Id int,
   Salary int check(Salary>0)
)
insert into CheckTest
select 1,1000
insert into CheckTest
select 2,0
insert into CheckTest
select 2,100
select * from CheckTest

-- Example2 for CheckTest
create table CheckTest2
(
  Name varchar(100),
  VaccinationFlag varchar(10) Check(VaccinationFlag in ('Yes','No'))
)
insert into CheckTest2
select 'Ratna','Yes'

insert into CheckTest2
select 'Anjitha','No'

insert into CheckTest2
select 'Kadali',null

insert into CheckTest2
select 'Mantri','Y'  -- statement terminates because condition doesn't satisfied

select * from CheckTest2


      -- 5. DEFAULT:
         -- helps us in inserting the default value to a column there is no value
         -- specified explicitly during the insert
create table DefaultTest
(
   Id int,
   Name varchar(100) default('NoNameProvided')
)
insert into DefaultTest
select 1,'Ratna'

insert into DefaultTest
select 2,null

insert into DefaultTest
select 3,'Anjitha'

select * from DefaultTest

      -- 6. IDENTITY Constraint
         -- helps us in generating identity values for each row of the table
         -- normally, we cannot insert data into a Identity column manually
create table IdentityTest
(
   Id int identity(1,6),  --(seed,Increment) 1,6,11,16,21.....
   Name varchar(100)
)
insert into IdentityTest
select 'Ratna' union 
select 'Anjitha'

insert into IdentityTest
select 'Kadali' union 
select 'Mantri'

select * from IdentityTest


-- Date: 18 August 2025


create table Customer
(customer_Id int primary key,
customer_Name char(20) not null,
Email_Id nvarchar(30) unique,
Age int check(Age>=18))

insert into Customer
values(2015,'Ratna','ratna123@gmail.com',22)

select * from Customer


-- Date: 19 August 2025

    -- 7. FOREIGN key:
        -- it is a field that helps us in identifying a row in another table(primary parent) 
create table ForeignKeyTest
(
   Id int foreign key references PrimaryKeyTest(Id),
   DOB date
)
insert into ForeignKeyTest(Id,DOB)
select 1,'2003-06-19'
insert into ForeignKeyTest
select 2,'2004-09-12'
insert into ForeignKeyTest
select 3,'1997-12-27'

select * from ForeignKeyTest

select * from PrimaryKeyTest


-- Data Retrieval Part
   -- SELECT statement helps us in limiting the columns
   -- we use WHERE clause to restrict/filter the rows that are displayed
SELECT * -- represents all columns in the table
               --First_Name,
               --Last_Name
              -- emp.Address
FROM Employee AS emp
-- WHERE Emp_Id = 1
--WHERE Emp_Id in (1,2,5,6) 
--WHERE First_name='Kajal'
--WHERE Emp_Id>=3
--WHERE Emp_Id<=3
--WHERE Emp_Id!=3
--WHERE Emp_Id <> 3
--WHERE Emp_Id>3 AND Address='India'
--WHERE Emp_Id>3 OR Address='India'
--WHERE NOT Emp_Id IN (1,5,7)
--WHERE Emp_Id BETWEEN 3 AND 6

     -- DISTINCT:
        -- Helps us in retrieving only the distinct values from a table
select DISTINCT Address
From Employee
   
     -- TOP clause:
        -- top helps us in displaying n number of records as per request
select TOP 3 *
from Employee AS emp
WHERE Address= 'London'

-- Date: 20 August 2025

    -- LIKE operator:
       -- helps us in identifying patterns in the text column
       -- we use two wild card characters to use this like operator
          -- % refers to 0 to n number of alpha numeric characters
          -- _ refers to only one aplha numeric character
SELECT * 
FROM Employee
--WHERE First_name LIKE '%h'  -- filters out all the records which ends with h 
--WHERE First_name LIKE '%a'
--WHERE First_name LIKE 'R%'   -- filters out all the records which starts with R
--WHERE Last_name LIKE 'P%'
--WHERE First_name LIKE '%o%'    -- filters out all the records which contains o
--WHERE First_name LIKE '%s_'      -- filters out all the records which ends with s and other alpha numeric character
--WHERE First_name LIKE '__t%'


