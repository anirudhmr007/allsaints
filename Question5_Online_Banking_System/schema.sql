-- ============================================================
-- QUESTION 5: ONLINE BANKING SYSTEM
-- DATABASE SETUP SCRIPT FOR PGADMIN 4
-- ============================================================
-- 
-- STEP-BY-STEP PGADMIN INSTRUCTIONS:
-- 1. Open pgAdmin 4 and enter your master password to connect.
-- 2. In the left Object Explorer tree, expand 'Servers' -> 'PostgreSQL'.
-- 3. Right-click 'Databases' -> select 'Create' -> click 'Database...'.
-- 4. In the 'Database' field, type: banking_db
-- 5. Click the 'Save' button.
-- 6. In the left tree, select/click on 'banking_db'.
-- 7. From the top menu, click 'Tools' -> 'Query Tool' (or right-click 'banking_db' -> 'Query Tool').
-- 8. Open this 'schema.sql' file using the Folder icon, or copy and paste all the SQL below.
-- 9. Click the 'Execute' button (the Play triangle icon / F5).
-- 10. Check the 'Data Output' tab at the bottom: "Query returned successfully".
-- ============================================================

DROP TABLE IF EXISTS bank_accounts;

CREATE TABLE bank_accounts (
    account_id BIGSERIAL PRIMARY KEY,
    account_number VARCHAR(30) NOT NULL UNIQUE,
    customer_name VARCHAR(100) NOT NULL,
    age INT NOT NULL,
    gender VARCHAR(10) NOT NULL,
    contact_number VARCHAR(15) NOT NULL,
    email VARCHAR(100) NOT NULL,
    address VARCHAR(255) NOT NULL,
    account_type VARCHAR(50) NOT NULL,
    account_balance NUMERIC(14, 2) NOT NULL DEFAULT 0.00
);

-- Insert Sample Customer Bank Accounts
INSERT INTO bank_accounts (account_number, customer_name, age, gender, contact_number, email, address, account_type, account_balance) VALUES
('ACC1000101', 'Arthur Morgan', 36, 'Male', '9870001111', 'arthur.morgan@bank.com', '100 Blackwater Ridge, Dallas', 'Savings', 12500.50),
('ACC1000102', 'Sadie Adler', 31, 'Female', '9870002222', 'sadie.adler@bank.com', '45 Valentine Ranch, Austin', 'Current', 45000.00),
('ACC1000103', 'John Marston', 34, 'Male', '9870003333', 'john.marston@bank.com', '78 Beecher Hope, Denver', 'Savings', 8200.75),
('ACC1000104', 'Abigail Roberts', 32, 'Female', '9870004444', 'abigail.roberts@bank.com', '12 Rhodes Court, Atlanta', 'Fixed Deposit', 65000.00),
('ACC1000105', 'Charles Smith', 29, 'Male', '9870005555', 'charles.smith@bank.com', '99 Wapiti Trail, Helena', 'Savings', 15400.20);
