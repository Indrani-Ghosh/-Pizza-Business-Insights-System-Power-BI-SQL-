-- View all records
SELECT * 
FROM [PIZZASALES CSV];

-- Total Revenue
SELECT SUM(total_price) AS Total_Revenue
FROM [PIZZASALES CSV];

-- Average Order Value (AOV)
SELECT SUM(total_price) / COUNT(DISTINCT order_id) AS AOV
FROM [PIZZASALES CSV];

-- Total Orders
SELECT COUNT(DISTINCT order_id) AS Total_Orders
FROM [PIZZASALES CSV];

-- Average Pizzas per Order
SELECT CAST(CAST(SUM(quantity) AS DECIMAL(10,2)) /
            CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS DECIMAL(10,2)) 
            AS Avg_Pizzas_per_Order
FROM [PIZZASALES CSV];

-- Daily Trend for Total Orders
SELECT DATENAME(DW, order_date) AS days_, 
       COUNT(DISTINCT order_id) AS total_orders
FROM [PIZZASALES CSV]
GROUP BY DATENAME(DW, order_date)
ORDER BY COUNT(DISTINCT order_id) DESC;

-- Monthly Trend for Total Orders
SELECT DATENAME(MONTH, order_date) AS months, 
       COUNT(DISTINCT order_id) AS total_orders
FROM [PIZZASALES CSV]
GROUP BY DATENAME(MONTH, order_date)
ORDER BY COUNT(DISTINCT order_id) DESC;

-- Revenue by Pizza Category
SELECT pizza_category,
       SUM(total_price) AS total_revenue,
       CONCAT(ROUND(SUM(total_price) * 100.0 / 
             (SELECT SUM(total_price) FROM [PIZZASALES CSV]), 2), '%') AS percentage_sales
FROM [PIZZASALES CSV]
GROUP BY pizza_category
ORDER BY SUM(total_price) DESC;

-- Revenue by Pizza Size
SELECT pizza_size,
       SUM(total_price) AS total_revenue,
       CONCAT(ROUND(SUM(total_price) * 100.0 / 
             (SELECT SUM(total_price) FROM [PIZZASALES CSV]), 2), '%') AS percentage_sales
FROM [PIZZASALES CSV]
GROUP BY pizza_size
ORDER BY SUM(total_price) DESC;

-- Top 5 Best Sellers by Revenue
SELECT TOP 5 pizza_name, 
       SUM(total_price) AS total_revenue
FROM [PIZZASALES CSV]
GROUP BY pizza_name
ORDER BY total_revenue DESC;

-- Bottom 5 Worst Sellers by Revenue
SELECT TOP 5 pizza_name, 
       SUM(total_price) AS total_revenue
FROM [PIZZASALES CSV]
GROUP BY pizza_name
ORDER BY total_revenue ASC;
