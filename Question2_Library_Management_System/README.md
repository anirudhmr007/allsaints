# Question 2: Library Management System

A production-grade web application built using **Spring Boot MVC**, **Spring Data JPA**, **Hibernate**, **JSP**, and **PostgreSQL**.

---

## 📋 Table of Contents
1. [Overview & Features](#overview--features)
2. [MVC Architecture](#mvc-architecture)
3. [Prerequisites](#prerequisites)
4. [PostgreSQL Database Setup](#postgresql-database-setup)
5. [Configuration](#configuration)
6. [How to Run the Application](#how-to-run-the-application)
7. [Endpoints & Operations](#endpoints--operations)
8. [Sample Test Data](#sample-test-data)

---

## 📚 Overview & Features
This application manages book inventories and catalogue records for a library:
- **Add New Book**: Captures BookID (auto-generated), Title, Author, Publisher, ISBN (unique), Edition, Publication Year, Category, and Available Copies.
- **Display Books**: Shows all available books in an interactive JSP table with real-time stock indicators.
- **Search Book**: Search records instantly by Book ID or filter by Title.
- **Update Book**: Full edit interface to update book details, editions, and stock counts.
- **Delete Book**: Remove book records by Book ID with confirmation prompt.

---

## 🏛 MVC Architecture
```
Question2_Library_Management_System/
├── pom.xml
├── schema.sql
├── README.md
└── src/
    └── main/
        ├── java/com/example/library/
        │   ├── LibraryApplication.java          # Spring Boot Main Class & Servlet Initializer
        │   ├── entity/Book.java                 # JPA Entity mapped to 'books' table
        │   ├── repository/BookRepository.java   # Spring Data JPA Repository
        │   ├── service/BookService.java         # Service layer with transaction management
        │   └── controller/BookController.java   # Spring MVC Controller handling actions
        ├── resources/
        │   └── application.properties           # PostgreSQL datasource & JSP view config
        └── webapp/WEB-INF/jsp/
            ├── book-list.jsp                    # JSP table view & search bar
            ├── book-form.jsp                    # JSP form for adding & editing books
            └── book-view.jsp                    # JSP single book details view
```

---

## ⚙ Prerequisites
- **JDK 17 or higher** (JDK 17, 21, or 25)
- **PostgreSQL 12+** running locally on port 5432
- **Maven 3.8+** (or IDE built-in Maven)

---

## 🗄 PostgreSQL Database Setup
1. Open PostgreSQL terminal:
   ```bash
   psql -U postgres
   ```
2. Create database:
   ```sql
   CREATE DATABASE library_db;
   ```
3. Run the schema and initial data:
   ```bash
   \c library_db;
   \i schema.sql;
   ```

---

## 🔧 Configuration (`application.properties`)
```properties
server.port=8082
spring.datasource.url=jdbc:postgresql://localhost:5432/library_db
spring.datasource.username=postgres
spring.datasource.password=postgres
spring.jpa.hibernate.ddl-auto=update
spring.mvc.view.prefix=/WEB-INF/jsp/
spring.mvc.view.suffix=.jsp
```

---

## 🚀 How to Run the Application

### Option A: Using Maven CLI
```bash
cd Question2_Library_Management_System
mvn clean spring-boot:run
```
Visit: `http://localhost:8082/books/list`

### Option B: Using IntelliJ / Eclipse / VS Code
1. Open the project folder `Question2_Library_Management_System`.
2. Locate `src/main/java/com/example/library/LibraryApplication.java`.
3. Run the `main` method.
4. Access `http://localhost:8082/` in your browser.

---

## 🌐 Endpoints & Operations

| Operation | HTTP Method | URL | Description |
|-----------|-------------|-----|-------------|
| Display Books | `GET` | `/books/list` or `/` | Show all books in a JSP table |
| Add Book Form | `GET` | `/books/new` | Display add book form |
| Save Book | `POST` | `/books/new` | Persist new book in PostgreSQL |
| Search Book | `GET` | `/books/search?bookId=1` | Search book by Book ID |
| View Book Details | `GET` | `/books/view/{id}` | View full book specifications |
| Edit Book Form | `GET` | `/books/edit/{id}` | Edit book form prefilled |
| Update Book | `POST` | `/books/update/{id}` | Save updated book information |
| Delete Book | `GET` | `/books/delete/{id}` | Delete book record by Book ID |

---

## 🧪 Sample Test Data
| BookID | Title | Author | Publisher | ISBN | Edition | Year | Category | Copies |
|--------|-------|--------|-----------|------|---------|------|----------|--------|
| 1 | Clean Code | Robert C. Martin | Prentice Hall | 978-0132350884 | 1st Edition | 2008 | Computer Science | 12 |
| 2 | Introduction to Algorithms | Thomas H. Cormen | MIT Press | 978-0262033848 | 3rd Edition | 2009 | Algorithms | 7 |
| 3 | Effective Java | Joshua Bloch | Addison-Wesley | 978-0134685991 | 3rd Edition | 2017 | Programming | 15 |
