
-- Date: 25 September 2025

-- NORMALIZATION:
   -- helps us in reducing data redundancy in accordance with a series of normal forms
   -- three types of Normal forms:
      -- First Normal Form (1 NF)
      -- Second Normal Form (2 NF)
      -- Third Normal Form (3 NF)
-- DRAWBACKS:
   -- data accessibility issues
   -- data manipulation issues
   -- space crunch

-- First Normal Form (1 NF):
   -- Every cell (intersection of a row and a column) must have a single data value

-- Normalized SETUP
   -- creates a lookup table

   -- Creating a de-normalized table
create table De_NormalizedTable
(
   EMPID int,
   NAME varchar(20),
   EMPAGE int,
   DEPT varchar(100)
)
insert into De_NormalizedTable
values(1,'Dinesh',27,'Software,Testing,Database'),
(2,'Santosh',28,'Management,Sware,Finance'),
(3,'John',25,'SW,Mgmt,Testing'),
(4,'Smith',29,'Software,Testing,Finance')

   -- Lookup table
create table Dept_Table
(
     DEPTID int,
     DEPTNAME varchar(20)
)
insert into Dept_Table
values(1,'Software'),
(2,'Testing'),
(3,'Database'),
(4,'Management'),
(5,'Sales'),
(6,'Finance')

alter table Dept_Table
alter column DEPTID int not null

alter table Dept_Table
add constraint Pk_Dept_Table primary key(DEPTID)

select * from De_NormalizedTable
select * from Dept_Table

   -- Normalized table
create table NormalizedTable
(
    EMPID int,
    NAME varchar(20),
    EMPAGE int,
    DEPT int foreign key references Dept_Table(DEPTID)
)
insert into NormalizedTable
select 1,'Dinesh',27,1 union all
select 2,'Santosh',28,4 union all
select 3,'John',25,1 union all
select 4,'Smith',29,2

select * from NormalizedTable

   -- Normalized setup(Lookup table)

-- Second Normal Form (2 NF):
   -- when it is in 1 NF, partial dependencies are removed and placed in a different table

   -- creating de_normalized table
create table CourseTable
(
    COURSE_NAME varchar(10) primary key,
    START_DATE date,
    TITLE varchar(50)
)
insert into CourseTable
values('SQL','2019-08-02','SQL Development'),
('MSBI','2019-08-20','MSBI Development'),
('AWS','2019-09-01','Amazon Web Servies Training')
--values('SQl','2019-10-02','SQL Development'),
--('SQL','2019-11-02','SQL Development')
select * from CourseTable

   -- Lookup Table
create table Course_Title
(
  COURSE_NAME varchar(10) primary key,
  TITLE varchar(50)
)
insert into Course_Title
values('SQL','SQL Development'),
('MSBI','MSBI Development'),
('AWS','Amazon Web Services Training')
select * from Course_Title

    -- Normalized Table
create table CourseStart
(
   COURSE_NAME varchar(10) foreign key references Course_Title(COURSE_NAME),
   START_DATE date
)
insert into CourseStart
values('SQL','2019-08-02'),
('MSBI','2019-08-20'),
('AWS','2019-09-01'),
('SQL','2019-10-02'),
('SQL','2019-11-02')

select * from CourseStart

-- Third Normal Form (3 NF):
   -- when the table is in 2 NF 
   -- Non-Primary key columns shouldn't depnd on other non-primary key columns
   
   -- creating a de_normalized table
--create table EmployeeCourse


-- Date: 27 September 2025

-- Transaction:
   -- set of SQL operations performed in a sequence such that all operations are guarenteed to succeed or fall as a single unit
   -- Transaction is ALL or NONE
   -- follows ACID property
      -- Atomicity  -- transaction should be considered as a single unit, irrespective of the no of steps involved
      -- Consistency  -- transaction should always leave the DB/Table in a consistent state after commit or rollback of the changes
      -- Isolation  -- each transaction has its own boundaries and do not interfere with other transactions
      -- Durability  -- any modification done on the data after the transaction is finished should be kept permanently in the DB/system
-- when to use transaction:
   -- when multiple no of rows are inserted, updated or deleted in a sequence
   -- when the changes in the one table required the other table data to be kept consistent
   -- 
