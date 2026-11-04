# Question 7: Blood Donor Management System

A healthcare management and donor screening web portal developed using **Spring Boot MVC**, **Spring Data JPA**, **Hibernate**, **JSP**, and **PostgreSQL**.

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

## 🩸 Overview & Features
This application maintains records of blood donors and screens donation eligibility:
- **Register New Blood Donor**: Captures DonorID (auto-generated), Name, Age (validated between 18 and 65), Gender, Blood Group (A+, A-, B+, B-, AB+, AB-, O+, O-), Contact Number (10 digits), Email, Address, Last Donation Date, and Health Status.
- **Display Registered Donors**: Shows all donors in a responsive JSP table with color-coded blood group tags and eligibility badges.
- **Search by Blood Group**: Instant filtering of donors by specific blood groups.
- **Search by Donor ID**: Quick numeric ID search.
- **Update Donor Details**: Edit health status, contact info, and donation dates.
- **Delete Donor Record**: Remove donor records with confirmation protection.
- **Eligibility Screening**: Automatically evaluates whether a donor meets age, health, and 90-day minimum donation interval criteria.

---

## 🏛 MVC Architecture
```
Question7_Blood_Donor_Management_System/
├── pom.xml
├── schema.sql
├── README.md
└── src/
    └── main/
        ├── java/com/example/blooddonor/
        │   ├── BloodDonorApplication.java           # Main Spring Boot Runner
        │   ├── entity/BloodDonor.java               # JPA Entity for 'blood_donors'
        │   ├── repository/BloodDonorRepository.java # JPA Repository (includes findByBloodGroup)
        │   ├── service/BloodDonorService.java       # Service with eligibility verification logic
        │   └── controller/BloodDonorController.java # MVC Controller
        ├── resources/
        │   └── application.properties               # Port 8087, PostgreSQL, & JSP configuration
        └── webapp/WEB-INF/jsp/
            ├── donor-list.jsp                       # Directory with blood group dropdown filter
            ├── donor-form.jsp                       # Registration & update form
            └── donor-view.jsp                       # Medical profile & eligibility badge
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
   CREATE DATABASE blood_donor_db;
   ```
3. Load schema and sample donor profiles:
   ```bash
   \c blood_donor_db;
   \i schema.sql;
   ```

---

## 🔧 Configuration (`application.properties`)
```properties
server.port=8087
spring.datasource.url=jdbc:postgresql://localhost:5432/blood_donor_db
spring.datasource.username=postgres
spring.datasource.password=postgres
spring.jpa.hibernate.ddl-auto=update
spring.mvc.view.prefix=/WEB-INF/jsp/
spring.mvc.view.suffix=.jsp
```

---

## 🛡 Business Validation Rules
1. **Donor Age Validation**:
   - Blood donors must be between **18 and 65 years old**. Donors outside this range are rejected during registration.
2. **Health Status Validation**:
   - Donors marked with health status "Fit" or "Healthy" receive an **Eligible** badge.
   - Statuses such as "Under Medication", "Low Hemoglobin", or "Unfit" are tagged as **Ineligible**.
3. **Donation Frequency Eligibility**:
   - Standard red blood cell donations require at least **90 days (approx. 3 months)** between successive donations.
   - The system computes `daysSinceLastDonation`. Donors with less than 90 days since their last donation are flagged as currently ineligible.

---

## 🚀 How to Run the Application

### Option A: Maven CLI
```bash
cd Question7_Blood_Donor_Management_System
mvn clean spring-boot:run
```
Visit: `http://localhost:8087/donors/list`

### Option B: IDE
1. Open `Question7_Blood_Donor_Management_System` in your IDE.
2. Run `com.example.blooddonor.BloodDonorApplication`.
3. Open `http://localhost:8087/` in your browser.

---

## 🌐 Endpoints & Operations

| Operation | HTTP Method | URL | Description |
|-----------|-------------|-----|-------------|
| Display Registered Donors | `GET` | `/donors/list` or `/` | View all donors with eligibility badges |
| Filter by Blood Group | `GET` | `/donors/search-by-group?bloodGroup=O+` | Filter donors by Blood Group |
| Search by Donor ID | `GET` | `/donors/search-by-id?donorId=1` | Search donor by numeric ID |
| Register Donor Form | `GET` | `/donors/register` | Open donor registration form |
| Save Donor | `POST` | `/donors/register` | Save donor with validation |
| View Donor Profile | `GET` | `/donors/view/{id}` | Detailed medical card & eligibility |
| Edit Donor Form | `GET` | `/donors/edit/{id}` | Form to modify donor information |
| Update Donor | `POST` | `/donors/update/{id}` | Save updated donor information |
| Delete Donor | `GET` | `/donors/delete/{id}` | Delete donor record by ID |

---

## 🧪 Sample Test Data
| DonorID | Name | Age | Blood Group | Contact | Health Status | Last Donation |
|---------|------|-----|-------------|---------|---------------|---------------|
| 1 | Liam Hemsworth | 28 | O+ | 9812345678 | Fit | 2024-01-15 |
| 2 | Emma Watson | 24 | A+ | 9823456789 | Fit | 2024-05-10 |
| 3 | Lucas Scott | 34 | B- | 9834567890 | Fit | 2024-08-20 |
| 4 | Sophia Turner | 19 | AB+ | 9845678901 | Fit | Never |
