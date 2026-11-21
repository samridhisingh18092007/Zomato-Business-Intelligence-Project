
-- ZOMATO BUSINESS INTELLIGENCE
-- SQL ANALYSIS QUERIES

-- 1. Total Customers
SELECT COUNT(*) FROM customers;

-- 2. Total Orders
SELECT COUNT(*) FROM orders;

-- 3. Unique Customers in Orders
SELECT COUNT(DISTINCT "CustomerID") FROM orders;

-- 4. Total Restaurants
SELECT COUNT(*) FROM restaurants;

-- 5. Total Food Items
SELECT COUNT(*) FROM menu;

-- 6. Total Revenue
SELECT ROUND(SUM("FinalAmount")::numeric, 2)
FROM orders;

-- 7. Average Order Value
SELECT ROUND(AVG("FinalAmount")::numeric, 2)
FROM orders;

-- 8. Orders with Final Amount
SELECT COUNT("FinalAmount")
FROM orders;

-- 9. Missing Final Amount
SELECT COUNT(*)
FROM orders
WHERE "FinalAmount" IS NULL;

-- 10. Restaurant Revenue Analysis
SELECT
    o."RestaurantID",
    COUNT(o."OrderID") AS Total_Orders,
    ROUND(SUM(o."FinalAmount")::numeric, 2) AS Total_Revenue,
    ROUND(AVG(o."FinalAmount")::numeric, 2) AS Average_Order_Value
FROM orders o
WHERE o."FinalAmount" IS NOT NULL
GROUP BY o."RestaurantID"
ORDER BY Total_Revenue DESC
LIMIT 10;

-- 11. Monthly Revenue Analysis
SELECT
    TO_CHAR("OrderDate", 'YYYY-MM') AS Month,
    COUNT("OrderID") AS Total_Orders,
    ROUND(SUM("FinalAmount")::numeric, 2) AS Monthly_Revenue
FROM orders
WHERE "FinalAmount" IS NOT NULL
GROUP BY TO_CHAR("OrderDate", 'YYYY-MM')
ORDER BY Month;

-- 12. Payment Analysis
SELECT
    "PaymentMethod",
    "PaymentStatus",
    COUNT(*) AS Total_Transactions,
    COUNT(DISTINCT "OrderID") AS Unique_Orders
FROM payments
GROUP BY "PaymentMethod", "PaymentStatus"
ORDER BY Total_Transactions DESC;

-- 13. Customer Analysis
SELECT
    "CustomerID",
    COUNT("OrderID") AS Total_Orders,
    ROUND(SUM("FinalAmount")::numeric, 2) AS Total_Spending,
    ROUND(AVG("FinalAmount")::numeric, 2) AS Average_Order_Value
FROM orders
WHERE "FinalAmount" IS NOT NULL
GROUP BY "CustomerID"
ORDER BY Total_Spending DESC
LIMIT 10;

-- 14. Top Delivery Partners
SELECT
    "DeliveryPartnerID",
    COUNT(*) AS Total_Orders,
    ROUND(AVG("DeliveryTimeMinutes")::numeric, 2) AS Avg_Delivery_Time
FROM orders
WHERE "DeliveryPartnerID" IS NOT NULL
  AND "DeliveryTimeMinutes" > 0
GROUP BY "DeliveryPartnerID"
ORDER BY Total_Orders DESC
LIMIT 10;

-- 15. Top Selling Food Items
SELECT
    oi."FoodItemID",
    SUM(oi."Quantity") AS Total_Quantity_Sold,
    ROUND(SUM(oi."TotalPrice")::numeric, 2) AS Total_Sales
FROM order_items oi
WHERE oi."Quantity" > 0
  AND oi."TotalPrice" IS NOT NULL
GROUP BY oi."FoodItemID"
ORDER BY Total_Quantity_Sold DESC
LIMIT 10;

-- 16. Order Status Analysis
SELECT
    "OrderStatus",
    COUNT(*) AS Total_Orders
FROM orders
GROUP BY "OrderStatus"
ORDER BY Total_Orders DESC;

-- 17. Customer Membership Analysis
SELECT
    c."Membership",
    COUNT(DISTINCT c."CustomerID") AS Total_Customers,
    COUNT(o."OrderID") AS Total_Orders
FROM customers c
LEFT JOIN orders o
    ON c."CustomerID" = o."CustomerID"
GROUP BY c."Membership"
ORDER BY Total_Orders DESC;

-- 18. Customer Feedback Ratings
SELECT
    "CustomerRating",
    COUNT(*) AS Total_Feedback
FROM customer_feedback
WHERE "CustomerRating" IS NOT NULL
GROUP BY "CustomerRating"
ORDER BY "CustomerRating";

-- 19. Traffic Level Analysis
SELECT
    "TrafficLevel",
    COUNT(*) AS Total_Records,
    ROUND(AVG("AverageSpeed")::numeric, 2) AS Avg_Speed
FROM traffic
GROUP BY "TrafficLevel"
ORDER BY Total_Records DESC;

-- 20. Weather Monthly Analysis
SELECT
    TO_CHAR("Date", 'YYYY-MM') AS Month,
    ROUND(AVG("Humidity")::numeric, 2) AS Avg_Humidity,
    ROUND(AVG("Rainfall")::numeric, 2) AS Avg_Rainfall
FROM weather
GROUP BY TO_CHAR("Date", 'YYYY-MM')
ORDER BY Month;

-- 21. Orders by Hour
SELECT
    EXTRACT(HOUR FROM "OrderTime") AS Order_Hour,
    COUNT(*) AS Total_Orders
FROM orders
GROUP BY Order_Hour
ORDER BY Order_Hour;
