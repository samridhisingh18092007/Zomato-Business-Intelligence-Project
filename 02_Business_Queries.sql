-- 02_Business_Queries.sql

-- 1. Total Orders
SELECT COUNT(*) AS total_orders
FROM orders;

-- 2. Total Revenue
SELECT SUM("FinalAmount") AS total_revenue
FROM orders;

-- 3. Average Order Value
SELECT AVG("FinalAmount") AS average_order_value
FROM orders;

-- 4. Total Customers
SELECT COUNT(DISTINCT "CustomerID") AS total_customers
FROM orders;

-- 5. Order Status Breakdown
SELECT "OrderStatus", COUNT(*) AS total
FROM orders
GROUP BY "OrderStatus";

-- 6. Payment Method Breakdown
SELECT "PaymentMethod", COUNT(*) AS total
FROM payments
GROUP BY "PaymentMethod";