select * from sales_details
limit 10;

select count(*) from sales_details;

alter table sales_details
rename column quantiy to quantity;

update sales_details set age = 22
where age is null;

---data cleaning

select * from sales_details
where 
transactions_id is null
or 
sale_date is null
or
sale_time is null
or
customer_id is null
or 
gender is null
or 
age is null
or
category is null
or 
quantity is null
or
price_per_unit is null
or
cogs is null
or total_sale is null;

delete from sales_details
where 
transactions_id is null
or 
sale_date is null
or
sale_time is null
or
customer_id is null
or 
gender is null
or 
age is null
or
category is null
or 
quantity is null
or
price_per_unit is null
or
cogs is null
or 
total_sale is null;

----data exploration
--total sales
select count(*) from sales_details;

--numbers of customers
select count(distinct customer_id) as total_customers
from sales_details;

---numbers of categories
select count(distinct category) as total_category
from sales_details;

---lists of categories
select distinct category as lists_of_category
from sales_details;

---total sales made on '2022-11-05'
select * from sales_details
where sale_date ='2022-11-05';

--- transactions more than 4 made from clothing category in the month of november, and calculate the total
select *
	from sales_details
	where category ='Clothing'
	and
	sale_date between '2022-11-01' and '2022-11-30'
	and
	quantity >=4;

	select count (*)
	from sales_details
	where category ='Clothing'
	and
	sale_date between '2022-11-01' and '2022-11-30'
	and
	quantity >=4;

	---calculate the total orders and total sales for each category
	select 
	category,
	count(*)as total_order,
	sum(total_sale) as net_sales
	from sales_details
	group by category;

	---find the average age of customers who purchased items from the beauty category
	select
	ROUND(avg(age),2) as avg_age
	from sales_details
	where category = 'Beauty';


	---find all trnasactions where the total_sale is greater than 1000
	select *
	from sales_details
	where total_sale > 1000;

	--- total number of transactions made by each gender in each category

	select 
	category,
	gender,
	count(*) as total_transaction
	from sales_details
	group by
	category, gender
	order by
	category;

	---calculate the average sale for each month, and find out the best selling month in each year.
	select 
	year, month, avg_sale
	from
	(
	select
	extract(year from sale_date) as year,
	extract(month from sale_date) as month,
	avg(total_sale) as avg_sale,
	rank() over(partition by extract(year from sale_date) order by avg(total_sale) desc)as rank
	from
	sales_details
	group by
	1, 2) as best_performer
	where rank = 1;

--- find the top 5 customers based on the highest total sales
select 
customer_id,
sum(total_sale) as total_sales
from
sales_details
group by 1
order by 2 desc
limit 5;

---find the number of unique customers who purchased items from each category
select 
category,
count(distinct customer_id) as unique_customer
from sales_details
group by category;

---create each shift and number of orders (e.g morning <=12, afternoon between 12 & 17, evening >17)

with hourly_sale as
(
select *,
case
when extract(hour from sale_time) <12 then 'Morning'
when extract(hour from sale_time) between 12 and 17 then 'Afternoon'
else 'Evening'
end as shift_period
from sales_details
)
select 
shift_period,
count(*) as total_orders
from hourly_sale
group by shift_period
order by total_orders desc;

---end of project