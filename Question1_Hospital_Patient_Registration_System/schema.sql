-- ============================================================
-- Database: hospital_db
-- Run in psql or pgAdmin:
-- CREATE DATABASE hospital_db;
-- \c hospital_db;
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
