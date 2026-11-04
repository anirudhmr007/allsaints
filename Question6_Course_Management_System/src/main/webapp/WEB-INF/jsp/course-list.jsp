<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Course Management System</title>
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
            <a class="nav-link text-white active" href="${pageContext.request.contextPath}/courses/list">
                <i class="bi bi-journal-text me-1"></i> Course Offerings
            </a>
            <a class="btn btn-info btn-sm text-dark fw-bold ms-2" href="${pageContext.request.contextPath}/courses/new">
                <i class="bi bi-plus-circle-fill me-1"></i> Add New Course
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
    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger alert-dismissible fade show shadow-sm" role="alert">
            <i class="bi bi-exclamation-triangle-fill me-2"></i> ${errorMessage}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>
    <c:if test="${not empty searchSuccess}">
        <div class="alert alert-info alert-dismissible fade show shadow-sm" role="alert">
            <i class="bi bi-info-circle-fill me-2"></i> ${searchSuccess}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>
    <c:if test="${not empty searchError}">
        <div class="alert alert-warning alert-dismissible fade show shadow-sm" role="alert">
            <i class="bi bi-exclamation-circle-fill me-2"></i> ${searchError}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <!-- Header & Search Controls -->
    <div class="card shadow-sm border-0 mb-4">
        <div class="card-body">
            <div class="row align-items-center g-3">
                <div class="col-md-6">
                    <h4 class="card-title fw-bold text-dark mb-1">
                        <i class="bi bi-mortarboard me-2 text-primary"></i>Available Courses Catalog
                    </h4>
                    <p class="text-muted small mb-0">Total Courses: ${courses.size()}</p>
                </div>
                <div class="col-md-6">
                    <form action="${pageContext.request.contextPath}/courses/search" method="get" class="d-flex gap-2">
                        <div class="input-group">
                            <span class="input-group-text bg-white"><i class="bi bi-search"></i></span>
                            <input type="number" name="courseId" class="form-control" placeholder="Search by Course ID..." value="${searchedId}" required>
                            <button class="btn btn-outline-dark" type="submit">Search</button>
                        </div>
                        <c:if test="${not empty searchedId}">
                            <a href="${pageContext.request.contextPath}/courses/list" class="btn btn-secondary">Reset</a>
                        </c:if>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Courses Table -->
    <div class="card shadow-sm border-0">
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead class="table-dark text-white">
                        <tr>
                            <th class="ps-3">ID</th>
                            <th>Code</th>
                            <th>Course Name</th>
                            <th>Department</th>
                            <th>Faculty</th>
                            <th>Credits</th>
                            <th>Semester</th>
                            <th>Enrollment / Capacity</th>
                            <th>Status</th>
                            <th class="text-center pe-3">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${not empty courses}">
                                <c:forEach var="course" items="${courses}">
                                    <tr>
                                        <td class="ps-3 fw-bold text-primary">#${course.courseId}</td>
                                        <td><span class="badge bg-primary fs-6">${course.courseCode}</span></td>
                                        <td class="fw-semibold">${course.courseName}</td>
                                        <td>${course.department}</td>
                                        <td><small class="text-muted">${course.facultyName}</small></td>
                                        <td>${course.credits} Credits</td>
                                        <td>${course.semester}</td>
                                        <td>
                                            <div class="d-flex align-items-center gap-2">
                                                <strong>${course.enrolledCount}</strong> / ${course.courseCapacity}
                                                <div class="progress flex-grow-1" style="height: 6px; min-width: 60px;">
                                                    <div class="progress-bar ${course.full ? 'bg-danger' : 'bg-success'}" 
                                                         style="width: ${(course.enrolledCount * 100) / course.courseCapacity}%;">
                                                    </div>
                                                </div>
                                            </div>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${course.full}">
                                                    <span class="badge bg-danger">Capacity Full</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-success">${course.availableSeats} Seats Left</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="text-center pe-3">
                                            <div class="btn-group btn-group-sm">
                                                <a href="${pageContext.request.contextPath}/courses/register-student?courseId=${course.courseId}" 
                                                   class="btn ${course.full ? 'btn-outline-secondary disabled' : 'btn-outline-success'}" 
                                                   title="Register Student">
                                                    <i class="bi bi-person-plus"></i> Enroll
                                                </a>
                                                <a href="${pageContext.request.contextPath}/courses/view/${course.courseId}" class="btn btn-outline-info" title="View Course & Roster">
                                                    <i class="bi bi-eye"></i>
                                                </a>
                                                <a href="${pageContext.request.contextPath}/courses/edit/${course.courseId}" class="btn btn-outline-warning" title="Edit Course">
                                                    <i class="bi bi-pencil-square"></i>
                                                </a>
                                                <a href="${pageContext.request.contextPath}/courses/delete/${course.courseId}" 
                                                   class="btn btn-outline-danger" 
                                                   onclick="return confirm('Are you sure you want to delete course #${course.courseId} (${course.courseName})?');"
                                                   title="Delete Course">
                                                    <i class="bi bi-trash"></i>
                                                </a>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="10" class="text-center py-5 text-muted">
                                        <i class="bi bi-journal-x fs-1 d-block mb-2 text-secondary"></i>
                                        No course offerings found.
                                        <div class="mt-2">
                                            <a href="${pageContext.request.contextPath}/courses/new" class="btn btn-info btn-sm text-dark fw-bold">
                                                <i class="bi bi-plus-circle-fill me-1"></i> Add First Course
                                            </a>
                                        </div>
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

<footer class="text-center text-muted py-4 mt-5">
    <small>&copy; Course Management System | Spring Boot MVC + PostgreSQL + JSP</small>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
