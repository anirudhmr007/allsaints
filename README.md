# Enterprise Spring Boot MVC + PostgreSQL + JSP Applications

This repository contains **8 complete, fully-functional, ready-to-execute** web applications developed using:
- **Java 17+** (Compatible with JDK 17, 21, and 25)
- **Spring Boot 3.3.5 MVC**
- **Spring Data JPA & Hibernate**
- **PostgreSQL**
- **JSP (Jakarta Server Pages) & JSTL**
- **Bootstrap 5.3 & Bootstrap Icons**

Each project follows strict **MVC Layered Architecture**:
- **Controller Layer** (`controller/`): Request handling, routing, validation feedback, and model mapping.
- **Service Layer** (`service/`): Business logic, transaction management, and business validation rules.
- **Repository Layer** (`repository/`): Spring Data JPA repositories with query methods.
- **Entity Layer** (`entity/`): JPA Entities annotated with Jakarta persistence and validation constraints.
- **Presentation Layer** (`webapp/WEB-INF/jsp/`): Interactive, responsive JSP views with Bootstrap 5.

---

## 📁 Repository Structure & Projects Directory

| # | Folder Name | Application Name | Default Port | Database Name |
|---|-------------|------------------|--------------|---------------|
| 1 | [`Question1_Hospital_Patient_Registration_System`](./Question1_Hospital_Patient_Registration_System) | Hospital Patient Registration System | `8081` | `hospital_db` |
| 2 | [`Question2_Library_Management_System`](./Question2_Library_Management_System) | Library Management System | `8082` | `library_db` |
| 3 | [`Question3_Employee_Management_System`](./Question3_Employee_Management_System) | Employee Management System | `8083` | `employee_db` |
| 4 | [`Question4_Product_Inventory_Management_System`](./Question4_Product_Inventory_Management_System) | Product Inventory Management System | `8084` | `inventory_db` |
| 5 | [`Question5_Online_Banking_System`](./Question5_Online_Banking_System) | Online Banking System | `8085` | `banking_db` |
| 6 | [`Question6_Course_Management_System`](./Question6_Course_Management_System) | Course Management System | `8086` | `course_db` |
| 7 | [`Question7_Blood_Donor_Management_System`](./Question7_Blood_Donor_Management_System) | Blood Donor Management System | `8087` | `blood_donor_db` |
| 8 | [`Question8_Pharmacy_Management_System`](./Question8_Pharmacy_Management_System) | Pharmacy Management System | `8088` | `pharmacy_db` |

---

## 🛠️ General Prerequisites
Before running any application, ensure you have the following installed on your machine:
1. **Java Development Kit (JDK)**: Version 17, 21, or 25 installed. Check with:
   ```bash
   java -version
   ```
2. **Apache Maven**: Version 3.8+ installed (or open directly in IntelliJ/Eclipse). Check with:
   ```bash
   mvn -version
   ```
3. **PostgreSQL Server**: Running locally on port `5432` with standard user credentials (`postgres`/`postgres`).

---

## 🗄️ Database Initialization (Quick Setup)
Every project includes a `schema.sql` script with table schemas and initial sample records.

To create all databases in PostgreSQL at once, run:
```sql
CREATE DATABASE hospital_db;
CREATE DATABASE library_db;
CREATE DATABASE employee_db;
CREATE DATABASE inventory_db;
CREATE DATABASE banking_db;
CREATE DATABASE course_db;
CREATE DATABASE blood_donor_db;
CREATE DATABASE pharmacy_db;
```
Then load each project's schema from its folder:
```bash
psql -U postgres -d hospital_db -f Question1_Hospital_Patient_Registration_System/schema.sql
psql -U postgres -d library_db -f Question2_Library_Management_System/schema.sql
psql -U postgres -d employee_db -f Question3_Employee_Management_System/schema.sql
psql -U postgres -d inventory_db -f Question4_Product_Inventory_Management_System/schema.sql
psql -U postgres -d banking_db -f Question5_Online_Banking_System/schema.sql
psql -U postgres -d course_db -f Question6_Course_Management_System/schema.sql
psql -U postgres -d blood_donor_db -f Question7_Blood_Donor_Management_System/schema.sql
psql -U postgres -d pharmacy_db -f Question8_Pharmacy_Management_System/schema.sql
```
*(Alternatively, Hibernate is configured with `ddl-auto=update`, so tables will also be created automatically when each app boots!)*

---

## 🚀 Execution Instructions for Any Project

### Running via Command Line (Maven):
1. Open terminal and navigate into the desired question folder, for example:
   ```bash
   cd Question1_Hospital_Patient_Registration_System
   ```
2. Start the Spring Boot application:
   ```bash
   mvn clean spring-boot:run
   ```
3. Open your browser and access the application at its configured port (e.g., `http://localhost:8081/`).

### Running via IDE (IntelliJ IDEA / Eclipse / Spring Tool Suite / VS Code):
1. Choose **File -> Open / Import** and select the specific project folder (or the root repository).
2. Allow Maven to import dependencies.
3. Open the `Application.java` class under `src/main/java/com/example/...`.
4. Right-click and choose **Run**.

---

## 📖 Detailed Project Guides
For detailed documentation, endpoint listings, validation rules, and sample test data for each project, please refer to the individual `README.md` file located inside each folder:
- [Question 1: Hospital Patient Registration Guide](./Question1_Hospital_Patient_Registration_System/README.md)
- [Question 2: Library Management Guide](./Question2_Library_Management_System/README.md)
- [Question 3: Employee Management Guide](./Question3_Employee_Management_System/README.md)
- [Question 4: Product Inventory Guide](./Question4_Product_Inventory_Management_System/README.md)
- [Question 5: Online Banking Guide](./Question5_Online_Banking_System/README.md)
- [Question 6: Course Management Guide](./Question6_Course_Management_System/README.md)
- [Question 7: Blood Donor Management Guide](./Question7_Blood_Donor_Management_System/README.md)
- [Question 8: Pharmacy Management Guide](./Question8_Pharmacy_Management_System/README.md)
