<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Course Details & Class Roster - ${course.courseCode}</title>
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

    <!-- Flash Alerts -->
    <c:if test="${not empty successMessage}">
        <div class="alert alert-success alert-dismissible fade show shadow-sm" role="alert">
            <i class="bi bi-check-circle-fill me-2"></i> ${successMessage}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <div class="row g-4">
        
        <!-- Course Summary Card -->
        <div class="col-lg-5">
            <div class="card shadow-sm border-0">
                <div class="card-header bg-dark text-white py-3 d-flex justify-content-between align-items-center">
                    <h5 class="card-title mb-0 fw-bold">
                        <i class="bi bi-book-half text-info me-2"></i>${course.courseCode}
                    </h5>
                    <span class="badge ${course.full ? 'bg-danger' : 'bg-success'} px-3 py-2">
                        ${course.full ? 'Class Full' : 'Open for Enrollment'}
                    </span>
                </div>
                <div class="card-body p-4">
                    <h4 class="fw-bold mb-1">${course.courseName}</h4>
                    <p class="text-muted mb-3">${course.department} &bull; ${course.semester}</p>

                    <table class="table table-bordered align-middle">
                        <tbody>
                            <tr>
                                <th class="bg-light" style="width: 40%;">Course ID</th>
                                <td>#${course.courseId}</td>
                            </tr>
                            <tr>
                                <th class="bg-light">Faculty Name</th>
                                <td>${course.facultyName}</td>
                            </tr>
                            <tr>
                                <th class="bg-light">Credits</th>
                                <td>${course.credits} Credits</td>
                            </tr>
                            <tr>
                                <th class="bg-light">Class Capacity</th>
                                <td><strong>${course.courseCapacity} students</strong></td>
                            </tr>
                            <tr>
                                <th class="bg-light">Enrolled Students</th>
                                <td><span class="badge ${course.full ? 'bg-danger' : 'bg-primary'} fs-6">${course.enrolledCount} enrolled</span></td>
                            </tr>
                            <tr>
                                <th class="bg-light">Available Seats</th>
                                <td><strong class="text-success fs-6">${course.availableSeats} remaining</strong></td>
                            </tr>
                        </tbody>
                    </table>

                    <div class="d-grid gap-2 mt-4">
                        <c:choose>
                            <c:when test="${!course.full}">
                                <a href="${pageContext.request.contextPath}/courses/register-student?courseId=${course.courseId}" class="btn btn-success fw-bold">
                                    <i class="bi bi-person-plus-fill me-1"></i> Register Student to this Course
                                </a>
                            </c:when>
                            <c:otherwise>
                                <button class="btn btn-secondary fw-bold" disabled>
                                    <i class="bi bi-slash-circle me-1"></i> Enrollment Closed (Capacity Full)
                                </button>
                            </c:otherwise>
                        </c:choose>
                        <a href="${pageContext.request.contextPath}/courses/edit/${course.courseId}" class="btn btn-outline-warning">
                            <i class="bi bi-pencil-square me-1"></i> Edit Course Information
                        </a>
                    </div>
                </div>
            </div>
        </div>

        <!-- Enrolled Students Roster -->
        <div class="col-lg-7">
            <div class="card shadow-sm border-0">
                <div class="card-header bg-white py-3 border-bottom d-flex justify-content-between align-items-center">
                    <h5 class="card-title mb-0 fw-bold text-dark">
                        <i class="bi bi-people-fill text-primary me-2"></i>Enrolled Students Roster
                    </h5>
                    <span class="badge bg-secondary">${registrations.size()} Registered</span>
                </div>
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-hover align-middle mb-0">
                            <thead class="table-light">
                                <tr>
                                    <th class="ps-3">Reg ID</th>
                                    <th>Student ID</th>
                                    <th>Student Name</th>
                                    <th>Email</th>
                                    <th>Registered On</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:choose>
                                    <c:when test="${not empty registrations}">
                                        <c:forEach var="reg" items="${registrations}">
                                            <tr>
                                                <td class="ps-3 fw-bold text-muted">#${reg.registrationId}</td>
                                                <td><span class="badge bg-dark">${reg.studentId}</span></td>
                                                <td class="fw-semibold">${reg.studentName}</td>
                                                <td><small class="text-muted">${reg.studentEmail}</small></td>
                                                <td><small>${reg.registrationDate}</small></td>
                                            </tr>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <tr>
                                            <td colspan="5" class="text-center py-4 text-muted">
                                                <i class="bi bi-person-dash fs-3 d-block mb-1 text-secondary"></i>
                                                No students have registered for this course yet.
                                            </td>
                                        </tr>
                                    </c:otherwise>
                                </c:choose>
                            </tbody>
                        </table>
                    </div>
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
