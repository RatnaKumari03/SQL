-- Date: 20 August 2025

-- JOINS:
   -- Joins plays a crucial role in RDBMS
   -- 3 types of joins:
      -- Inner join 
      -- Outer join(left outer join/left join,right outer join/right join,full outer join/join)
      -- Cross join
create table EmployeeDOB
(
  Emp_Id int,
  Emp_DOB date
)
insert into EmployeeDOB
select 1,GETDATE()-7000 union all
select 2,GETDATE()-7300 union all
select 3,GETDATE()-6000 union all
select 4,GETDATE()-6500 union all
select 5,GETDATE()-5000 union all
select 6,GETDATE()-5500 union all
select 7,GETDATE()-4000 union all
select 8,GETDATE()-4500 union all
select 9,GETDATE()-3000 union all
select 10,GETDATE()-3500 union all
select 11,GETDATE()-2000

select * from EmployeeDOB

    -- INNER join:
       -- it only joins matching records from table A and table B
       -- returns common records from both the tables
       -- Syntax:
             /* select column
              from table1
              INNER JOIN table2
              ON table1.column_x= table2.column_y   */

select emp.*,edob.Emp_DOB
from Employee AS emp
INNER JOIN EmployeeDOB AS edob
ON edob.Emp_Id=emp.Emp_Id


    -- LEFT join/LEFT OUTER join:
      -- returns all the records from the left table and the matched records from the right table
      -- if some records are not matched, it returns null values
      -- Syntax:
            /* select column
              from table1
              LEFT JOIN table2
              ON table1.column_x= table2.column_y   */
select *
from Employee as emp
LEFT JOIN EmployeeDOB as edob
ON edob.Emp_Id=emp.Emp_Id


   -- RIGHT JOIN/RIGHT OUTER join:
     -- returns all the records from the right table and the matched records from the left table
     -- if some records are not matched, it returns null value
     -- Syntax:
           /* select column
              from table1
              RIGHT JOIN table2
              ON table1.column_x= table2.column_y   */
select * 
from Employee as emp
RIGHT JOIN EmployeeDOB as edob
ON edob.Emp_Id=emp.Emp_Id


-- Date: 21 August 2025

    -- FULL join:
      -- it combines two tables and returns the records from both tables, if values are missing it returns null
select * from Employee
select * from EmployeeDOB

select * 
from Employee as emp
FULL OUTER JOIN EmployeeDOB as edob
on edob.Emp_Id=emp.Emp_Id
--where emp.Emp_Id is null or edob.Emp_Id is null
  
   -- CROSS join:
     -- it is the cartesian product of both tables
     -- Each record from the table is joined with all the records from the other table
     -- size of o/p is equal to the no.of records in the first table

select * from Employee
CROSS JOIN EmployeeDOB

create table Months(MonthNm varchar(10))

insert into Months(MonthNm)
select 'Jan' union all
select 'Feb' union all
select 'Mar' union all
select 'Apr' union all
select 'May' union all
select 'Jun' union all
select 'Jul' union all
select 'Aug' union all
select 'Sep' union all
select 'Oct' union all
select 'Nov' union all
select 'Dec'

select * from Months
-- cross joining Employee table amd Months table
select First_Name,Last_Name,MonthNm
from Employee as emp
CROSS JOIN Months as m


-- UPDATE and DELETE
  -- Take the backup of the rows before your update or delete them
  -- Always start your update and delete query with SELECT
  -- NEVER EVER EVER forget WHERE clause

  -- take backup of the rows before doing any updates
  select * 
  into Employee_Backup
  from Employee

  select * from Employee_Backup

  -- Backup only a few rows from the table
  select *
  into Employee_BackupOnlyRows
  from Employee
  where Emp_Id in (1,4,7)

  select * from Employee_BackupOnlyRows

select * from Employee

--Date: 25 August 2025
-- UPDATE:

UPDATE emp 
SET First_name='Bhavs'
from Employee as emp
where Emp_Id=3

-- Revert back your change using back up table
UPDATE emp
SET First_name=bak.First_name
from Employee as emp
inner join Employee_Backup as bak
on bak.Emp_Id=emp.Emp_Id

select * from Employee_Backup

insert into Employee
select 13,'Ishitha','Raman',45000,'Delhi'
select * from Employee
Update emp
SET Address='Punjab'
from Employee as emp
where Emp_Id=13

-- DELETE:
DELETE emp
from Employee as emp
where Emp_Id=13
/*
Delete emp
from Employee as emp
where Emp_Id=12
*/
--Revert back your change using backup table
insert into Employee
select Emp_Id,First_name,Last_name,salary,Address
from Employee_Backup
where Emp_Id=13

select * from Employee
