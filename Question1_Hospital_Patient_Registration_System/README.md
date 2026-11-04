# Question 1: Hospital Patient Registration System

A full-stack enterprise web application built using **Spring Boot MVC**, **Spring Data JPA**, **Hibernate**, **JSP (Jakarta Server Pages)**, and **PostgreSQL**.

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

## 🏥 Overview & Features
This application manages hospital patient registrations and provides end-to-end CRUD operations:
- **Register Patient**: Captures Patient ID (auto-generated), Name, Age, Gender, Contact Number, Email, Address, and Blood Group.
- **Display Patients**: Shows all registered patients in a clean, responsive JSP table.
- **Search Patient**: Quickly search and retrieve patient records by Patient ID.
- **Update Patient Details**: Edit existing patient demographic and contact information.
- **Delete Patient**: Safely remove patient records using their Patient ID with confirmation safeguards.

---

## 🏛 MVC Architecture
The project strictly follows the industry standard MVC layered architecture:
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
            ├── patient-form.jsp                   # JSP view for registration & updating
            └── patient-view.jsp                   # JSP view for single patient details
```

---

## ⚙ Prerequisites
- **Java Development Kit (JDK)**: Version 17 or higher (JDK 17, 21, or 25).
- **PostgreSQL**: Version 12 or higher (running on port 5432).
- **Apache Maven**: Version 3.8+ (or your IDE's embedded Maven).

---

## 🗄 PostgreSQL Database Setup

1. Open your terminal or `psql` command line / pgAdmin:
   ```bash
   psql -U postgres
   ```
2. Create the database:
   ```sql
   CREATE DATABASE hospital_db;
   ```
3. Connect to the database and run the schema script:
   ```bash
   \c hospital_db;
   \i schema.sql;
   ```
   *(Or simply run the SQL statements inside `schema.sql` directly in pgAdmin query tool).*

---

## 🔧 Configuration (`application.properties`)
Update `src/main/resources/application.properties` if your PostgreSQL credentials differ:
```properties
server.port=8081
spring.datasource.url=jdbc:postgresql://localhost:5432/hospital_db
spring.datasource.username=postgres
spring.datasource.password=postgres
spring.jpa.hibernate.ddl-auto=update
spring.mvc.view.prefix=/WEB-INF/jsp/
spring.mvc.view.suffix=.jsp
```

---

## 🚀 How to Run the Application

### Option A: Using Maven from Command Line
1. Navigate to the project directory:
   ```bash
   cd Question1_Hospital_Patient_Registration_System
   ```
2. Build and run:
   ```bash
   mvn clean spring-boot:run
   ```
3. Open your browser and visit:
   ```
   http://localhost:8081/patients/list
   ```

### Option B: Using IntelliJ IDEA / Eclipse / VS Code
1. Open your IDE and select **Open / Import Project** -> select `Question1_Hospital_Patient_Registration_System/pom.xml`.
2. Wait for dependencies to download.
3. Locate `src/main/java/com/example/hospital/HospitalApplication.java`.
4. Right-click and choose **Run 'HospitalApplication'**.
5. Navigate to: `http://localhost:8081/`

---

## 🌐 Endpoints & Operations

| Operation | HTTP Method | URL | Description |
|-----------|-------------|-----|-------------|
| Display Patients | `GET` | `/patients/list` or `/` | View all registered patients in JSP table |
| Register Patient Form | `GET` | `/patients/register` | Open patient registration form |
| Save Patient | `POST` | `/patients/register` | Save patient to PostgreSQL |
| Search Patient | `GET` | `/patients/search?patientId=1` | Search patient by Patient ID |
| View Patient | `GET` | `/patients/view/{id}` | View single patient profile |
| Edit Patient Form | `GET` | `/patients/edit/{id}` | Open update form pre-populated |
| Update Patient | `POST` | `/patients/update/{id}` | Save updated patient details |
| Delete Patient | `GET` | `/patients/delete/{id}` | Delete patient by ID |

---

## 🧪 Sample Test Data
| PatientID | Name | Age | Gender | Contact Number | Email | Blood Group | Address |
|-----------|------|-----|--------|----------------|-------|-------------|---------|
| 1 | John Doe | 35 | Male | 9876543210 | john.doe@example.com | O+ | 123 Baker Street, London |
| 2 | Jane Smith | 28 | Female | 9876543211 | jane.smith@example.com | A+ | 45 Elm Street, Springfield |
| 3 | Robert Brown | 52 | Male | 9876543212 | robert.brown@example.com | B+ | 789 Pine Road, Manchester |
| 4 | Emily Davis | 22 | Female | 9876543213 | emily.davis@example.com | AB+ | 12 Maple Avenue, Bristol |
