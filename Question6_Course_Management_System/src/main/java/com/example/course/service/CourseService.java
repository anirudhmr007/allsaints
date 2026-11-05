package com.example.course.service;

import com.example.course.entity.Course;
import com.example.course.entity.CourseRegistration;
import com.example.course.repository.CourseRegistrationRepository;
import com.example.course.repository.CourseRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Service Layer: Business logic and validations for Course Management.
 */
@Service
public class CourseService {

    @Autowired
    private CourseRepository courseRepository;

    @Autowired
    private CourseRegistrationRepository registrationRepository;

    // 1. Get all available courses
    public List<Course> getAllCourses() {
        return courseRepository.findAll();
    }

    // 2. Find course by Course ID
    public Course getCourseById(Long id) {
        return courseRepository.findById(id).orElse(null);
    }

    // 3. Add or update course
    public Course saveCourse(Course course) {
        return courseRepository.save(course);
    }

    // 4. Delete course by Course ID
    public void deleteCourse(Long id) {
        courseRepository.deleteById(id);
    }

    // 5. Get number of currently enrolled students for a course
    public int getEnrolledCount(Long courseId) {
        return registrationRepository.findByCourseId(courseId).size();
    }

    // 6. Register a student with Capacity and Duplicate checks
    public String registerStudent(Long courseId, String studentId, String studentName) {
        Course course = getCourseById(courseId);
        if (course == null) {
            return "Error: Course not found!";
        }

        // Validation 1: Prevent registration if course capacity is full
        int currentEnrolled = getEnrolledCount(courseId);
        if (currentEnrolled >= course.getCourseCapacity()) {
            return "Error: Course capacity is full (" + currentEnrolled + "/" + course.getCourseCapacity() + ")! Cannot register.";
        }

        // Validation 2: Avoid duplicate student registrations for the same course
        if (registrationRepository.existsByCourseIdAndStudentId(courseId, studentId.trim())) {
            return "Error: Student with ID '" + studentId + "' is ALREADY registered for this course!";
        }

        // Save registration
        CourseRegistration reg = new CourseRegistration(courseId, studentId.trim(), studentName.trim());
        registrationRepository.save(reg);
        return "Success: Student " + studentName + " (" + studentId + ") registered successfully for " + course.getCourseName() + "!";
    }
}
