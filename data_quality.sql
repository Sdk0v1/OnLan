-- =========================================================
-- OnLan Mini Logistics Analytics — Data Quality Checks
-- =========================================================

-- 1. NULL values across key columns
SELECT
    COUNT(*) FILTER (WHERE order_id IS NULL)        AS null_order_id,
    COUNT(*) FILTER (WHERE order_date IS NULL)       AS null_order_date,
    COUNT(*) FILTER (WHERE city_from IS NULL)        AS null_city_from,
    COUNT(*) FILTER (WHERE city_to IS NULL)          AS null_city_to,
    COUNT(*) FILTER (WHERE delivery_type IS NULL)    AS null_delivery_type,
    COUNT(*) FILTER (WHERE weight_kg IS NULL)        AS null_weight_kg,
    COUNT(*) FILTER (WHERE delivery_cost IS NULL)    AS null_delivery_cost,
    COUNT(*) FILTER (WHERE delivery_status IS NULL)  AS null_delivery_status,
    COUNT(*) FILTER (WHERE delivery_days IS NULL)    AS null_delivery_days,
    COUNT(*) FILTER (WHERE profit IS NULL)           AS null_profit,
    COUNT(*) FILTER (WHERE driver_id IS NULL)        AS null_driver_id
FROM orders;

-- 2. Duplicate order_id
SELECT order_id, COUNT(*) AS duplicate_count
FROM orders
GROUP BY order_id
HAVING COUNT(*) > 1;

-- 3. Negative profit (expected: Cancelled orders only)
SELECT order_id, delivery_status, profit
FROM orders
WHERE profit < 0
ORDER BY profit;

-- 4. delivery_days < 0 (invalid, should never happen)
SELECT order_id, delivery_status, delivery_days
FROM orders
WHERE delivery_days < 0;

-- 5. Invalid delivery_status values
SELECT DISTINCT delivery_status
FROM orders
WHERE delivery_status NOT IN ('Completed', 'Delayed', 'Cancelled');
