<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${medicine.medicineId != null ? 'Edit Medicine' : 'Add Medicine'}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<nav class="navbar navbar-expand-lg navbar-dark bg-success shadow-sm mb-4">
    <div class="container">
        <a class="navbar-brand fw-bold" href="${pageContext.request.contextPath}/medicines">
            <i class="bi bi-capsule me-2"></i>Pharmacy Management System
        </a>
        <a class="btn btn-outline-light btn-sm" href="${pageContext.request.contextPath}/medicines">
            <i class="bi bi-arrow-left me-1"></i> Back to List
        </a>
    </div>
</nav>

<div class="container">
    <div class="row justify-content-center">
        <div class="col-lg-8">

            <!-- Error message if validation failed -->
            <c:if test="${not empty errorMessage}">
                <div class="alert alert-danger alert-dismissible fade show mb-3" role="alert">
                    <i class="bi bi-exclamation-triangle-fill me-2"></i>${errorMessage}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>

            <div class="card shadow-sm">
                <div class="card-header bg-success text-white">
                    <h5 class="card-title mb-0 fw-bold">
                        <i class="bi ${medicine.medicineId != null ? 'bi-pencil-square' : 'bi-plus-circle'} me-2"></i>
                        ${medicine.medicineId != null ? 'Edit Medicine Details' : 'Add New Medicine'}
                    </h5>
                </div>
                <div class="card-body p-4">
                    <form action="${pageContext.request.contextPath}/medicines/save" method="post">
                        
                        <!-- Hidden ID field for edit -->
                        <c:if test="${medicine.medicineId != null}">
                            <input type="hidden" name="medicineId" value="${medicine.medicineId}">
                        </c:if>

                        <div class="row mb-3">
                            <div class="col-md-7">
                                <label class="form-label fw-semibold">Medicine Name *</label>
                                <input type="text" name="medicineName" class="form-control" value="${medicine.medicineName}" placeholder="e.g. Paracetamol 650mg" required>
                            </div>
                            <div class="col-md-5">
                                <label class="form-label fw-semibold">Category *</label>
                                <input type="text" name="category" class="form-control" value="${medicine.category}" placeholder="e.g. Analgesic, Antibiotic" required>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label class="form-label fw-semibold">Manufacturer *</label>
                                <input type="text" name="manufacturer" class="form-control" value="${medicine.manufacturer}" placeholder="e.g. Pfizer, GSK" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-semibold">Batch Number *</label>
                                <input type="text" name="batchNumber" class="form-control" value="${medicine.batchNumber}" placeholder="e.g. BATCH-2024-01" required>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <div class="col-md-4">
                                <label class="form-label fw-semibold">Price ($) *</label>
                                <input type="number" step="0.01" name="price" class="form-control" value="${medicine.price}" min="0.01" placeholder="e.g. 10.50" required>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label fw-semibold">Quantity in Stock *</label>
                                <input type="number" name="quantity" class="form-control" value="${medicine.quantity}" min="0" placeholder="0 or more" required>
                                <small class="text-muted">Negative numbers are prohibited</small>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label fw-semibold">Supplier Name *</label>
                                <input type="text" name="supplierName" class="form-control" value="${medicine.supplierName}" placeholder="e.g. MedSupply Co." required>
                            </div>
                        </div>

                        <div class="row mb-4">
                            <div class="col-md-6">
                                <label class="form-label fw-semibold">Manufacturing Date *</label>
                                <input type="date" name="manufacturingDate" class="form-control" value="${medicine.manufacturingDate}" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-semibold">Expiry Date *</label>
                                <input type="date" name="expiryDate" class="form-control" value="${medicine.expiryDate}" required>
                            </div>
                        </div>

                        <div class="d-flex justify-content-between">
                            <a href="${pageContext.request.contextPath}/medicines" class="btn btn-secondary">
                                <i class="bi bi-x-circle me-1"></i> Cancel
                            </a>
                            <button type="submit" class="btn btn-success fw-semibold px-4">
                                <i class="bi bi-check-circle me-1"></i> ${medicine.medicineId != null ? 'Update Medicine' : 'Save Medicine'}
                            </button>
                        </div>
                    </form>
                </div>
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
