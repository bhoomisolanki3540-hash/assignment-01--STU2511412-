-- Q1: List all customers along with the total number of orders they have placed
-- We join the CSV customers file with the JSON orders file
SELECT c.name, COUNT(o.order_id) AS total_orders
FROM read_csv_auto('customers (1).csv') AS c
LEFT JOIN read_json_auto('orders (1).json') AS o ON c.customer_id = o.customer_id
GROUP BY c.name;

-- Q2: Find the top 3 customers by total order value
-- We sum the total_amount from the JSON file for each customer in the CSV
SELECT c.name, SUM(o.total_amount) AS total_order_value
FROM read_csv_auto('customers (1).csv') AS c
JOIN read_json_auto('orders (1).json') AS o ON c.customer_id = o.customer_id
GROUP BY c.name
ORDER BY total_order_value DESC
LIMIT 3;

-- Q3: List all products purchased by customers from Bangalore
-- We chain the join from customers (CSV) -> orders (JSON) -> products (Parquet)
SELECT DISTINCT p.product_name
FROM read_csv_auto('customers (1).csv') AS c
JOIN read_json_auto('orders (1).json') AS o ON c.customer_id = o.customer_id
JOIN read_parquet('products (1).parquet') AS p ON o.order_id = p.order_id
WHERE c.city = 'Bangalore';

-- Q4: Join all three files to show: customer name, order date, product name, and quantity
-- This query demonstrates a multi-format join across CSV, JSON, and Parquet
SELECT 
    c.name AS customer_name, 
    o.order_date, 
    p.product_name, 
    p.quantity
FROM read_csv_auto('customers (1).csv') AS c
JOIN read_json_auto('orders (1).json') AS o ON c.customer_id = o.customer_id
JOIN read_parquet('products (1).parquet') AS p ON o.order_id = p.order_id;
