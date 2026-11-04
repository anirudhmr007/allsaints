-- ============================================================
-- QUESTION 4: PRODUCT INVENTORY MANAGEMENT SYSTEM
-- DATABASE SETUP SCRIPT FOR PGADMIN 4
-- ============================================================
-- 
-- STEP-BY-STEP PGADMIN INSTRUCTIONS:
-- 1. Open pgAdmin 4 and enter your master password to connect.
-- 2. In the left Object Explorer tree, expand 'Servers' -> 'PostgreSQL'.
-- 3. Right-click 'Databases' -> select 'Create' -> click 'Database...'.
-- 4. In the 'Database' field, type: inventory_db
-- 5. Click the 'Save' button.
-- 6. In the left tree, select/click on 'inventory_db'.
-- 7. From the top menu, click 'Tools' -> 'Query Tool' (or right-click 'inventory_db' -> 'Query Tool').
-- 8. Open this 'schema.sql' file using the Folder icon, or copy and paste all the SQL below.
-- 9. Click the 'Execute' button (the Play triangle icon / F5).
-- 10. Check the 'Data Output' tab at the bottom: "Query returned successfully".
-- ============================================================

DROP TABLE IF EXISTS products;

CREATE TABLE products (
    product_id BIGSERIAL PRIMARY KEY,
    product_name VARCHAR(150) NOT NULL,
    category VARCHAR(100) NOT NULL,
    brand VARCHAR(100) NOT NULL,
    description TEXT,
    price NUMERIC(10, 2) NOT NULL,
    quantity INT NOT NULL,
    supplier_name VARCHAR(150) NOT NULL,
    manufacturing_date DATE NOT NULL,
    expiry_date DATE NOT NULL
);

-- Insert Sample Products
INSERT INTO products (product_name, category, brand, description, price, quantity, supplier_name, manufacturing_date, expiry_date) VALUES
('Wireless Noise-Cancelling Headphones', 'Electronics', 'Sony', 'Premium over-ear wireless headphones with active noise cancellation', 299.99, 45, 'Global Tech Distributors', '2024-01-15', '2027-01-15'),
('Organic Green Tea Bags (100 pack)', 'Groceries', 'Lipton', 'Pure organic green tea leaves packed in eco-friendly bags', 14.50, 120, 'Nature Leaf Suppliers', '2024-06-01', '2026-06-01'),
('Ergonomic Office Chair', 'Furniture', 'Herman Miller', 'Adjustable lumbar support ergonomic mesh desk chair', 450.00, 18, 'Apex Office Supplies', '2023-11-20', '2033-11-20'),
('Stainless Steel Water Bottle 1L', 'Kitchenware', 'Hydro Flask', 'Vacuum insulated stainless steel water bottle keeps drinks cold 24 hrs', 34.95, 80, 'Pure Hydration Ltd', '2024-03-10', '2030-03-10'),
('Multi-Surface Disinfectant Spray', 'Household', 'Lysol', 'Antibacterial surface disinfectant spray 500ml', 6.99, 200, 'Hygiene First Co.', '2024-02-01', '2026-02-01');
