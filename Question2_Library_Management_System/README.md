# Question 2: Library Management System
### GUI Execution Guide for Spring Tools 4 for Eclipse (STS) & pgAdmin 4

A full-stack enterprise web application built using **Spring Boot MVC**, **Spring Data JPA**, **Hibernate**, **JSP**, and **PostgreSQL**.

---

## 📋 Table of Contents
1. [Overview & Features](#overview--features)
2. [MVC Architecture](#mvc-architecture)
3. [pgAdmin 4 Database Setup (No Terminal Needed)](#-pgadmin-4-database-setup-no-terminal-needed)
4. [Spring Tools 4 for Eclipse (STS) Execution Guide](#-spring-tools-4-for-eclipse-sts-execution-guide)
5. [Endpoints & Operations](#endpoints--operations)
6. [Sample Test Data](#sample-test-data)

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

## 🐘 pgAdmin 4 Database Setup (No Terminal Needed)

Follow these simple GUI steps in **pgAdmin 4**:

### Step 1: Create Database in pgAdmin
1. Open **pgAdmin 4** on your laptop and log in.
2. In the left **Object Explorer**, expand **Servers** -> **PostgreSQL**.
3. **Right-click** on **Databases** -> select **Create** -> click **Database...**.
4. In the dialog, enter:
   - **Database**: `library_db`
5. Click **Save**.

### Step 2: Execute `schema.sql` in pgAdmin
1. In the left tree, click on `library_db`.
2. From the top toolbar, click **Tools** -> **Query Tool** (or right-click `library_db` -> **Query Tool**).
3. Click the **Open File** icon (Folder icon) on the toolbar and open:
   `C:\WIPRO_SAMPLES\Question2_Library_Management_System\schema.sql`
   *(Or copy and paste the SQL content from `schema.sql` into the Query Tool).*
4. Click the **Execute** button (Play triangle icon or press **F5**).
5. The message **"Query returned successfully"** confirms table creation and initial seed data.

---

## 🍃 Spring Tools 4 for Eclipse (STS) Execution Guide

### Step 1: Import Project into STS
1. Open **Spring Tools 4 for Eclipse (STS)**.
2. Go to **File** -> **Import...**.
3. Select **Maven** -> **Existing Maven Projects** -> click **Next**.
4. Click **Browse...** for **Root Directory** and select:
   `C:\WIPRO_SAMPLES\Question2_Library_Management_System`
5. Confirm the checkbox for `/pom.xml` is checked, then click **Finish**.
6. Wait for Maven dependency resolution in the bottom-right progress bar.

### Step 2: Verify / Update Database Password
1. In STS **Package Explorer**, expand:
   `Question2_Library_Management_System` -> `src/main/resources`
2. Double-click `application.properties`:
   ```properties
   server.port=8082
   spring.datasource.url=jdbc:postgresql://localhost:5432/library_db
   spring.datasource.username=postgres
   spring.datasource.password=postgres
   ```
3. If your pgAdmin password is different, adjust `spring.datasource.password` and save (**Ctrl + S**).

### Step 3: Run the Application in STS
- **Method A**: Right-click `Question2_Library_Management_System` in Package Explorer -> **Run As** -> **1 Spring Boot App**.
- **Method B**: In the **Boot Dashboard** (bottom-left), find `library-management` and click the green **(Re)start** button.

### Step 4: Verify in Console
In the **Console** view, you will see:
```text
Tomcat started on port 8082 (http) with context path '/'
Started LibraryApplication in X.XXX seconds
```

### Step 5: Test in Browser
Open your browser and navigate to:
👉 **[http://localhost:8082/books/list](http://localhost:8082/books/list)**

### Step 6: Stop App
Click the red square **Terminate** button in the Console or the **Stop** button in Boot Dashboard.

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
