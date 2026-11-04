-- ============================================================
-- Database: library_db
-- Run in psql or pgAdmin:
-- CREATE DATABASE library_db;
-- \c library_db;
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
