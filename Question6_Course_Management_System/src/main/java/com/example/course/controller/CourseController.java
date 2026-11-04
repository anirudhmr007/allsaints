package com.example.course.controller;

import com.example.course.entity.Course;
import com.example.course.service.CourseService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping({"/", "/courses"})
public class CourseController {

    private final CourseService courseService;

    @Autowired
    public CourseController(CourseService courseService) {
        this.courseService = courseService;
    }

    // Display all available courses in a JSP table
    @GetMapping({"", "/list"})
    public String listCourses(Model model) {
        List<Course> courses = courseService.getAllCourses();
        model.addAttribute("courses", courses);
        return "course-list";
    }

    // Show form to add a new course
    @GetMapping("/new")
    public String showAddCourseForm(Model model) {
        if (!model.containsAttribute("course")) {
            model.addAttribute("course", new Course());
        }
        model.addAttribute("isEdit", false);
        return "course-form";
    }

    // Add a new course and save details in PostgreSQL
    @PostMapping("/new")
    public String saveCourse(@Valid @ModelAttribute("course") Course course,
                             BindingResult result,
                             RedirectAttributes redirectAttributes,
                             Model model) {
        if (result.hasErrors()) {
            model.addAttribute("isEdit", false);
            return "course-form";
        }
        try {
            courseService.saveCourse(course);
            redirectAttributes.addFlashAttribute("successMessage",
                    "Course '" + course.getCourseName() + " (" + course.getCourseCode() + ")' added successfully!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Error adding course: " + e.getMessage());
            return "redirect:/courses/new";
        }
        return "redirect:/courses/list";
    }

    // Search for a course using Course ID
    @GetMapping("/search")
    public String searchCourse(@RequestParam(value = "courseId", required = false) Long courseId,
                               Model model) {
        if (courseId == null) {
            return "redirect:/courses/list";
        }

        Optional<Course> courseOpt = courseService.getCourseById(courseId);
        List<Course> searchResults = new ArrayList<>();
        if (courseOpt.isPresent()) {
            searchResults.add(courseOpt.get());
            model.addAttribute("searchSuccess", "Found course with ID: " + courseId);
        } else {
            model.addAttribute("searchError", "No course found with Course ID: " + courseId);
        }
        model.addAttribute("courses", searchResults);
        model.addAttribute("searchedId", courseId);
        return "course-list";
    }

    // View course details & registered students
    @GetMapping("/view/{id}")
    public String viewCourse(@PathVariable("id") Long id, Model model, RedirectAttributes redirectAttributes) {
        Optional<Course> courseOpt = courseService.getCourseById(id);
        if (courseOpt.isPresent()) {
            Course course = courseOpt.get();
            model.addAttribute("course", course);
            model.addAttribute("registrations", courseService.getCourseRegistrations(id));
            return "course-view";
        }
        redirectAttributes.addFlashAttribute("errorMessage", "Course not found with ID: " + id);
        return "redirect:/courses/list";
    }

    // Show edit course form
    @GetMapping("/edit/{id}")
    public String showEditCourseForm(@PathVariable("id") Long id, Model model, RedirectAttributes redirectAttributes) {
        Optional<Course> courseOpt = courseService.getCourseById(id);
        if (courseOpt.isPresent()) {
            model.addAttribute("course", courseOpt.get());
            model.addAttribute("isEdit", true);
            return "course-form";
        }
        redirectAttributes.addFlashAttribute("errorMessage", "Course not found with ID: " + id);
        return "redirect:/courses/list";
    }

    // Update course details
    @PostMapping("/update/{id}")
    public String updateCourse(@PathVariable("id") Long id,
                               @Valid @ModelAttribute("course") Course course,
                               BindingResult result,
                               RedirectAttributes redirectAttributes,
                               Model model) {
        if (result.hasErrors()) {
            model.addAttribute("isEdit", true);
            return "course-form";
        }
        try {
            courseService.updateCourse(id, course);
            redirectAttributes.addFlashAttribute("successMessage", "Course ID " + id + " updated successfully!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Error updating course: " + e.getMessage());
        }
        return "redirect:/courses/list";
    }

    // Delete a course record using Course ID
    @GetMapping("/delete/{id}")
    public String deleteCourse(@PathVariable("id") Long id, RedirectAttributes redirectAttributes) {
        boolean deleted = courseService.deleteCourseById(id);
        if (deleted) {
            redirectAttributes.addFlashAttribute("successMessage", "Course with ID " + id + " deleted successfully!");
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "Course with ID " + id + " not found.");
        }
        return "redirect:/courses/list";
    }

    // Show student registration form for a course
    @GetMapping("/register-student")
    public String showRegisterStudentForm(@RequestParam("courseId") Long courseId, Model model, RedirectAttributes redirectAttributes) {
        Optional<Course> courseOpt = courseService.getCourseById(courseId);
        if (courseOpt.isEmpty()) {
            redirectAttributes.addFlashAttribute("errorMessage", "Course not found.");
            return "redirect:/courses/list";
        }
        model.addAttribute("course", courseOpt.get());
        return "course-register-student";
    }

    // Process student registration with capacity and duplicate validation
    @PostMapping("/register-student")
    public String processStudentRegistration(@RequestParam("courseId") Long courseId,
                                            @RequestParam("studentId") String studentId,
                                            @RequestParam("studentName") String studentName,
                                            @RequestParam("studentEmail") String studentEmail,
                                            RedirectAttributes redirectAttributes) {
        try {
            courseService.registerStudent(courseId, studentId, studentName, studentEmail);
            redirectAttributes.addFlashAttribute("successMessage",
                    "Student '" + studentName + " (" + studentId + ")' successfully registered for course!");
            return "redirect:/courses/view/" + courseId;
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
            return "redirect:/courses/register-student?courseId=" + courseId;
        }
    }
}
