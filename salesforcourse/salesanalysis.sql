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

--month wise profit

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


--

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
order by 
	year(Date), month(Date)
