-- =========================================================
-- OnLan Mini Logistics Analytics — SQL Analysis
-- International freight forwarding: Ukraine -> Europe routes
-- 12 Junior-level queries answering key business questions
-- =========================================================

-- 1. Total Orders
-- Business question: how many orders has the company processed?
SELECT COUNT(*) AS total_orders
FROM orders;

-- 2. Total Revenue
-- Business question: what is the company's total revenue?
SELECT ROUND(SUM(delivery_cost), 2) AS total_revenue
FROM orders;

-- 3. Total Profit
-- Business question: what is the company's net profit?
SELECT ROUND(SUM(profit), 2) AS total_profit
FROM orders;

-- 4. Average Delivery Cost
-- Business question: how much does an average international shipment cost?
SELECT ROUND(AVG(delivery_cost), 2) AS avg_delivery_cost
FROM orders;

-- 5. Orders by Destination City
-- Business question: which international destinations are most in demand?
SELECT city_to, COUNT(*) AS orders_count
FROM orders
GROUP BY city_to
ORDER BY orders_count DESC;

-- 6. Orders by Delivery Type
-- Business question: which delivery type is most popular?
SELECT delivery_type, COUNT(*) AS orders_count
FROM orders
GROUP BY delivery_type
ORDER BY orders_count DESC;

-- 7. Completed vs Delayed Orders
-- Business question: how often do delays occur (e.g. customs)?
SELECT delivery_status, COUNT(*) AS orders_count
FROM orders
WHERE delivery_status IN ('Completed', 'Delayed')
GROUP BY delivery_status;

-- 8. Delay Rate
-- Business question: what percentage of international deliveries are delayed?
SELECT
    ROUND(
        100.0 * SUM(CASE WHEN delivery_status = 'Delayed' THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS delay_rate_percent
FROM orders;

-- 9. Top 10 Routes
-- Business question: which international routes are most popular and profitable?
SELECT
    city_from,
    city_to,
    COUNT(*) AS orders_count,
    ROUND(SUM(profit), 2) AS total_profit
FROM orders
GROUP BY city_from, city_to
ORDER BY orders_count DESC
LIMIT 10;

-- 10. Top Drivers
-- Business question: which drivers/carriers are most efficient on international routes?
SELECT
    d.driver_name,
    COUNT(o.order_id) AS orders_count,
    ROUND(SUM(o.profit), 2) AS total_profit
FROM orders o
JOIN drivers d ON o.driver_id = d.driver_id
GROUP BY d.driver_name
ORDER BY total_profit DESC
LIMIT 10;

-- 11. Average Delivery Days by Type
-- Business question: how long does international delivery actually take by type?
SELECT
    delivery_type,
    ROUND(AVG(delivery_days), 1) AS avg_delivery_days
FROM orders
WHERE delivery_status = 'Completed'
GROUP BY delivery_type
ORDER BY avg_delivery_days;

-- 12. Profit by Month
-- Business question: how does profitability change throughout the year — seasonality?
SELECT
    TO_CHAR(order_date, 'YYYY-MM') AS month,
    ROUND(SUM(profit), 2) AS monthly_profit
FROM orders
GROUP BY TO_CHAR(order_date, 'YYYY-MM')
ORDER BY month;
