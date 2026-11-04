<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pharmacy Management System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<nav class="navbar navbar-expand-lg navbar-dark bg-teal shadow-sm mb-4" style="background-color: #0d9488;">
    <div class="container">
        <a class="navbar-brand fw-bold" href="${pageContext.request.contextPath}/medicines/list">
            <i class="bi bi-capsule me-2"></i>Apothecary Pharmacy System
        </a>
        <div class="navbar-nav ms-auto">
            <a class="nav-link text-white active" href="${pageContext.request.contextPath}/medicines/list">
                <i class="bi bi-prescription2 me-1"></i> Medicine Formulary
            </a>
            <a class="btn btn-light btn-sm ms-2 fw-semibold" style="color: #0d9488;" href="${pageContext.request.contextPath}/medicines/new">
                <i class="bi bi-plus-circle-fill me-1"></i> Add New Medicine
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

    <!-- Expired Stock Warning Banner -->
    <c:if test="${expiredCount > 0}">
        <div class="alert alert-danger shadow-sm d-flex align-items-center" role="alert">
            <i class="bi bi-exclamation-octagon-fill fs-4 me-3 text-danger"></i>
            <div>
                <strong>Pharmacy Safety Alert:</strong> There are <strong>${expiredCount}</strong> expired medicine batch(es) detected in the system! Expired items are highlighted with a red badge below.
            </div>
        </div>
    </c:if>

    <!-- Header & Search Controls -->
    <div class="card shadow-sm border-0 mb-4">
        <div class="card-body">
            <div class="row align-items-center g-3">
                <div class="col-md-6">
                    <h4 class="card-title fw-bold mb-1" style="color: #0d9488;">
                        <i class="bi bi-capsule-pill me-2"></i>Available Medicine Inventory
                    </h4>
                    <p class="text-muted small mb-0">Total Formulations: ${medicines.size()} &bull; Expired Batches: <span class="badge ${expiredCount > 0 ? 'bg-danger' : 'bg-success'}">${expiredCount}</span></p>
                </div>
                <div class="col-md-6">
                    <form action="${pageContext.request.contextPath}/medicines/search" method="get" class="d-flex gap-2">
                        <div class="input-group">
                            <span class="input-group-text bg-white"><i class="bi bi-search"></i></span>
                            <input type="text" name="query" class="form-control" placeholder="Search by Medicine ID or Name..." value="${searchQuery}" required>
                            <button class="btn btn-outline-secondary" type="submit">Search</button>
                        </div>
                        <c:if test="${not empty searchQuery}">
                            <a href="${pageContext.request.contextPath}/medicines/list" class="btn btn-secondary">Reset</a>
                        </c:if>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Medicines Table -->
    <div class="card shadow-sm border-0">
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead class="table-light text-dark">
                        <tr>
                            <th class="ps-3">ID</th>
                            <th>Medicine Name</th>
                            <th>Category</th>
                            <th>Manufacturer</th>
                            <th>Batch No</th>
                            <th>Price</th>
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
                                        <td class="ps-3 fw-bold" style="color: #0d9488;">#${med.medicineId}</td>
                                        <td class="fw-semibold">
                                            ${med.medicineName}
                                            <c:if test="${med.expired}">
                                                <i class="bi bi-exclamation-triangle-fill text-danger ms-1" title="Expired Medicine!"></i>
                                            </c:if>
                                        </td>
                                        <td><span class="badge bg-secondary">${med.category}</span></td>
                                        <td><small>${med.manufacturer}</small></td>
                                        <td><code>${med.batchNumber}</code></td>
                                        <td class="fw-bold text-success">
                                            $<fmt:formatNumber value="${med.price}" type="number" minFractionDigits="2" maxFractionDigits="2"/>
                                        </td>
                                        <td>
                                            <span class="badge ${med.quantity > 20 ? 'bg-success' : (med.quantity > 0 ? 'bg-warning text-dark' : 'bg-danger')} rounded-pill px-3 py-1">
                                                ${med.quantity} units
                                            </span>
                                        </td>
                                        <td>
                                            <span class="${med.expired ? 'text-danger fw-bold' : ''}">
                                                ${med.expiryDate}
                                            </span>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${med.expired}">
                                                    <span class="badge bg-danger text-white">
                                                        <i class="bi bi-x-octagon me-1"></i>EXPIRED
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-success">
                                                        <i class="bi bi-shield-check me-1"></i>Valid Stock
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="text-center pe-3">
                                            <div class="btn-group btn-group-sm">
                                                <a href="${pageContext.request.contextPath}/medicines/view/${med.medicineId}" class="btn btn-outline-info" title="View Details">
                                                    <i class="bi bi-eye"></i>
                                                </a>
                                                <a href="${pageContext.request.contextPath}/medicines/edit/${med.medicineId}" class="btn btn-outline-warning" title="Edit Medicine">
                                                    <i class="bi bi-pencil-square"></i>
                                                </a>
                                                <a href="${pageContext.request.contextPath}/medicines/delete/${med.medicineId}" 
                                                   class="btn btn-outline-danger" 
                                                   onclick="return confirm('Delete medicine record #${med.medicineId} (${med.medicineName})?');"
                                                   title="Delete Medicine">
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
                                        <i class="bi bi-prescription2 fs-1 d-block mb-2 text-secondary"></i>
                                        No medicine records found.
                                        <div class="mt-2">
                                            <a href="${pageContext.request.contextPath}/medicines/new" class="btn text-white btn-sm" style="background-color: #0d9488;">
                                                <i class="bi bi-plus-circle-fill me-1"></i> Add First Medicine
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
    <small>&copy; Pharmacy Management System | Spring Boot MVC + PostgreSQL + JSP</small>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

