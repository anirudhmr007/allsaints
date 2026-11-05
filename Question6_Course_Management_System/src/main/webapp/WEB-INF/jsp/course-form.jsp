<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${pageTitle}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container mt-4" style="max-width: 650px;">
    <div class="card shadow">
        <div class="card-header bg-primary text-white">
            <h4 class="mb-0">${pageTitle}</h4>
        </div>
        <div class="card-body p-4">
            <form action="${pageContext.request.contextPath}/courses/save" method="post">
                <input type="hidden" name="courseId" value="${course.courseId}">

                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label fw-bold">Course Code:</label>
                        <input type="text" name="courseCode" class="form-control" value="${course.courseCode}" placeholder="e.g. CS101" required>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label fw-bold">Course Name:</label>
                        <input type="text" name="courseName" class="form-control" value="${course.courseName}" placeholder="Course name" required>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label fw-bold">Department:</label>
                        <input type="text" name="department" class="form-control" value="${course.department}" placeholder="Department" required>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label fw-bold">Faculty Name:</label>
                        <input type="text" name="facultyName" class="form-control" value="${course.facultyName}" placeholder="Instructor name" required>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-4 mb-3">
                        <label class="form-label fw-bold">Credits:</label>
                        <input type="number" name="credits" class="form-control" value="${course.credits}" min="1" max="10" placeholder="Credits" required>
                    </div>
                    <div class="col-md-4 mb-3">
                        <label class="form-label fw-bold">Semester:</label>
                        <input type="text" name="semester" class="form-control" value="${course.semester}" placeholder="e.g. Sem 1" required>
                    </div>
                    <div class="col-md-4 mb-3">
                        <label class="form-label fw-bold">Course Capacity:</label>
                        <input type="number" name="courseCapacity" class="form-control" value="${course.courseCapacity}" min="1" placeholder="Max students" required>
                    </div>
                </div>

                <div class="d-flex justify-content-between mt-4">
                    <a href="${pageContext.request.contextPath}/courses" class="btn btn-secondary">Cancel</a>
                    <button type="submit" class="btn btn-primary fw-bold">Save Course</button>
                </div>
            </form>
        </div>
    </div>
</div>

</body>
</html>
