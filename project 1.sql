-----Create database 
Create database SQL_PROJECT01;
 use SQL_PROJECT01;
 -- Create Table 

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
-----Top 10 data show
  Select Top 10 * FROM retail_sale;
---- Total row  in file
  Select count(*)
   From retail_sale;

   -- find Null Values
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

--Delete NULL values 
Delete From retail_sale
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

Select count(*) from retail_sale;

----How many sales we have?
 Select count(*) as total_cololumn from retail_sale;

 -- how many unique  Coustomer we have ?

 Select count(distinct customer_id) as total_customer from retail_sale;

  Select distinct category from retail_sale;

  -- data analysis & busines Problem
  ---Q1.Write a SQL query to retrieve all columns for sales made on '2022-11-05:
  Select * 
  From retail_sale
  where sale_date= '2022-11-05';

  --Q2.Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:
SELECT *
FROM retail_sale
WHERE category = 'Clothing'
  AND sale_date >= '2022-11-01'
  AND sale_date < '2022-12-01'
  AND quantiy >= 4;


  ---Q3.Write a SQL query to calculate the total sales (total_sale) for each category.:

  Select category,
  sum( total_sale) as net_sales,
  count(*)  as TOTAL_ORDERS
  from retail_sale
  group by category;

  --Q4.Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:
  Select 
    avg(age) from retail_sale
   where category = 'Beauty';

   ---Q.5.Write a SQL query to find all transactions where the total_sale is greater than 1000.:
   Select  *
   from retail_sale
   where total_sale > 1000;

   ---Q6.Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:

   Select 
     category ,
	 gender,
	 count(*) As total_tarns
  from retail_sale
  group by category,
  gender;

   ----Q7.Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:
 
SELECT
    year,
    month,
    avg_total_sales,
    RANK() OVER (PARTITION BY year ORDER BY avg_total_sales DESC) AS rank
FROM (
    SELECT
        YEAR(sale_date) AS year,
        MONTH(sale_date) AS month,
        AVG(total_sale) AS avg_total_sales
    FROM retail_sale
    GROUP BY YEAR(sale_date), MONTH(sale_date)
 ) AS sales_rank

 --- Write the query calculate the avg  highest sale for year

 WITH MonthlySales AS (
    SELECT
        YEAR(sale_date) AS year,
        MONTH(sale_date) AS month,
        AVG(total_sale) AS avg_total_sales
    FROM retail_sale
    GROUP BY YEAR(sale_date), MONTH(sale_date)
),
RankedSales AS (
    SELECT
        year,
        month,
        avg_total_sales,
        RANK() OVER (PARTITION BY year ORDER BY avg_total_sales DESC) AS sales_rank
    FROM MonthlySales
)
SELECT
    year,
    month,
    avg_total_sales,
    sales_rank
FROM RankedSales
WHERE sales_rank = 1;

 
 ---Explanation:
---MonthlySales CTE:
----Aggregates the data to calculate the average total sales (avg_total_sales) for each month and year.
----RankedSales CTE:
----Applies the RANK() function to assign a rank to each month's average sales within its respective year, ordering from highest to lowest.
---Final SELECT Statement:
---Filters the results to include only those months where sales_rank = 1, effectively retrieving the month(s) with the highest average sales for each year.
---Note:
---Using RANK() allows for the possibility of ties; if multiple months have the same highest average sales within a year, they will all receive a rank of 1 and be included in the results.
   
   
 ---Q8.**Write a SQL query to find the top 5 customers based on the highest total sales **:

   SELECT TOP 5
    customer_id,
    SUM(total_sale) AS total_sales
