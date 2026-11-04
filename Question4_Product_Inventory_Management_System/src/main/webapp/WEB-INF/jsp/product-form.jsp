<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${isEdit ? 'Update Product' : 'Add New Product'} - Inventory Control</title>
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
        <div class="col-lg-8">
            <div class="card shadow-sm border-0">
                <div class="card-header text-white py-3" style="background-color: #4f46e5;">
                    <h5 class="card-title mb-0 fw-bold">
                        <i class="bi ${isEdit ? 'bi-pencil-square' : 'bi-plus-circle-fill'} me-2"></i>
                        ${isEdit ? 'Update Product Details' : 'Register New Inventory Product'}
                    </h5>
                </div>
                <div class="card-body p-4">
                    <form action="${isEdit ? pageContext.request.contextPath.concat('/products/update/').concat(product.productId) : pageContext.request.contextPath.concat('/products/new')}" method="post">
                        
                        <c:if test="${isEdit}">
                            <div class="mb-3">
                                <label class="form-label fw-semibold">Product ID</label>
                                <input type="text" class="form-control" value="${product.productId}" disabled>
                            </div>
                        </c:if>

                        <!-- Product Name -->
                        <div class="mb-3">
                            <label for="productName" class="form-label fw-semibold">Product Name <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" id="productName" name="productName" value="${product.productName}" placeholder="e.g. Wireless Noise-Cancelling Headphones" required>
                        </div>

                        <!-- Category & Brand -->
                        <div class="row g-3 mb-3">
                            <div class="col-md-6">
                                <label for="category" class="form-label fw-semibold">Category <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" id="category" name="category" value="${product.category}" placeholder="e.g. Electronics, Groceries, Furniture" required>
                            </div>
                            <div class="col-md-6">
                                <label for="brand" class="form-label fw-semibold">Brand / Manufacturer <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" id="brand" name="brand" value="${product.brand}" placeholder="e.g. Sony, Apple, Nike" required>
                            </div>
                        </div>

                        <!-- Description -->
                        <div class="mb-3">
                            <label for="description" class="form-label fw-semibold">Description</label>
                            <textarea class="form-control" id="description" name="description" rows="2" placeholder="Brief technical or product specification">${product.description}</textarea>
                        </div>

                        <!-- Price, Quantity, Supplier -->
                        <div class="row g-3 mb-3">
                            <div class="col-md-4">
                                <label for="price" class="form-label fw-semibold">Unit Price ($) <span class="text-danger">*</span></label>
                                <input type="number" step="0.01" class="form-control" id="price" name="price" value="${product.price}" min="0.01" placeholder="e.g. 49.99" required>
                            </div>
                            <div class="col-md-4">
                                <label for="quantity" class="form-label fw-semibold">Quantity in Stock <span class="text-danger">*</span></label>
                                <input type="number" class="form-control" id="quantity" name="quantity" value="${product.quantity}" min="0" placeholder="e.g. 100" required>
                            </div>
                            <div class="col-md-4">
                                <label for="supplierName" class="form-label fw-semibold">Supplier Name <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" id="supplierName" name="supplierName" value="${product.supplierName}" placeholder="e.g. Apex Global Ltd" required>
                            </div>
                        </div>

                        <!-- Manufacturing Date & Expiry Date -->
                        <div class="row g-3 mb-4">
                            <div class="col-md-6">
                                <label for="manufacturingDate" class="form-label fw-semibold">Manufacturing Date <span class="text-danger">*</span></label>
                                <input type="date" class="form-control" id="manufacturingDate" name="manufacturingDate" value="${product.manufacturingDate}" required>
                            </div>
                            <div class="col-md-6">
                                <label for="expiryDate" class="form-label fw-semibold">Expiry Date <span class="text-danger">*</span></label>
                                <input type="date" class="form-control" id="expiryDate" name="expiryDate" value="${product.expiryDate}" required>
                            </div>
                        </div>

                        <div class="d-flex justify-content-between align-items-center">
                            <a href="${pageContext.request.contextPath}/products/list" class="btn btn-outline-secondary">
                                <i class="bi bi-x-circle me-1"></i> Cancel
                            </a>
                            <button type="submit" class="btn text-white px-4 fw-semibold" style="background-color: #4f46e5;">
                                <i class="bi ${isEdit ? 'bi-check-circle-fill' : 'bi-save-fill'} me-1"></i>
                                ${isEdit ? 'Save Changes' : 'Register Product'}
                            </button>
                        </div>

                    </form>
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
