<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Pharmacy Management System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-success shadow-sm mb-4">
    <div class="container">
        <a class="navbar-brand fw-bold" href="${pageContext.request.contextPath}/medicines">
            <i class="bi bi-capsule me-2"></i>Pharmacy Management System
        </a>
        <a class="btn btn-light btn-sm fw-semibold" href="${pageContext.request.contextPath}/medicines/add">
            <i class="bi bi-plus-circle me-1"></i> Add New Medicine
        </a>
    </div>
</nav>

<div class="container">

    <!-- Flash Messages -->
    <c:if test="${not empty successMessage}">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            <i class="bi bi-check-circle-fill me-2"></i>${successMessage}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>
    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            <i class="bi bi-exclamation-triangle-fill me-2"></i>${errorMessage}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <!-- Expired Stock Warning Banner -->
    <c:if test="${expiredCount > 0}">
        <div class="alert alert-danger d-flex align-items-center mb-3">
            <i class="bi bi-exclamation-octagon-fill fs-4 me-3 text-danger"></i>
            <div>
                <strong>Pharmacy Expiry Alert:</strong> Found <strong>${expiredCount}</strong> expired medicine batch(es) in the database! Expired medicines are flagged in red below.
            </div>
        </div>
    </c:if>

    <!-- Header and Search Bar -->
    <div class="card shadow-sm mb-4">
        <div class="card-body">
            <div class="row align-items-center g-3">
                <div class="col-md-6">
                    <h5 class="fw-bold mb-0 text-success">
                        <i class="bi bi-capsule-pill me-2"></i>Medicine Inventory
                    </h5>
                    <small class="text-muted">Total Medicines: ${medicines.size()}</small>
                </div>
                <div class="col-md-6">
                    <form action="${pageContext.request.contextPath}/medicines/search" method="get" class="d-flex gap-2">
                        <input type="text" name="keyword" class="form-control" placeholder="Search by ID or Medicine Name..." value="${keyword}" required>
                        <button type="submit" class="btn btn-success">Search</button>
                        <c:if test="${not empty keyword}">
                            <a href="${pageContext.request.contextPath}/medicines" class="btn btn-secondary">Reset</a>
                        </c:if>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Medicines Table -->
    <div class="card shadow-sm">
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead class="table-success">
                        <tr>
                            <th class="ps-3">ID</th>
                            <th>Medicine Name</th>
                            <th>Category</th>
                            <th>Manufacturer</th>
                            <th>Batch No</th>
                            <th>Price ($)</th>
                            <th>Stock Qty</th>
                            <th>Expiry Date</th>
                            <th>Status</th>
                            <th class="text-center pe-3">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${not empty medicines}">
                                <c:forEach var="med" items="${medicines}">
                                    <tr class="${med.expired ? 'table-danger' : ''}">
                                        <td class="ps-3 fw-bold">#${med.medicineId}</td>
                                        <td class="fw-semibold">${med.medicineName}</td>
                                        <td><span class="badge bg-secondary">${med.category}</span></td>
                                        <td>${med.manufacturer}</td>
                                        <td><code>${med.batchNumber}</code></td>
                                        <td class="fw-bold text-success">${med.price}</td>
                                        <td>
                                            <span class="badge ${med.quantity > 0 ? 'bg-primary' : 'bg-danger'}">
                                                ${med.quantity}
                                            </span>
                                        </td>
                                        <td>${med.expiryDate}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${med.expired}">
                                                    <span class="badge bg-danger"><i class="bi bi-x-octagon me-1"></i>EXPIRED</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-success"><i class="bi bi-check-circle me-1"></i>Valid Stock</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="text-center pe-3">
                                            <a href="${pageContext.request.contextPath}/medicines/edit/${med.medicineId}" class="btn btn-sm btn-outline-warning me-1">
                                                <i class="bi bi-pencil-square"></i> Edit
                                            </a>
                                            <a href="${pageContext.request.contextPath}/medicines/delete/${med.medicineId}" 
                                               class="btn btn-sm btn-outline-danger"
                                               onclick="return confirm('Are you sure you want to delete medicine #${med.medicineId}?');">
                                                <i class="bi bi-trash"></i> Delete
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="10" class="text-center py-4 text-muted">
                                        No medicines found in the database.
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

<footer class="text-center text-muted py-4 mt-4">
    <small>&copy; Pharmacy Management System | Spring Boot & pgAdmin</small>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
