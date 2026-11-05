package com.example.course.controller;

import com.example.course.entity.Course;
import com.example.course.service.CourseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Controller Layer: Handles web requests for Course Management System.
 */
@Controller
public class CourseController {

    @Autowired
    private CourseService courseService;

    // Helper to add enrollment counts to model
    private void attachEnrollmentData(List<Course> courses, Model model) {
        Map<Long, Integer> enrolledMap = new HashMap<>();
        for (Course c : courses) {
            enrolledMap.put(c.getCourseId(), courseService.getEnrolledCount(c.getCourseId()));
        }
        model.addAttribute("enrolledMap", enrolledMap);
    }

    // 1. Display all available courses in a JSP table
    @GetMapping({"/", "/courses", "/courses/list"})
    public String showCoursesList(Model model) {
        List<Course> courses = courseService.getAllCourses();
        model.addAttribute("courses", courses);
        attachEnrollmentData(courses, model);
        return "course-list";
    }

    // 2. Show form to add a new course
    @GetMapping("/courses/add")
    public String showAddCourseForm(Model model) {
        model.addAttribute("course", new Course());
        model.addAttribute("pageTitle", "Add New Course");
        return "course-form";
    }

    // 3. Save new course or update existing course
    @PostMapping("/courses/save")
    public String saveCourse(@ModelAttribute("course") Course course, RedirectAttributes redirectAttributes) {
        courseService.saveCourse(course);
        redirectAttributes.addFlashAttribute("message", "Course saved successfully!");
        return "redirect:/courses";
    }

    // 4. Search for a course using Course ID
    @GetMapping("/courses/search")
    public String searchCourse(@RequestParam(value = "courseId", required = false) Long courseId, Model model) {
        if (courseId != null) {
            Course course = courseService.getCourseById(courseId);
            List<Course> resultList = new ArrayList<>();
            if (course != null) {
                resultList.add(course);
            } else {
                model.addAttribute("error", "No course found with Course ID: " + courseId);
            }
            model.addAttribute("courses", resultList);
            model.addAttribute("searchedId", courseId);
            attachEnrollmentData(resultList, model);
        } else {
            List<Course> all = courseService.getAllCourses();
            model.addAttribute("courses", all);
            attachEnrollmentData(all, model);
        }
        return "course-list";
    }

    // 5. Show form to update course details
    @GetMapping("/courses/edit/{id}")
    public String showEditForm(@PathVariable("id") Long id, Model model) {
        Course course = courseService.getCourseById(id);
        model.addAttribute("course", course);
        model.addAttribute("pageTitle", "Update Course Details");
        return "course-form";
    }

    // 6. Delete a course record using Course ID
    @GetMapping("/courses/delete/{id}")
    public String deleteCourse(@PathVariable("id") Long id, RedirectAttributes redirectAttributes) {
        courseService.deleteCourse(id);
        redirectAttributes.addFlashAttribute("message", "Course deleted successfully!");
        return "redirect:/courses";
    }

    // 7. Show student registration form
    @GetMapping("/courses/register")
    public String showRegisterStudentForm(@RequestParam(value = "courseId", required = false) Long courseId, Model model) {
        model.addAttribute("courses", courseService.getAllCourses());
        model.addAttribute("selectedCourseId", courseId);
        return "course-register";
    }

    // 8. Submit student course registration
    @PostMapping("/courses/register/save")
    public String registerStudent(@RequestParam("courseId") Long courseId,
                                  @RequestParam("studentId") String studentId,
                                  @RequestParam("studentName") String studentName,
                                  RedirectAttributes redirectAttributes) {
        String result = courseService.registerStudent(courseId, studentId, studentName);
        if (result.startsWith("Error")) {
            redirectAttributes.addFlashAttribute("error", result);
        } else {
            redirectAttributes.addFlashAttribute("message", result);
        }
        return "redirect:/courses";
    }
}
