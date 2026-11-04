<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Employee Profile - #${employee.employeeId}</title>
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
            <a class="nav-link text-white" href="${pageContext.request.contextPath}/employees/list">
                <i class="bi bi-arrow-left me-1"></i> Back to Directory
            </a>
        </div>
    </div>
</nav>

<div class="container">
    <div class="row justify-content-center">
        <div class="col-lg-7">
            <div class="card shadow-sm border-0">
                <div class="card-header bg-dark text-white py-3 d-flex justify-content-between align-items-center">
                    <h5 class="card-title mb-0 fw-bold">
                        <i class="bi bi-person-badge-fill text-warning me-2"></i>Employee Profile: #${employee.employeeId}
                    </h5>
                    <span class="badge bg-warning text-dark px-3 py-2 fs-6 fw-bold">
                        ${employee.department}
                    </span>
                </div>
                <div class="card-body p-4">
                    <div class="text-center mb-4">
                        <div class="display-6 fw-bold text-dark">${employee.name}</div>
                        <p class="text-muted mb-0">${employee.designation} &bull; ${employee.gender}, ${employee.age} Years Old</p>
                    </div>

                    <table class="table table-bordered align-middle">
                        <tbody>
                            <tr>
                                <th class="bg-light text-secondary" style="width: 35%;">Employee ID</th>
                                <td class="fw-bold text-primary">#${employee.employeeId}</td>
                            </tr>
                            <tr>
                                <th class="bg-light text-secondary">Department</th>
                                <td><span class="badge bg-secondary">${employee.department}</span></td>
                            </tr>
                            <tr>
                                <th class="bg-light text-secondary">Designation</th>
                                <td>${employee.designation}</td>
                            </tr>
                            <tr>
                                <th class="bg-light text-secondary">Contact Number</th>
                                <td>${employee.contactNumber}</td>
                            </tr>
                            <tr>
                                <th class="bg-light text-secondary">Email Address</th>
                                <td><a href="mailto:${employee.email}">${employee.email}</a></td>
                            </tr>
                            <tr>
                                <th class="bg-light text-secondary">Residential Address</th>
                                <td>${employee.address}</td>
                            </tr>
                            <tr>
                                <th class="bg-light text-secondary">Date of Joining</th>
                                <td>${employee.dateOfJoining}</td>
                            </tr>
                            <tr>
                                <th class="bg-light text-secondary">Annual Salary</th>
                                <td><strong class="text-success fs-5">$<fmt:formatNumber value="${employee.salary}" type="number" minFractionDigits="2" maxFractionDigits="2"/></strong></td>
                            </tr>
                        </tbody>
                    </table>

                    <div class="d-flex justify-content-between mt-4">
                        <a href="${pageContext.request.contextPath}/employees/list" class="btn btn-secondary">
                            <i class="bi bi-arrow-left me-1"></i> Back to Directory
                        </a>
                        <div class="d-flex gap-2">
                            <a href="${pageContext.request.contextPath}/employees/edit/${employee.employeeId}" class="btn btn-warning text-dark fw-semibold">
                                <i class="bi bi-pencil-square me-1"></i> Edit
                            </a>
                            <a href="${pageContext.request.contextPath}/employees/delete/${employee.employeeId}" 
                               class="btn btn-danger"
                               onclick="return confirm('Are you sure you want to delete employee #${employee.employeeId}?');">
                                <i class="bi bi-trash me-1"></i> Delete
                            </a>
                        </div>
                    </div>
                </div>
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

