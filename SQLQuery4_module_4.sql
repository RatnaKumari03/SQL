-- Date: 08 September 2025

select * from Employee
select * , Grade=
case
when Salary<25000 then 'C'
when Salary<=30000 then 'B'
when Salary>=40000 then 'A'
else 'Salary Not Defined'
end
from Employee

   -- ORDER BY:
   -- Except and Intersect
   -- UNION and UNION ALL
   -- Ranking functions
   -- Group By

-- ORDER BY:
   -- Ascending/Descending order
   -- order by clause helps us in achieving this
   -- default ordering mechanism in SQL is Ascending order
   -- if we want to force the sorting in descending order, we need to specify it(DESC)
   -- we can have sorting applied on more than one column in the table
   -- we have to specify the sorting mechanism for each column individually

select * from Employee
ORDER BY salary DESC, Emp_Id asc  

select * from Employee
ORDER By salary asc,Emp_Id DESC

-- can also sort data using column position/index in the SELECT
-- This is not ideal way
-- Cases when the SELECT statement is altered,might be bad for this kind of sorting
select first_name,salary,Address,last_name
from Employee
ORDER BY 2 DESC  -- column position for the salary column
   ,1 asc   -- column position for the Emp_Id column

select * from Employee
where salary=(select max(salary) from Employee)

/*
varchar  1,2,3,11,222,56,22,33,1111,333,2222,4,12
int -- 1,2,3,4,11,12,22,33,56,222,333,1111,2222
varchar  -- 1,11,1111,12,2,22,222,2222,3,333,4,56
*/

select ASCII('!') as '!'
, ASCII('#') as '#'
, ASCII('@') as '@'
, ASCII('&') as '&'
, ASCII('-') as '-'
, ASCII('*') as '*'
, ASCII('$') as '$'

-- integer data type sorting
create table intSort
(
   id int
)
insert into intSort(id)
select 1 union all
select 2 union all
select 11 union all
select 12 union all
select 22 union all
select 44 union all
select 222 union all
select 111 union all
select -10 union all
select -5 union all
select -13

select * from intSort
ORDER BY id desc

select * from intSort
ORDER BY id asc

-- text data type sorting
create table textSort
(
   id varchar(10)
)
insert into textSort
SELECT '!hello' UNION ALL
SELECT 'Hello' UNION ALL
SELECT 'Hhello' UNION ALL
SELECT '@hello' UNION ALL
SELECT '#hello' UNION ALL
SELECT '123.45' UNION ALL
SELECT '2.46' UNION ALL
SELECT '-10'

--alpha + num+ spl char -- >splchar(anscii), numeric (0-9), alph (A-Z,a-z),
 
SELECT * FROM textSort
ORDER BY id ASC

-- Date: 10 September 2025

/*
sequence in which the commands needs to be written
SELECT DISTINCT TOP(n) *, ColumnNames,FUNCTIONS
FROM
[INNER/LEFT/CROSS] JOIN ....ON
WHERE
GROUP BY
HAVING
ORDER BY

sequence in which the parts of a query is executed
FROM
JOIN
ON
WHERE
GROUP BY
HAVING
DISTINCT
ORDER BY
TOP
Column List/[*]/Functions
*/

-- GROUP BY:
   -- Group By clause helps us in grouping the data based on certain values
   -- All the non-aggregated columns in the SELECT clause should be in the GROUP BY clause

create table Population
(
   Country varchar(10), City varchar(10), Town varchar(10), Population int
)
insert into Population
values('C1','CT1','T1',100),
('C2','CT2','T2',78),
('C3','CT3','T3',12),
('C4','CT4','T4',34),
('C5','CT5','T5',56),
('C6','CT6','T6',10),
('C7','CT7','T7',25),
('C8','CT8','T8',95)

insert into Population
select 'C1','CT1','T1',90

insert into Population
select 'C2','CT2','T3',85
select 'C4','CT4','T2',75

select * from Population
-- Total Population in the table
select SUM(Population)
from Population

-- Total population based on a country
select Country,SUM(Population) as TotalPopulation
from Population
GROUP BY Country

select * from Population

-- Total Population based on a city
select City,SUM(Population) as TotalPopulation
from Population
GROUP BY City

-- Filter data before Group By
  -- here the data is filtered first and then grouped
select City,SUM(Population) as TotalPopulation
from Population
WHERE City<> 'CT4' 
GROUP BY City

select City,SUM(Population) as TotalPopulation
from Population
WHERE City='CT3' or City='CT4' 
GROUP BY City

-- Filter data after grouping(filter aggregated data)
   -- for Aggregated data filtering, we need to use the HAVING clause
   -- Aggregated data cannot be filtered using a WHERE clause
   -- HAVING can be used only with GROUP BY
select City,SUM(Population) as SumOfPopulation
from Population
WHERE City<> 'CT3'  -- Before grouping
GROUP BY City
HAVING SUM(Population) <150  -- After grouping
ORDER BY City

select * from world_population

-- Date: 11 September 2025

-- UNION vs UNION ALL:
  -- when data returned from a SELECT using a UNION, it returns UNIQUE data in case there are duplicates
  -- when data returned from a SELECT using a UNION ALL, it returns data including the duplicates too

