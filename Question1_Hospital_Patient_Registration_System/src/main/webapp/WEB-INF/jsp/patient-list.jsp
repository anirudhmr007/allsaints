<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hospital Patient Registration System</title>
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
            <a class="nav-link text-white active" href="${pageContext.request.contextPath}/patients/list">
                <i class="bi bi-people-fill me-1"></i> Patient Directory
            </a>
            <a class="btn btn-light btn-sm ms-2" href="${pageContext.request.contextPath}/patients/register">
                <i class="bi bi-person-plus-fill me-1"></i> Register New Patient
            </a>
        </div>
    </div>
</nav>

<div class="container">

    <!-- Flash Messages -->
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
                    <h4 class="card-title fw-bold text-primary mb-1">
                        <i class="bi bi-card-checklist me-2"></i>Registered Patients List
                    </h4>
                    <p class="text-muted small mb-0">Total Patients displayed: ${patients.size()}</p>
                </div>
                <div class="col-md-6">
                    <form action="${pageContext.request.contextPath}/patients/search" method="get" class="d-flex gap-2">
                        <div class="input-group">
                            <span class="input-group-text bg-white"><i class="bi bi-search"></i></span>
                            <input type="number" name="patientId" class="form-control" placeholder="Search by Patient ID..." value="${searchedId}" required>
                            <button class="btn btn-outline-primary" type="submit">Search</button>
                        </div>
                        <c:if test="${not empty searchedId}">
                            <a href="${pageContext.request.contextPath}/patients/list" class="btn btn-secondary">Reset</a>
                        </c:if>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Patients Table -->
    <div class="card shadow-sm border-0">
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead class="table-primary text-dark">
                        <tr>
                            <th class="ps-3">Patient ID</th>
                            <th>Name</th>
                            <th>Age</th>
                            <th>Gender</th>
                            <th>Blood Group</th>
                            <th>Contact</th>
                            <th>Email</th>
                            <th>Address</th>
                            <th class="text-center pe-3">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${not empty patients}">
                                <c:forEach var="patient" items="${patients}">
                                    <tr>
                                        <td class="ps-3 fw-bold text-primary">#${patient.patientId}</td>
                                        <td class="fw-semibold">${patient.name}</td>
                                        <td>${patient.age} yrs</td>
                                        <td>
                                            <span class="badge ${patient.gender == 'Male' ? 'bg-info' : (patient.gender == 'Female' ? 'bg-danger' : 'bg-secondary')}">
                                                ${patient.gender}
                                            </span>
                                        </td>
                                        <td>
                                            <span class="badge bg-danger text-white rounded-pill px-2 py-1">
                                                <i class="bi bi-droplet-fill me-1"></i>${patient.bloodGroup}
                                            </span>
                                        </td>
                                        <td>${patient.contactNumber}</td>
                                        <td><small class="text-muted">${patient.email}</small></td>
                                        <td><small class="text-truncate d-inline-block" style="max-width: 150px;">${patient.address}</small></td>
                                        <td class="text-center pe-3">
                                            <div class="btn-group btn-group-sm">
                                                <a href="${pageContext.request.contextPath}/patients/view/${patient.patientId}" class="btn btn-outline-info" title="View Details">
                                                    <i class="bi bi-eye"></i>
                                                </a>
                                                <a href="${pageContext.request.contextPath}/patients/edit/${patient.patientId}" class="btn btn-outline-warning" title="Edit Patient">
                                                    <i class="bi bi-pencil-square"></i>
                                                </a>
                                                <a href="${pageContext.request.contextPath}/patients/delete/${patient.patientId}" 
                                                   class="btn btn-outline-danger" 
                                                   onclick="return confirm('Are you sure you want to delete patient #${patient.patientId} (${patient.name})?');"
                                                   title="Delete Patient">
                                                    <i class="bi bi-trash"></i>
                                                </a>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="9" class="text-center py-5 text-muted">
                                        <i class="bi bi-inbox fs-1 d-block mb-2 text-secondary"></i>
                                        No patient records found.
                                        <div class="mt-2">
                                            <a href="${pageContext.request.contextPath}/patients/register" class="btn btn-primary btn-sm">
                                                <i class="bi bi-person-plus-fill me-1"></i> Register the First Patient
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
    <small>&copy; Hospital Patient Registration System | Spring Boot MVC + PostgreSQL + JSP</small>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
