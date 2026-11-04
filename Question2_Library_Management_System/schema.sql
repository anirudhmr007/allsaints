-- ============================================================
-- QUESTION 2: LIBRARY MANAGEMENT SYSTEM
-- DATABASE SETUP SCRIPT FOR PGADMIN 4
-- ============================================================
-- 
-- STEP-BY-STEP PGADMIN INSTRUCTIONS:
-- 1. Open pgAdmin 4 and enter your master password to connect.
-- 2. In the left Object Explorer tree, expand 'Servers' -> 'PostgreSQL'.
-- 3. Right-click 'Databases' -> select 'Create' -> click 'Database...'.
-- 4. In the 'Database' field, type: library_db
-- 5. Click the 'Save' button.
-- 6. In the left tree, select/click on 'library_db'.
-- 7. From the top menu, click 'Tools' -> 'Query Tool' (or right-click 'library_db' -> 'Query Tool').
-- 8. Open this 'schema.sql' file using the Folder icon, or copy and paste all the SQL below.
-- 9. Click the 'Execute' button (the Play triangle icon / F5).
-- 10. Check the 'Data Output' tab at the bottom: "Query returned successfully".
-- ============================================================

DROP TABLE IF EXISTS books;

CREATE TABLE books (
    book_id BIGSERIAL PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    author VARCHAR(150) NOT NULL,
    publisher VARCHAR(150) NOT NULL,
    isbn VARCHAR(30) NOT NULL UNIQUE,
    edition VARCHAR(50) NOT NULL,
    publication_year INT NOT NULL,
    category VARCHAR(100) NOT NULL,
    available_copies INT NOT NULL DEFAULT 0
);

-- Insert Sample Books
INSERT INTO books (title, author, publisher, isbn, edition, publication_year, category, available_copies) VALUES
('Clean Code', 'Robert C. Martin', 'Prentice Hall', '978-0132350884', '1st Edition', 2008, 'Computer Science', 12),
('Introduction to Algorithms', 'Thomas H. Cormen', 'MIT Press', '978-0262033848', '3rd Edition', 2009, 'Algorithms', 7),
('Effective Java', 'Joshua Bloch', 'Addison-Wesley', '978-0134685991', '3rd Edition', 2017, 'Programming', 15),
('Design Patterns', 'Erich Gamma et al.', 'Addison-Wesley', '978-0201633610', '1st Edition', 1994, 'Software Engineering', 5),
('Spring in Action', 'Craig Walls', 'Manning Publications', '978-1617294945', '6th Edition', 2022, 'Frameworks', 10);
