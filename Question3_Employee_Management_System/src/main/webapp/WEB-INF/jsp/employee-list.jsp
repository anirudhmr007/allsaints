<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Employee Management System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container mt-4">
    <!-- Header -->
    <div class="d-flex justify-content-between align-items-center mb-3 pb-2 border-bottom">
        <h2 class="text-dark">Employee Management System</h2>
        <a href="${pageContext.request.contextPath}/employees/add" class="btn btn-dark fw-bold">+ Add New Employee</a>
    </div>

    <!-- Alert Messages -->
    <c:if test="${not empty message}">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            ${message}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="alert alert-warning alert-dismissible fade show" role="alert">
            ${error}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <!-- Search by Employee ID -->
    <div class="card p-3 mb-4 shadow-sm bg-white">
        <form action="${pageContext.request.contextPath}/employees/search" method="get" class="row g-2 align-items-center">
            <div class="col-auto">
                <label class="fw-bold">Search Employee by ID:</label>
            </div>
            <div class="col-auto">
                <input type="number" name="employeeId" class="form-control" placeholder="Enter Employee ID" value="${searchedId}" required>
            </div>
            <div class="col-auto">
                <button type="submit" class="btn btn-outline-dark">Search</button>
                <a href="${pageContext.request.contextPath}/employees" class="btn btn-secondary">Show All</a>
            </div>
        </form>
    </div>

    <!-- Employees Table -->
    <div class="card shadow-sm">
        <div class="card-header bg-dark text-white">
            <h5 class="mb-0">All Registered Employees</h5>
        </div>
        <div class="card-body p-0">
            <table class="table table-striped table-hover mb-0">
                <thead class="table-light">
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Age</th>
                        <th>Gender</th>
                        <th>Department</th>
                        <th>Designation</th>
                        <th>Contact</th>
                        <th>Email</th>
                        <th>Joining Date</th>
                        <th>Salary ($)</th>
                        <th class="text-center">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${not empty employees}">
                            <c:forEach var="e" items="${employees}">
                                <tr>
                                    <td><strong>#${e.employeeId}</strong></td>
                                    <td>${e.name}</td>
                                    <td>${e.age}</td>
                                    <td>${e.gender}</td>
                                    <td><span class="badge bg-secondary">${e.department}</span></td>
                                    <td>${e.designation}</td>
                                    <td>${e.contactNumber}</td>
                                    <td>${e.email}</td>
                                    <td>${e.dateOfJoining}</td>
                                    <td class="text-success fw-bold">${e.salary}</td>
                                    <td class="text-center">
                                        <a href="${pageContext.request.contextPath}/employees/edit/${e.employeeId}" class="btn btn-sm btn-warning">Edit</a>
                                        <a href="${pageContext.request.contextPath}/employees/delete/${e.employeeId}" 
                                           class="btn btn-sm btn-danger"
                                           onclick="return confirm('Delete employee #${e.employeeId}?');">Delete</a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr>
                                <td colspan="11" class="text-center py-4 text-muted">No employee records found.</td>
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
