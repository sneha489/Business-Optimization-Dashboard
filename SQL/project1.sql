-- =========================================================
-- BUSINESS OPTIMIZATION DASHBOARD
-- SQL ANALYSIS QUERIES
-- =========================================================


-- 1. View Inventory Data
SELECT *
FROM [dbo].[Test+Environment+Inventory+Dataset];


-- 2. View Product Data
SELECT *
FROM products;


-- 3. Join Inventory and Product Tables
SELECT
    a.[Order_Date_DD_MM_YYYY],
    a.product_id,
    a.availability,
    a.demand,
    b.product_name,
    b.unit_price
FROM [dbo].[Test+Environment+Inventory+Dataset] AS a
LEFT JOIN products AS b
    ON a.product_id = b.product_id;


-- 4. Total Demand
SELECT
    SUM(demand) AS total_demand
FROM [dbo].[Test+Environment+Inventory+Dataset];


-- 5. Total Available Inventory
SELECT
    SUM(availability) AS total_availability
FROM [dbo].[Test+Environment+Inventory+Dataset];


-- 6. Average Demand
SELECT
    AVG(demand) AS average_demand
FROM [dbo].[Test+Environment+Inventory+Dataset];


-- 7. Average Inventory Availability
SELECT
    AVG(availability) AS average_availability
FROM [dbo].[Test+Environment+Inventory+Dataset];


-- 8. Products with Demand Greater Than Availability
SELECT
    a.product_id,
    b.product_name,
    a.demand,
    a.availability,
    (a.demand - a.availability) AS shortage
FROM [dbo].[Test+Environment+Inventory+Dataset] AS a
LEFT JOIN products AS b
    ON a.product_id = b.product_id
WHERE a.demand > a.availability;


-- 9. Total Supply Shortage
SELECT
    SUM(demand - availability) AS total_supply_shortage
FROM [dbo].[Test+Environment+Inventory+Dataset]
WHERE demand > availability;


-- 10. Product-wise Demand
SELECT
    a.product_id,
    b.product_name,
    SUM(a.demand) AS total_demand
FROM [dbo].[Test+Environment+Inventory+Dataset] AS a
LEFT JOIN products AS b
    ON a.product_id = b.product_id
GROUP BY
    a.product_id,
    b.product_name
ORDER BY total_demand DESC;


-- 11. Product-wise Availability
SELECT
    a.product_id,
    b.product_name,
    SUM(a.availability) AS total_availability
FROM [dbo].[Test+Environment+Inventory+Dataset] AS a
LEFT JOIN products AS b
    ON a.product_id = b.product_id
GROUP BY
    a.product_id,
    b.product_name
ORDER BY total_availability DESC;


-- 12. Product-wise Demand vs Availability
SELECT
    a.product_id,
    b.product_name,
    SUM(a.demand) AS total_demand,
    SUM(a.availability) AS total_availability,
    SUM(a.demand - a.availability) AS shortage
FROM [dbo].[Test+Environment+Inventory+Dataset] AS a
LEFT JOIN products AS b
    ON a.product_id = b.product_id
GROUP BY
    a.product_id,
    b.product_name
ORDER BY shortage DESC;


-- 13. Product Price Information
SELECT
    product_id,
    product_name,
    unit_price
FROM products
ORDER BY unit_price DESC;


-- 14. Estimated Demand Value
SELECT
    a.product_id,
    b.product_name,
    SUM(a.demand) AS total_demand,
    b.unit_price,
    SUM(a.demand) * b.unit_price AS estimated_demand_value
FROM [dbo].[Test+Environment+Inventory+Dataset] AS a
LEFT JOIN products AS b
    ON a.product_id = b.product_id
GROUP BY
    a.product_id,
    b.product_name,
    b.unit_price
ORDER BY estimated_demand_value DESC;


-- 15. Inventory Value
SELECT
    a.product_id,
    b.product_name,
    SUM(a.availability) AS total_availability,
    b.unit_price,
    SUM(a.availability) * b.unit_price AS inventory_value
FROM [dbo].[Test+Environment+Inventory+Dataset] AS a
LEFT JOIN products AS b
    ON a.product_id = b.product_id
GROUP BY
    a.product_id,
    b.product_name,
    b.unit_price
ORDER BY inventory_value DESC;


-- 16. Overall Business Summary
SELECT
    SUM(a.demand) AS total_demand,
    SUM(a.availability) AS total_availability,
    SUM(CASE
        WHEN a.demand > a.availability
        THEN a.demand - a.availability
        ELSE 0
    END) AS total_shortage,
    AVG(a.demand) AS average_demand,
    AVG(a.availability) AS average_availability
FROM [dbo].[Test+Environment+Inventory+Dataset] AS a;


-- 17. Demand and Availability by Date
SELECT
    [Order_Date_DD_MM_YYYY],
    SUM(demand) AS total_demand,
    SUM(availability) AS total_availability
FROM [dbo].[Test+Environment+Inventory+Dataset]
GROUP BY [Order_Date_DD_MM_YYYY]
ORDER BY [Order_Date_DD_MM_YYYY];


-- 18. Products Having No Shortage
SELECT
    a.product_id,
    b.product_name,
    SUM(a.demand) AS total_demand,
    SUM(a.availability) AS total_availability
FROM [dbo].[Test+Environment+Inventory+Dataset] AS a
LEFT JOIN products AS b
    ON a.product_id = b.product_id
GROUP BY
    a.product_id,
    b.product_name
HAVING SUM(a.availability) >= SUM(a.demand);


-- 19. Products Requiring Restocking
SELECT
    a.product_id,
    b.product_name,
    SUM(a.demand) AS total_demand,
    SUM(a.availability) AS total_availability,
    SUM(a.demand - a.availability) AS restock_quantity
FROM [dbo].[Test+Environment+Inventory+Dataset] AS a
LEFT JOIN products AS b
    ON a.product_id = b.product_id
GROUP BY
    a.product_id,
    b.product_name
HAVING SUM(a.demand) > SUM(a.availability)
ORDER BY restock_quantity DESC;


-- 20. Final Dataset for Power BI
SELECT
    a.[Order_Date_DD_MM_YYYY],
    a.product_id,
    b.product_name,
    a.availability,
    a.demand,
    b.unit_price,
    CASE
        WHEN a.demand > a.availability
        THEN a.demand - a.availability
        ELSE 0
    END AS shortage
FROM [dbo].[Test+Environment+Inventory+Dataset] AS a
LEFT JOIN products AS b
    ON a.product_id = b.product_id;
