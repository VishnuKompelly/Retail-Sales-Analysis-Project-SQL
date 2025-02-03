# 🛒 Retail Sales Data Analysis Using SQL

## 📌 Project Overview
This project involves analyzing retail sales data using SQL to derive valuable insights. The dataset contains information about transactions, including sales date, customer details, product category, and total sales. The goal is to perform data analysis using SQL queries and extract meaningful business intelligence from the sales trends, customer behaviors, and category performance.

  - **Project Title** : Retail Sales Analysis using SQL
  - **Level** : Beginner
  - **Database** : ```SQL_Project_P1```

## 📊 Dataset Description

The dataset consists of a retail sales database with the following columns:
  - ```sale_date```: The date of the transaction
  - ```category```: The product category (e.g., Clothing, Beauty, Electronics)
  - ```total_sale```: The total revenue from the transaction
  - ```customer_id```: Unique identifier for customers
  - ```age```: Age of the customer
  - ```gender```: Gender of the customer
  - ```sale_time```: The time of transaction
  - ```quantity```: Number of items sold
  - ```transactions_id```: Unique transaction identifier


## 🔍 Key SQL Queries and Insights
Below are the main queries and business insights derived from the data:
  1. Total Sales per Category
      - Query calculates total revenue for each category.
      - Helps identify best-selling product categories.
  2. Average Age of Customers in Beauty Category
      - Finds the average customer age who purchased beauty products.
      - Useful for targeting specific age groups.
  3. Highest Revenue-Generating Month per Year
      - Determines the top-selling month in each year based on average sales.
      - Helps businesses plan for seasonal demand and stock management.
  4. Top 5 Customers Based on Sales
      - Identifies the most valuable customers based on total spending.
      - Useful for loyalty programs and personalized marketing.
  5. Sales Trends by Time of Day
      - Classifies transactions into Morning, Afternoon, and Evening shifts.
      - Helps in optimizing staffing and promotional offers.

## Project Structure:
SQL PROJECT 1
  - Retails Sales Project

  - Database setup and Table Creation
      ```SQL
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
			);```

## 1. DATA EXPLOIRATION
  - Total records
    ```SQL
    SELECT * FROM retail_sales;
    ```
  - Total transactions count
```SQL
SELECT count(transactions_id) from retail_sales;
```
- Total Customer records count
```SQL
SELECT count(customer_id) from retail_sales;
```  
  - Unique customer count
```SQL
SELECT count(DISTINCT customer_id) from retail_sales;
```
  - number of categories
```SQL
SELECT count(DISTINCT category) from retail_sales;
```
  - type of categories
```SQL
SELECT category from retail_sales
GROUP BY category
```

## 2. DATA CLEANING
   - Look for null valued data
```SQL
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
```
  - We can now delete the records with null values.
  - I decided to delete the records which does not have any sales value.

```SQL
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
```
  - Cross check the records count
```SQL
SELECT count(transactions_id) from retail_sales;
```

## 3. DATA ANALYSIS AND FINDINGS
  1.Write a SQL query to retrieve all columns for sales made on '2022-11-05.
```SQL
SELECT * FROM retail_sales
WHERE sale_date = '2022-11-05';
```

  2.Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 3 in the month of Nov-2022:
```SQL
SELECT * FROM retail_sales
WHERE 
		category='Clothing' and
		TO_CHAR(sale_date, 'YYYY-MM') = '2022-11' and
		quantiy>3;
  ```

  3.Write a SQL query to calculate the total sales (total_sale) for each category.
```SQL
SELECT category,
		SUM(total_sale) as net_sales,
		count(*) as net_orders
from retail_sales
group by 1
order by 1;
```

  4.Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category
```SQL
SELECT round(AVG(age),2) as avg_age from retail_sales
where category='Beauty';
```
  
  5. Write a SQL query to find all transactions where the total_sale is greater than 1000.

```SQL
SELECT * FROM retail_sales
WHERE total_sale > 1000;
```

  6.Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
```SQL
SELECT category,gender,count(transactions_id)  from retail_sales
GROUP BY category, gender
ORDER BY category
```

  7.Write a SQL query to calculate the average sale for each month. Find out best selling month in each year.
```SQL
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
```
  8.Write a SQL query to find the top 5 customers based on the highest total sales.
```SQL
SELECT customer_id, sum(total_sale) as sale
FROM retail_sales
GROUP BY customer_id
ORDER BY sale desc
LIMIT 5;
```

  9.Write a SQL query to find the number of unique customers who purchased items from each category.
```SQL
SELECT count(distinct customer_id) , category
FROM retail_sales
group by 2;
```
  10. Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17).
```SQL
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
```

 
## 📈 Reports and Findings
1. Summary 📑
  - The dataset provides transactional insights into sales patterns, customer demographics, and product category performance.
  - Helps in understanding which categories are performing well and which need improvement.
2. Trend Analysis 📊
  - Peak sales months indicate seasonal demand, allowing for better inventory management.
  - Category-based sales analysis reveals which products are the most popular among customers.
3. Customer Insights 👥
  - Top customers contribute significantly to revenue and should be targeted for engagement.
  - Age group analysis helps in understanding product preferences among different demographics.
  - Gender-wise transactions provide data-driven insights for product recommendations.


## 🏆 Conclusion
This project demonstrates how SQL can be used for **data analytics in retail**. The insights gained help businesses make informed decisions on **inventory**, **customer targeting**, and **sales optimization**.

## 🛠️ Technologies Used
•	SQL (Structured Query Language)
•	PostgreSQL / postgreSQL Server
•	pgAdmin 4 (for executing queries)

## 📌 How to Run the Queries
1.	Install PostgreSQL from [here](https://www.enterprisedb.com/downloads/postgres-postgresql-downloads)
2.	Create a database
3.	Load the dataset into a database.
4.	Execute the provided SQL queries to generate insights.


## 📁 Project Structure
```
├── analysis_sql.sql   # Contains all SQL queries
├── README.md          # Project documentation
└── retail_sales_data.csv  
```

## 📢 Contributing
Feel free to fork this repository and contribute by adding more queries or improving existing ones.



