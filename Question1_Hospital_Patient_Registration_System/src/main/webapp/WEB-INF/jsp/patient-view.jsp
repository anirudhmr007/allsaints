<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Patient Details - #${patient.patientId}</title>
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
        <div class="col-lg-7">
            <div class="card shadow-sm border-0">
                <div class="card-header bg-primary text-white py-3 d-flex justify-content-between align-items-center">
                    <h5 class="card-title mb-0 fw-bold">
                        <i class="bi bi-person-badge-fill me-2"></i>Patient Profile: #${patient.patientId}
                    </h5>
                    <span class="badge bg-danger rounded-pill px-3 py-2 fs-6">
                        <i class="bi bi-droplet-fill me-1"></i>${patient.bloodGroup}
                    </span>
                </div>
                <div class="card-body p-4">
                    <div class="text-center mb-4">
                        <div class="display-6 fw-bold text-dark">${patient.name}</div>
                        <p class="text-muted mb-0">${patient.gender} &bull; ${patient.age} Years Old</p>
                    </div>

                    <table class="table table-bordered align-middle">
                        <tbody>
                            <tr>
                                <th class="bg-light text-secondary" style="width: 35%;">Patient ID</th>
                                <td class="fw-bold text-primary">#${patient.patientId}</td>
                            </tr>
                            <tr>
                                <th class="bg-light text-secondary">Contact Number</th>
                                <td>${patient.contactNumber}</td>
                            </tr>
                            <tr>
                                <th class="bg-light text-secondary">Email Address</th>
                                <td><a href="mailto:${patient.email}" class="text-decoration-none">${patient.email}</a></td>
                            </tr>
                            <tr>
                                <th class="bg-light text-secondary">Blood Group</th>
                                <td><span class="badge bg-danger">${patient.bloodGroup}</span></td>
                            </tr>
                            <tr>
                                <th class="bg-light text-secondary">Residential Address</th>
                                <td>${patient.address}</td>
                            </tr>
                        </tbody>
                    </table>

                    <div class="d-flex justify-content-between mt-4">
                        <a href="${pageContext.request.contextPath}/patients/list" class="btn btn-secondary">
                            <i class="bi bi-arrow-left me-1"></i> Back to List
                        </a>
                        <div class="d-flex gap-2">
                            <a href="${pageContext.request.contextPath}/patients/edit/${patient.patientId}" class="btn btn-warning">
                                <i class="bi bi-pencil-square me-1"></i> Edit
                            </a>
                            <a href="${pageContext.request.contextPath}/patients/delete/${patient.patientId}" 
                               class="btn btn-danger"
                               onclick="return confirm('Are you sure you want to delete patient #${patient.patientId}?');">
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
    <small>&copy; Hospital Patient Registration System | Spring Boot MVC + PostgreSQL + JSP</small>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
