# Question 8: Pharmacy Management System
### GUI Execution Guide for Spring Tools 4 for Eclipse (STS) & pgAdmin 4

A full-stack enterprise web application built using **Spring Boot MVC**, **Spring Data JPA**, **Hibernate**, **JSP**, and **PostgreSQL**.

---

## 📋 Table of Contents
1. [Overview & Features](#overview--features)
2. [MVC Architecture](#mvc-architecture)
3. [pgAdmin 4 Database Setup (No Terminal Needed)](#-pgadmin-4-database-setup-no-terminal-needed)
4. [Spring Tools 4 for Eclipse (STS) Execution Guide](#-spring-tools-4-for-eclipse-sts-execution-guide)
5. [Endpoints & Operations](#endpoints--operations)
6. [Business Validation Rules](#business-validation-rules)
7. [Sample Test Data](#sample-test-data)

---

## 💊 Overview & Features
This application tracks dispensary medicine inventory, batch dates, suppliers, and expiration statuses:
- **Add New Medicine**: Add medicine details with MedicineID, Medicine Name, Category, Manufacturer, Batch Number, Price, Quantity, Manufacturing Date, Expiry Date, and Supplier Name.
- **View All Medicines**: Display all available medicines in a JSP table with stock badges and expiry indicators.
- **Search Medicines**: Find medicines using either numeric **Medicine ID** or **Medicine Name** query.
- **Update Medicine Details**: Modify existing batch quantities, unit prices, or dates.
- **Delete Medicine**: Remove records using Medicine ID.
- **Safety Validation**:
  - Automatically identifies and flags expired medicines with high-visibility red alerts.
  - Strictly prevents negative stock quantities (`quantity >= 0`).

---

## 🏛 MVC Architecture
```
Question8_Pharmacy_Management_System/
├── pom.xml
├── schema.sql
├── README.md
└── src/
    └── main/
        ├── java/com/example/pharmacy/
        │   ├── PharmacyApplication.java           # Main Spring Boot Runner
        │   ├── entity/Medicine.java               # JPA Entity for 'medicines' table
        │   ├── repository/MedicineRepository.java # JPA Repository
        │   ├── service/MedicineService.java       # Service with negative stock & expiry logic
        │   └── controller/MedicineController.java # MVC Controller
        ├── resources/
        │   └── application.properties             # Port 8088, DB, & JSP config
        └── webapp/WEB-INF/jsp/
            ├── medicine-list.jsp                  # Formulary table with expired warnings & search
            └── medicine-form.jsp                  # Simple medicine registration & edit form
```

---

## 🐘 pgAdmin 4 Database Setup (No Terminal Needed)

### Step 1: Create Database in pgAdmin
1. Open **pgAdmin 4** on your laptop and log in.
2. In the left **Object Explorer**, expand **Servers** -> **PostgreSQL**.
3. **Right-click** on **Databases** -> select **Create** -> click **Database...**.
4. In the dialog, set:
   - **Database**: `pharmacy_db`
5. Click **Save**.

### Step 2: Execute `schema.sql` in pgAdmin
1. In the left tree, select `pharmacy_db`.
2. From the top toolbar, click **Tools** -> **Query Tool** (or right-click `pharmacy_db` -> **Query Tool**).
3. Click the **Open File** icon (Folder icon) on the toolbar and open:
   `C:\WIPRO_SAMPLES\Question8_Pharmacy_Management_System\schema.sql`
   *(Or copy and paste the SQL content from `schema.sql` directly).*
4. Click the **Execute** button (Play triangle icon or press **F5**).
5. The message **"Query returned successfully"** indicates tables and initial medicines are ready.

---

## 🍃 Spring Tools 4 for Eclipse (STS) Execution Guide

### Step 1: Import Project into STS
1. Open **Spring Tools 4 for Eclipse (STS)**.
2. Click **File** -> **Import...**.
3. Select **Maven** -> **Existing Maven Projects** -> click **Next**.
4. Click **Browse...** for **Root Directory** and select:
   `C:\WIPRO_SAMPLES\Question8_Pharmacy_Management_System`
5. Ensure `/pom.xml` is checked, then click **Finish**.
6. Wait for Maven build to complete.

### Step 2: Verify / Update Database Password
1. In STS **Package Explorer**, expand:
   `Question8_Pharmacy_Management_System` -> `src/main/resources`
2. Double-click `application.properties`:
   ```properties
   server.port=8088
   spring.datasource.url=jdbc:postgresql://localhost:5432/pharmacy_db
   spring.datasource.username=postgres
   spring.datasource.password=postgres
   ```
3. Update `spring.datasource.password` if your pgAdmin password is different, and save (**Ctrl + S**).

### Step 3: Run the Application in STS
- **Method A**: Right-click `Question8_Pharmacy_Management_System` in Package Explorer -> **Run As** -> **1 Spring Boot App**.
- **Method B**: In the **Boot Dashboard** view, locate `pharmacy-management-system` and click the green **(Re)start** play icon.

### Step 4: Verify in Console
The **Console** view will log:
```text
Tomcat started on port 8088 (http) with context path '/'
Started PharmacyApplication in X.XXX seconds
```

### Step 5: Test in Browser
Open your browser and visit:
👉 **[http://localhost:8088/medicines/list](http://localhost:8088/medicines/list)**

### Step 6: Stop App
Click the red square **Terminate** button in the Console or the **Stop** button in Boot Dashboard.

---

## 🛡 Business Validation Rules
1. **Prevent Negative Stock Quantities**:
   - The stock quantity is constrained with `@Min(0)` and service-level checks.
   - Negative values are rejected:
     `"Validation Error: Negative stock quantities are strictly prohibited. Quantity must be 0 or more."`
2. **Identification of Expired Medicines**:
   - The system checks whether `expiryDate.isBefore(LocalDate.now())`.
   - Expired medicines are visually highlighted with a red warning badge in the table and display an explicit **EXPIRED BATCH** safety alert in the detailed view.
   - A global safety alert banner warns the pharmacist how many expired batches are currently in the system.
3. **Date Sequence Integrity**:
   - Expiry date cannot precede the manufacturing date.

---

## 🌐 Endpoints & Operations

| Operation | HTTP Method | URL | Description |
|-----------|-------------|-----|-------------|
| View All Medicines | `GET` | `/` or `/medicines` or `/medicines/list` | Formularies table with expired batch alerts |
| Add Medicine Form | `GET` | `/medicines/add` | Open simple formulation form |
| Save / Update Medicine | `POST` | `/medicines/save` | Save new or updated medicine in PostgreSQL |
| Search Medicines | `GET` | `/medicines/search?keyword=Amoxicillin` | Search by Medicine ID or Name |
| Edit Medicine Form | `GET` | `/medicines/edit/{id}` | Edit formulation details |
| Delete Medicine | `GET` | `/medicines/delete/{id}` | Remove medicine record by ID |

---

## 🧪 Sample Test Data
| MedicineID | Medicine Name | Category | Manufacturer | Batch No | Price | Qty | Expiry Date | Status |
|------------|---------------|----------|--------------|----------|-------|-----|-------------|--------|
| 1 | Amoxicillin 500mg | Antibiotic | Pfizer Inc. | BATCH-AMX-2024 | $12.50 | 150 | 2026-01-10 | Valid Stock |
| 2 | Paracetamol 650mg | Analgesic | GSK Pharma | BATCH-PCM-2024 | $4.25 | 300 | 2027-03-01 | Valid Stock |
| 5 | Insulin Glargine 100IU | Antidiabetic | Sanofi | BATCH-INS-2022 | $45.00 | 15 | 2023-01-15 | **EXPIRED** |
