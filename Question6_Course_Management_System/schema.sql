-- ============================================================
-- QUESTION 6: COURSE MANAGEMENT SYSTEM
-- DATABASE SETUP SCRIPT FOR PGADMIN 4
-- ============================================================
-- 
-- STEP-BY-STEP PGADMIN INSTRUCTIONS:
-- 1. Open pgAdmin 4 and enter your master password to connect.
-- 2. In the left Object Explorer tree, expand 'Servers' -> 'PostgreSQL'.
-- 3. Right-click 'Databases' -> select 'Create' -> click 'Database...'.
-- 4. In the 'Database' field, type: course_db
-- 5. Click the 'Save' button.
-- 6. In the left tree, select/click on 'course_db'.
-- 7. From the top menu, click 'Tools' -> 'Query Tool' (or right-click 'course_db' -> 'Query Tool').
-- 8. Open this 'schema.sql' file using the Folder icon, or copy and paste all the SQL below.
-- 9. Click the 'Execute' button (the Play triangle icon / F5).
-- 10. Check the 'Data Output' tab at the bottom: "Query returned successfully".
-- ============================================================

DROP TABLE IF EXISTS course_registrations;
DROP TABLE IF EXISTS courses;

CREATE TABLE courses (
    course_id BIGSERIAL PRIMARY KEY,
    course_code VARCHAR(30) NOT NULL UNIQUE,
    course_name VARCHAR(150) NOT NULL,
    department VARCHAR(100) NOT NULL,
    faculty_name VARCHAR(100) NOT NULL,
    credits INT NOT NULL,
    semester VARCHAR(30) NOT NULL,
    course_capacity INT NOT NULL
);

CREATE TABLE course_registrations (
    registration_id BIGSERIAL PRIMARY KEY,
    course_id BIGINT NOT NULL REFERENCES courses(course_id) ON DELETE CASCADE,
    student_id VARCHAR(50) NOT NULL,
    student_name VARCHAR(100) NOT NULL,
    student_email VARCHAR(100) NOT NULL,
    registration_date DATE NOT NULL,
    CONSTRAINT unique_course_student UNIQUE(course_id, student_id)
);

-- Insert Sample Courses
INSERT INTO courses (course_code, course_name, department, faculty_name, credits, semester, course_capacity) VALUES
('CS101', 'Introduction to Computer Science', 'Computer Science', 'Dr. Alan Turing', 4, 'Semester 1', 3),
('CS201', 'Data Structures & Algorithms', 'Computer Science', 'Dr. Donald Knuth', 4, 'Semester 3', 30),
('MATH101', 'Linear Algebra & Calculus', 'Mathematics', 'Dr. Carl Gauss', 3, 'Semester 1', 25),
('EE105', 'Digital Logic & Circuit Design', 'Electrical Engineering', 'Dr. Claude Shannon', 4, 'Semester 2', 20),
('AI301', 'Artificial Intelligence & Deep Learning', 'Computer Science', 'Dr. Geoffrey Hinton', 4, 'Semester 5', 2);

-- Insert Sample Student Registrations (CS101 has 2/3 enrolled, AI301 has 2/2 full)
INSERT INTO course_registrations (course_id, student_id, student_name, student_email, registration_date) VALUES
(1, 'STU001', 'Alice Vance', 'alice.vance@university.edu', '2024-08-01'),
(1, 'STU002', 'Bob Vance', 'bob.vance@university.edu', '2024-08-02'),
(5, 'STU003', 'Charlie Day', 'charlie.day@university.edu', '2024-08-01'),
(5, 'STU004', 'Dennis Reynolds', 'dennis.reynolds@university.edu', '2024-08-02');
