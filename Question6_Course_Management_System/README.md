# Question 6: Course Management System

An academic curriculum and student course enrollment web portal built with **Spring Boot MVC**, **Spring Data JPA**, **Hibernate**, **JSP**, and **PostgreSQL**.

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
            ├── course-list.jsp                            # Offerings table with capacity indicators
            ├── course-form.jsp                            # Add & edit course
            ├── course-view.jsp                            # Course profile & class roster
            └── course-register-student.jsp                # Student course registration form
```

---

## ⚙ Prerequisites
- **JDK 17 or higher**
- **PostgreSQL 12+**
- **Maven 3.8+**

---

## 🗄 PostgreSQL Database Setup
1. Open PostgreSQL command line:
   ```bash
   psql -U postgres
   ```
2. Create database:
   ```sql
   CREATE DATABASE course_db;
   ```
3. Run the initialization script:
   ```bash
   \c course_db;
   \i schema.sql;
   ```

---

## 🔧 Configuration (`application.properties`)
```properties
server.port=8086
spring.datasource.url=jdbc:postgresql://localhost:5432/course_db
spring.datasource.username=postgres
spring.datasource.password=postgres
spring.jpa.hibernate.ddl-auto=update
spring.mvc.view.prefix=/WEB-INF/jsp/
spring.mvc.view.suffix=.jsp
```

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

## 🚀 How to Run the Application

### Option A: Maven CLI
```bash
cd Question6_Course_Management_System
mvn clean spring-boot:run
```
Visit: `http://localhost:8086/courses/list`

### Option B: IDE
1. Open `Question6_Course_Management_System` in your IDE.
2. Run `com.example.course.CourseApplication`.
3. Open `http://localhost:8086/` in your browser.

---

## 🌐 Endpoints & Operations

| Operation | HTTP Method | URL | Description |
|-----------|-------------|-----|-------------|
| Display Available Courses | `GET` | `/courses/list` or `/` | Catalog with seat counters & progress |
| Add Course Form | `GET` | `/courses/new` | Open course creation form |
| Save Course | `POST` | `/courses/new` | Persist course in PostgreSQL |
| Search Course | `GET` | `/courses/search?courseId=1` | Search course by Course ID |
| View Course & Roster | `GET` | `/courses/view/{id}` | View course details and student roster |
| Edit Course Form | `GET` | `/courses/edit/{id}` | Edit course form |
| Update Course | `POST` | `/courses/update/{id}` | Save course modifications |
| Delete Course | `GET` | `/courses/delete/{id}` | Delete course and its registrations |
| Register Student Form | `GET` | `/courses/register-student?courseId=1` | Open student registration form |
| Submit Student Registration | `POST` | `/courses/register-student` | Enroll student with validations |

---

## 🧪 Sample Test Data
| Course Code | Course Name | Department | Faculty | Credits | Capacity | Enrolled |
|-------------|-------------|------------|---------|---------|----------|----------|
| `CS101` | Intro to Computer Science | Computer Science | Dr. Alan Turing | 4 | 3 | 2 (Open) |
| `AI301` | AI & Deep Learning | Computer Science | Dr. Geoffrey Hinton | 4 | 2 | 2 (Full) |
| `CS201` | Data Structures | Computer Science | Dr. Donald Knuth | 4 | 30 | 0 (Open) |