-- Types of transactions:
   -- Autocommit Transaction
   -- Explicit Transaction
select * from Employee
select * from EmployeeDOB
-- creating a transaction
BEGIN TRANSACTION 
  update e
  SET e.last_name='Bist' 
  from Employee as e
  where Emp_Id=13

  update edob
  SET edob.Emp_DOB='2003-06-19'
  from EmployeeDOB as edob
  where Emp_Id=1

ROLLBACK TRANSACTION  -- if we want to rollback our transaction
COMMIT TRANSACTION    -- if we want to commit our transaction

select * from Employee where Emp_Id=13
select * from EmployeeDOB where Emp_Id=1

-- Date: 29 September 2025

BEGIN TRANSACTION 
    delete e 
    from Employee as e
    where Emp_Id=13

COMMIT TRANSACTION
ROLLBACK TRANSACTION

select * from Employee

-- Transcount

-- ERROR/EXCEPTION HANDLING
   -- Try Catch blocks handles the errors
   -- Try block contains the SQL statements that needs to be execute
   -- If there are any errors from the SQL query, Catch block is hit

DECLARE @Numerator int=40,
        @Denominator int=0

-- Try Block
BEGIN TRY 
    select @Numerator/@Denominator
END TRY
-- Catch Vlock
BEGIN CATCH
    select 'Catch block is hit'

-- printing the actual error message
DECLARE @ErrorMessage varchar(500)
SET @ErrorMessage=ERROR_MESSAGE()
    
    select @ErrorMessage
END CATCH

-- Try catch block on Transaction
BEGIN TRY
   BEGIN TRANSACTION
       select * from Employee
       where Emp_Id=5 and last_name='Dude'
       
       select * from Employee
       where Last_name='Perugu'
     COMMIT TRANSACTION
     select 'TransactionCommitted'
END TRY
BEGIN CATCH
   ROLLBACK TRANSACTION 
   select 'TransactionRolledback'
END CATCH

-- Example of try catch block on procedure
CREATE OR ALTER PROCEDURE spName
AS
BEGIN
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	BEGIN TRY
		BEGIN TRANSACTION
			UPDATE Employee
			SET Last_name = 'Yadav'--Kumar
			WHERE Emp_Id = 1
 
			INSERT INTO Employee(Emp_Id,first_name,Last_name,Salary,Address)
			SELECT 101, 'Hello', 'World', 2000, 'US'
 
	
 
			--UPDATE Employee
			--SET EmployeeID = 1/0 -- Divide by Zero
			--WHERE EmployeeID = 1
		COMMIT TRANSACTION
		SELECT 'TransactionCommitted'
	END TRY
	BEGIN CATCH
		SELECT ERROR_LINE(),ERROR_MESSAGE(),GETDATE()
		ROLLBACK TRANSACTION
		SELECT 'TransactionRolledBack'
	END CATCH
END
 
EXEC spName

-- Date: 02 October 2025

-- Schema:
    -- star schema(fact table,dimension tables)
    -- snowflake schema(fact table,dimension tables, and dimension tables again normalized)
    -- star --> no normalization
    -- snowflake --> normalization

-- STAR SCHEMA
-- Dimension Tables
CREATE TABLE Dim_Date (
    DateKey INT PRIMARY KEY,
    Date DATE,
    Month INT,
    Year INT
);

CREATE TABLE Dim_Product (
    ProductKey INT PRIMARY KEY,
    ProductName VARCHAR(50),
    Category VARCHAR(50),
    Price DECIMAL(10,2)
);

CREATE TABLE Dim_Customer (
    CustomerKey INT PRIMARY KEY,
    CustomerName VARCHAR(50),
    City VARCHAR(50),
    State VARCHAR(50)
);

-- Fact Table
CREATE TABLE Fact_Sales (
    SaleID INT PRIMARY KEY,
    DateKey INT,
    ProductKey INT,
    CustomerKey INT,
    Quantity INT,
    TotalAmount DECIMAL(10,2),
    FOREIGN KEY (DateKey) REFERENCES Dim_Date(DateKey),
    FOREIGN KEY (ProductKey) REFERENCES Dim_Product(ProductKey),
    FOREIGN KEY (CustomerKey) REFERENCES Dim_Customer(CustomerKey)
);

