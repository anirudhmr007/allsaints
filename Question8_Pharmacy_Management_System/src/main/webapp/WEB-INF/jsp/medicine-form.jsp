<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${isEdit ? 'Update Medicine' : 'Add New Medicine'} - Apothecary Pharmacy</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<nav class="navbar navbar-expand-lg navbar-dark shadow-sm mb-4" style="background-color: #0d9488;">
    <div class="container">
        <a class="navbar-brand fw-bold" href="${pageContext.request.contextPath}/medicines/list">
            <i class="bi bi-capsule me-2"></i>Apothecary Pharmacy System
        </a>
        <div class="navbar-nav ms-auto">
            <a class="nav-link text-white" href="${pageContext.request.contextPath}/medicines/list">
                <i class="bi bi-arrow-left me-1"></i> Back to Formulary
            </a>
        </div>
    </div>
</nav>

<div class="container">
    <div class="row justify-content-center">
        <div class="col-lg-8">
            <div class="card shadow-sm border-0">
                <div class="card-header text-white py-3" style="background-color: #0d9488;">
                    <h5 class="card-title mb-0 fw-bold">
                        <i class="bi ${isEdit ? 'bi-pencil-square' : 'bi-plus-circle-fill'} me-2"></i>
                        ${isEdit ? 'Update Medicine Formulation' : 'Add New Medicine to Pharmacy Inventory'}
                    </h5>
                </div>
                <div class="card-body p-4">
                    <form action="${isEdit ? pageContext.request.contextPath.concat('/medicines/update/').concat(medicine.medicineId) : pageContext.request.contextPath.concat('/medicines/new')}" method="post">
                        
                        <c:if test="${isEdit}">
                            <div class="mb-3">
                                <label class="form-label fw-semibold">Medicine ID</label>
                                <input type="text" class="form-control" value="${medicine.medicineId}" disabled>
                            </div>
                        </c:if>

                        <!-- Medicine Name & Category -->
                        <div class="row g-3 mb-3">
                            <div class="col-md-7">
                                <label for="medicineName" class="form-label fw-semibold">Medicine Name & Strength <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" id="medicineName" name="medicineName" value="${medicine.medicineName}" placeholder="e.g. Amoxicillin 500mg" required>
                            </div>
                            <div class="col-md-5">
                                <label for="category" class="form-label fw-semibold">Category <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" id="category" name="category" value="${medicine.category}" placeholder="e.g. Antibiotic, Analgesic" required>
                            </div>
                        </div>

                        <!-- Manufacturer & Batch Number -->
                        <div class="row g-3 mb-3">
                            <div class="col-md-6">
                                <label for="manufacturer" class="form-label fw-semibold">Manufacturer <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" id="manufacturer" name="manufacturer" value="${medicine.manufacturer}" placeholder="e.g. Pfizer Inc., Novartis" required>
                            </div>
                            <div class="col-md-6">
                                <label for="batchNumber" class="form-label fw-semibold">Batch Number <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" id="batchNumber" name="batchNumber" value="${medicine.batchNumber}" placeholder="e.g. BATCH-AMX-2024" required>
                            </div>
                        </div>

                        <!-- Price, Quantity, Supplier -->
                        <div class="row g-3 mb-3">
                            <div class="col-md-4">
                                <label for="price" class="form-label fw-semibold">Unit Price ($) <span class="text-danger">*</span></label>
                                <input type="number" step="0.01" class="form-control" id="price" name="price" value="${medicine.price}" min="0.01" placeholder="e.g. 15.00" required>
                            </div>
                            <div class="col-md-4">
                                <label for="quantity" class="form-label fw-semibold">Stock Quantity <span class="text-danger">*</span></label>
                                <input type="number" class="form-control" id="quantity" name="quantity" value="${medicine.quantity}" min="0" placeholder="e.g. 100" required>
                                <div class="form-text">Must be 0 or greater (negative prohibited).</div>
                            </div>
                            <div class="col-md-4">
                                <label for="supplierName" class="form-label fw-semibold">Supplier Name <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" id="supplierName" name="supplierName" value="${medicine.supplierName}" placeholder="e.g. MedGlobal Ltd" required>
                            </div>
                        </div>

                        <!-- Manufacturing Date & Expiry Date -->
                        <div class="row g-3 mb-4">
                            <div class="col-md-6">
                                <label for="manufacturingDate" class="form-label fw-semibold">Manufacturing Date <span class="text-danger">*</span></label>
                                <input type="date" class="form-control" id="manufacturingDate" name="manufacturingDate" value="${medicine.manufacturingDate}" required>
                            </div>
                            <div class="col-md-6">
                                <label for="expiryDate" class="form-label fw-semibold">Expiry Date <span class="text-danger">*</span></label>
                                <input type="date" class="form-control" id="expiryDate" name="expiryDate" value="${medicine.expiryDate}" required>
                                <div class="form-text">Must be after the manufacturing date.</div>
                            </div>
                        </div>

                        <div class="d-flex justify-content-between align-items-center">
                            <a href="${pageContext.request.contextPath}/medicines/list" class="btn btn-outline-secondary">
                                <i class="bi bi-x-circle me-1"></i> Cancel
                            </a>
                            <button type="submit" class="btn text-white px-4 fw-semibold" style="background-color: #0d9488;">
                                <i class="bi ${isEdit ? 'bi-check-circle-fill' : 'bi-capsule-fill'} me-1"></i>
                                ${isEdit ? 'Save Changes' : 'Save Medicine'}
                            </button>
                        </div>

                    </form>
                </div>
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
