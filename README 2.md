# SQL Project - Retail Sales Analysis 

## Project Overview

**Project Title**: Retail Sales Analysis  

**Database**: `SQL_PROJECT01;`

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. This project is ideal for those who are starting their journey in data analysis and want to build a solid foundation in SQL.

## Objectives

1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure

### 1. Database Setup

- **Database Creation**: The project starts by creating a database named `SQL_PROJECT01`.
- **Table Creation**: A table named `retail_sale` is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

```sql
CREATE DATABASE SQL_PROJECT01;

 CREATE TABLE   retail_sale
 (
 transactions_id  INT	,
 sale_date	DATE,
 sale_time	TIME ,
 customer_id INT	,
 gender	VARCHAR(20),
 age INT	,
 category VARCHAR (20)	,
 quantiy INT ,
 price_per_unit FLOAT	,
 cogs	FLOAT,
 total_sale FLOAT

 );
```

### 2. Data Exploration & Cleaning

- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.

```sql
SELECT COUNT(*) FROM retail_sale;
SELECT COUNT(DISTINCT customer_id) FROM retail_sales;
SELECT DISTINCT category FROM retail_sale;

Select * fROM retail_sale
   where transactions_id is NULL
   or
sale_date is NULL
   or 
sale_time is NULL
   or
customer_id is NULL
   or 
gender is NULL
    or
category is NULL
    or 
quantiy is NULL
    or
price_per_unit is NULL
   or
cogs is NULL
     or
total_sale is NULL;

DELETE FROM retail_sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;
```

### 3. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

## Customer Analysis

1. **How many unique customers made purchases?**:
```sql
Select  count(Distinct customer_id) AS unique_customer 
from  retail_sale;
```

2. ***Which age group spends the most?**:
```sql
SELECT 
    CASE 
        WHEN age BETWEEN 18 AND 25 THEN '18-25'
        WHEN age BETWEEN 26 AND 35 THEN '26-35'
        WHEN age BETWEEN 36 AND 45 THEN '36-45'
        WHEN age BETWEEN 46 AND 60 THEN '46-60'
        ELSE '60+' 
    END AS age_group,
    SUM(total_sale) AS total_spent
FROM retail_sale
GROUP BY 
    CASE 
        WHEN age BETWEEN 18 AND 25 THEN '18-25'
        WHEN age BETWEEN 26 AND 35 THEN '26-35'
        WHEN age BETWEEN 36 AND 45 THEN '36-45'
        WHEN age BETWEEN 46 AND 60 THEN '46-60'
        ELSE '60+' 
    END;
```
  ## Product/Category Insights

3. **What are the top 3 selling categories by total sales?**:
```sql
 Select Top 3 
    category ,Sum(total_sale) AS totaL_Sales
 From retail_sale
 group by category
 order by totaL_Sales DESC;
```

4. **Which category is most popular among male vs female?**:
```sql
Select
     gender,
     category ,
	 count(*) AS Counts
  from retail_sale
  group by gender,category
  order by Counts Desc ,gender;
```
## Time-Based Analysis

5. **How many sales were made each month?**:
```sql
SELECT 
   Month (sale_date) AS months, 
   COUNT(*) AS total_sales
FROM retail_sale
GROUP BY Month (sale_date)
ORDER BY months;
```

6. **During what hour of the day do most sales occur?**:
```sql
SELECT 
    DATEPART(HOUR, sale_time) AS hours,
    COUNT(*) AS total_sales
FROM retail_sale
GROUP BY DATEPART(HOUR, sale_time)
ORDER BY total_sales DESC;
```
## Profit Analysis 

7. **What is the total profit made?**:
```sql
SELECT 
   SUM(total_sale - cogs) AS total_profit
FROM retail_sale;

```

8. **How much profit is made per customer on average?**:
```sql
SELECT 
   customer_id, 
   AVG(total_sale - cogs) AS avg_profit
FROM retail_sale
GROUP BY customer_id;
```
## Operational / Performance Insights

9. **Are there any customers with consistent monthly purchases?**:
```sql
SELECT 
    customer_id, 
    COUNT(DISTINCT FORMAT(sale_date, 'yyyy-MM')) AS active_months
FROM retail_sale
GROUP BY customer_id
HAVING COUNT(DISTINCT FORMAT(sale_date, 'yyyy-MM')) = 12;
```

10. **What is the total number of repeat vs one-time customers?**:
```sql
SELECT
  customer_type,
  COUNT(*) AS total_customers
FROM (
  SELECT
    customer_id,
    CASE
      WHEN COUNT(*) = 1 THEN 'One-Time'
      ELSE 'Repeat'
    END AS customer_type
  FROM retail_sale
  GROUP BY customer_id
) AS sub
GROUP BY customer_type;
```

## Findings

- **Customer Demographics**: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
- **High-Value Transactions**: Several transactions had a total sale amount greater than 1000, indicating premium purchases.
- **Sales Trends**: Monthly analysis shows variations in sales, helping identify peak seasons.
- **Customer Insights**: The analysis identifies the top-spending customers and the most popular product categories.

## Reports

- **Sales Summary**: A detailed report summarizing total sales, customer demographics, and category performance.
- **Trend Analysis**: Insights into sales trends across different months and shifts.
- **Customer Insights**: Reports on top customers and unique customer counts per category.

## Conclusion

This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.

