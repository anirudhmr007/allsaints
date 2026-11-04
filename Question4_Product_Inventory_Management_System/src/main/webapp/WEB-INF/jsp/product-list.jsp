<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Product Inventory Management System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<nav class="navbar navbar-expand-lg navbar-dark bg-indigo shadow-sm mb-4" style="background-color: #4f46e5;">
    <div class="container">
        <a class="navbar-brand fw-bold" href="${pageContext.request.contextPath}/products/list">
            <i class="bi bi-boxes me-2"></i>Inventory Control Portal
        </a>
        <div class="navbar-nav ms-auto">
            <a class="nav-link text-white active" href="${pageContext.request.contextPath}/products/list">
                <i class="bi bi-grid-3x3-gap-fill me-1"></i> Stock Registry
            </a>
            <a class="btn btn-light btn-sm ms-2 fw-semibold" style="color: #4f46e5;" href="${pageContext.request.contextPath}/products/new">
                <i class="bi bi-plus-circle-fill me-1"></i> Add New Product
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

    <!-- Header & Search Controls -->
    <div class="card shadow-sm border-0 mb-4">
        <div class="card-body">
            <div class="row align-items-center g-3">
                <div class="col-md-6">
                    <h4 class="card-title fw-bold mb-1" style="color: #4f46e5;">
                        <i class="bi bi-box-seam-fill me-2"></i>Registered Products Inventory
                    </h4>
                    <p class="text-muted small mb-0">Total Products in stock: ${products.size()}</p>
                </div>
                <div class="col-md-6">
                    <form action="${pageContext.request.contextPath}/products/search" method="get" class="d-flex gap-2">
                        <div class="input-group">
                            <span class="input-group-text bg-white"><i class="bi bi-search"></i></span>
                            <input type="number" name="productId" class="form-control" placeholder="Search by Product ID..." value="${searchedId}" required>
                            <button class="btn btn-outline-primary" type="submit">Search</button>
                        </div>
                        <c:if test="${not empty searchedId}">
                            <a href="${pageContext.request.contextPath}/products/list" class="btn btn-secondary">Reset</a>
                        </c:if>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Products Table -->
    <div class="card shadow-sm border-0">
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead class="table-light text-dark">
                        <tr>
                            <th class="ps-3">ID</th>
                            <th>Product Name</th>
                            <th>Category</th>
                            <th>Brand</th>
                            <th>Price</th>
                            <th>Stock</th>
                            <th>Supplier</th>
                            <th>Mfg Date</th>
                            <th>Exp Date</th>
                            <th class="text-center pe-3">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${not empty products}">
                                <c:forEach var="prod" items="${products}">
                                    <tr>
                                        <td class="ps-3 fw-bold" style="color: #4f46e5;">#${prod.productId}</td>
                                        <td class="fw-semibold">${prod.productName}</td>
                                        <td><span class="badge bg-secondary">${prod.category}</span></td>
                                        <td>${prod.brand}</td>
                                        <td class="fw-bold text-success">
                                            $<fmt:formatNumber value="${prod.price}" type="number" minFractionDigits="2" maxFractionDigits="2"/>
                                        </td>
                                        <td>
                                            <span class="badge ${prod.quantity > 10 ? 'bg-success' : (prod.quantity > 0 ? 'bg-warning text-dark' : 'bg-danger')} rounded-pill px-3 py-1">
                                                ${prod.quantity} units
                                            </span>
                                        </td>
                                        <td><small class="text-muted">${prod.supplierName}</small></td>
                                        <td><small>${prod.manufacturingDate}</small></td>
                                        <td><small>${prod.expiryDate}</small></td>
                                        <td class="text-center pe-3">
                                            <div class="btn-group btn-group-sm">
                                                <a href="${pageContext.request.contextPath}/products/view/${prod.productId}" class="btn btn-outline-info" title="View Details">
                                                    <i class="bi bi-eye"></i>
                                                </a>
                                                <a href="${pageContext.request.contextPath}/products/edit/${prod.productId}" class="btn btn-outline-warning" title="Edit Product">
                                                    <i class="bi bi-pencil-square"></i>
                                                </a>
                                                <a href="${pageContext.request.contextPath}/products/delete/${prod.productId}" 
                                                   class="btn btn-outline-danger" 
                                                   onclick="return confirm('Are you sure you want to delete product #${prod.productId} (${prod.productName})?');"
                                                   title="Delete Product">
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
                                        <i class="bi bi-box-seam fs-1 d-block mb-2 text-secondary"></i>
                                        No product records found.
                                        <div class="mt-2">
                                            <a href="${pageContext.request.contextPath}/products/new" class="btn btn-primary btn-sm">
                                                <i class="bi bi-plus-circle-fill me-1"></i> Add First Product
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
    <small>&copy; Product Inventory Management System | Spring Boot MVC + PostgreSQL + JSP</small>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
