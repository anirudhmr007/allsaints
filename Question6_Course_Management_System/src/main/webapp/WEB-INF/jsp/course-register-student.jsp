<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register Student - ${course.courseCode}</title>
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
        <div class="col-lg-7">

            <!-- Flash Error -->
            <c:if test="${not empty errorMessage}">
                <div class="alert alert-danger alert-dismissible fade show shadow-sm" role="alert">
                    <i class="bi bi-exclamation-triangle-fill me-2"></i> ${errorMessage}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>

            <div class="card shadow-sm border-0">
                <div class="card-header bg-success text-white py-3">
                    <h5 class="card-title mb-0 fw-bold">
                        <i class="bi bi-person-plus-fill me-2"></i>Student Registration for Course: ${course.courseCode}
                    </h5>
                </div>
                <div class="card-body p-4">

                    <!-- Course Snapshot -->
                    <div class="alert alert-info d-flex justify-content-between align-items-center mb-4">
                        <div>
                            <strong>${course.courseName}</strong><br>
                            <small class="text-muted">Faculty: ${course.facultyName} &bull; ${course.semester}</small>
                        </div>
                        <div class="text-end">
                            <span class="badge ${course.full ? 'bg-danger' : 'bg-primary'} fs-6">
                                ${course.enrolledCount} / ${course.courseCapacity} Seats Filled
                            </span>
                        </div>
                    </div>

                    <form action="${pageContext.request.contextPath}/courses/register-student" method="post">
                        <input type="hidden" name="courseId" value="${course.courseId}">

                        <div class="mb-3">
                            <label for="studentId" class="form-label fw-semibold">Student ID <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" id="studentId" name="studentId" placeholder="e.g. STU1024" required>
                            <div class="form-text">System will automatically reject duplicate registrations for the same student ID.</div>
                        </div>

                        <div class="mb-3">
                            <label for="studentName" class="form-label fw-semibold">Student Full Name <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" id="studentName" name="studentName" placeholder="e.g. Alice Vance" required>
                        </div>

                        <div class="mb-4">
                            <label for="studentEmail" class="form-label fw-semibold">Student University Email <span class="text-danger">*</span></label>
                            <input type="email" class="form-control" id="studentEmail" name="studentEmail" placeholder="e.g. alice.vance@university.edu" required>
                            <div class="form-text">Validates that email has not already registered for this course.</div>
                        </div>

                        <div class="d-flex justify-content-between align-items-center">
                            <a href="${pageContext.request.contextPath}/courses/view/${course.courseId}" class="btn btn-outline-secondary">
                                <i class="bi bi-x-circle me-1"></i> Cancel
                            </a>
                            <button type="submit" class="btn btn-success px-4 fw-bold">
                                <i class="bi bi-check-circle-fill me-1"></i> Complete Registration
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

