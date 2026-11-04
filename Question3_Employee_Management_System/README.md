# Question 3: Employee Management System

A production-ready Enterprise Human Resources web application built using **Spring Boot MVC**, **Spring Data JPA**, **Hibernate**, **JSP**, and **PostgreSQL**.

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

## 💼 Overview & Features
This application manages employee records and HR payroll demographics:
- **Add New Employee**: Captures EmployeeID, Name, Age (validated 18+), Gender, Contact Number (10 digits), Email, Address, Department, Designation, Date of Joining, and Salary.
- **Display Registered Employees**: Renders all staff members in a responsive JSP table with currency formatting.
- **Search Employee**: Search employee records by unique Employee ID.
- **Update Employee Details**: Edit existing employee department, salary, role, and contact data.
- **Delete Employee**: Safely remove employee profiles with confirmation dialog.

---

## 🏛 MVC Architecture
```
Question3_Employee_Management_System/
├── pom.xml
├── schema.sql
├── README.md
└── src/
    └── main/
        ├── java/com/example/employee/
        │   ├── EmployeeApplication.java           # Main Spring Boot Runner
        │   ├── entity/Employee.java               # JPA Entity for 'employees' table
        │   ├── repository/EmployeeRepository.java # JPA Repository
        │   ├── service/EmployeeService.java       # Transactional Business Service
        │   └── controller/EmployeeController.java # Web MVC Controller
        ├── resources/
        │   └── application.properties             # Port, DB, & JSP config
        └── webapp/WEB-INF/jsp/
            ├── employee-list.jsp                  # Directory view
            ├── employee-form.jsp                  # Registration/Edit form
            └── employee-view.jsp                  # Single profile view
```

---

## ⚙ Prerequisites
- **JDK 17 or higher**
- **PostgreSQL 12+**
- **Maven 3.8+**

---

## 🗄 PostgreSQL Database Setup
1. Open PostgreSQL prompt:
   ```bash
   psql -U postgres
   ```
2. Create database:
   ```sql
   CREATE DATABASE employee_db;
   ```
3. Initialize tables and data:
   ```bash
   \c employee_db;
   \i schema.sql;
   ```

---

## 🔧 Configuration (`application.properties`)
```properties
server.port=8083
spring.datasource.url=jdbc:postgresql://localhost:5432/employee_db
spring.datasource.username=postgres
spring.datasource.password=postgres
spring.jpa.hibernate.ddl-auto=update
spring.mvc.view.prefix=/WEB-INF/jsp/
spring.mvc.view.suffix=.jsp
```

---

## 🚀 How to Run the Application

### Option A: Maven CLI
```bash
cd Question3_Employee_Management_System
mvn clean spring-boot:run
```
Visit: `http://localhost:8083/employees/list`

### Option B: IDE (IntelliJ / Eclipse / VS Code)
1. Import `Question3_Employee_Management_System` as Maven Project.
2. Run `com.example.employee.EmployeeApplication`.
3. Open `http://localhost:8083/` in browser.

---

## 🌐 Endpoints & Operations

| Operation | HTTP Method | URL | Description |
|-----------|-------------|-----|-------------|
| List Employees | `GET` | `/employees/list` or `/` | Display registered employees |
| New Employee Form | `GET` | `/employees/new` | Display employee registration form |
| Save Employee | `POST` | `/employees/new` | Save new employee in PostgreSQL |
| Search Employee | `GET` | `/employees/search?employeeId=1` | Search employee by Employee ID |
| View Employee | `GET` | `/employees/view/{id}` | View detailed profile |
| Edit Employee Form | `GET` | `/employees/edit/{id}` | Form to modify employee |
| Update Employee | `POST` | `/employees/update/{id}` | Save modifications |
| Delete Employee | `GET` | `/employees/delete/{id}` | Remove employee record |

---

## 🧪 Sample Test Data
| EmployeeID | Name | Department | Designation | Contact | Salary |
|------------|------|------------|-------------|---------|--------|
| 1 | Alexander Wright | Engineering | Senior Software Engineer | 9811223344 | $95,000.00 |
| 2 | Sarah Jenkins | Human Resources | HR Manager | 9822334455 | $75,000.00 |
| 3 | David Kumar | Product | Principal Product Manager | 9833445566 | $120,000.00 |