FROM retail_sale
GROUP BY customer_id
ORDER BY total_sales DESC;

   ---Q9.Write a SQL query to find the number of unique customers who purchased items from each category.:

   Select 
   count(distinct customer_id) as unique_customer,
   category

   from retail_sale
   group by category;


   ---Q10.Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):

  WITH hourly_sale AS (
    SELECT 
        CASE
            WHEN DATEPART(HOUR, sale_time) < 12 THEN 'Morning'
            WHEN DATEPART(HOUR, sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
            ELSE 'Evening'
        END AS shift_period
    FROM retail_sale
)
SELECT 
    shift_period,
    COUNT(*) AS total_orders    
FROM hourly_sale
GROUP BY shift_period;

---Customer Analysis-----

---Q11.How many unique customers made purchases?
  Select  count(Distinct customer_id) AS unique_customer 
  from  retail_sale;

  ---Q12.What is the gender distribution of customers?
  Select gender , count(*) as  total_customer
   From retail_sale
   group by gender;

   ---Q13.What is the average age of customers by gender?
   Select gender, avg(age) AS avg_age
   from retail_sale
   group by gender;

   ---Q.14 Which age group spends the most?
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

	---Q 15.Which customer made the highest number of purchases?
  Select  Top 1 
    customer_id, 
	count(*) AS num_transaction 
  from retail_sale
  group by customer_id
  order by num_transaction desc;

  ---Product/Category Insights
  --Q 16.What are the top 3 selling categories by total sales?
  Select Top 3 
    category ,Sum(total_sale) AS totaL_Sales
 From retail_sale
 group by category
 order by totaL_Sales DESC;

 --Q 17.Which category has the highest average unit price?
 Select 
    category ,
	avg(price_per_unit) AS avg_price
from retail_sale
group by category
order by avg_price desc;

--Q.18.Which category generates the highest profit?

Select 
   category ,
   Sum(total_sale-cogs) AS profit
from retail_sale
group by category
order by profit DESC;

-Q 19.What is the average quantity sold per transaction for each category?
  Select 
     category,
	 avg(quantiy) AS avg_qty
  From retail_sale
  group by category

  --Q 20.Which category is most popular among male vs female?
  Select
     gender,
     category ,
	 count(*) AS Counts
  from retail_sale
  group by gender,category
  order by Counts Desc ,gender;
  ---Time-Based Analysis----
  --Q 21.How many sales were made each month?

SELECT 
   Month (sale_date) AS months, 
   COUNT(*) AS total_sales
FROM retail_sale
GROUP BY Month (sale_date)
ORDER BY months;

---Q 22.Which month had the highest total sales?

SELECT  top 1
  MONTH( sale_date) AS months, 
  SUM(total_sale) AS total_sales
FROM retail_sale
GROUP BY  MONTH( sale_date)
ORDER BY total_sales DESC;

--Q 23.What is the distribution of sales by day of the week?

SELECT
   Day(sale_date) AS days,
   COUNT(*) AS total_sales
FROM retail_sale
GROUP BY  Day(sale_date)
order by  Day(sale_date);

--Q 24.During what hour of the day do most sales occur?

SELECT 
    DATEPART(HOUR, sale_time) AS hours,
    COUNT(*) AS total_sales
FROM retail_sale
GROUP BY DATEPART(HOUR, sale_time)
ORDER BY total_sales DESC;

------Profit Analysis
Q 25.What is the total profit made?

SELECT 
   SUM(total_sale - cogs) AS total_profit
FROM retail_sale;

--Q 26.Which product category has the highest profit margin?

SELECT
   category, 
   AVG((total_sale - cogs)/total_sale) AS avg_profit_margin
FROM retail_sale
GROUP BY category
ORDER BY avg_profit_margin DESC;

--Q 27.Which transaction had the highest profit?

SELECT top 1
   transactions_id, 
   (total_sale - cogs) AS profit
FROM retail_sale
ORDER BY profit DESC;

--Q 28.How much profit is made per customer on average?

SELECT 
   customer_id, 
   AVG(total_sale - cogs) AS avg_profit
FROM retail_sale
GROUP BY customer_id;
--Q 30.Which gender is more profitable?

SELECT
  gender,
  SUM(total_sale - cogs) AS profit
FROM retail_sale
GROUP BY gender;

----Operational / Performance Insights
---Q 31.What is the average transaction value?

SELECT AVG(total_sale) AS avg_transaction_value FROM sales;

Q 32.How many transactions have missing quantity or price?

SELECT COUNT(*) FROM retail_sale 
WHERE quantiy IS NULL OR price_per_unit IS NULL;

--Q 33.Are there any customers with consistent monthly purchases?

SELECT 
    customer_id, 
    COUNT(DISTINCT FORMAT(sale_date, 'yyyy-MM')) AS active_months
FROM retail_sale
GROUP BY customer_id
HAVING COUNT(DISTINCT FORMAT(sale_date, 'yyyy-MM')) = 12;

---Q 34.Which sales had a zero profit?

SELECT * FROM retail_sale WHERE total_sale = cogs;

--Q 35.What percentage of total sales come from repeat customers?

WITH repeat_customers AS (
    SELECT customer_id
    FROM retail_sale
    GROUP BY customer_id
    HAVING COUNT(*) > 1
)
SELECT 
    100.0 * SUM(total_sale) / 
    (SELECT SUM(total_sale) FROM retail_sale) AS repeat_customer_sales_pct
FROM retail_sale
WHERE customer_id IN (SELECT customer_id FROM repeat_customers);

--Customer Segmentation & Lifetime Value
--Q 36.What is the total number of repeat vs one-time customers?

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

--Q 37.Which customer has the highest lifetime value (LTV)?
 Select Top 1
    customer_id,
	Sum(total_sale) AS lifetime_value
from retail_sale
group by customer_id
order by lifetime_value desc;

--Q 38.What is the average number of purchases per customer?
 
 SELECT AVG(purchase_count) AS avg_purchases
FROM (
  SELECT customer_id, COUNT(*) AS purchase_count
  FROM retail_sale
  GROUP BY customer_id
) sub;
--Q 39.Which customer segment (by age group) has the highest average profit per transaction?
 SELECT 
  CASE 
    WHEN age BETWEEN 18 AND 25 THEN '18-25'
    WHEN age BETWEEN 26 AND 35 THEN '26-35'
    WHEN age BETWEEN 36 AND 45 THEN '36-45'
    WHEN age BETWEEN 46 AND 60 THEN '46-60'
    ELSE '60+'
  END AS age_group,
  AVG(total_sale - cogs) AS avg_profit
FROM retail_sale
GROUP BY CASE 
    WHEN age BETWEEN 18 AND 25 THEN '18-25'
    WHEN age BETWEEN 26 AND 35 THEN '26-35'
    WHEN age BETWEEN 36 AND 45 THEN '36-45'
    WHEN age BETWEEN 46 AND 60 THEN '46-60'
    ELSE '60+'
	END ;
--Q 40.How many customers are in each age group?

SELECT 
  CASE 
    WHEN age BETWEEN 18 AND 25 THEN '18-25'
    WHEN age BETWEEN 26 AND 35 THEN '26-35'
    WHEN age BETWEEN 36 AND 45 THEN '36-45'
    WHEN age BETWEEN 46 AND 60 THEN '46-60'
    ELSE '60+'
  END AS age_group,
  COUNT(DISTINCT customer_id) AS customer_count
FROM retail_sale
GROUP BY CASE 
    WHEN age BETWEEN 18 AND 25 THEN '18-25'
    WHEN age BETWEEN 26 AND 35 THEN '26-35'
    WHEN age BETWEEN 36 AND 45 THEN '36-45'
    WHEN age BETWEEN 46 AND 60 THEN '46-60'
    ELSE '60+'
  END;
 -- Sales Efficiency & Basket Analysis
  --Q 41.What is the average basket size (items per transaction)?

SELECT AVG(quantiy) AS avg_basket_size FROM retail_sale;

--Q 42.Which gender has the higher average basket size?

SELECT gender, AVG(quantiy) AS avg_basket_size
FROM retail_sale
GROUP BY gender;


--Q 43.Which transactions had unusually high quantities (outliers)?

SELECT * FROM retail_sale
WHERE quantiy > (
  SELECT AVG(quantiy) + 2 * STDEV(quantiy) FROM retail_sale
);

-- Note  Find the Standard devision 
SELECT
  Category,
  Quantiy,
  STDEV(Quantiy) OVER (PARTITION BY Category) AS CategoryStdDev
FROM retail_sale;

--Q.44.What’s the distribution of sales by number of items sold?

SELECT quantiy, COUNT(*) AS frequency
FROM retail_sale
GROUP BY quantiy
ORDER BY quantiy;

--Promotions & Pricing
--Q 45.What is the average unit price across all categories?

SELECT 
   category,
   AVG(price_per_unit) AS avg_price
FROM retail_sale
GROUP BY category;

---Q 46.Which transactions had the lowest price per unit in each category?

SELECT *
FROM retail_sale s1
WHERE price_per_unit = (
  SELECT MIN(price_per_unit) FROM retail_sale s2 WHERE s2.category = s1.category
);
--Q 47.Are customers more sensitive to price in any particular category?
---  Noted --Approach: Look for negative correlation between price and quantity sold per category.

SELECT 
   category, 
   price_per_unit, 
   AVG(quantiy) AS avg_quantity
FROM retail_sale
GROUP BY category, price_per_unit
ORDER BY category, price_per_unit;

---Q 48.Which category gives highest ROI (return on investment)?

SELECT category, AVG((total_sale - cogs) / cogs) AS avg_roi
FROM retail_sale
GROUP BY category
ORDER BY avg_roi DESC;

--Operational KPIs
--Q 49. How many transactions are there each day?

SELECT sale_date AS days, COUNT(*) AS transactions
FROM retail_sale
GROUP BY sale_date 
ORDER BY sale_date ;


--Q 50.Which day of the week sees the highest average sales value?


SELECT
     sale_date AS day_of_week, AVG(total_sale) AS avg_sales
FROM retail_sale
GROUP BY sale_date
ORDER BY avg_sales DESC;

--Q 51.What is the average margin per unit sold per category?

SELECT 
   category, 
   AVG((total_sale - cogs) / quantiy) AS margin_per_unit
FROM retail_sale
GROUP BY category;

--Q 52.What is the total number of items sold per category?

SELECT 
    category, 
    SUM(quantiy) AS total_items_sold
FROM retail_sale
GROUP BY category
ORDER BY total_items_sold DESC;


----Data Quality & Integrity
--Q 53.Are there any transactions with negative or zero values?

SELECT * 
FROM retail_sale
WHERE 
 quantiy <= 0 OR
 price_per_unit <= 0
 OR total_sale <= 0;

--Q 54. Check if total_sale = price_per_unit * quantity for all transactions.


SELECT * 
FROM retail_sale
WHERE total_sale != quantiy * price_per_unit;

--Q55.Find outliers in profit per transaction.


SELECT *
FROM retail_sale
WHERE (total_sale - cogs) > (
  SELECT AVG(total_sale - cogs) + 2 * STDEV(total_sale - cogs) FROM retail_sale
) ;
--Q 56.Are there any duplicated transactions?

SELECT transactions_id, COUNT(*) AS count
FROM retail_sale
GROUP BY transactions_id
HAVING COUNT(*) > 1;