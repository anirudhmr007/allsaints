<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${isEdit ? 'Update Course' : 'Add New Course'} - Academic Portal</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<nav class="navbar navbar-expand-lg navbar-dark bg-dark shadow-sm mb-4">
    <div class="container">
        <a class="navbar-brand fw-bold text-info" href="${pageContext.request.contextPath}/courses/list">
            <i class="bi bi-mortarboard-fill me-2"></i>University Academic Course Portal
        </a>
        <div class="navbar-nav ms-auto">
            <a class="nav-link text-white" href="${pageContext.request.contextPath}/courses/list">
                <i class="bi bi-arrow-left me-1"></i> Back to Offerings
            </a>
        </div>
    </div>
</nav>

<div class="container">
    <div class="row justify-content-center">
        <div class="col-lg-8">
            <div class="card shadow-sm border-0">
                <div class="card-header bg-dark text-white py-3">
                    <h5 class="card-title mb-0 fw-bold">
                        <i class="bi ${isEdit ? 'bi-pencil-square' : 'bi-plus-circle-fill'} text-info me-2"></i>
                        ${isEdit ? 'Update Course Curriculum' : 'Add New Academic Course'}
                    </h5>
                </div>
                <div class="card-body p-4">
                    <form action="${isEdit ? pageContext.request.contextPath.concat('/courses/update/').concat(course.courseId) : pageContext.request.contextPath.concat('/courses/new')}" method="post">
                        
                        <!-- Course Code & Name -->
                        <div class="row g-3 mb-3">
                            <div class="col-md-4">
                                <label for="courseCode" class="form-label fw-semibold">Course Code <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" id="courseCode" name="courseCode" value="${course.courseCode}" ${isEdit ? 'readonly' : ''} placeholder="e.g. CS101" required>
                            </div>
                            <div class="col-md-8">
                                <label for="courseName" class="form-label fw-semibold">Course Name <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" id="courseName" name="courseName" value="${course.courseName}" placeholder="e.g. Introduction to Computer Science" required>
                            </div>
                        </div>

                        <!-- Department & Faculty Name -->
                        <div class="row g-3 mb-3">
                            <div class="col-md-6">
                                <label for="department" class="form-label fw-semibold">Department <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" id="department" name="department" value="${course.department}" placeholder="e.g. Computer Science" required>
                            </div>
                            <div class="col-md-6">
                                <label for="facultyName" class="form-label fw-semibold">Faculty / Professor Name <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" id="facultyName" name="facultyName" value="${course.facultyName}" placeholder="e.g. Dr. Alan Turing" required>
                            </div>
                        </div>

                        <!-- Credits, Semester, Course Capacity -->
                        <div class="row g-3 mb-4">
                            <div class="col-md-4">
                                <label for="credits" class="form-label fw-semibold">Credits <span class="text-danger">*</span></label>
                                <input type="number" class="form-control" id="credits" name="credits" value="${course.credits}" min="1" max="10" placeholder="e.g. 4" required>
                            </div>
                            <div class="col-md-4">
                                <label for="semester" class="form-label fw-semibold">Semester <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" id="semester" name="semester" value="${course.semester}" placeholder="e.g. Semester 1, Fall 2024" required>
                            </div>
                            <div class="col-md-4">
                                <label for="courseCapacity" class="form-label fw-semibold">Course Capacity <span class="text-danger">*</span></label>
                                <input type="number" class="form-control" id="courseCapacity" name="courseCapacity" value="${course.courseCapacity}" min="1" placeholder="Max students" required>
                            </div>
                        </div>

                        <div class="d-flex justify-content-between align-items-center">
                            <a href="${pageContext.request.contextPath}/courses/list" class="btn btn-outline-secondary">
                                <i class="bi bi-x-circle me-1"></i> Cancel
                            </a>
                            <button type="submit" class="btn btn-info px-4 fw-bold text-dark">
                                <i class="bi ${isEdit ? 'bi-check-circle-fill' : 'bi-save-fill'} me-1"></i>
                                ${isEdit ? 'Save Changes' : 'Create Course'}
                            </button>
                        </div>

                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<footer class="text-center text-muted py-4 mt-5">
    <small>&copy; Course Management System | Spring Boot MVC + PostgreSQL + JSP</small>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

