
-- 1. Overall sales

SELECT
    ROUND(SUM(quantity * unit_price), 2) AS revenue,
    COUNT(DISTINCT invoice_no) AS total_orders,
    COUNT(DISTINCT customer_id) AS customers
FROM sales;


-- 2. Monthly revenue

SELECT
    DATE_TRUNC('month', invoice_date)::date AS month,
    ROUND(SUM(quantity * unit_price), 2) AS revenue,
    COUNT(DISTINCT invoice_no) AS orders
FROM sales
GROUP BY 1
ORDER BY 1;


-- 3. Top 10 products by revenue

SELECT
    stock_code,
    description,
    SUM(quantity) AS units_sold,
    ROUND(SUM(quantity * unit_price), 2) AS revenue
FROM sales
WHERE description IS NOT NULL
GROUP BY stock_code, description
ORDER BY revenue DESC
LIMIT 10;


-- 4. Top 10 countries by revenue

SELECT
    country,
    COUNT(DISTINCT invoice_no) AS orders,
    ROUND(SUM(quantity * unit_price), 2) AS revenue
FROM sales
GROUP BY country
ORDER BY revenue DESC
LIMIT 10;

