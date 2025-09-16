-- Assignment 2 - Student Management Database
-- 1. Create a Table
create table StudentManagement
(
    StudentID int primary key identity(1,1),
    FirstName varchar(50) not null,
    LastName varchar(50) not null,
    DOB date not null,
    Gender char(1) check(Gender in ('M','F')),
    Marks int check(Marks between 0 and 100),
    AdmissionDate Datetime default GETDATE()
)

-- 2. Insert Records
insert into StudentManagement
select 'Ratna','Perugu','2003-06-19','F',85, GETDATE() union all
select 'Sai','Perugu','2007-10-20','M',87, GETDATE() union all
select 'Mani','Perugu','2001-03-29','F',90, GETDATE() union all
select 'Prathima','Machavaram','2002-11-01','F',80, GETDATE() union all
select 'Abhi','Kadiyam','2004-07-10','M',75, GETDATE() union all
select 'Shalu','Chettipalli','2005-07-25','F',82, GETDATE() union all
select 'Anjitha','Shaan','2003-05-11','F',72,GETDATE()

select * from StudentManagement

-- 3. Create a Backup Table
select * into StudentManagement_Backup
from StudentManagement

select * from StudentManagement_Backup

-- 4. Apply Date Functions

  -- 1. Display students’ age in years using DOB.
select DOB,DATEDIFF(year,DOB,GETDATE())
from StudentManagement

  -- 2. Extract year and month from AdmissionDate.
select AdmissionDate,DATENAME(YEAR,AdmissionDate) as AdmissionYear,
DATENAME(MONTH,AdmissionDate) as AdmissionMonth
from StudentManagement

  -- 3. Display students admitted in the last 30 days.
select StudentID,FirstName,LastName,AdmissionDate
from StudentManagement
where AdmissionDate>=DATEADD(DAY,-30,GETDATE())

-- 5. Apply Aggregate Functions
   
   -- 1. Find the highest, lowest, and average marks.
select max(marks) as Highest_marks from StudentManagement
select min(marks) as Lowest_marks from StudentManagement
select AVG(marks) as Avg_marks from StudentManagement

   -- 2. Count the total number of male and female students.
select COUNT(Gender) as Male from StudentManagement
where Gender='M'

select COUNT(Gender) as Female from StudentManagement
where Gender='F'

   -- 3. Find the number of students born after 2000.
select COUNT(DOB) as Born_After_2000 from StudentManagement
where DOB>'2000'