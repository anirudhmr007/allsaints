<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${isEdit ? 'Update Employee' : 'Add New Employee'} - Corporate HR</title>
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
        <div class="col-lg-8">
            <div class="card shadow-sm border-0">
                <div class="card-header bg-dark text-white py-3">
                    <h5 class="card-title mb-0 fw-bold">
                        <i class="bi ${isEdit ? 'bi-pencil-square' : 'bi-person-plus-fill'} text-warning me-2"></i>
                        ${isEdit ? 'Update Employee Profile' : 'Add New Employee'}
                    </h5>
                </div>
                <div class="card-body p-4">
                    <form action="${isEdit ? pageContext.request.contextPath.concat('/employees/update/').concat(employee.employeeId) : pageContext.request.contextPath.concat('/employees/new')}" method="post">
                        
                        <c:if test="${isEdit}">
                            <div class="mb-3">
                                <label class="form-label fw-semibold">Employee ID</label>
                                <input type="text" class="form-control" value="${employee.employeeId}" disabled>
                            </div>
                        </c:if>

                        <!-- Name & Age -->
                        <div class="row g-3 mb-3">
                            <div class="col-md-8">
                                <label for="name" class="form-label fw-semibold">Full Name <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" id="name" name="name" value="${employee.name}" placeholder="e.g. Alexander Wright" required>
                            </div>
                            <div class="col-md-4">
                                <label for="age" class="form-label fw-semibold">Age <span class="text-danger">*</span></label>
                                <input type="number" class="form-control" id="age" name="age" value="${employee.age}" min="18" max="75" placeholder="e.g. 30" required>
                            </div>
                        </div>

                        <!-- Gender, Contact & Email -->
                        <div class="row g-3 mb-3">
                            <div class="col-md-4">
                                <label for="gender" class="form-label fw-semibold">Gender <span class="text-danger">*</span></label>
                                <select class="form-select" id="gender" name="gender" required>
                                    <option value="" disabled ${empty employee.gender ? 'selected' : ''}>-- Select --</option>
                                    <option value="Male" ${employee.gender == 'Male' ? 'selected' : ''}>Male</option>
                                    <option value="Female" ${employee.gender == 'Female' ? 'selected' : ''}>Female</option>
                                    <option value="Other" ${employee.gender == 'Other' ? 'selected' : ''}>Other</option>
                                </select>
                            </div>
                            <div class="col-md-4">
                                <label for="contactNumber" class="form-label fw-semibold">Contact Number <span class="text-danger">*</span></label>
                                <input type="tel" class="form-control" id="contactNumber" name="contactNumber" value="${employee.contactNumber}" pattern="[0-9]{10}" placeholder="10-digit number" required>
                            </div>
                            <div class="col-md-4">
                                <label for="email" class="form-label fw-semibold">Email Address <span class="text-danger">*</span></label>
                                <input type="email" class="form-control" id="email" name="email" value="${employee.email}" placeholder="employee@company.com" required>
                            </div>
                        </div>

                        <!-- Address -->
                        <div class="mb-3">
                            <label for="address" class="form-label fw-semibold">Address <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" id="address" name="address" value="${employee.address}" placeholder="Street, City, Country" required>
                        </div>

                        <!-- Department & Designation -->
                        <div class="row g-3 mb-3">
                            <div class="col-md-6">
                                <label for="department" class="form-label fw-semibold">Department <span class="text-danger">*</span></label>
                                <select class="form-select" id="department" name="department" required>
                                    <option value="" disabled ${empty employee.department ? 'selected' : ''}>-- Select Department --</option>
                                    <option value="Engineering" ${employee.department == 'Engineering' ? 'selected' : ''}>Engineering</option>
                                    <option value="Human Resources" ${employee.department == 'Human Resources' ? 'selected' : ''}>Human Resources</option>
                                    <option value="Finance" ${employee.department == 'Finance' ? 'selected' : ''}>Finance</option>
                                    <option value="Product" ${employee.department == 'Product' ? 'selected' : ''}>Product</option>
                                    <option value="Marketing" ${employee.department == 'Marketing' ? 'selected' : ''}>Marketing</option>
                                    <option value="Operations" ${employee.department == 'Operations' ? 'selected' : ''}>Operations</option>
                                </select>
                            </div>
                            <div class="col-md-6">
                                <label for="designation" class="form-label fw-semibold">Designation <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" id="designation" name="designation" value="${employee.designation}" placeholder="e.g. Senior Software Engineer" required>
                            </div>
                        </div>

                        <!-- Date of Joining & Salary -->
                        <div class="row g-3 mb-4">
                            <div class="col-md-6">
                                <label for="dateOfJoining" class="form-label fw-semibold">Date of Joining <span class="text-danger">*</span></label>
                                <input type="date" class="form-control" id="dateOfJoining" name="dateOfJoining" value="${employee.dateOfJoining}" required>
                            </div>
                            <div class="col-md-6">
                                <label for="salary" class="form-label fw-semibold">Annual Salary ($) <span class="text-danger">*</span></label>
                                <input type="number" step="0.01" class="form-control" id="salary" name="salary" value="${employee.salary}" min="1" placeholder="e.g. 85000.00" required>
                            </div>
                        </div>

                        <div class="d-flex justify-content-between align-items-center">
                            <a href="${pageContext.request.contextPath}/employees/list" class="btn btn-outline-secondary">
                                <i class="bi bi-x-circle me-1"></i> Cancel
                            </a>
                            <button type="submit" class="btn btn-warning px-4 text-dark fw-bold">
                                <i class="bi ${isEdit ? 'bi-check-circle-fill' : 'bi-save-fill'} me-1"></i>
                                ${isEdit ? 'Save Changes' : 'Save Employee'}
                            </button>
                        </div>

                    </form>
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
