# Retail_Sales_Analysis SQL Project

## Project Overview
### Project Title - Retail Sales Analysis
This project is designed to explore and analyse the retail sales data. It involved setting up a retail sales database, performance of exploratory data analysis (EDA), and provision of insights into specific business questions through SQL queries. 
### Objectives
1. To populate retail sales database with the company's sales data
2. Perform exploratory data analysis to understand the dataset.
3. To derive insights from the sales data to enhance business growth and executive decision making. These include customer demographics, periodic sales, top performing products etc.
### Data Structure
1. Database Setup
   a. Database Creation - The project commenced with the creation of a database named retail_sales_db.
   b. Table Creation - A table named sales_details was created to store the sales data. The table columns includes transaction_id, sale_date, sale_time, customer_id, gender, age, product_category, quantity_sold, price_per_unit, cost_of_goods_sold (cogs), and total_sale.

**Database Creation**
```
   CREATE DATABASE retail_sales_analysis;
```
**Table Creation**
```
  CREATE TABLE sales_details (
         transaction_id INT PRIMARY KEY,
         sale_date DATE,
         sale_time TIME,
         customer_id INT,
         gender VARCHAR (15),
         age INT,
         category VARCHAR (35),
         quantity INT,
         price_per_unit FLOAT,
         cogs FLOAT,
         total_sale FLOAT
         );
```

### Data Cleaning & Exploration
**Record Count**: Determined the total number of records in the dataset.
**Customer Count**: Identified the unique customers in the dataset.
**Category Count**: Identified the unique product categories in the dataset.
**Null Value Check**: Checked for any null values in the dataset and the records with missing data was deleted. 

```sql
  SELECT * FROM sales_details;
  SELECT COUNT (*) FROM sales_details;
  SELECT COUNT (DISTINCT customer_id) FROM sales_details;
  SELECT DISTINCT category FROM sales_details;
```
```sql
  SELECT * FROM sales_details
  WHERE 
  transactions_id IS NULL
  OR sale_date IS NULL
  OR sale_time IS NULL
  OR customer_id IS NULL
  OR gender IS NULL
  OR age IS NULL
  OR category IS NULL
  OR quantity IS NULL
  OR price_per_unit IS NULL
  OR cogs IS NULL
  OR total_sale IS NULL;
```

```sql
  DELETE FROM sales_details
  WHERE 
  transactions_id IS NULL
  OR sale_date IS NULL
  OR sale_time IS NULL
  OR customer_id IS NULL
  OR gender IS NULL
  OR age IS NULL
  OR category IS NULL
  OR quantity IS NULL
  OR price_per_unit IS NULL
  OR cogs IS NULL
  OR total_sale IS NULL;
```
### Data Analysis & Findings
#### The followings sql queries were developed to answer specific business questions:

 1. **total sales**:
```sql
    SELECT COUNT (*) FROM sales_details;
```
  2. **numbers of customers**
```sql
    SELECT COUNT (DISTINCT customer_id) as total_customers
    FROM sales_details;
```
3. **numbers of categories**
```sql
    SELECT COUNT (DISTINCT category) as total_category
    FROM sales_details;
```
4. **lists of categories**
```sql
   SELECT DISTINCT  category as lists_of_category
    FROM sales_details;
```
5. **total sales made on '2022-11-05'**
```sql 
    SELECT * FROM sales_details
    WHERE sale_date ='2022-11-05';
```
6. **transactions more than 4 made from clothing category in the month of       november, and calculate the total**
```sql
    SELECT * FROM sales_details
	  WHERE category ='Clothing'
	  AND
	  sale_date between '2022-11-01' and '2022-11-30'
	  AND
	  quantity >=4;
```
```sql
   SELECT COUNT (*)
    FROM sales_details
	  WHERE category ='Clothing'
  	AND
	  sale_date between '2022-11-01' AND '2022-11-30'
	  AND quantity >=4;
```
7. **calculate the total orders and total sales for each category**
```sql
   SELECT 
	  category,
	  COUNT (*)as total_order,
	  SUM (total_sale) as net_sales
	  FROM sales_details
	  GROUP BY category;
```
8. **find the average age of customers who purchased items from the beauty category**
```sql
   SELECT
  	ROUND(avg(age),2) as avg_age
	  FROM sales_details
	  WHERE category = 'Beauty';
```
9. **find all trnasactions where the total_sale is greater than 1000**
```sql
   SELECT *
	  FROM sales_details
	  WHERE total_sale > 1000;
```
10. **total number of transactions made by each gender in each category**
```sql 
  SELECT 
	category,
	gender,
	COUNT (*) as total_transaction
	FROM sales_details
	GROUP BY
	category, gender
	ORDER BY
	category;
```
11. **calculate the average sale for each month, and find out the best selling month in each year**.
```sql
  SELECT 
	  year, month, avg_sale
	  FROM
	  (
	  SELECT
	  EXTRACT(year FROM sale_date) AS year,
  	EXTRACT(month FROM sale_date) AS month,
  	AVG(total_sale) AS avg_sale,
  	RANK() OVER(PARTITION BY EXTRACT(year FROM sale_date) ORDER BY
    AVG(total_sale) DESC) AS rank
	  FROM sales_details
	  GROUP BY
	  1, 2) as best_performer
	  WHERE rank = 1;
```
12. **find the top 5 customers based on the highest total sales**
```sql
  SELECT
  customer_id,
  SUM(total_sale) AS total_sales
  FROM
  sales_details
  GROUP BY 1
  ORDER BY 2 DESC
  LIMIT 5;
```
13. **find the number of unique customers who purchased items from each category**
```sql
  SELECT
  category,
  COUNT(DISTINCT customer_id) AS unique_customer
  FROM sales_details
  GROUP BY category;
```
14. **create each shift and number of orders (e.g morning <=12, afternoon between 12 & 17, evening >17)**
```sql
  WITH hourly_sale AS
  (
  SELECT *,
  CASE
  WHEN EXTRACT(hour FROM sale_time) <12 THEN 'Morning'
  WHEN EXTRACT (hour FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
  ELSE 'Evening'
  END AS shift_period
  FROM sales_details
  )
  SELECT 
  shift_period,
  COUNT (*) AS total_orders
  FROM hourly_sale
  GROUP BY shift_period
  ORDER BY total_orders DESC;
```
**end of project**



   
         
   
