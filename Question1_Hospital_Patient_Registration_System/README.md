# Question 1: Hospital Patient Registration System
### GUI Execution Guide for Spring Tools 4 for Eclipse (STS) & pgAdmin 4

A full-stack enterprise web application built using **Spring Boot MVC**, **Spring Data JPA**, **Hibernate**, **JSP (Jakarta Server Pages)**, and **PostgreSQL**.

---

## 📋 Table of Contents
1. [Overview & Features](#overview--features)
2. [MVC Architecture](#mvc-architecture)
3. [pgAdmin 4 Database Setup (No Terminal Needed)](#-pgadmin-4-database-setup-no-terminal-needed)
4. [Spring Tools 4 for Eclipse (STS) Execution Guide](#-spring-tools-4-for-eclipse-sts-execution-guide)
5. [Endpoints & Operations](#endpoints--operations)
6. [Sample Test Data](#sample-test-data)

---

## 🏥 Overview & Features
This application manages hospital patient registrations and provides end-to-end CRUD operations:
- **Register Patient**: Captures Patient ID (auto-generated), Name, Age, Gender, Contact Number, Email, Address, and Blood Group.
- **Display Patients**: Shows all registered patients in a clean, responsive JSP table.
- **Search Patient**: Quickly search and retrieve patient records by Patient ID.
- **Update Patient Details**: Edit existing patient demographic and contact information.
- **Delete Patient**: Safely remove patient records using their Patient ID with confirmation safeguards.

---

## 🏛 MVC Architecture
```
Question1_Hospital_Patient_Registration_System/
├── pom.xml
├── schema.sql
├── README.md
└── src/
    └── main/
        ├── java/com/example/hospital/
        │   ├── HospitalApplication.java          # Spring Boot main class & Servlet Initializer
        │   ├── entity/Patient.java                # JPA Entity mapped to 'patients' table
        │   ├── repository/PatientRepository.java  # Spring Data JPA Repository
        │   ├── service/PatientService.java        # Business logic & transaction boundary
        │   └── controller/PatientController.java  # Spring MVC Request Controller
        ├── resources/
        │   └── application.properties             # DB connection, JPA, & JSP view resolver
        └── webapp/WEB-INF/jsp/
            ├── patient-list.jsp                   # JSP view displaying patient table & search
            └── patient-form.jsp                   # JSP view for registration & updating (Add & Edit)
```

---

## 🐘 pgAdmin 4 Database Setup (No Terminal Needed)

Follow these simple GUI steps in **pgAdmin 4**:

### Step 1: Create the Database in pgAdmin
1. Open **pgAdmin 4** on your laptop and enter your master password.
2. In the left **Object Explorer** tree, expand **Servers** -> click **PostgreSQL 15/16/17/18**.
3. **Right-click** on **Databases** -> select **Create** -> click **Database...**.
4. In the dialog, set:
   - **Database**: `hospital_db`
5. Click **Save**.

### Step 2: Run `schema.sql` in pgAdmin
1. In the left tree, click to highlight your new database: `hospital_db`.
2. From the top menu, click **Tools** -> **Query Tool** (or right-click `hospital_db` -> **Query Tool**).
3. Click the **Open File** icon (Folder icon on the toolbar) and browse to:
   `C:\WIPRO_SAMPLES\Question1_Hospital_Patient_Registration_System\schema.sql`
   *(Alternatively, copy and paste the contents of `schema.sql` directly into the Query Tool).*
4. Click the **Execute** button (the Play triangle icon or press **F5**).
5. The **Data Output** pane at the bottom will display:
   `Query returned successfully in ... msec.`
6. In the left tree, you can expand `hospital_db` -> `Schemas` -> `public` -> `Tables` to see the `patients` table with initial records.

---

## 🍃 Spring Tools 4 for Eclipse (STS) Execution Guide

Follow these GUI steps in **Spring Tools 4 for Eclipse (STS)**:

### Step 1: Import Project into STS
1. Open **Spring Tools 4 for Eclipse (STS)**.
2. Click **File** -> **Import...**
3. In the Import wizard, expand **Maven** -> select **Existing Maven Projects** -> click **Next**.
4. Click **Browse...** for **Root Directory** and select:
   `C:\WIPRO_SAMPLES\Question1_Hospital_Patient_Registration_System`
5. Ensure the checkbox next to `/pom.xml` is checked.
6. Click **Finish**.
7. Wait a few moments for STS to download any necessary Maven dependencies (watch the progress bar in the bottom-right corner of STS).

### Step 2: Verify / Update Database Password in STS
1. In **Package Explorer** or **Project Explorer**, expand:
   `Question1_Hospital_Patient_Registration_System` -> `src/main/resources`
2. Double-click `application.properties` to open it in the editor:
   ```properties
   server.port=8081
   spring.datasource.url=jdbc:postgresql://localhost:5432/hospital_db
   spring.datasource.username=postgres
   spring.datasource.password=postgres
   ```
3. If your pgAdmin PostgreSQL password is NOT `postgres` (e.g., `admin`, `root`, or your personal password), change `spring.datasource.password` to match your pgAdmin password.
4. Press **Ctrl + S** to save the file.

### Step 3: Run the Application from STS GUI
Choose either of the two easy GUI methods:

- **Method A (Recommended - Right Click)**:
  1. In **Package Explorer**, right-click the project `Question1_Hospital_Patient_Registration_System`.
  2. Select **Run As** -> **1 Spring Boot App**.

- **Method B (Using Boot Dashboard)**:
  1. Look at the **Boot Dashboard** view in the bottom-left corner of STS.
  2. Under **local**, find `hospital-patient-registration`.
  3. Click the green **(Re)start** play icon (or right-click -> **(Re)start**).

### Step 4: Verify in Console
Look at the **Console** view tab at the bottom of STS. You will see:
```text
Tomcat started on port 8081 (http) with context path '/'
Started HospitalApplication in X.XXX seconds
```

### Step 5: Open Application in Your Browser
Open Chrome, Edge, or Firefox and navigate to:
👉 **[http://localhost:8081/patients/list](http://localhost:8081/patients/list)**

### Step 6: How to Stop the App in STS
- In the **Console** view, click the red square **Terminate** button, **OR**
- In the **Boot Dashboard**, select the application and click the red square **Stop** button.

---

## 🌐 Endpoints & Operations

| Operation | HTTP Method | URL | Description |
|-----------|-------------|-----|-------------|
| Display Patients | `GET` | `/` or `/patients` or `/patients/list` | View all registered patients in JSP table |
| Register Patient Form | `GET` | `/patients/add` | Open simple patient registration form |
| Save / Update Patient | `POST` | `/patients/save` | Save new or updated patient to PostgreSQL |
| Search Patient | `GET` | `/patients/search?patientId=1` | Search patient by Patient ID |
| Edit Patient Form | `GET` | `/patients/edit/{id}` | Open edit form pre-populated |
| Delete Patient | `GET` | `/patients/delete/{id}` | Delete patient by ID |

---

## 🧪 Sample Test Data
| PatientID | Name | Age | Gender | Contact Number | Email | Blood Group | Address |
|-----------|------|-----|--------|----------------|-------|-------------|---------|
| 1 | John Doe | 35 | Male | 9876543210 | john.doe@example.com | O+ | 123 Baker Street, London |
| 2 | Jane Smith | 28 | Female | 9876543211 | jane.smith@example.com | A+ | 45 Elm Street, Springfield |
| 3 | Robert Brown | 52 | Male | 9876543212 | robert.brown@example.com | B+ | 789 Pine Road, Manchester |
| 4 | Emily Davis | 22 | Female | 9876543213 | emily.davis@example.com | AB+ | 12 Maple Avenue, Bristol |
