-- ============================================================
-- QUESTION 7: BLOOD DONOR MANAGEMENT SYSTEM
-- DATABASE SETUP SCRIPT FOR PGADMIN 4
-- ============================================================
-- 
-- STEP-BY-STEP PGADMIN INSTRUCTIONS:
-- 1. Open pgAdmin 4 and enter your master password to connect.
-- 2. In the left Object Explorer tree, expand 'Servers' -> 'PostgreSQL'.
-- 3. Right-click 'Databases' -> select 'Create' -> click 'Database...'.
-- 4. In the 'Database' field, type: blood_donor_db
-- 5. Click the 'Save' button.
-- 6. In the left tree, select/click on 'blood_donor_db'.
-- 7. From the top menu, click 'Tools' -> 'Query Tool' (or right-click 'blood_donor_db' -> 'Query Tool').
-- 8. Open this 'schema.sql' file using the Folder icon, or copy and paste all the SQL below.
-- 9. Click the 'Execute' button (the Play triangle icon / F5).
-- 10. Check the 'Data Output' tab at the bottom: "Query returned successfully".
-- ============================================================

DROP TABLE IF EXISTS blood_donors;

CREATE TABLE blood_donors (
    donor_id BIGSERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    age INT NOT NULL,
    gender VARCHAR(10) NOT NULL,
    blood_group VARCHAR(10) NOT NULL,
    contact_number VARCHAR(15) NOT NULL,
    email VARCHAR(100) NOT NULL,
    address VARCHAR(255) NOT NULL,
    last_donation_date DATE,
    health_status VARCHAR(50) NOT NULL
);

-- Insert Sample Blood Donors
INSERT INTO blood_donors (name, age, gender, blood_group, contact_number, email, address, last_donation_date, health_status) VALUES
('Liam Hemsworth', 28, 'Male', 'O+', '9812345678', 'liam.h@bloodbank.org', '42 High St, Boston', '2024-01-15', 'Fit'),
('Emma Watson', 24, 'Female', 'A+', '9823456789', 'emma.w@bloodbank.org', '18 Cambridge Rd, Boston', '2024-05-10', 'Fit'),
('Lucas Scott', 34, 'Male', 'B-', '9834567890', 'lucas.s@bloodbank.org', '90 Riverway, Cambridge', '2024-08-20', 'Fit'),
('Sophia Turner', 19, 'Female', 'AB+', '9845678901', 'sophia.t@bloodbank.org', '33 Beacon St, Somerville', NULL, 'Fit'),
('Oliver Queen', 42, 'Male', 'O-', '9856789012', 'oliver.q@bloodbank.org', '101 Central Ave, Brookline', '2024-02-14', 'Fit'),
('Noah Miller', 17, 'Male', 'A-', '9867890123', 'noah.m@bloodbank.org', '55 Park Ave, Newton', NULL, 'Under Medication');
