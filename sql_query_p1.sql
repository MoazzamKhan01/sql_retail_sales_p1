-- SQL Project 1 (retail sales analysis)

-- Q.1 WRITE A QUERY TO RETRIEVE ALL COLUMNS FOR SALES MADE ON "2022-11-05"

SELECT * FROM retail_sales
	WHERE sale_date = '2022-11-05'

-- Q.2 WRITE A SQL QUERY TO RETRIEVE ALL TRANSACTIONS WHERE THE CATEGORY IS 'CLOTHING' AND THE QUANTITY SOLD IS MORE THAN 4? 

SELECT *
FROM retail_sales
WHERE   category ILIKE 'clothing'          
  AND   quantity >= 4                      
  AND   TO_CHAR(sale_date, 'YYYY-MM') = '2022-11';   

-- Q.3 WRITE A SQL QUERY TO CALCULATE TOTAL SALES FOR EACH CATEGORY?

SELECT category,
	SUM(total_sale) as net_sales,
	COUNT(*) as total_orders
FROM retail_sales
GROUP BY 1

-- Q.4 WRITE A SQL QUERY TO FIND THE AVG. AGE OF CUSTOMERS WHO PURCHASED ITEMS FROM BEAUTY CATEGORY?

SELECT category,
 ROUND(AVG(age)) as avg_age
  FROM retail_sales
 WHERE category = 'Beauty'
GROUP BY 1

-- Q.5 WRITE A SQL QUERY TO FIND ALL TRANSACTIONS WHERE TOTAL SALE IS GREATER THAN 1000

SELECT * FROM 
retail_sales 

SELECT transaction_id
FROM retail_sales 
WHERE total_sale > 1000;

-- Q.6 WRITE A SQL QUERY TO FIND TOTAL NUMBER OF TRANSACTIONS MADE BY EACH GENDER IN EACH CATEGORY?
SELECT 
	category,
	gender,
	COUNT(*) as total_trans
FROM retail_sales
GROUP BY 
category,
gender
ORDER BY 1

-- Q.7 WRITE A SQL QUERY TO CALCULATE THE AVERAGE SALE FOR EACH MONTH. FIND OUT THE BEST SELLING MONTH IN EACH YEAR?

SELECT year,
	month,
	avg_sales
FROM
(
	SELECT 
		EXTRACT(YEAR FROM sale_date) as year,
		EXTRACT (MONTH FROM sale_date) as month,
		AVG(total_sale) as avg_sales,
		RANK() OVER(PARTITION BY EXTRACT (YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC)as rank
	FROM retail_sales
	GROUP BY 1,2) as T1
WHERE rank = 1
-- ORDER BY 1 ,3 DESC 

-- Q.8 WRITE A SQL QUERY TO FIND TOP 5 CUSTOMERS BASED ON HIGHEST TOTAL SALES?

SELECT customer_id,
	SUM(total_sale) as total_sales
FROM retail_sales
GROUP BY 1 
ORDER BY total_sales DESC
LIMIT 5;

-- WRITE A SQL TO FIND THE NUMBER OF UNIQUE CUSTOMERS WHO PURCHASED ITEM FROM EACH CATEGORY
SELECT category,
	COUNT(DISTINCT customer_id) as unique_customers
FROM retail_sales
GROUP BY category
ORDER BY unique_customers DESC

-- WRITE A SQL QUERY TO EACH SHIFT AND NUMBER OF ORDERS (EXAMPLE MORNING =12, AFTERNOON BETWEEN 12 AND 17, EVENING>17)?W
WITH hourly_sales 
AS
(
SELECT *,
CASE
	WHEN EXTRACT (HOUR FROM sale_time) < 12 THEN 'morning'
	WHEN EXTRACT (HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'afternoon'
	ELSE 'evening'
	END as shift 
FROM retail_sales
)
SELECT shift,
	COUNT(*) as total_orders
FROM hourly_sales
GROUP BY shift

-- end of project

-- SELECT EXTRACT (HOUR FROM CURRENT_TIME) this is watch
SELECT * FROM retail_sales