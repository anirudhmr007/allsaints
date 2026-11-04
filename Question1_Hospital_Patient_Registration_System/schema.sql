-- ============================================================
-- QUESTION 1: HOSPITAL PATIENT REGISTRATION SYSTEM
-- DATABASE SETUP SCRIPT FOR PGADMIN 4
-- ============================================================
-- 
-- STEP-BY-STEP PGADMIN INSTRUCTIONS:
-- 1. Open pgAdmin 4 and enter your master password to connect.
-- 2. In the left Object Explorer tree, expand 'Servers' -> 'PostgreSQL'.
-- 3. Right-click 'Databases' -> select 'Create' -> click 'Database...'.
-- 4. In the 'Database' field, type: hospital_db
-- 5. Click the 'Save' button.
-- 6. In the left tree, select/click on 'hospital_db'.
-- 7. From the top menu, click 'Tools' -> 'Query Tool' (or right-click 'hospital_db' -> 'Query Tool').
-- 8. Open this 'schema.sql' file using the Folder icon, or copy and paste all the SQL below.
-- 9. Click the 'Execute' button (the Play triangle icon / F5).
-- 10. Check the 'Data Output' tab at the bottom: "Query returned successfully".
-- ============================================================

DROP TABLE IF EXISTS patients;

CREATE TABLE patients (
    patient_id BIGSERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    age INT NOT NULL,
    gender VARCHAR(10) NOT NULL,
    contact_number VARCHAR(15) NOT NULL,
    email VARCHAR(100) NOT NULL,
    address VARCHAR(255) NOT NULL,
    blood_group VARCHAR(10) NOT NULL
);

-- Insert Initial Sample Records
INSERT INTO patients (name, age, gender, contact_number, email, address, blood_group) VALUES
('John Doe', 35, 'Male', '9876543210', 'john.doe@example.com', '123 Baker Street, London', 'O+'),
('Jane Smith', 28, 'Female', '9876543211', 'jane.smith@example.com', '45 Elm Street, Springfield', 'A+'),
('Robert Brown', 52, 'Male', '9876543212', 'robert.brown@example.com', '789 Pine Road, Manchester', 'B+'),
('Emily Davis', 22, 'Female', '9876543213', 'emily.davis@example.com', '12 Maple Avenue, Bristol', 'AB+'),
('Michael Wilson', 45, 'Male', '9876543214', 'michael.wilson@example.com', '99 Oak Lane, Leeds', 'O-');
