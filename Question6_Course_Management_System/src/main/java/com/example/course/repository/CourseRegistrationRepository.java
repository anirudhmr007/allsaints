package com.example.course.repository;

import com.example.course.entity.CourseRegistration;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CourseRegistrationRepository extends JpaRepository<CourseRegistration, Long> {
    List<CourseRegistration> findByCourseId(Long courseId);
    boolean existsByCourseIdAndStudentId(Long courseId, String studentId);
}
