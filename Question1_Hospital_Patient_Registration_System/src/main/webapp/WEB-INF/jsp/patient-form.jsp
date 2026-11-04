<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${isEdit ? 'Update Patient' : 'Register New Patient'} - City Care Hospital</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<nav class="navbar navbar-expand-lg navbar-dark bg-primary shadow-sm mb-4">
    <div class="container">
        <a class="navbar-brand fw-bold" href="${pageContext.request.contextPath}/patients/list">
            <i class="bi bi-hospital me-2"></i>City Care Hospital System
        </a>
        <div class="navbar-nav ms-auto">
            <a class="nav-link text-white" href="${pageContext.request.contextPath}/patients/list">
                <i class="bi bi-arrow-left me-1"></i> Back to Patient Directory
            </a>
        </div>
    </div>
</nav>

<div class="container">
    <div class="row justify-content-center">
        <div class="col-lg-8">
            <div class="card shadow-sm border-0">
                <div class="card-header bg-primary text-white py-3">
                    <h5 class="card-title mb-0 fw-bold">
                        <i class="bi ${isEdit ? 'bi-pencil-square' : 'bi-person-plus-fill'} me-2"></i>
                        ${isEdit ? 'Update Patient Details' : 'Register New Patient'}
                    </h5>
                </div>
                <div class="card-body p-4">
                    <form action="${isEdit ? pageContext.request.contextPath.concat('/patients/update/').concat(patient.patientId) : pageContext.request.contextPath.concat('/patients/register')}" method="post">
                        
                        <c:if test="${isEdit}">
                            <div class="mb-3">
                                <label class="form-label fw-semibold">Patient ID</label>
                                <input type="text" class="form-control" value="${patient.patientId}" disabled>
                            </div>
                        </c:if>

                        <!-- Name & Age -->
                        <div class="row g-3 mb-3">
                            <div class="col-md-8">
                                <label for="name" class="form-label fw-semibold">Full Name <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" id="name" name="name" value="${patient.name}" placeholder="e.g. John Doe" required>
                            </div>
                            <div class="col-md-4">
                                <label for="age" class="form-label fw-semibold">Age <span class="text-danger">*</span></label>
                                <input type="number" class="form-control" id="age" name="age" value="${patient.age}" min="0" max="130" placeholder="e.g. 35" required>
                            </div>
                        </div>

                        <!-- Gender & Blood Group -->
                        <div class="row g-3 mb-3">
                            <div class="col-md-6">
                                <label for="gender" class="form-label fw-semibold">Gender <span class="text-danger">*</span></label>
                                <select class="form-select" id="gender" name="gender" required>
                                    <option value="" disabled ${empty patient.gender ? 'selected' : ''}>-- Select Gender --</option>
                                    <option value="Male" ${patient.gender == 'Male' ? 'selected' : ''}>Male</option>
                                    <option value="Female" ${patient.gender == 'Female' ? 'selected' : ''}>Female</option>
                                    <option value="Other" ${patient.gender == 'Other' ? 'selected' : ''}>Other</option>
                                </select>
                            </div>
                            <div class="col-md-6">
                                <label for="bloodGroup" class="form-label fw-semibold">Blood Group <span class="text-danger">*</span></label>
                                <select class="form-select" id="bloodGroup" name="bloodGroup" required>
                                    <option value="" disabled ${empty patient.bloodGroup ? 'selected' : ''}>-- Select Blood Group --</option>
                                    <option value="A+" ${patient.bloodGroup == 'A+' ? 'selected' : ''}>A+</option>
                                    <option value="A-" ${patient.bloodGroup == 'A-' ? 'selected' : ''}>A-</option>
                                    <option value="B+" ${patient.bloodGroup == 'B+' ? 'selected' : ''}>B+</option>
                                    <option value="B-" ${patient.bloodGroup == 'B-' ? 'selected' : ''}>B-</option>
                                    <option value="AB+" ${patient.bloodGroup == 'AB+' ? 'selected' : ''}>AB+</option>
                                    <option value="AB-" ${patient.bloodGroup == 'AB-' ? 'selected' : ''}>AB-</option>
                                    <option value="O+" ${patient.bloodGroup == 'O+' ? 'selected' : ''}>O+</option>
                                    <option value="O-" ${patient.bloodGroup == 'O-' ? 'selected' : ''}>O-</option>
                                </select>
                            </div>
                        </div>

                        <!-- Contact & Email -->
                        <div class="row g-3 mb-3">
                            <div class="col-md-6">
                                <label for="contactNumber" class="form-label fw-semibold">Contact Number <span class="text-danger">*</span></label>
                                <input type="tel" class="form-control" id="contactNumber" name="contactNumber" value="${patient.contactNumber}" pattern="[0-9]{10}" placeholder="10-digit mobile number" required>
                                <div class="form-text">Must be a 10-digit numeric mobile number.</div>
                            </div>
                            <div class="col-md-6">
                                <label for="email" class="form-label fw-semibold">Email Address <span class="text-danger">*</span></label>
                                <input type="email" class="form-control" id="email" name="email" value="${patient.email}" placeholder="patient@example.com" required>
                            </div>
                        </div>

                        <!-- Address -->
                        <div class="mb-4">
                            <label for="address" class="form-label fw-semibold">Residential Address <span class="text-danger">*</span></label>
                            <textarea class="form-control" id="address" name="address" rows="3" placeholder="Full street address, city, postal code" required>${patient.address}</textarea>
                        </div>

                        <div class="d-flex justify-content-between align-items-center">
                            <a href="${pageContext.request.contextPath}/patients/list" class="btn btn-outline-secondary">
                                <i class="bi bi-x-circle me-1"></i> Cancel
                            </a>
                            <button type="submit" class="btn btn-primary px-4">
                                <i class="bi ${isEdit ? 'bi-check-circle-fill' : 'bi-person-plus-fill'} me-1"></i>
                                ${isEdit ? 'Save Changes' : 'Complete Registration'}
                            </button>
                        </div>

                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<footer class="text-center text-muted py-4 mt-5">
    <small>&copy; Hospital Patient Registration System | Spring Boot MVC + PostgreSQL + JSP</small>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
