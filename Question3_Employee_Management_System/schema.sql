-- ============================================================
-- Database: employee_db
-- Run in psql or pgAdmin:
-- CREATE DATABASE employee_db;
-- \c employee_db;
-- ============================================================

DROP TABLE IF EXISTS employees;

CREATE TABLE employees (
    employee_id BIGSERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    age INT NOT NULL,
    gender VARCHAR(10) NOT NULL,
    contact_number VARCHAR(15) NOT NULL,
    email VARCHAR(100) NOT NULL,
    address VARCHAR(255) NOT NULL,
    department VARCHAR(100) NOT NULL,
    designation VARCHAR(100) NOT NULL,
    date_of_joining DATE NOT NULL,
    salary NUMERIC(12, 2) NOT NULL
);

-- Insert Sample Employees
INSERT INTO employees (name, age, gender, contact_number, email, address, department, designation, date_of_joining, salary) VALUES
('Alexander Wright', 32, 'Male', '9811223344', 'alexander.wright@company.com', '10 Wall Street, New York', 'Engineering', 'Senior Software Engineer', '2021-03-15', 95000.00),
('Sarah Jenkins', 29, 'Female', '9822334455', 'sarah.jenkins@company.com', '45 Sunset Blvd, Los Angeles', 'Human Resources', 'HR Manager', '2020-07-01', 75000.00),
('David Kumar', 38, 'Male', '9833445566', 'david.kumar@company.com', '78 Silicon Avenue, Austin', 'Product', 'Principal Product Manager', '2019-01-10', 120000.00),
('Elena Rostova', 26, 'Female', '9844556677', 'elena.rostova@company.com', '21 Market Street, Chicago', 'Finance', 'Financial Analyst', '2023-05-20', 68000.00),
('Marcus Brody', 45, 'Male', '9855667788', 'marcus.brody@company.com', '89 Broadway, Seattle', 'Operations', 'Operations Director', '2017-11-05', 135000.00);
