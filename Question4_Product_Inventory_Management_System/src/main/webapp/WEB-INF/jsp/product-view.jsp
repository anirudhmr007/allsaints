<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Product Details - #${product.productId}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<nav class="navbar navbar-expand-lg navbar-dark shadow-sm mb-4" style="background-color: #4f46e5;">
    <div class="container">
        <a class="navbar-brand fw-bold" href="${pageContext.request.contextPath}/products/list">
            <i class="bi bi-boxes me-2"></i>Inventory Control Portal
        </a>
        <div class="navbar-nav ms-auto">
            <a class="nav-link text-white" href="${pageContext.request.contextPath}/products/list">
                <i class="bi bi-arrow-left me-1"></i> Back to Stock Registry
            </a>
        </div>
    </div>
</nav>

<div class="container">
    <div class="row justify-content-center">
        <div class="col-lg-7">
            <div class="card shadow-sm border-0">
                <div class="card-header text-white py-3 d-flex justify-content-between align-items-center" style="background-color: #4f46e5;">
                    <h5 class="card-title mb-0 fw-bold">
                        <i class="bi bi-box-seam me-2"></i>Product Specification: #${product.productId}
                    </h5>
                    <span class="badge ${product.quantity > 0 ? 'bg-success' : 'bg-danger'} px-3 py-2 fs-6">
                        ${product.quantity} in stock
                    </span>
                </div>
                <div class="card-body p-4">
                    <div class="text-center mb-4">
                        <div class="display-6 fw-bold text-dark">${product.productName}</div>
                        <p class="text-muted mb-0">Brand: <strong>${product.brand}</strong> &bull; Category: <span class="badge bg-secondary">${product.category}</span></p>
                    </div>

                    <table class="table table-bordered align-middle">
                        <tbody>
                            <tr>
                                <th class="bg-light text-secondary" style="width: 35%;">Product ID</th>
                                <td class="fw-bold" style="color: #4f46e5;">#${product.productId}</td>
                            </tr>
                            <tr>
                                <th class="bg-light text-secondary">Description</th>
                                <td>${empty product.description ? 'No description available' : product.description}</td>
                            </tr>
                            <tr>
                                <th class="bg-light text-secondary">Unit Price</th>
                                <td><strong class="text-success fs-5">$<fmt:formatNumber value="${product.price}" type="number" minFractionDigits="2" maxFractionDigits="2"/></strong></td>
                            </tr>
                            <tr>
                                <th class="bg-light text-secondary">Current Quantity</th>
                                <td>${product.quantity} Units</td>
                            </tr>
                            <tr>
                                <th class="bg-light text-secondary">Supplier Name</th>
                                <td>${product.supplierName}</td>
                            </tr>
                            <tr>
                                <th class="bg-light text-secondary">Manufacturing Date</th>
                                <td>${product.manufacturingDate}</td>
                            </tr>
                            <tr>
                                <th class="bg-light text-secondary">Expiry Date</th>
                                <td>${product.expiryDate}</td>
                            </tr>
                        </tbody>
                    </table>

                    <div class="d-flex justify-content-between mt-4">
                        <a href="${pageContext.request.contextPath}/products/list" class="btn btn-secondary">
                            <i class="bi bi-arrow-left me-1"></i> Back to Inventory
                        </a>
                        <div class="d-flex gap-2">
                            <a href="${pageContext.request.contextPath}/products/edit/${product.productId}" class="btn btn-warning">
                                <i class="bi bi-pencil-square me-1"></i> Edit
                            </a>
                            <a href="${pageContext.request.contextPath}/products/delete/${product.productId}" 
                               class="btn btn-danger"
                               onclick="return confirm('Are you sure you want to delete product #${product.productId}?');">
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
    <small>&copy; Product Inventory Management System | Spring Boot MVC + PostgreSQL + JSP</small>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
