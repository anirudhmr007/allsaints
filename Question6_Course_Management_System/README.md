# Question 6: Course Management System
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

## 🎓 Overview & Features
This application manages academic course offerings and student course enrollments:
- **Add New Course**: Captures CourseID (auto-generated), Course Code (unique), Course Name, Department, Faculty Name, Credits, Semester, and Course Capacity.
- **Display Available Courses**: Visualizes course status, capacity progress bars, faculty names, and seat availability in a responsive JSP table.
- **Search Course**: Search courses by unique Course ID.
- **Update Course Details**: Modify curriculum, professor assignments, and capacities.
- **Delete Course**: Remove courses and cascading registrations.
- **Student Course Registration with Capacity & Duplicate Checks**:
  - Automatically blocks new enrollments when a course reaches its maximum capacity.
  - Automatically identifies and rejects duplicate student registrations for the same course (by Student ID or Student Email).

---

## 🏛 MVC Architecture
```
Question6_Course_Management_System/
├── pom.xml
├── schema.sql
├── README.md
└── src/
    └── main/
        ├── java/com/example/course/
        │   ├── CourseApplication.java                    # Spring Boot Application & Servlet Initializer
        │   ├── entity/Course.java                         # Course Entity mapped to 'courses' table
        │   ├── entity/CourseRegistration.java             # Course Registration Entity mapped to 'course_registrations'
        │   ├── repository/CourseRepository.java           # JPA Repository for courses
        │   ├── repository/CourseRegistrationRepository.java # JPA Repository for registrations
        │   ├── service/CourseService.java                 # Service with capacity & duplicate validation logic
        │   └── controller/CourseController.java           # MVC Controller handling endpoints
        ├── resources/
        │   └── application.properties                     # Port 8086, DB, & JSP config
        └── webapp/WEB-INF/jsp/
            ├── course-list.jsp                            # Offerings table with capacity indicators & search
            ├── course-form.jsp                            # Add & edit course
            └── course-register.jsp                        # Simple student course registration form
```

---

## 🐘 pgAdmin 4 Database Setup (No Terminal Needed)

### Step 1: Create Database in pgAdmin
1. Open **pgAdmin 4** on your laptop and log in.
2. In the left **Object Explorer**, expand **Servers** -> **PostgreSQL**.
3. **Right-click** on **Databases** -> select **Create** -> click **Database...**.
4. In the dialog, set:
   - **Database**: `course_db`
5. Click **Save**.

### Step 2: Execute `schema.sql` in pgAdmin
1. In the left tree, select `course_db`.
2. From the top toolbar, click **Tools** -> **Query Tool** (or right-click `course_db` -> **Query Tool**).
3. Click the **Open File** icon (Folder icon) on the toolbar and open:
   `C:\WIPRO_SAMPLES\Question6_Course_Management_System\schema.sql`
   *(Or copy and paste the SQL content from `schema.sql` directly).*
4. Click the **Execute** button (Play triangle icon or press **F5**).
5. The message **"Query returned successfully"** indicates tables (`courses`, `course_registrations`) and initial courses are ready.

---

## 🍃 Spring Tools 4 for Eclipse (STS) Execution Guide

### Step 1: Import Project into STS
1. Open **Spring Tools 4 for Eclipse (STS)**.
2. Click **File** -> **Import...**.
3. Select **Maven** -> **Existing Maven Projects** -> click **Next**.
4. Click **Browse...** for **Root Directory** and select:
   `C:\WIPRO_SAMPLES\Question6_Course_Management_System`
5. Ensure `/pom.xml` is checked, then click **Finish**.
6. Wait for Maven build to complete.

### Step 2: Verify / Update Database Password
1. In STS **Package Explorer**, expand:
   `Question6_Course_Management_System` -> `src/main/resources`
2. Double-click `application.properties`:
   ```properties
   server.port=8086
   spring.datasource.url=jdbc:postgresql://localhost:5432/course_db
   spring.datasource.username=postgres
   spring.datasource.password=postgres
   ```
3. Update `spring.datasource.password` if your pgAdmin password is different, and save (**Ctrl + S**).

### Step 3: Run the Application in STS
- **Method A**: Right-click `Question6_Course_Management_System` in Package Explorer -> **Run As** -> **1 Spring Boot App**.
- **Method B**: In the **Boot Dashboard** view, locate `course-management-system` and click the green **(Re)start** play icon.

### Step 4: Verify in Console
The **Console** view will log:
```text
Tomcat started on port 8086 (http) with context path '/'
Started CourseApplication in X.XXX seconds
```

### Step 5: Test in Browser
Open your browser and visit:
👉 **[http://localhost:8086/courses/list](http://localhost:8086/courses/list)**

### Step 6: Stop App
Click the red square **Terminate** button in the Console or the **Stop** button in Boot Dashboard.

---

## 🛡 Business Validation Rules
1. **Course Capacity Enforcement**:
   - Every course defines a `courseCapacity` (maximum allowable seats).
   - Before completing student enrollment, the system checks whether `enrolledCount >= courseCapacity`.
   - If full, enrollment is rejected with:
     `"Registration Rejected: Course '...' is FULL. Capacity of X students reached."`
2. **Duplicate Registration Prevention**:
   - The system checks if the `Student ID` or `Student Email` is already enrolled in the target course.
   - If a duplicate attempt is detected, registration is blocked:
     `"Duplicate Registration: Student ID '...' is ALREADY registered for course ..."`

---

## 🌐 Endpoints & Operations

| Operation | HTTP Method | URL | Description |
|-----------|-------------|-----|-------------|
| Display Available Courses | `GET` | `/` or `/courses` or `/courses/list` | Catalog with seat counters & progress |
| Add Course Form | `GET` | `/courses/add` | Open simple course creation form |
| Save / Update Course | `POST` | `/courses/save` | Persist new or updated course in PostgreSQL |
| Search Course | `GET` | `/courses/search?courseId=1` | Search course by Course ID |
| Edit Course Form | `GET` | `/courses/edit/{id}` | Edit course form |
| Delete Course | `GET` | `/courses/delete/{id}` | Delete course and its registrations |
| Enroll Student Form | `GET` | `/courses/enroll/{id}` | Open student registration form for course |
| Submit Student Registration | `POST` | `/courses/enroll` | Enroll student with capacity & duplicate checks |

---

## 🧪 Sample Test Data
| Course Code | Course Name | Department | Faculty | Credits | Capacity | Enrolled |
|-------------|-------------|------------|---------|---------|----------|----------|
| `CS101` | Intro to Computer Science | Computer Science | Dr. Alan Turing | 4 | 3 | 2 (Open) |
| `AI301` | AI & Deep Learning | Computer Science | Dr. Geoffrey Hinton | 4 | 2 | 2 (Full) |
| `CS201` | Data Structures | Computer Science | Dr. Donald Knuth | 4 | 30 | 0 (Open) |
