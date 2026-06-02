-- 1. VIEW DATA
SELECT *
FROM superstore
LIMIT 10;

-- 2. FILTER DATA USING WHERE
SELECT *
FROM superstore
WHERE country = 'India';

-- 3. SORT DATA USING ORDER BY
SELECT *
FROM superstore
ORDER BY sales DESC
LIMIT 10;

-- 4. GROUP BY (TOTAL SALES BY CATEGORY)
SELECT
    category,
    SUM(sales) AS total_sales
FROM superstore
GROUP BY category;

-- 5. AGGREGATE FUNCTIONS (SALES + PROFIT)
SELECT
    category,
    SUM(sales) AS total_sales,
    AVG(profit) AS average_profit
FROM superstore
GROUP BY category;

-- 6. CREATE CUSTOMERS TABLE
CREATE TABLE customers AS
SELECT DISTINCT
    customer_id,
    customer_name,
    segment
FROM superstore;

-- 7. INNER JOIN (CUSTOMER SALES)
SELECT
    s.order_id,
    c.customer_name,
    s.sales
FROM superstore s
INNER JOIN customers c
ON s.customer_id = c.customer_id
LIMIT 20;

-- 8. LEFT JOIN (CUSTOMER ORDERS)
SELECT
    c.customer_name,
    s.order_id,
    s.sales
FROM customers c
LEFT JOIN superstore s
ON c.customer_id = s.customer_id
LIMIT 20;

-- 9. SUBQUERY (ABOVE AVERAGE SALES)
SELECT
    order_id,
    sales
FROM superstore
WHERE sales >
(
    SELECT AVG(sales)
    FROM superstore
);

-- 10. VIEW (CATEGORY ANALYSIS)
CREATE VIEW category_sales AS
SELECT
    category,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit,
    AVG(profit) AS average_profit
FROM superstore
GROUP BY category;

SELECT * FROM category_sales;

-- 11. VIEW (REGION PERFORMANCE)
CREATE VIEW region_performance AS
SELECT
    region,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit,
    COUNT(order_id) AS total_orders
FROM superstore
GROUP BY region;

SELECT * FROM region_performance;

-- 12. VIEW (CUSTOMER ANALYSIS)
CREATE VIEW customer_sales AS
SELECT
    customer_id,
    customer_name,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit
FROM superstore
GROUP BY customer_id, customer_name;

SELECT *
FROM customer_sales
ORDER BY total_sales DESC
LIMIT 10;

-- 13. VIEW (PRODUCT PERFORMANCE)
CREATE VIEW product_performance AS
SELECT
    product_name,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit,
    SUM(quantity) AS total_quantity_sold
FROM superstore
GROUP BY product_name;

SELECT *
FROM product_performance
ORDER BY total_sales DESC
LIMIT 10;

-- 14. INDEXING
CREATE INDEX idx_customer ON superstore(customer_id);
CREATE INDEX idx_order ON superstore(order_id);
CREATE INDEX idx_product ON superstore(product_id);
CREATE INDEX idx_region ON superstore(region);
CREATE INDEX idx_category ON superstore(category);

-- 15. FINAL ANALYSIS (REGION INSIGHTS)
SELECT
    region,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit
FROM superstore
GROUP BY region
ORDER BY total_sales DESC;