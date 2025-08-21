-- SQL ASSIGNMENT 1

-- Q1. Create Tables
--Create the following 3 tables with appropriate constraints:

create table Student
(
   StudentID int primary key,
   Name varchar(50) not null,
   Age int check(Age>=17),
   DepartmentID int foreign key references Departments(DepartmentID)
)

create table Departments
(
   DepartmentID int primary key,
   DepartmentName varchar(50) not null unique,
)

create table Courses
(
   CourseID int primary key,
   CourseName varchar(50) not null,
   DepartmentID int foreign key references Departments(DepartmentID)
)

-- Q2. INSERT data
--Insert atleast 5 records in each table
insert into Departments
select 1,'Computer Science' union all
select 2,'Mechanical' union all
select 3,'Electrical' union all
select 4,'Civil' union all
select 5,'Electronics'

insert into Student
select 1,'Gayathri',20,1 union all
select 2,'Anjitha',21,2 union all
select 3,'Bhavana',19,3 union all
select 4,'Sunitha',18,4 union all
select 5,'Ratna',22,5

insert into Courses
select 1,'DBMS',1 union all
select 2,'Thermodynamics',2 union all
select 3,'AI',4 union all
select 4,'Structures',3 union all
select 5,'Circuits',5

select * from Student
select * from Departments
select * from Courses


--Q3 Apply WHERE and Operators

SELECT *
from Student as stu
WHERE Age>20

select * 
from Courses as c join  Departments as d 
on c.DepartmentID  = d.DepartmentID 
where DepartmentName = 'computer science'

select * 
from Student as stu join Departments as d 
on stu.DepartmentID=d.DepartmentID
where DepartmentName='Electronics'

select *
from Student
where Age BETWEEN 18 and 22


--Q4. JOINS

-- Inner join
select stu.Name, d.DepartmentName 
from Student as stu 
inner join departments as d 
on stu.DepartmentID = d.DepartmentID

-- Left join
select c.CourseName, d.DepartmentID 
from Courses as c 
left join departments as d 
on d.DepartmentID = c.DepartmentID

-- Right join
select Name,CourseName 
from Courses as c 
right join Student as stu 
on stu.DepartmentID = c.DepartmentID