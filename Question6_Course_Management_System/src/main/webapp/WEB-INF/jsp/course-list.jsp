<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Course Management System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container mt-4">
    <!-- Header -->
    <div class="d-flex justify-content-between align-items-center mb-3 pb-2 border-bottom">
        <h2 class="text-primary">Course Management System</h2>
        <div>
            <a href="${pageContext.request.contextPath}/courses/register" class="btn btn-success fw-bold me-2">Register Student</a>
            <a href="${pageContext.request.contextPath}/courses/add" class="btn btn-primary fw-bold">+ Add New Course</a>
        </div>
    </div>

    <!-- Alert Messages -->
    <c:if test="${not empty message}">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            ${message}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            ${error}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <!-- Search by Course ID -->
    <div class="card p-3 mb-4 shadow-sm bg-white">
        <form action="${pageContext.request.contextPath}/courses/search" method="get" class="row g-2 align-items-center">
            <div class="col-auto">
                <label class="fw-bold">Search Course by ID:</label>
            </div>
            <div class="col-auto">
                <input type="number" name="courseId" class="form-control" placeholder="Enter Course ID" value="${searchedId}" required>
            </div>
            <div class="col-auto">
                <button type="submit" class="btn btn-outline-primary">Search</button>
                <a href="${pageContext.request.contextPath}/courses" class="btn btn-secondary">Show All</a>
            </div>
        </form>
    </div>

    <!-- Courses Table -->
    <div class="card shadow-sm">
        <div class="card-header bg-primary text-white">
            <h5 class="mb-0">Available Courses</h5>
        </div>
        <div class="card-body p-0">
            <table class="table table-striped table-hover mb-0">
                <thead class="table-light">
                    <tr>
                        <th>Course ID</th>
                        <th>Course Code</th>
                        <th>Course Name</th>
                        <th>Department</th>
                        <th>Faculty</th>
                        <th>Credits</th>
                        <th>Semester</th>
                        <th>Enrolled / Capacity</th>
                        <th>Status</th>
                        <th class="text-center">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${not empty courses}">
                            <c:forEach var="c" items="${courses}">
                                <c:set var="enrolled" value="${enrolledMap[c.courseId]}" />
                                <tr>
                                    <td><strong>#${c.courseId}</strong></td>
                                    <td><span class="badge bg-primary">${c.courseCode}</span></td>
                                    <td>${c.courseName}</td>
                                    <td>${c.department}</td>
                                    <td>${c.facultyName}</td>
                                    <td>${c.credits}</td>
                                    <td>${c.semester}</td>
                                    <td><strong>${enrolled}</strong> / ${c.courseCapacity}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${enrolled >= c.courseCapacity}">
                                                <span class="badge bg-danger">Full</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-success">${c.courseCapacity - enrolled} seats open</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="text-center">
                                        <a href="${pageContext.request.contextPath}/courses/register?courseId=${c.courseId}" class="btn btn-sm btn-outline-success">Enroll</a>
                                        <a href="${pageContext.request.contextPath}/courses/edit/${c.courseId}" class="btn btn-sm btn-warning">Edit</a>
                                        <a href="${pageContext.request.contextPath}/courses/delete/${c.courseId}" 
                                           class="btn btn-sm btn-danger"
                                           onclick="return confirm('Delete course #${c.courseId}?');">Delete</a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr>
                                <td colspan="10" class="text-center py-4 text-muted">No course records found.</td>
                            </tr>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
