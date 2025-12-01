--sql REtail sales Analysis - p1
CREATE DATABASE sql_project_p2;

--sql create table
DROP TABLE IF EXISTS retail_sales;
CREATE TABLE retail_sales
(
	transactions_id	INT PRIMARY KEY,
	sale_date DATE,
	sale_time TIME,
	customer_id	INT,
	gender VARCHAR(10),
	age	INT,
	category VARCHAR(20),	
	quantiy INT,
	price_per_unit FLOAT,	
	cogs FLOAT,
	total_sale FLOAT
);

SELECT * FROM retail_sales
LIMIT 10

SELECT 
	count(*)
FROM retail_sales


SELECT * FROM retail_sales
WHERE transactions_id IS NULL

SELECT * FROM retail_sales
WHERE sale_time IS NULL

SELECT * FROM retail_sales
WHERE
	transactions_id IS NULL
	OR
	sale_date is null
	or
	sale_time is null
	or 
	gender is null
	or
	category is null
	or 
	quantiy is null
	or
	cogs is null
	or
	total_sale is null;

-- data exploration

-- how many sales we have?
SELECT COUNT (*) total_sale FROM retail_sales

-- how many unique customer we have?
SELECT COUNT(DISTINCT customer_id) as total_sale FROM retail_sales 

SELECT DISTINCT category FROM retail_sales

--data analysis & Business key problems & answer

--Q1. write a SQL query to retrieve all columns for sales made on '12/12/2022'

SELECT *
from retail_sales
WHERE sale_date = '12/12/2022'

--Q2. write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 3 in the month of Dec-2022

SELECT * 
FROM retail_sales
WHERE  category = 'Clothing'
AND
TO_CHAR(sale_date, 'mm/yyyy') = '12/2022'
AND
quantiy >= 3

--Q3. write a SQL query to calculate the total sales (total_sale) for each category.

SELECT 
	category,
	SUM(total_sale) as net_sale,
	COUNT(*) as total_orderS
FROM retail_sales
GROUP BY 1

--Q4. write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

SELECT 
	ROUND(AVG(age),2) as avg_age
	FROM retail_sales
	WHERE category = 'Electronics'


--Q5. write a SQL query to find all transactions where the total_sale is greater than 800.

SELECT * FROM retail_sales
WHERE total_sale > 800

--Q6. write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

SELECT 
	category,
	gender,
	COUNT(*) as total_trans
FROM retail_sales
GROUP 
	BY
	category,
	gender
		

--Q7. write a SQL query to calculate the average sale for each month. find out the best selling month in each years.

SELECT 
	year,
	month,
	avg_sale
FROM
(
SELECT 
	EXTRACT(YEAR FROM sale_date) as year,
	EXTRACT(MONTH FROM sale_date) as month,
	AVG(total_sale) as avg_sale,
	RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC)
FROM retail_sales
GROUP BY 1,2
) as t1 
WHERE rank = 1
--ORDER BY 1,2,3 DESC

--Q8. write a SQL query to find the top 5 customers based on the highest total sales.

SELECT  
	customer_id,
	SUM(total_sale) as total_sales
FROM retail_sales
GROUP BY 1
ORDER BY 2 desc
LIMIT 5


--Q9. write a SQL query to find the number of unique customers who purchased items from each category.

SELECT 
	category,
	COUNT(DISTINCT customer_id) as unique_customer
FROM retail_sales
GROUP BY category

--Q10. write a SQL query to create each shift and number of orders (Example Morning < 12, Afternoon between 12 & 17, Evening > 17).

WITH hourly_sale
AS
(
SELECT *,
	CASE
		WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
		WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
	ELSE 'Evening'
	END as shift
FROM retail_sales
)
SELECT 
	shift,
	count(*) as total_order
FROM hourly_sale
GROUP BY shift

















