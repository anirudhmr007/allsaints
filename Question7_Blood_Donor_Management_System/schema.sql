-- ============================================================
-- Database: blood_donor_db
-- Run in psql or pgAdmin:
-- CREATE DATABASE blood_donor_db;
-- \c blood_donor_db;
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
