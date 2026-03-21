-- Q1: Total sales revenue by product category for each month
SELECT p.category, d.month, SUM(f.total_revenue) as monthly_revenue
FROM fact_sales f
JOIN dim_product p ON f.product_key = p.product_key
JOIN dim_date d ON f.date_key = d.date_key
GROUP BY p.category, d.month
ORDER BY d.month;

-- Q2: Top 2 performing stores by total revenue
SELECT s.store_name, SUM(f.total_revenue) as total_revenue
FROM fact_sales f
JOIN dim_store s ON f.store_key = s.store_key
GROUP BY s.store_name
ORDER BY total_revenue DESC
LIMIT 2;

-- Q3: Month-over-month sales trend across all stores
SELECT d.month, d.year, SUM(f.total_revenue) as total_sales
FROM fact_sales f
JOIN dim_date d ON f.date_key = d.date_key
GROUP BY d.year, d.month
ORDER BY d.year, d.month;