-- Insert into Dim_Date
INSERT INTO Dim_Date (DateKey, Date, Month, Year) VALUES
(20241001, '2024-10-01', 10, 2024),
(20241002, '2024-10-02', 10, 2024),
(20241003, '2024-10-03', 10, 2024);

-- Insert into Dim_Product
INSERT INTO Dim_Product (ProductKey, ProductName, Category, Price) VALUES
(1, 'Laptop', 'Electronics', 800.00),
(2, 'Phone', 'Electronics', 500.00),
(3, 'Table', 'Furniture', 150.00);

-- Insert into Dim_Customer
INSERT INTO Dim_Customer (CustomerKey, CustomerName, City, State) VALUES
(101, 'Alice', 'New York', 'NY'),
(102, 'Bob', 'Los Angeles', 'CA'),
(103, 'Charlie', 'Chicago', 'IL');

-- Insert into Fact_Sales
INSERT INTO Fact_Sales (SaleID, DateKey, ProductKey, CustomerKey, Quantity, TotalAmount) VALUES
(1, 20241001, 1, 101, 2, 1600.00),
(2, 20241002, 2, 102, 1, 500.00),
(3, 20241003, 3, 103, 4, 600.00);
 
select * from Dim_Date
select * from Dim_Product
select * from Dim_Customer
select * from Fact_Sales

-- Date: 03 October 2025
-- SNOWFLAKE SCHEMA

-- Category (normalized from Product)
CREATE TABLE Dim_Category (
    CategoryKey INT PRIMARY KEY,
    CategoryName VARCHAR(50)
);

-- Product
CREATE TABLE Dim__Product (
    ProductKey INT PRIMARY KEY,
    ProductName VARCHAR(50),
    CategoryKey INT,
    FOREIGN KEY (CategoryKey) REFERENCES Dim_Category(CategoryKey)
);

-- Location (normalized from Customer)
CREATE TABLE Dim_Location (
    LocationKey INT PRIMARY KEY,
    City VARCHAR(50),
    State VARCHAR(50)
);

-- Customer
CREATE TABLE Dim__Customer (
    CustomerKey INT PRIMARY KEY,
    CustomerName VARCHAR(50),
    LocationKey INT,
    FOREIGN KEY (LocationKey) REFERENCES Dim_Location(LocationKey)
);

-- Date
CREATE TABLE Dim__Date (
    DateKey INT PRIMARY KEY,
    [Date] DATE
);

-- Fact Table
CREATE TABLE Fact__Sales (
    SaleID INT PRIMARY KEY,
    DateKey INT,
    ProductKey INT,
    CustomerKey INT,
    Quantity INT,
    TotalAmount DECIMAL(10,2),
    FOREIGN KEY (DateKey) REFERENCES Dim__Date(DateKey),
    FOREIGN KEY (ProductKey) REFERENCES Dim__Product(ProductKey),
    FOREIGN KEY (CustomerKey) REFERENCES Dim__Customer(CustomerKey)
);

-- Category
INSERT INTO Dim_Category VALUES (1, 'Electronics'), (2, 'Furniture');

-- Product
INSERT INTO Dim__Product VALUES 
(101, 'Laptop', 1),
(102, 'Table', 2);

-- Location
INSERT INTO Dim_Location VALUES 
(1, 'New York', 'NY'),
(2, 'Chicago', 'IL');

-- Customer
INSERT INTO Dim__Customer VALUES 
(201, 'Alice', 1),
(202, 'Bob', 2);

-- Date
INSERT INTO Dim__Date VALUES 
(20241001, '2024-10-01'),
(20241002, '2024-10-02');

-- Fact
INSERT INTO Fact__Sales VALUES 
(1, 20241001, 101, 201, 1, 1200.00),
(2, 20241002, 102, 202, 2, 500.00);

select * from Dim_Category
select * from Dim__Product
select * from Dim_Location
select * from Dim__Customer
select * from Dim__Date
select * from Fact__Sales

