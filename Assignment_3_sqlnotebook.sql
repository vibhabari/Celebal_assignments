CREATE DATABASE superstore;
USE superstore;
SELECT * FROM SUPERSTORE_RAW;

-- CREATE TABLE CUSTOMERS
CREATE TABLE customers AS
SELECT DISTINCT
    `Customer ID` AS customer_id,
    `Customer Name` AS customer_name,
    `Segment` AS segment
FROM superstore_raw;


-- CREATE TABLE PRODUCTS
CREATE TABLE products AS
SELECT DISTINCT
    `Product ID` AS product_id,
    `Product Name` AS product_name,
    `Category` AS category,
    `Sub-Category` AS sub_category
FROM superstore_raw;

-- CREATE TABLE ORDERS
CREATE TABLE orders AS
SELECT
    `Order ID` AS order_id,
    `Customer ID` AS customer_id,
    `Product ID` AS product_id,
    STR_TO_DATE(`Order Date`, '%m/%d/%Y') AS order_date,
    STR_TO_DATE(`Ship Date`, '%m/%d/%Y')  AS ship_date,
    `Ship Mode` AS ship_mode,
    CAST(`Sales` AS DECIMAL(10,2)) AS sales,
    CAST(`Quantity` AS SIGNED) AS quantity,
    CAST(`Discount` AS DECIMAL(5,2)) AS discount,
    CAST(`Profit` AS DECIMAL(10,2)) AS profit,
    `Region` AS region
FROM superstore_raw;

-- SUBQUERIES
-- ABOVE AVERAGE SALES
SELECT
    o.order_id,
    c.customer_name,
    ROUND(o.sales, 2) AS sales
FROM orders o
JOIN customers c USING (customer_id)
WHERE o.sales > (SELECT AVG(sales) FROM orders)
ORDER BY o.sales DESC
LIMIT 10;

-- HIGHEST ORDER PER CUSTOMER

SELECT c.customer_name, o.order_id, ROUND(o.sales, 2) AS max_order_sales
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN (
    SELECT customer_id, MAX(sales) AS max_sales
    FROM   orders
    GROUP  BY customer_id          
) AS mx ON o.customer_id = mx.customer_id
AND o.sales = mx.max_sales
ORDER BY max_order_sales DESC
LIMIT 10;

-- CTE

WITH customer_sales AS (
    SELECT
        customer_id,
        ROUND(SUM(sales),  2) AS total_sales,
        COUNT(DISTINCT order_id)  AS total_orders
    FROM orders
    GROUP BY customer_id
)
SELECT
    c.customer_name,
    c.segment,
    cs.total_sales,
    cs.total_orders
FROM customer_sales cs
JOIN customers c USING (customer_id)
ORDER BY cs.total_sales DESC
LIMIT 10;

-- WINDOW FUNCTIONS
WITH sales_agg AS(SELECT customer_id, region, ROUND(SUM(sales), 2) AS total_sales FROM orders
GROUP BY customer_id, region),
ranked_sales AS(SELECT c.customer_name, c.segment, s.region, s.total_sales,
ROW_NUMBER() OVER(PARTITION BY s.region ORDER BY s.total_sales DESC) AS row_num FROM sales_agg s
JOIN customers c
ON s.customer_id = c.customer_id)
SELECT * FROM ranked_sales
WHERE row_num <= 3
ORDER BY region, row_num;

WITH cte AS (SELECT customer_id, ROUND(SUM(sales), 2) AS total_sales FROM orders
GROUP BY customer_id)
SELECT c.customer_name, c.segment, cs.total_sales,
RANK() OVER (ORDER BY cs.total_sales DESC) AS rnk, DENSE_RANK() OVER (ORDER BY cs.total_sales DESC) AS dense_rnk
FROM cte cs
JOIN customers c USING (customer_id)
ORDER BY rnk
LIMIT 15;

-- COMBINED JOIN + CTE + WINDOW FUNCTION

WITH cte_sales AS (SELECT customer_id, ROUND(SUM(sales),2) AS total_sales, ROUND(SUM(profit),2) AS total_profit,
COUNT(DISTINCT order_id)  AS total_orders FROM orders
GROUP BY customer_id),
cte_ranked AS (SELECT *, RANK() OVER (ORDER BY total_sales DESC) AS sales_rank
FROM cte_sales)
SELECT c.customer_name, c.segment, r.total_sales, r.total_orders, r.total_profit, r.sales_rank FROM cte_ranked r
JOIN customers c USING (customer_id)
ORDER BY r.sales_rank
LIMIT 15;

-- BUSINESS QUERIES
-- TOP CUSTOMERS
WITH customer_sales AS (SELECT customer_id, ROUND(SUM(sales), 2)AS total_sales, COUNT(DISTINCT order_id)AS total_orders FROM orders
GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT  10)
SELECT c.customer_name, c.segment, cs.total_sales, cs.total_orders FROM customer_sales cs
JOIN customers c ON cs.customer_id = c.customer_id
ORDER BY cs.total_sales DESC;

-- LOW CUSTOMERS
WITH cte AS(SELECT customer_id, ROUND(SUM(sales),2)AS total_sales FROM orders
GROUP BY customer_id)
SELECT c.customer_name, c.segment, cs.total_sales FROM cte cs
JOIN customers c ON cs.customer_id = c.customer_id
ORDER BY cs.total_sales ASC
LIMIT 10;

-- SINGLE ORDER CUSTOMER
WITH order_counts AS (
    SELECT customer_id, COUNT(DISTINCT order_id) AS order_count
    FROM orders
    GROUP BY customer_id
)
SELECT
    c.customer_name,
    c.segment,
    oc.order_count
FROM order_counts oc
JOIN customers c USING (customer_id)
WHERE oc.order_count = 1
ORDER BY c.customer_name;

-- ABOVE AVERAGE SALES
SELECT COUNT(*) AS above_avg_count, ROUND(AVG(sales), 2) AS avg_sale
FROM orders
WHERE sales > (SELECT AVG(sales) FROM orders);
