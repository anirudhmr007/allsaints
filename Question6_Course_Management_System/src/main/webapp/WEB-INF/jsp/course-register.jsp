<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Student Course Registration</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container mt-4" style="max-width: 600px;">
    <div class="card shadow">
        <div class="card-header bg-success text-white">
            <h4 class="mb-0">Register Student to Course</h4>
        </div>
        <div class="card-body p-4">
            <form action="${pageContext.request.contextPath}/courses/register/save" method="post">
                
                <div class="mb-3">
                    <label class="form-label fw-bold">Select Course:</label>
                    <select name="courseId" class="form-select" required>
                        <option value="">-- Choose Course --</option>
                        <c:forEach var="c" items="${courses}">
                            <option value="${c.courseId}" ${c.courseId == selectedCourseId ? 'selected' : ''}>
                                ${c.courseCode} - ${c.courseName} (Capacity: ${c.courseCapacity})
                            </option>
                        </c:forEach>
                    </select>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-bold">Student ID:</label>
                    <input type="text" name="studentId" class="form-control" placeholder="e.g. STU101" required>
                    <small class="text-muted">Duplicate student registrations are automatically blocked.</small>
                </div>

                <div class="mb-4">
                    <label class="form-label fw-bold">Student Name:</label>
                    <input type="text" name="studentName" class="form-control" placeholder="Student full name" required>
                </div>

                <div class="d-flex justify-content-between">
                    <a href="${pageContext.request.contextPath}/courses" class="btn btn-secondary">Cancel</a>
                    <button type="submit" class="btn btn-success fw-bold">Enroll Student</button>
                </div>
            </form>
        </div>
    </div>
</div>

</body>
</html>
