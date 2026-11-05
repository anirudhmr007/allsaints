package com.example.course.entity;

import jakarta.persistence.*;

/**
 * Course Entity represents an academic course.
 * Table: courses
 */
@Entity
@Table(name = "courses")
public class Course {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "course_id")
    private Long courseId;

    @Column(name = "course_code", nullable = false, unique = true)
    private String courseCode;

    @Column(name = "course_name", nullable = false)
    private String courseName;

    @Column(name = "department", nullable = false)
    private String department;

    @Column(name = "faculty_name", nullable = false)
    private String facultyName;

    @Column(name = "credits", nullable = false)
    private int credits;

    @Column(name = "semester", nullable = false)
    private String semester;

    @Column(name = "course_capacity", nullable = false)
    private int courseCapacity;

    public Course() {
    }

    public Course(String courseCode, String courseName, String department, String facultyName, int credits, String semester, int courseCapacity) {
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

    public int getCredits() {
        return credits;
    }

    public void setCredits(int credits) {
        this.credits = credits;
    }

    public String getSemester() {
        return semester;
    }

    public void setSemester(String semester) {
        this.semester = semester;
    }

    public int getCourseCapacity() {
        return courseCapacity;
    }

    public void setCourseCapacity(int courseCapacity) {
        this.courseCapacity = courseCapacity;
    }
}
