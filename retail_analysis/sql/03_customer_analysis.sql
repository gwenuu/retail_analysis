
-- 1. Top 10 customers by spending

SELECT
    customer_id,
    COUNT(DISTINCT invoice_no) AS total_orders,
    ROUND(SUM(quantity * unit_price), 2) AS total_spent
FROM sales
WHERE customer_id IS NOT NULL
GROUP BY customer_id
ORDER BY total_spent DESC
LIMIT 10;


-- 2. Repeat customers

SELECT
    customer_id,
    COUNT(DISTINCT invoice_no) AS total_orders
FROM sales
WHERE customer_id IS NOT NULL
GROUP BY customer_id
HAVING COUNT(DISTINCT invoice_no) > 1
ORDER BY total_orders DESC
LIMIT 20;


-- 3. Average order value

WITH order_totals AS (
    SELECT
        invoice_no,
        SUM(quantity * unit_price) AS order_value
    FROM sales
    GROUP BY invoice_no
)

SELECT
    ROUND(AVG(order_value), 2) AS avg_order_value
FROM order_totals;


-- 4. Percentage of repeat customers

WITH customer_orders AS (
    SELECT
        customer_id,
        COUNT(DISTINCT invoice_no) AS order_count
    FROM sales
    WHERE customer_id IS NOT NULL
    GROUP BY customer_id
)

SELECT
    COUNT(*) AS total_customers,
    COUNT(*) FILTER (
        WHERE order_count > 1
    ) AS repeat_customers,
    ROUND(
        100.0 * COUNT(*) FILTER (WHERE order_count > 1)
        / NULLIF(COUNT(*), 0),
        2
    ) AS repeat_rate
FROM customer_orders;