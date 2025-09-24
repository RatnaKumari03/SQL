-- Assignment 4

-- Tasks to be performed

  -- 1. using inbuilt function min,max and average amount from the orders table
select * from Orders_Table

select MIN(amount) as Max_amount,
       MAX(amount) as Min_amount, 
       AVG(amount) as Avg_amount 
from Orders_Table

  -- 2. Creating a user-defined function which will multiply the given number with 10
create FUNCTION fn_MultiplyNumber
(
   @number int
)
returns int
as
Begin
   return (@number*10)
End
select dbo.fn_MultiplyNumber(2)
select dbo.fn_MultiplyNumber(25)

  -- 3. using case statement 
select
case
when 100<200 then '100 is less than 200'
when 100>=200 then '100 is not greater or equal to 200'
end as Result

  -- 4. using case statement,set the status of amount as high,low or medium
select amount,
case
when amount>=3000 then 'Amount is High Amount'
when amount>=2000 then 'Amount is Medium Amount'
when amount<=600 then 'Amount is Low Amount'
end as Status_Amount
from Orders_Table

  -- 5. creating user defined function to fetch amount greater than
      --  the given input
create Function fn_GetHighAmount
(
   @input_amount int
)
returns Table
as
return
(
   select * from Orders_Table
   where amount>@input_amount
)

select * from fn_GetHighAmount(1000)
select * from fn_GetHighAmount(3000)
select * from fn_GetHighAmount(100)