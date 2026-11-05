# Question 3: Employee Management System
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
            ├── employee-list.jsp                  # Directory view & search
            └── employee-form.jsp                  # Simple Registration & Edit form
```

---

## 🐘 pgAdmin 4 Database Setup (No Terminal Needed)

### Step 1: Create Database in pgAdmin
1. Open **pgAdmin 4** on your laptop and log in.
2. In the left **Object Explorer**, expand **Servers** -> **PostgreSQL**.
3. **Right-click** on **Databases** -> select **Create** -> click **Database...**.
4. In the dialog, set:
   - **Database**: `employee_db`
5. Click **Save**.

### Step 2: Execute `schema.sql` in pgAdmin
1. In the left tree, select `employee_db`.
2. From the top toolbar, click **Tools** -> **Query Tool** (or right-click `employee_db` -> **Query Tool**).
3. Click the **Open File** icon (Folder icon) on the toolbar and open:
   `C:\WIPRO_SAMPLES\Question3_Employee_Management_System\schema.sql`
   *(Or copy and paste the SQL content from `schema.sql` directly).*
4. Click the **Execute** button (Play triangle icon or press **F5**).
5. The message **"Query returned successfully"** indicates tables and initial employee records are ready.

---

## 🍃 Spring Tools 4 for Eclipse (STS) Execution Guide

### Step 1: Import Project into STS
1. Open **Spring Tools 4 for Eclipse (STS)**.
2. Click **File** -> **Import...**.
3. Select **Maven** -> **Existing Maven Projects** -> click **Next**.
4. Click **Browse...** for **Root Directory** and select:
   `C:\WIPRO_SAMPLES\Question3_Employee_Management_System`
5. Ensure `/pom.xml` is checked, then click **Finish**.
6. Wait for Maven build to complete.

### Step 2: Verify / Update Database Password
1. In STS **Package Explorer**, expand:
   `Question3_Employee_Management_System` -> `src/main/resources`
2. Double-click `application.properties`:
   ```properties
   server.port=8083
   spring.datasource.url=jdbc:postgresql://localhost:5432/employee_db
   spring.datasource.username=postgres
   spring.datasource.password=postgres
   ```
3. Update `spring.datasource.password` if your pgAdmin password is different, and save (**Ctrl + S**).

### Step 3: Run the Application in STS
- **Method A**: Right-click `Question3_Employee_Management_System` in Package Explorer -> **Run As** -> **1 Spring Boot App**.
- **Method B**: In the **Boot Dashboard** view, locate `employee-management` and click the green **(Re)start** play icon.

### Step 4: Verify in Console
The **Console** view will log:
```text
Tomcat started on port 8083 (http) with context path '/'
Started EmployeeApplication in X.XXX seconds
```

### Step 5: Test in Browser
Open your browser and visit:
👉 **[http://localhost:8083/employees/list](http://localhost:8083/employees/list)**

### Step 6: Stop App
Click the red square **Terminate** button in the Console or the **Stop** button in Boot Dashboard.

---

## 🌐 Endpoints & Operations

| Operation | HTTP Method | URL | Description |
|-----------|-------------|-----|-------------|
| List Employees | `GET` | `/` or `/employees` or `/employees/list` | Display registered employees |
| New Employee Form | `GET` | `/employees/add` | Display simple employee registration form |
| Save / Update Employee | `POST` | `/employees/save` | Save new or updated employee in PostgreSQL |
| Search Employee | `GET` | `/employees/search?employeeId=1` | Search employee by Employee ID |
| Edit Employee Form | `GET` | `/employees/edit/{id}` | Form to modify employee |
| Delete Employee | `GET` | `/employees/delete/{id}` | Remove employee record |

---

## 🧪 Sample Test Data
| EmployeeID | Name | Department | Designation | Contact | Salary |
|------------|------|------------|-------------|---------|--------|
| 1 | Alexander Wright | Engineering | Senior Software Engineer | 9811223344 | $95,000.00 |
| 2 | Sarah Jenkins | Human Resources | HR Manager | 9822334455 | $75,000.00 |
| 3 | David Kumar | Product | Principal Product Manager | 9833445566 | $120,000.00 |
