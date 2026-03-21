-- 1. Create Dimension Tables
CREATE TABLE dim_date (
    date_key INT PRIMARY KEY,
    full_date DATE NOT NULL,
    day INT,
    month INT,
    year INT
);

CREATE TABLE dim_store (
    store_key SERIAL PRIMARY KEY,
    store_name VARCHAR(100),
    store_city VARCHAR(50)
);

CREATE TABLE dim_product (
    product_key SERIAL PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50)
);

-- 2. Create Fact Table
CREATE TABLE fact_sales (
    transaction_id VARCHAR(20) PRIMARY KEY,
    date_key INT REFERENCES dim_date(date_key),
    store_key INT REFERENCES dim_store(store_key),
    product_key INT REFERENCES dim_product(product_key),
    units_sold INT NOT NULL,
    unit_price DECIMAL(10, 2) NOT NULL,
    total_revenue DECIMAL(12, 2) GENERATED ALWAYS AS (units_sold * unit_price) STORED
);

-- 3. Populate Dimension Data
INSERT INTO dim_date VALUES 
(20230829, '2023-08-29', 29, 8, 2023),
(20231212, '2023-12-12', 12, 12, 2023),
(20230205, '2023-02-05', 5, 2, 2023),
(20230115, '2023-01-15', 15, 1, 2023),
(20230809, '2023-08-09', 9, 8, 2023);

INSERT INTO dim_store (store_name, store_city) VALUES 
('Chennai Anna', 'Chennai'),
('Delhi South', 'Delhi'),
('Bangalore MG', 'Bangalore'),
('Pune FC Road', 'Pune');

INSERT INTO dim_product (product_name, category) VALUES 
('Speaker', 'Electronics'),
('Tablet', 'Electronics'),
('Phone', 'Electronics'),
('Atta 10kg', 'Groceries'),
('Smartwatch', 'Electronics');

-- 4. Populate Fact Table (10 Cleaned Rows)
-- Assuming IDs: Chennai=1, Delhi=2, Bangalore=3, Pune=4; Speaker=1, Tablet=2, Phone=3, Atta=4, Smart=5
INSERT INTO fact_sales (transaction_id, date_key, store_key, product_key, units_sold, unit_price) VALUES 
('TXN5000', 20230829, 1, 1, 3, 49262.78),
('TXN5001', 20231212, 1, 2, 11, 23226.12),
('TXN5002', 20230205, 1, 3, 20, 48703.39),
('TXN5003', 20230205, 2, 2, 14, 23226.12),
('TXN5004', 20230115, 1, 5, 10, 58851.01),
('TXN5005', 20230809, 3, 4, 12, 52464.00),
('TXN5006', 20230809, 4, 5, 6, 58851.01),
('TXN5007', 20231212, 4, 5, 16, 2317.47),
('TXN5008', 20231212, 3, 4, 9, 27469.99),
('TXN5009', 20230829, 3, 5, 3, 58851.01);
