package com.example.course.repository;

import com.example.course.entity.Course;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface CourseRepository extends JpaRepository<Course, Long> {
    Optional<Course> findByCourseCode(String courseCode);
    List<Course> findByCourseNameContainingIgnoreCase(String courseName);
    List<Course> findByDepartmentIgnoreCase(String department);
    boolean existsByCourseCode(String courseCode);
}
