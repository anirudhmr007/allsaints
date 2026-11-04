-- ============================================================
-- QUESTION 8: PHARMACY MANAGEMENT SYSTEM
-- DATABASE SETUP SCRIPT FOR PGADMIN 4
-- ============================================================
-- 
-- STEP-BY-STEP PGADMIN INSTRUCTIONS:
-- 1. Open pgAdmin 4 and enter your master password to connect.
-- 2. In the left Object Explorer tree, expand 'Servers' -> 'PostgreSQL'.
-- 3. Right-click 'Databases' -> select 'Create' -> click 'Database...'.
-- 4. In the 'Database' field, type: pharmacy_db
-- 5. Click the 'Save' button.
-- 6. In the left tree, select/click on 'pharmacy_db'.
-- 7. From the top menu, click 'Tools' -> 'Query Tool' (or right-click 'pharmacy_db' -> 'Query Tool').
-- 8. Open this 'schema.sql' file using the Folder icon, or copy and paste all the SQL below.
-- 9. Click the 'Execute' button (the Play triangle icon / F5).
-- 10. Check the 'Data Output' tab at the bottom: "Query returned successfully".
-- ============================================================

DROP TABLE IF EXISTS medicines;

CREATE TABLE medicines (
    medicine_id BIGSERIAL PRIMARY KEY,
    medicine_name VARCHAR(150) NOT NULL,
    category VARCHAR(100) NOT NULL,
    manufacturer VARCHAR(150) NOT NULL,
    batch_number VARCHAR(50) NOT NULL,
    price NUMERIC(10, 2) NOT NULL,
    quantity INT NOT NULL,
    manufacturing_date DATE NOT NULL,
    expiry_date DATE NOT NULL,
    supplier_name VARCHAR(150) NOT NULL
);

-- Insert Sample Medicines (Includes active stock and expired medicine for validation testing)
INSERT INTO medicines (medicine_name, category, manufacturer, batch_number, price, quantity, manufacturing_date, expiry_date, supplier_name) VALUES
('Amoxicillin 500mg', 'Antibiotic', 'Pfizer Inc.', 'BATCH-AMX-2024', 12.50, 150, '2024-01-10', '2026-01-10', 'MedGlobal Logistics'),
('Paracetamol 650mg', 'Analgesic / Antipyretic', 'GSK Pharma', 'BATCH-PCM-2024', 4.25, 300, '2024-03-01', '2027-03-01', 'Apex Health Care Supplies'),
('Azithromycin 250mg', 'Antibiotic', 'Novartis', 'BATCH-AZM-2023', 18.00, 80, '2023-05-15', '2025-05-15', 'MedGlobal Logistics'),
('Cetirizine 10mg', 'Antihistamine', 'Sun Pharma', 'BATCH-CTZ-2024', 6.75, 200, '2024-02-12', '2026-08-12', 'Universal Drug Hub'),
('Insulin Glargine 100IU', 'Antidiabetic', 'Sanofi', 'BATCH-INS-2022', 45.00, 15, '2022-01-15', '2023-01-15', 'ColdChain Pharma Supplies');
