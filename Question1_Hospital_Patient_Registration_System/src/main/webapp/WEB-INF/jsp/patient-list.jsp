<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Hospital Patient Registration System</title>
    <!-- Simple Bootstrap 5 for clean styling -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container mt-4">
    <!-- Page Header -->
    <div class="d-flex justify-content-between align-items-center mb-3 pb-2 border-bottom">
        <h2 class="text-primary">Hospital Patient Registration System</h2>
        <a href="${pageContext.request.contextPath}/patients/add" class="btn btn-primary fw-bold">+ Register New Patient</a>
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

    <!-- Search Bar by Patient ID -->
    <div class="card p-3 mb-4 shadow-sm bg-white">
        <form action="${pageContext.request.contextPath}/patients/search" method="get" class="row g-2 align-items-center">
            <div class="col-auto">
                <label class="fw-bold">Search Patient by ID:</label>
            </div>
            <div class="col-auto">
                <input type="number" name="patientId" class="form-control" placeholder="Enter Patient ID (e.g. 1)" value="${searchedId}" required>
            </div>
            <div class="col-auto">
                <button type="submit" class="btn btn-outline-primary">Search</button>
                <a href="${pageContext.request.contextPath}/patients" class="btn btn-secondary">Show All</a>
            </div>
        </form>
    </div>

    <!-- Patients Table -->
    <div class="card shadow-sm">
        <div class="card-header bg-primary text-white">
            <h5 class="mb-0">All Registered Patients</h5>
        </div>
        <div class="card-body p-0">
            <table class="table table-striped table-hover mb-0">
                <thead class="table-light">
                    <tr>
                        <th>Patient ID</th>
                        <th>Name</th>
                        <th>Age</th>
                        <th>Gender</th>
                        <th>Contact Number</th>
                        <th>Email</th>
                        <th>Address</th>
                        <th>Blood Group</th>
                        <th class="text-center">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${not empty patients}">
                            <c:forEach var="p" items="${patients}">
                                <tr>
                                    <td><strong>#${p.patientId}</strong></td>
                                    <td>${p.name}</td>
                                    <td>${p.age}</td>
                                    <td>${p.gender}</td>
                                    <td>${p.contactNumber}</td>
                                    <td>${p.email}</td>
                                    <td>${p.address}</td>
                                    <td><span class="badge bg-danger">${p.bloodGroup}</span></td>
                                    <td class="text-center">
                                        <a href="${pageContext.request.contextPath}/patients/edit/${p.patientId}" class="btn btn-sm btn-warning">Edit</a>
                                        <a href="${pageContext.request.contextPath}/patients/delete/${p.patientId}" 
                                           class="btn btn-sm btn-danger"
                                           onclick="return confirm('Are you sure you want to delete patient #${p.patientId}?');">Delete</a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr>
                                <td colspan="9" class="text-center py-4 text-muted">No patient records found.</td>
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
