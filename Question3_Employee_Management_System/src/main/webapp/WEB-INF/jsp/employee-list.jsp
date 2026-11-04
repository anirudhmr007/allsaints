<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Employee Management System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<nav class="navbar navbar-expand-lg navbar-dark bg-dark shadow-sm mb-4">
    <div class="container">
        <a class="navbar-brand fw-bold" href="${pageContext.request.contextPath}/employees/list">
            <i class="bi bi-briefcase-fill text-warning me-2"></i>Corporate HR Portal
        </a>
        <div class="navbar-nav ms-auto">
            <a class="nav-link text-white active" href="${pageContext.request.contextPath}/employees/list">
                <i class="bi bi-people me-1"></i> Employees
            </a>
            <a class="btn btn-warning btn-sm ms-2 text-dark fw-semibold" href="${pageContext.request.contextPath}/employees/new">
                <i class="bi bi-person-plus-fill me-1"></i> Add New Employee
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
                        <i class="bi bi-person-lines-fill text-warning me-2"></i>Registered Employees Directory
                    </h4>
                    <p class="text-muted small mb-0">Total Employees: ${employees.size()}</p>
                </div>
                <div class="col-md-6">
                    <form action="${pageContext.request.contextPath}/employees/search" method="get" class="d-flex gap-2">
                        <div class="input-group">
                            <span class="input-group-text bg-white"><i class="bi bi-search"></i></span>
                            <input type="number" name="employeeId" class="form-control" placeholder="Search by Employee ID..." value="${searchedId}" required>
                            <button class="btn btn-outline-dark" type="submit">Search</button>
                        </div>
                        <c:if test="${not empty searchedId}">
                            <a href="${pageContext.request.contextPath}/employees/list" class="btn btn-secondary">Reset</a>
                        </c:if>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Employees Table -->
    <div class="card shadow-sm border-0">
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead class="table-dark text-white">
                        <tr>
                            <th class="ps-3">ID</th>
                            <th>Name</th>
                            <th>Age/Gender</th>
                            <th>Department</th>
                            <th>Designation</th>
                            <th>Contact</th>
                            <th>Email</th>
                            <th>Date of Joining</th>
                            <th>Salary</th>
                            <th class="text-center pe-3">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${not empty employees}">
                                <c:forEach var="emp" items="${employees}">
                                    <tr>
                                        <td class="ps-3 fw-bold text-primary">#${emp.employeeId}</td>
                                        <td class="fw-semibold">${emp.name}</td>
                                        <td>${emp.age} yrs &bull; <small class="text-muted">${emp.gender}</small></td>
                                        <td><span class="badge bg-secondary">${emp.department}</span></td>
                                        <td>${emp.designation}</td>
                                        <td>${emp.contactNumber}</td>
                                        <td><small class="text-muted">${emp.email}</small></td>
                                        <td>${emp.dateOfJoining}</td>
                                        <td class="fw-bold text-success">
                                            $<fmt:formatNumber value="${emp.salary}" type="number" minFractionDigits="2" maxFractionDigits="2"/>
                                        </td>
                                        <td class="text-center pe-3">
                                            <div class="btn-group btn-group-sm">
                                                <a href="${pageContext.request.contextPath}/employees/view/${emp.employeeId}" class="btn btn-outline-info" title="View Details">
                                                    <i class="bi bi-eye"></i>
                                                </a>
                                                <a href="${pageContext.request.contextPath}/employees/edit/${emp.employeeId}" class="btn btn-outline-warning" title="Edit Employee">
                                                    <i class="bi bi-pencil-square"></i>
                                                </a>
                                                <a href="${pageContext.request.contextPath}/employees/delete/${emp.employeeId}" 
                                                   class="btn btn-outline-danger" 
                                                   onclick="return confirm('Are you sure you want to delete employee #${emp.employeeId} (${emp.name})?');"
                                                   title="Delete Employee">
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
                                        <i class="bi bi-people fs-1 d-block mb-2 text-secondary"></i>
                                        No employee records found.
                                        <div class="mt-2">
                                            <a href="${pageContext.request.contextPath}/employees/new" class="btn btn-dark btn-sm">
                                                <i class="bi bi-person-plus-fill me-1"></i> Add First Employee
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
    <small>&copy; Employee Management System | Spring Boot MVC + PostgreSQL + JSP</small>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
