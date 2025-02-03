-- SQL PROJECT 1
-- Retails Sales Project

-- Database setup and Table Creation
CREATE TABLE retail_sales
			(
			transactions_id	INT,
			sale_date	DATE,
			sale_time	TIME,
			customer_id	INT,
			gender	VARCHAR(10),
			age	INT,
			category VARCHAR(15),	
			quantiy	INT,
			price_per_unit FLOAT,	
			cogs	FLOAT,
			total_sale FLOAT
			);

-- Data exploiration
--		Total records
SELECT * FROM retail_sales;
--		Total transactions count
SELECT count(transactions_id) from retail_sales;
--		Total Customer records count
SELECT count(customer_id) from retail_sales;
--		Unique customer count
SELECT count(DISTINCT customer_id) from retail_sales;
--		number of categories
SELECT count(DISTINCT category) from retail_sales;
--		type of categories
SELECT category from retail_sales
GROUP BY category

-- Data Cleaning
--		Look for null valued data
SELECT * FROM retail_sales
WHERE transactions_id is NULL or
			sale_date is NULL or
			sale_time is NULL or
			customer_id	is NULL or
			gender is NULL or
			age is NULL or
			category is NULL or	
			quantiy	is NULL or
			price_per_unit is NULL	or
			cogs is NULL or
			total_sale is NULL;
-- We can now delete the records with null values.
-- I decided to delete the records which does not have any sales value.

DELETE FROM retail_sales
WHERE transactions_id is NULL or
			sale_date is NULL or
			sale_time is NULL or
			customer_id	is NULL or
			gender is NULL or
			category is NULL or	
			quantiy	is NULL or
			price_per_unit is NULL	or
			cogs is NULL or
			total_sale is NULL;
			
-- Cross check the records count
SELECT count(transactions_id) from retail_sales;

-- DATA ANALYSIS AND FINDINGS
-- 1.Write a SQL query to retrieve all columns for sales made on '2022-11-05:
SELECT * FROM retail_sales
WHERE sale_date = '2022-11-05';

-- 2.Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 3 in the month of Nov-2022:
SELECT * FROM retail_sales
WHERE 
		category='Clothing' and
		TO_CHAR(sale_date, 'YYYY-MM') = '2022-11' and
		quantiy>3;

-- 3.Write a SQL query to calculate the total sales (total_sale) for each category.
SELECT category,
		SUM(total_sale) as net_sales,
		count(*) as net_orders
from retail_sales
group by 1
order by 1;

-- 4.Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category
SELECT round(AVG(age),2) as avg_age from retail_sales
where category='Beauty';

--5. Write a SQL query to find all transactions where the total_sale is greater than 1000.

SELECT * FROM retail_sales
WHERE total_sale > 1000;

-- 6.Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
SELECT category,gender,count(transactions_id)  from retail_sales
GROUP BY category, gender
ORDER BY category

-- 7.Write a SQL query to calculate the average sale for each month. Find out best selling month in each year.
SELECT 
	year,month,avg_sales
FROM
(
SELECT
	EXTRACT(YEAR FROM sale_date) as year,
	EXTRACT(MONTH FROM sale_date) as month,
	AVG(total_sale) as avg_sales,
	RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) as rank
FROM retail_sales
GROUP BY YEAR , MONTH

) as t1
WHERE rank=1;

-- 8.Write a SQL query to find the top 5 customers based on the highest total sales.

SELECT customer_id, sum(total_sale) as sale
FROM retail_sales
GROUP BY customer_id
ORDER BY sale desc
LIMIT 5;


-- 9.Write a SQL query to find the number of unique customers who purchased items from each category.
SELECT count(distinct customer_id) , category
FROM retail_sales
group by 2;

--10. Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17).
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
    COUNT(*) as total_orders    
FROM hourly_sale
GROUP BY shift


 








