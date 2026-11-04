# Question 8: Pharmacy Management System

A healthcare pharmaceutical inventory management system built with **Spring Boot MVC**, **Spring Data JPA**, **Hibernate**, **JSP**, and **PostgreSQL**.

---

## 📋 Table of Contents
1. [Overview & Features](#overview--features)
2. [MVC Architecture](#mvc-architecture)
3. [Prerequisites](#prerequisites)
4. [PostgreSQL Database Setup](#postgresql-database-setup)
5. [Configuration](#configuration)
6. [How to Run the Application](#how-to-run-the-application)
7. [Endpoints & Operations](#endpoints--operations)
8. [Business Validation Rules](#business-validation-rules)
9. [Sample Test Data](#sample-test-data)

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
            ├── medicine-list.jsp                  # Formulary table with expired warnings
            ├── medicine-form.jsp                  # Medicine registration & edit form
            └── medicine-view.jsp                  # Medicine dossier & shelf life info
```

---

## ⚙ Prerequisites
- **JDK 17 or higher**
- **PostgreSQL 12+**
- **Maven 3.8+**

---

## 🗄 PostgreSQL Database Setup
1. Open terminal:
   ```bash
   psql -U postgres
   ```
2. Create database:
   ```sql
   CREATE DATABASE pharmacy_db;
   ```
3. Load schema and initial batches:
   ```bash
   \c pharmacy_db;
   \i schema.sql;
   ```

---

## 🔧 Configuration (`application.properties`)
```properties
server.port=8088
spring.datasource.url=jdbc:postgresql://localhost:5432/pharmacy_db
spring.datasource.username=postgres
spring.datasource.password=postgres
spring.jpa.hibernate.ddl-auto=update
spring.mvc.view.prefix=/WEB-INF/jsp/
spring.mvc.view.suffix=.jsp
```

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

## 🚀 How to Run the Application

### Option A: Maven CLI
```bash
cd Question8_Pharmacy_Management_System
mvn clean spring-boot:run
```
Visit: `http://localhost:8088/medicines/list`

### Option B: IDE
1. Open `Question8_Pharmacy_Management_System` in your IDE.
2. Run `com.example.pharmacy.PharmacyApplication`.
3. Open `http://localhost:8088/` in your browser.

---

## 🌐 Endpoints & Operations

| Operation | HTTP Method | URL | Description |
|-----------|-------------|-----|-------------|
| View All Medicines | `GET` | `/medicines/list` or `/` | Formularies table with expired batch alerts |
| Add Medicine Form | `GET` | `/medicines/new` | Open new formulation form |
| Save Medicine | `POST` | `/medicines/new` | Save medicine in PostgreSQL |
| Search Medicines | `GET` | `/medicines/search?query=Amoxicillin` | Search by Medicine ID or Name |
| View Medicine Details | `GET` | `/medicines/view/{id}` | Dossier & remaining shelf life |
| Edit Medicine Form | `GET` | `/medicines/edit/{id}` | Edit formulation details |
| Update Medicine | `POST` | `/medicines/update/{id}` | Save modifications |
| Delete Medicine | `GET` | `/medicines/delete/{id}` | Remove medicine record by ID |

---

## 🧪 Sample Test Data
| MedicineID | Medicine Name | Category | Manufacturer | Batch No | Price | Qty | Expiry Date | Status |
|------------|---------------|----------|--------------|----------|-------|-----|-------------|--------|
| 1 | Amoxicillin 500mg | Antibiotic | Pfizer Inc. | BATCH-AMX-2024 | $12.50 | 150 | 2026-01-10 | Valid Stock |
| 2 | Paracetamol 650mg | Analgesic | GSK Pharma | BATCH-PCM-2024 | $4.25 | 300 | 2027-03-01 | Valid Stock |
| 5 | Insulin Glargine 100IU | Antidiabetic | Sanofi | BATCH-INS-2022 | $45.00 | 15 | 2023-01-15 | **EXPIRED** |
