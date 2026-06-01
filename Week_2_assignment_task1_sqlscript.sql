CREATE DATABASE sales;
-- 1)load dataset
USE sales;

-- 2)EXPLORE DATA 
-- DESCRIBE THE SCHEMA 
DESC superstore;

-- DISPLAYING THE TABLE RECORDS 
SELECT *
FROM superstore
LIMIT 10;

-- 3) FILTERING
-- FILTER BY Region 
 SELECT * FROM superstore WHERE Region = 'South';
 
 -- FFILTER BY category 
 SELECT * FROM superstore WHERE Category = 'Office Supplies';
 
 -- FILTER BY ordder date
 SELECT * FROM superstore WHERE STR_TO_DATE(`Order Date`, '%m/%d/%Y') = '2017-01-01';
 
 -- FILTER BY Sales
 SELECT * FROM superstore WHERE Sales > '8550';
 
 -- 4) USING GROUPBY Aggregrations
 -- Sales, Quantity by Category
 SELECT Category, SUM(Sales)   AS total_sales, SUM(Quantity) AS total_qty
FROM superstore
GROUP BY Category
ORDER BY total_sales DESC
LIMIT 10;
 
-- sub category
SELECT (`Sub-Category`), SUM(Sales) AS total_sales, SUM(Profit) AS total_profit,
    SUM(Quantity) AS total_qty
FROM superstore
GROUP BY (`Sub-Category`)
ORDER BY total_sales DESC
LIMIT 10;

-- Profit by Region
SELECT Region, SUM(Sales) AS total_sales,SUM(Profit) AS total_profit
FROM superstore
GROUP BY Region;

-- 5) sort and limit results
--  Top 10 Products by Revenue
SELECT (`Product Name`),SUM(Sales) AS total_sales, SUM(Quantity) AS units_sold
FROM superstore
GROUP BY (`Product Name`)
ORDER BY total_sales DESC
LIMIT 10;

-- top 5 customers
SELECT (`Customer Name`), ROUND(SUM(Sales),2) AS Customer_Sales
FROM superstore
GROUP BY(`Customer Name`)
ORDER BY Customer_Sales DESC
LIMIT 5;

-- Top States by Revenue
SELECT State,ROUND(SUM(Sales),2) AS total_sales
FROM superstore
GROUP BY State
ORDER BY total_sales DESC
LIMIT 5;

-- Top categories by profit
SELECT Category, Round(SUM(Profit),2) AS Total_Profit
FROM superstore
GROUP BY Category
ORDER BY Total_Profit DESC
LIMIT 3;

-- 6) Busines Queries
-- Monthly Revenue & Profit Trend
SELECT DATE_FORMAT(
           STR_TO_DATE(`Order Date`, '%m/%d/%Y'),
           '%Y-%m'
       ) AS Month,
       SUM(Sales) AS Monthly_Sales,SUM(Profit) AS Monthly_Profit
FROM superstore
GROUP BY Month
ORDER BY Month;

-- Mostly Profitable States
SELECT State, Round(SUM(Profit),2) AS Total_Profit
FROM superstore
GROUP BY State
ORDER BY Total_Profit DESC
LIMIT 10;

-- Duplicate Records
SELECT (`Order ID`), (`Product ID`), COUNT(*) AS Duplicate_Count
FROM superstore
GROUP BY (`Order ID`), (`Product ID`)
HAVING COUNT(*) > 1;

-- 7) Validate Results

-- Total No. Of Rows 
SELECT COUNT(*) AS Total_Rows
FROM superstore;

-- Checking null values
SELECT * FROM superstore
WHERE Sales IS NULL
   OR Profit IS NULL
   OR Category IS NULL;
   
-- Checking distinct categories
SELECT DISTINCT Category
FROM superstore;



