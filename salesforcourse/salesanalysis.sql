--use PowerBI

--select * from [dbo].salesforcourse where product_category is not null

--EXEC sp_rename 'salesforcourse-4fe2kehu', 'salesforcourse';



--which product_category popular or most likely to sell

select 
	--product_category
   Sub_Category
   ,count(*) 
from 
	salesforcourse
where 
	product_category is not null
group by 
	--Product_Category
	Sub_Category
order by 
	count(*) desc


--year wise sales

select 
	Year
   ,count(*) 
from 
	salesforcourse
where 
	product_category is not null
group by 
	--Product_Category
	Year
order by 
	count(*) desc


--year wise revenue

select 
	Year
   ,sum(Revenue) 
from 
	salesforcourse
where 
	product_category is not null
group by 
	--Product_Category
	Year
order by 
	sum(Revenue) desc

--select * from [dbo].salesforcourse

--Profit by state

select 
	State
   ,sum(Revenue) as TotalRevenue
   ,sum(cost) as TotalCost
   ,sum(revenue-cost) as profit
from 
	salesforcourse
where 
	product_category is not null
group by 
	--Product_Category
	State
order by 
	sum(Revenue) desc

--month, year wise profit

select 
	Month,Year
   ,sum(Revenue) as TotalRevenue
   ,sum(cost) as TotalCost
   ,sum(revenue-cost) as profit
from 
	salesforcourse
where 
	product_category is not null
group by 
	--Product_Category
	Month,Year
order by 
	sum(Revenue) desc


--rolling month profit
with cte as(
select 
	datename(month,Date) as month
   ,year(Date) as year
   ,sum(Revenue) as TotalRevenue
   ,sum(cost) as TotalCost
   ,sum(revenue-cost) as profit
   ,month(Date) as monthno
from 
	salesforcourse
where 
	product_category is not null
group by 
	--Product_Category
	datename(month,Date), year(Date),month(Date)
--order by 
--	year(Date), month(Date)
)

select *, (LAG(profit) over(order by year,monthno) - profit)/LAG(profit) over(order by year,monthno) as rollingmonthprofit from cte


--which product has maximum profit per unit (unitprice - unitcost)

select
	sub_category
--  ,datename(month,Date) as month
-- ,year(Date) as year
	,round(sum(unit_price-unit_cost),2) as ppu
--	,month(Date)
from
	salesforcourse
where 
	product_category is not null
group by 
	Sub_Category
--	,datename(month,Date)
--    ,year(Date)
--	,month(Date)
order by ppu
	--year(Date), month(Date)


--select * from [dbo].salesforcourse

--most profitable product 
select 
	--product_category
   Sub_Category
   ,sum(revenue-cost) as profit
from 
	salesforcourse
where 
	product_category is not null
group by 
	--Product_Category
	Sub_Category
order by 
	profit desc

--Gender impact in products

select 
	--product_category
   Sub_Category
   ,Customer_Gender
   ,sum(revenue-cost) as profit
from 
	salesforcourse
where 
	product_category is not null
group by 
	--Product_Category
	Sub_Category
	,Customer_Gender
order by 
	profit desc
	--,Sub_Category
	,Customer_Gender

--which state is consuming what product most


select 
	--product_category
   State
   ,Sub_Category
   ,count(*) as n
from 
	salesforcourse
where 
	product_category is not null
group by 
   State
   ,Sub_Category
having count(*) > 500
order by 
	n desc
