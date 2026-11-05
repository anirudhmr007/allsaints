# Question 7: Blood Donor Management System
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
            ├── donor-list.jsp                       # Directory with blood group filter & eligibility badges
            └── donor-form.jsp                       # Simple Registration & edit form
```

---

## 🐘 pgAdmin 4 Database Setup (No Terminal Needed)

### Step 1: Create Database in pgAdmin
1. Open **pgAdmin 4** on your laptop and log in.
2. In the left **Object Explorer**, expand **Servers** -> **PostgreSQL**.
3. **Right-click** on **Databases** -> select **Create** -> click **Database...**.
4. In the dialog, set:
   - **Database**: `blood_donor_db`
5. Click **Save**.

### Step 2: Execute `schema.sql` in pgAdmin
1. In the left tree, select `blood_donor_db`.
2. From the top toolbar, click **Tools** -> **Query Tool** (or right-click `blood_donor_db` -> **Query Tool**).
3. Click the **Open File** icon (Folder icon) on the toolbar and open:
   `C:\WIPRO_SAMPLES\Question7_Blood_Donor_Management_System\schema.sql`
   *(Or copy and paste the SQL content from `schema.sql` directly).*
4. Click the **Execute** button (Play triangle icon or press **F5**).
5. The message **"Query returned successfully"** indicates tables and initial donors are ready.

---

## 🍃 Spring Tools 4 for Eclipse (STS) Execution Guide

### Step 1: Import Project into STS
1. Open **Spring Tools 4 for Eclipse (STS)**.
2. Click **File** -> **Import...**.
3. Select **Maven** -> **Existing Maven Projects** -> click **Next**.
4. Click **Browse...** for **Root Directory** and select:
   `C:\WIPRO_SAMPLES\Question7_Blood_Donor_Management_System`
5. Ensure `/pom.xml` is checked, then click **Finish**.
6. Wait for Maven build to complete.

### Step 2: Verify / Update Database Password
1. In STS **Package Explorer**, expand:
   `Question7_Blood_Donor_Management_System` -> `src/main/resources`
2. Double-click `application.properties`:
   ```properties
   server.port=8087
   spring.datasource.url=jdbc:postgresql://localhost:5432/blood_donor_db
   spring.datasource.username=postgres
   spring.datasource.password=postgres
   ```
3. Update `spring.datasource.password` if your pgAdmin password is different, and save (**Ctrl + S**).

### Step 3: Run the Application in STS
- **Method A**: Right-click `Question7_Blood_Donor_Management_System` in Package Explorer -> **Run As** -> **1 Spring Boot App**.
- **Method B**: In the **Boot Dashboard** view, locate `blood-donor-management-system` and click the green **(Re)start** play icon.

### Step 4: Verify in Console
The **Console** view will log:
```text
Tomcat started on port 8087 (http) with context path '/'
Started BloodDonorApplication in X.XXX seconds
```

### Step 5: Test in Browser
Open your browser and visit:
👉 **[http://localhost:8087/donors/list](http://localhost:8087/donors/list)**

### Step 6: Stop App
Click the red square **Terminate** button in the Console or the **Stop** button in Boot Dashboard.

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

## 🌐 Endpoints & Operations

| Operation | HTTP Method | URL | Description |
|-----------|-------------|-----|-------------|
| Display Registered Donors | `GET` | `/` or `/donors` or `/donors/list` | View all donors with eligibility badges |
| Filter by Blood Group | `GET` | `/donors/filter?bloodGroup=O+` | Filter donors by Blood Group |
| Search by Donor ID | `GET` | `/donors/search?donorId=1` | Search donor by numeric ID |
| Register Donor Form | `GET` | `/donors/add` | Open simple donor registration form |
| Save / Update Donor | `POST` | `/donors/save` | Save new or updated donor with validation |
| Edit Donor Form | `GET` | `/donors/edit/{id}` | Form to modify donor information |
| Delete Donor | `GET` | `/donors/delete/{id}` | Delete donor record by ID |

---

## 🧪 Sample Test Data
| DonorID | Name | Age | Blood Group | Contact | Health Status | Last Donation |
|---------|------|-----|-------------|---------|---------------|---------------|
| 1 | Liam Hemsworth | 28 | O+ | 9812345678 | Fit | 2024-01-15 |
| 2 | Emma Watson | 24 | A+ | 9823456789 | Fit | 2024-05-10 |
| 3 | Lucas Scott | 34 | B- | 9834567890 | Fit | 2024-08-20 |
| 4 | Sophia Turner | 19 | AB+ | 9845678901 | Fit | Never |
