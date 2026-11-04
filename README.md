# All Saints Spring Boot MVC Suite
## Comprehensive GUI Guide for Spring Tools 4 for Eclipse (STS) & pgAdmin 4

This repository contains **8 complete, enterprise-grade, ready-to-execute** Spring Boot web applications designed specifically to be run using:
- **Spring Tools 4 for Eclipse (STS)** — No terminal commands required!
- **pgAdmin 4 (PostgreSQL GUI)** — Visual database management and SQL execution!

---

## 📁 Projects Index & Port Allocation

| # | Project Folder | Application Name | Default Port | Database Name |
|---|----------------|------------------|--------------|---------------|
| 1 | [`Question1_Hospital_Patient_Registration_System`](./Question1_Hospital_Patient_Registration_System) | Hospital Patient Registration System | `8081` | `hospital_db` |
| 2 | [`Question2_Library_Management_System`](./Question2_Library_Management_System) | Library Management System | `8082` | `library_db` |
| 3 | [`Question3_Employee_Management_System`](./Question3_Employee_Management_System) | Employee Management System | `8083` | `employee_db` |
| 4 | [`Question4_Product_Inventory_Management_System`](./Question4_Product_Inventory_Management_System) | Product Inventory Management System | `8084` | `inventory_db` |
| 5 | [`Question5_Online_Banking_System`](./Question5_Online_Banking_System) | Online Banking System | `8085` | `banking_db` |
| 6 | [`Question6_Course_Management_System`](./Question6_Course_Management_System) | Course Management System | `8086` | `course_db` |
| 7 | [`Question7_Blood_Donor_Management_System`](./Question7_Blood_Donor_Management_System) | Blood Donor Management System | `8087` | `blood_donor_db` |
| 8 | [`Question8_Pharmacy_Management_System`](./Question8_Pharmacy_Management_System) | Pharmacy Management System | `8088` | `pharmacy_db` |

---

## 🐘 PART 1: Database Setup in pgAdmin 4 (Pure GUI)

Before running an application in STS, its corresponding PostgreSQL database should be created in **pgAdmin 4**.

### Step 1: Connect to PostgreSQL in pgAdmin
1. Open the **pgAdmin 4** application on your laptop.
2. In the left-hand **Object Explorer** tree, expand **Servers**.
3. Click on your server (e.g. **PostgreSQL 15 / 16 / 17 / 18**) and type your master password.

### Step 2: Create the Database
For any question you want to run, create its database:
1. In the left tree, **Right-click on `Databases`** -> choose **Create** -> click **Database...**.
2. In the **Database** field, enter the name from the table above (e.g., `hospital_db` for Question 1, `library_db` for Question 2, etc.).
3. Click the blue **Save** button.

### Step 3: Run the `schema.sql` Script
1. In the left tree, click on your newly created database (e.g., `hospital_db`).
2. From the top menu bar, click **Tools** -> **Query Tool** (or right-click the database -> click **Query Tool**).
3. In the Query Tool toolbar, click the **Open File** icon (the Folder icon).
4. Browse to the project folder on your laptop, select `schema.sql`, and click **Open**.
   *(Alternatively, you can open `schema.sql` in any text editor, copy all contents, and paste them into the pgAdmin Query Tool editor).*
5. Click the **Execute** button (the Play triangle icon or press **F5** on your keyboard).
6. Look at the **Data Output** pane at the bottom: it will display **"Query returned successfully"**.
7. In the left tree, you can expand `Database -> Schemas -> public -> Tables` to view the newly created tables and data.

---

## 🍃 PART 2: Running in Spring Tools 4 for Eclipse (STS)

### Step 1: Import Projects into STS

You can import **all 8 projects at once** (recommended) or one by one:

#### Option A: Import All 8 Projects Simultaneously (One-Click)
1. Open **Spring Tools 4 for Eclipse (STS)**.
2. Click **File** from the top menu -> select **Import...**.
3. In the Import wizard, expand the **Maven** folder -> select **Existing Maven Projects** -> click **Next**.
4. In the **Root Directory** field, click **Browse...** and select the parent folder:
   `C:\WIPRO_SAMPLES`
5. STS will automatically scan and check all 8 projects and the root POM:
   - `Question1_Hospital_Patient_Registration_System`
   - `Question2_Library_Management_System`
   - `Question3_Employee_Management_System`
   - `Question4_Product_Inventory_Management_System`
   - `Question5_Online_Banking_System`
   - `Question6_Course_Management_System`
   - `Question7_Blood_Donor_Management_System`
   - `Question8_Pharmacy_Management_System`
6. Click **Finish**.
7. Wait a few moments while STS imports and resolves dependencies. Watch the progress bar in the bottom-right corner of STS.

