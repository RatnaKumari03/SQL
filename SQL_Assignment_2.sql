-- Assignment 2

-- Tasks to be Performed
  
  -- 1. creating customer table
create table Customer_Table
(
   customer_id int primary key,
   first_name varchar(20),
   last_name varchar(20),
   email varchar(50),
   address varchar(150),
   city varchar(15),
   state varchar(15),
   zip varchar(20)
)

  -- 2. Insert 5 new records into the table
insert into Customer_Table
select 1,'Ratna','Perugu','ratna123@gmail.com','123 Main St','San Jose','New York','522124' union all
select 2,'George','Miller','geo456@email.com','456 Sec St','San Jose','New Jersey','263526' union all
select 3,'James','Stuart','jamie789@yahoo.com','789 Valley St','San Fransisco','Austria','736217' union all
select 4,'Dante','Russo','dante08@gmail.com','101 Valhalla St','Manhattan','New York','253626' union all
select 5,'Christian','Harper','harper@example.com','231 Harper St','Manhattan','New York','733793'

select * from Customer_Table

  -- 3. Select only the ‘first_name’ and ‘last_name’ columns from the customer table
select first_name, last_name from Customer_Table

  -- 4. Select those records where ‘first_name’ starts with “G” 
      -- and city is ‘San Jose’.
select * from Customer_Table
where first_name like 'G%' and city='San Jose'

  -- 5. Select those records where Email has only ‘gmail’
select * from Customer_Table
where email like '%gmail.com' 

  -- 6. Select those records where the ‘last_name’ doesn't end with “A”
select * from Customer_Table
where last_name not like '%A'
