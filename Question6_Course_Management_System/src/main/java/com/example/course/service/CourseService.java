package com.example.course.service;

import com.example.course.entity.Course;
import com.example.course.entity.CourseRegistration;
import com.example.course.repository.CourseRegistrationRepository;
import com.example.course.repository.CourseRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@Service
@Transactional
public class CourseService {

    private final CourseRepository courseRepository;
    private final CourseRegistrationRepository registrationRepository;

    @Autowired
    public CourseService(CourseRepository courseRepository, CourseRegistrationRepository registrationRepository) {
        this.courseRepository = courseRepository;
        this.registrationRepository = registrationRepository;
    }

    public List<Course> getAllCourses() {
        return courseRepository.findAll();
    }

    public Optional<Course> getCourseById(Long id) {
        return courseRepository.findById(id);
    }

    public Course saveCourse(Course course) {
        if (course.getCourseId() == null && courseRepository.existsByCourseCode(course.getCourseCode())) {
            throw new IllegalArgumentException("Course with Code '" + course.getCourseCode() + "' already exists.");
        }
        return courseRepository.save(course);
    }

    public Course updateCourse(Long id, Course updated) {
        return courseRepository.findById(id).map(existing -> {
            existing.setCourseName(updated.getCourseName());
            existing.setDepartment(updated.getDepartment());
            existing.setFacultyName(updated.getFacultyName());
            existing.setCredits(updated.getCredits());
            existing.setSemester(updated.getSemester());
            // Capacity validation: capacity cannot be less than currently enrolled students
            if (updated.getCourseCapacity() < existing.getEnrolledCount()) {
                throw new IllegalArgumentException("Course capacity cannot be lower than current enrollment count ("
                        + existing.getEnrolledCount() + ").");
            }
            existing.setCourseCapacity(updated.getCourseCapacity());
            return courseRepository.save(existing);
        }).orElseThrow(() -> new IllegalArgumentException("Course not found with ID: " + id));
    }

    public boolean deleteCourseById(Long id) {
        if (courseRepository.existsById(id)) {
            courseRepository.deleteById(id);
            return true;
        }
        return false;
    }

    // Register student to a course with capacity and duplicate checks
    public CourseRegistration registerStudent(Long courseId, String studentId, String studentName, String studentEmail) {
        Course course = courseRepository.findById(courseId)
                .orElseThrow(() -> new IllegalArgumentException("Course not found with ID: " + courseId));

        // 1. Capacity validation: prevent registration when course capacity is full
        if (course.isFull()) {
            throw new IllegalStateException("Registration Rejected: Course '" + course.getCourseName()
                    + " (" + course.getCourseCode() + ")' is FULL. Capacity of " + course.getCourseCapacity() + " students reached.");
        }

        // 2. Duplicate registration validation: avoid duplicate student registrations for same course
        if (registrationRepository.existsByCourseAndStudentId(course, studentId.trim())) {
            throw new IllegalArgumentException("Duplicate Registration: Student ID '" + studentId
                    + "' is ALREADY registered for course " + course.getCourseCode() + ".");
        }

        if (registrationRepository.existsByCourseAndStudentEmail(course, studentEmail.trim())) {
            throw new IllegalArgumentException("Duplicate Registration: Student email '" + studentEmail
                    + "' is ALREADY registered for course " + course.getCourseCode() + ".");
        }

        CourseRegistration registration = new CourseRegistration(course, studentId.trim(), studentName.trim(), studentEmail.trim(), LocalDate.now());
        return registrationRepository.save(registration);
    }

    public List<CourseRegistration> getCourseRegistrations(Long courseId) {
        Course course = courseRepository.findById(courseId)
                .orElseThrow(() -> new IllegalArgumentException("Course not found with ID: " + courseId));
        return registrationRepository.findByCourse(course);
    }
}