#### Option B: Import a Single Question
1. Click **File** -> **Import...** -> **Maven** -> **Existing Maven Projects** -> **Next**.
2. Click **Browse...** and select only the specific folder (e.g., `C:\WIPRO_SAMPLES\Question1_Hospital_Patient_Registration_System`).
3. Click **Finish**.

---

### Step 2: Verify / Update Database Credentials in STS

By default, every project is configured with:
```properties
spring.datasource.url=jdbc:postgresql://localhost:5432/<database_name>
spring.datasource.username=postgres
spring.datasource.password=postgres
```

If your pgAdmin PostgreSQL password on your laptop is something else (e.g. `admin`, `root`, or your personal password):
1. In STS **Package Explorer** (left sidebar), expand the question folder you wish to run.
2. Expand `src/main/resources`.
3. Double-click `application.properties` to open it in the editor.
4. Update `spring.datasource.password=YOUR_PGADMIN_PASSWORD`.
5. Press **Ctrl + S** to save the file.

---

### Step 3: Run the Spring Boot App in STS

There are **three convenient GUI methods** to run the app in STS. Choose whichever you prefer:

#### Method 1: Package Explorer (Right-Click)
1. In the **Package Explorer** / **Project Explorer**, **Right-click** on the project folder (e.g. `Question1_Hospital_Patient_Registration_System`).
2. Hover over **Run As** in the context menu.
3. Click **1 Spring Boot App**.

#### Method 2: Boot Dashboard (Visual GUI)
1. In STS, locate the **Boot Dashboard** tab (usually visible at the bottom-left corner of STS; if hidden, open via **Window -> Show View -> Other -> Spring Tools -> Boot Dashboard**).
2. Under **local**, you will see the list of your Spring Boot apps.
3. Click on the app name and click the green **(Re)start** play icon on the Boot Dashboard toolbar.

#### Method 3: Main Java Class
1. Expand `src/main/java` -> expand `com.example...`.
2. Right-click the `...Application.java` file (e.g., `HospitalApplication.java`).
3. Select **Run As** -> **Java Application** (or **Spring Boot App**).

---

### Step 4: Check Console Output in STS
Look at the **Console** tab at the bottom of STS:
- You will see the Spring Boot ASCII banner.
- Hibernate and JPA will initialize and log table connections.
- At the end, look for the success message:
  ```text
  Tomcat started on port(s): 8081 (http) with context path '/'
  Started HospitalApplication in X.XXX seconds (process running for ...)
  ```

---

### Step 5: Open & Test in Your Web Browser

Open your preferred web browser (Google Chrome, Microsoft Edge, or Mozilla Firefox) and visit the corresponding URL:

| Question | Browser URL | What to Test |
|----------|-------------|--------------|
| **Q1: Hospital System** | [http://localhost:8081/patients/list](http://localhost:8081/patients/list) | Register patient, search by ID, update, delete |
| **Q2: Library System** | [http://localhost:8082/books/list](http://localhost:8082/books/list) | Add book, view catalogue, search, edit copies |
| **Q3: Employee System** | [http://localhost:8083/employees/list](http://localhost:8083/employees/list) | Add employee, view department, edit salary |
| **Q4: Inventory System** | [http://localhost:8084/products/list](http://localhost:8084/products/list) | Add product, stock counters, view specifications |
| **Q5: Banking System** | [http://localhost:8085/accounts/list](http://localhost:8085/accounts/list) | Register account, deposit money, test overdraft rejection |
| **Q6: Course System** | [http://localhost:8086/courses/list](http://localhost:8086/courses/list) | Enroll student, test course capacity limit & duplicate rejection |
| **Q7: Blood Donor System** | [http://localhost:8087/donors/list](http://localhost:8087/donors/list) | Filter by blood group, verify 90-day donation eligibility badges |
| **Q8: Pharmacy System** | [http://localhost:8088/medicines/list](http://localhost:8088/medicines/list) | Search by ID/Name, verify expired batch warnings & negative stock blocks |

---

### Step 6: How to Stop the App in STS
When you are done testing an application:
1. In the **Console** view in STS, click the red square **Terminate** button in the top-right of the Console pane.
   *(Or in the **Boot Dashboard**, click on the running project and click the red square **Stop** button).*
2. The console will say `<terminated>`.

---

## 💡 Troubleshooting Tips for STS & pgAdmin
- **Port already in use?**
  Each of the 8 projects has been assigned a distinct port (`8081` through `8088`) so they will never conflict with each other or default 8080!
- **Database password authentication failed?**
  Open `src/main/resources/application.properties` in STS, update `spring.datasource.password` to match your pgAdmin password, and save.
- **JSP view not rendering?**
  All projects include `tomcat-embed-jasper` in standard compile scope, meaning STS runs JSP pages out of the box with zero additional server configuration.
