<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Medicine Dossier - #${medicine.medicineId}</title>
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
        <div class="col-lg-7">
            <div class="card shadow-sm border-0">
                <div class="card-header text-white py-3 d-flex justify-content-between align-items-center" style="background-color: #0d9488;">
                    <h5 class="card-title mb-0 fw-bold">
                        <i class="bi bi-prescription me-2"></i>Medicine Dossier: #${medicine.medicineId}
                    </h5>
                    <span class="badge ${medicine.expired ? 'bg-danger' : 'bg-white text-dark'} px-3 py-2 fs-6">
                        ${medicine.expired ? 'EXPIRED BATCH' : 'ACTIVE STOCK'}
                    </span>
                </div>
                <div class="card-body p-4">
                    <div class="text-center mb-4">
                        <div class="display-6 fw-bold text-dark">${medicine.medicineName}</div>
                        <p class="text-muted mb-0">Manufacturer: <strong>${medicine.manufacturer}</strong> &bull; Batch: <code>${medicine.batchNumber}</code></p>
                    </div>

                    <!-- Expiration Alert Callout -->
                    <c:choose>
                        <c:when test="${medicine.expired}">
                            <div class="alert alert-danger d-flex align-items-center mb-4">
                                <i class="bi bi-exclamation-octagon-fill fs-2 me-3"></i>
                                <div>
                                    <strong>WARNING: THIS MEDICINE HAS EXPIRED!</strong><br>
                                    <small>Expired on ${medicine.expiryDate}. Do not dispense to patients under any circumstances.</small>
                                </div>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="alert alert-success d-flex align-items-center mb-4">
                                <i class="bi bi-shield-check fs-2 me-3"></i>
                                <div>
                                    <strong>Valid Medical Stock:</strong> Shelf life remaining: ${medicine.daysUntilExpiry} days (Expires: ${medicine.expiryDate}).
                                </div>
                            </div>
                        </c:otherwise>
                    </c:choose>

                    <table class="table table-bordered align-middle">
                        <tbody>
                            <tr>
                                <th class="bg-light text-secondary" style="width: 38%;">Medicine ID</th>
                                <td class="fw-bold" style="color: #0d9488;">#${medicine.medicineId}</td>
                            </tr>
                            <tr>
                                <th class="bg-light text-secondary">Therapeutic Category</th>
                                <td><span class="badge bg-secondary">${medicine.category}</span></td>
                            </tr>
                            <tr>
                                <th class="bg-light text-secondary">Batch Number</th>
                                <td><code>${medicine.batchNumber}</code></td>
                            </tr>
                            <tr>
                                <th class="bg-light text-secondary">Unit Price</th>
                                <td><strong class="text-success fs-5">$<fmt:formatNumber value="${medicine.price}" type="number" minFractionDigits="2" maxFractionDigits="2"/></strong></td>
                            </tr>
                            <tr>
                                <th class="bg-light text-secondary">Current Stock Quantity</th>
                                <td>${medicine.quantity} Units in inventory</td>
                            </tr>
                            <tr>
                                <th class="bg-light text-secondary">Manufacturing Date</th>
                                <td>${medicine.manufacturingDate}</td>
                            </tr>
                            <tr>
                                <th class="bg-light text-secondary">Expiry Date</th>
                                <td><strong class="${medicine.expired ? 'text-danger' : 'text-dark'}">${medicine.expiryDate}</strong></td>
                            </tr>
                            <tr>
                                <th class="bg-light text-secondary">Authorized Supplier</th>
                                <td>${medicine.supplierName}</td>
                            </tr>
                        </tbody>
                    </table>

                    <div class="d-flex justify-content-between mt-4">
                        <a href="${pageContext.request.contextPath}/medicines/list" class="btn btn-secondary">
                            <i class="bi bi-arrow-left me-1"></i> Back to Formulary
                        </a>
                        <div class="d-flex gap-2">
                            <a href="${pageContext.request.contextPath}/medicines/edit/${medicine.medicineId}" class="btn btn-warning">
                                <i class="bi bi-pencil-square me-1"></i> Edit
                            </a>
                            <a href="${pageContext.request.contextPath}/medicines/delete/${medicine.medicineId}" 
                               class="btn btn-danger"
                               onclick="return confirm('Are you sure you want to delete medicine #${medicine.medicineId}?');">
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
    <small>&copy; Pharmacy Management System | Spring Boot MVC + PostgreSQL + JSP</small>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
