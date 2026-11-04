package com.example.course.entity;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "courses")
public class Course {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "course_id")
    private Long courseId;

    @NotBlank(message = "Course code is required")
    @Column(name = "course_code", nullable = false, unique = true)
    private String courseCode;

    @NotBlank(message = "Course name is required")
    @Size(min = 2, max = 150, message = "Course name must be between 2 and 150 characters")
    @Column(name = "course_name", nullable = false)
    private String courseName;

    @NotBlank(message = "Department is required")
    @Column(name = "department", nullable = false)
    private String department;

    @NotBlank(message = "Faculty name is required")
    @Column(name = "faculty_name", nullable = false)
    private String facultyName;

    @NotNull(message = "Credits are required")
    @Min(value = 1, message = "Credits must be at least 1")
    @Max(value = 10, message = "Credits must not exceed 10")
    @Column(name = "credits", nullable = false)
    private Integer credits;

    @NotBlank(message = "Semester is required")
    @Column(name = "semester", nullable = false)
    private String semester;

    @NotNull(message = "Course capacity is required")
    @Min(value = 1, message = "Course capacity must be at least 1")
    @Column(name = "course_capacity", nullable = false)
    private Integer courseCapacity;

    @OneToMany(mappedBy = "course", cascade = CascadeType.ALL, orphanRemoval = true, fetch = FetchType.EAGER)
    private List<CourseRegistration> registrations = new ArrayList<>();

    public Course() {
    }

    public Course(String courseCode, String courseName, String department, String facultyName, Integer credits, String semester, Integer courseCapacity) {
        this.courseCode = courseCode;
        this.courseName = courseName;
        this.department = department;
        this.facultyName = facultyName;
        this.credits = credits;
        this.semester = semester;
        this.courseCapacity = courseCapacity;
    }

    public Long getCourseId() {
        return courseId;
    }

    public void setCourseId(Long courseId) {
        this.courseId = courseId;
    }

    public String getCourseCode() {
        return courseCode;
    }

    public void setCourseCode(String courseCode) {
        this.courseCode = courseCode;
    }

    public String getCourseName() {
        return courseName;
    }

    public void setCourseName(String courseName) {
        this.courseName = courseName;
    }

    public String getDepartment() {
        return department;
    }

    public void setDepartment(String department) {
        this.department = department;
    }

    public String getFacultyName() {
        return facultyName;
    }

    public void setFacultyName(String facultyName) {
        this.facultyName = facultyName;
    }

    public Integer getCredits() {
        return credits;
    }

    public void setCredits(Integer credits) {
        this.credits = credits;
    }

    public String getSemester() {
        return semester;
    }

    public void setSemester(String semester) {
        this.semester = semester;
    }

    public Integer getCourseCapacity() {
        return courseCapacity;
    }

    public void setCourseCapacity(Integer courseCapacity) {
        this.courseCapacity = courseCapacity;
    }

    public List<CourseRegistration> getRegistrations() {
        return registrations;
    }

    public void setRegistrations(List<CourseRegistration> registrations) {
        this.registrations = registrations;
    }

    public int getEnrolledCount() {
        return registrations != null ? registrations.size() : 0;
    }

    public boolean isFull() {
        return getEnrolledCount() >= courseCapacity;
    }

    public int getAvailableSeats() {
        return Math.max(0, courseCapacity - getEnrolledCount());
    }

    @Override
    public String toString() {
        return "Course{" +
                "courseId=" + courseId +
                ", courseCode='" + courseCode + '\'' +
                ", courseName='" + courseName + '\'' +
                ", department='" + department + '\'' +
                ", facultyName='" + facultyName + '\'' +
                ", credits=" + credits +
                ", semester='" + semester + '\'' +
                ", courseCapacity=" + courseCapacity +
                '}';
    }
}