select 1 union all
select 2 union all
select 2 union all
select 2

select 1 union
select 2 union
select 2 union
select 2

select Emp_Id,first_name from Employee
UNION 
select * from PrimaryKeyTest

select Emp_Id,first_name from Employee
UNION 
select * from PrimaryKeyTest
UNION 
select * from UniqueTest

-- EXCEPT operator:
  -- returns the records which are present in first SELECT only but missing in select SELECT
  -- when you run UNION,UNION ALL,EXCEPT,INTERSECT on tables, you need to remember 2 things:
     -- no.of columns selected from the tables are the same
     -- the columns that are returned should be of same data type

-- F1= Apple,Banana,Papaya
-- F2= Apple,Banana,Mango
-- F1 except F2 = Papaya,Mango
-- F2 except F1 = Papaya

select Id,Name from DefaultTest
select * from PrimaryKeyTest

select Id,Name from DefaultTest
EXCEPT
select Id,Name from PrimaryKeyTest

-- INTERSECT operator:
  -- common records between both the SELECT statements
-- F1= Apple,Orange,Banana
-- F2= Apple,Orange,Papaya
-- F1 INTERSECT F2= Apple,Orange
-- F2 INTERSECT F1= Apple,Orange

select Id,Name from PrimaryKeyTest
select Id,Name from DefaultTest

select Id,Name from PrimaryKeyTest
INTERSECT
select Id,Name from DefaultTest

-- Date: 12 September 2025

-- Ranking Functions:
  -- This helps us in assigning rank to each of the rows based on certain values
  -- Types of ranking functions:
     -- Row_Number
     -- Rank
     -- Dense_Ramk
create table Ranking
(
   Country Char(3),
   City Varchar(50),
   Population INT 
);
INSERT INTO Ranking (Country, City, Population) 
VALUES ('A', 'Z', 452345), 
('A', 'M', 687688), 
('A', 'G', 687688), 
('B', 'N', 935676), 
('B', 'O', 126863), 
('B', 'P', 445678), 
('B', 'Q', 434645), 
('B', 'R', 789768), 
('B', 'S', 345324), 
('B', 'H', 345324);

select * from Ranking

-- ORDER BY
select * 
  , ROW_NUMBER() OVER(ORDER BY Population DESC) as Row_Value
from Ranking

select *
  , RANK() OVER(ORDER BY Population DESC) as RnkValue
from Ranking

select * 
  , DENSE_RANK() OVER(ORDER BY Population DESC) as Dense_Rank
from Ranking

select *
  , ROW_NUMBER() OVER(ORDER BY Population DESC) as Row_Value
  , RANK() OVER(ORDER BY Population DESC) as RnkValue
  , DENSE_RANK() OVER(ORDER BY Population DESC) as Dense_Rank
from Ranking

-- ORDER BY combined with the PARTITION BY

-- ROW_NUMBER
select *,
   ROW_NUMBER() OVER(PARTITION BY Country ORDER BY Population DESC) as Rows_Number
from Ranking

-- RANK
select *,
   RANK() OVER(PARTITION BY Country ORDER BY Population DESC) as RankValue
from Ranking

-- DENSE_RANK
select *,
   DENSE_RANK() OVER(PARTITION BY Country ORDER BY Population DESC) as Dense_Rank
from Ranking

-- CTE (Common Table Expression)
-- It is a temp object
-- It has a very limited scope
-- can be used only in the first statement right after it is created
-- in the memory
-- Connected object

-- to get the third highest populated city across countries
;with RankedPopulation
as
(
  select *,
     DENSE_RANK() OVER(PARTITION BY Country ORDER BY Population DESC) as RankValue
     from Ranking
)
select * from RankedPopulation
WHERE RankValue in (3)

-- to get third lowest populated city across countries
; with RankedPopulation
as 
(
  select *,
     DENSE_RANK() OVER(PARTITION BY Country ORDER BY Population ASC) as RankValue
     from Ranking
)
select * from RankedPopulation
WHERE RankValue in (3)

-- Date: 15 September 2025
select * from world_population

-- Applying rank functions on 2022 population column
select Continent,Country_Territory,_2022_Population
  , ROW_NUMBER() OVER(ORDER BY _2022_Population DESC) as RowValue
  , RANK() OVER(ORDER BY _2022_Population DESC) as Rnk
  , DENSE_RANK() OVER(ORDER BY _2022_Population DESC) as Dense_Rnk
from world_population


select Continent,Country_Territory,_2022_Population
  , ROW_NUMBER() OVER(PARTITION BY Continent ORDER BY _2022_Population DESC) as RowValue
  , RANK() OVER(PARTITION BY Continent ORDER BY _2022_Population DESC) as Rnk
  , DENSE_RANK() OVER(PARTITION BY Continent ORDER BY _2022_Population DESC) as Dense_Rnk
from world_population

select Continent, COUNT(*) as Country_count
from world_population
group by Continent

select COUNT(distinct Continent) as Total_Continents
from world_population

select Continent, SUM(Cast(_2022_population as bigint)) as Total_2022_population
from world_population
group by Continent
order by Total_2022_population desc