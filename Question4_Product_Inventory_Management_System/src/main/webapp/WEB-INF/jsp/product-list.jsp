<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Product Inventory Management System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container mt-4">
    <!-- Header -->
    <div class="d-flex justify-content-between align-items-center mb-3 pb-2 border-bottom">
        <h2 class="text-primary">Product Inventory Management System</h2>
        <a href="${pageContext.request.contextPath}/products/add" class="btn btn-primary fw-bold">+ Add New Product</a>
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

    <!-- Search by Product ID -->
    <div class="card p-3 mb-4 shadow-sm bg-white">
        <form action="${pageContext.request.contextPath}/products/search" method="get" class="row g-2 align-items-center">
            <div class="col-auto">
                <label class="fw-bold">Search Product by ID:</label>
            </div>
            <div class="col-auto">
                <input type="number" name="productId" class="form-control" placeholder="Enter Product ID" value="${searchedId}" required>
            </div>
            <div class="col-auto">
                <button type="submit" class="btn btn-outline-primary">Search</button>
                <a href="${pageContext.request.contextPath}/products" class="btn btn-secondary">Show All</a>
            </div>
        </form>
    </div>

    <!-- Products Table -->
    <div class="card shadow-sm">
        <div class="card-header bg-primary text-white">
            <h5 class="mb-0">Registered Products in Inventory</h5>
        </div>
        <div class="card-body p-0">
            <table class="table table-striped table-hover mb-0">
                <thead class="table-light">
                    <tr>
                        <th>ID</th>
                        <th>Product Name</th>
                        <th>Category</th>
                        <th>Brand</th>
                        <th>Price ($)</th>
                        <th>Quantity</th>
                        <th>Supplier</th>
                        <th>Mfg Date</th>
                        <th>Exp Date</th>
                        <th class="text-center">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${not empty products}">
                            <c:forEach var="p" items="${products}">
                                <tr>
                                    <td><strong>#${p.productId}</strong></td>
                                    <td>${p.productName}</td>
                                    <td><span class="badge bg-secondary">${p.category}</span></td>
                                    <td>${p.brand}</td>
                                    <td class="text-success fw-bold">${p.price}</td>
                                    <td><span class="badge ${p.quantity > 0 ? 'bg-success' : 'bg-danger'}">${p.quantity}</span></td>
                                    <td>${p.supplierName}</td>
                                    <td>${p.manufacturingDate}</td>
                                    <td>${p.expiryDate}</td>
                                    <td class="text-center">
                                        <a href="${pageContext.request.contextPath}/products/edit/${p.productId}" class="btn btn-sm btn-warning">Edit</a>
                                        <a href="${pageContext.request.contextPath}/products/delete/${p.productId}" 
                                           class="btn btn-sm btn-danger"
                                           onclick="return confirm('Delete product #${p.productId}?');">Delete</a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr>
                                <td colspan="10" class="text-center py-4 text-muted">No products found in inventory.</td>
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
