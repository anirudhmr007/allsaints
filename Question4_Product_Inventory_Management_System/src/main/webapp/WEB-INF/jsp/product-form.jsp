<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${pageTitle}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container mt-4" style="max-width: 650px;">
    <div class="card shadow">
        <div class="card-header bg-primary text-white">
            <h4 class="mb-0">${pageTitle}</h4>
        </div>
        <div class="card-body p-4">
            <form action="${pageContext.request.contextPath}/products/save" method="post">
                <input type="hidden" name="productId" value="${product.productId}">

                <div class="mb-3">
                    <label class="form-label fw-bold">Product Name:</label>
                    <input type="text" name="productName" class="form-control" value="${product.productName}" placeholder="e.g. Wireless Headphones" required>
                </div>

                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label fw-bold">Category:</label>
                        <input type="text" name="category" class="form-control" value="${product.category}" placeholder="e.g. Electronics, Furniture" required>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label fw-bold">Brand:</label>
                        <input type="text" name="brand" class="form-control" value="${product.brand}" placeholder="e.g. Sony, Apple" required>
                    </div>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-bold">Description:</label>
                    <textarea name="description" class="form-control" rows="2" placeholder="Product details">${product.description}</textarea>
                </div>

                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label fw-bold">Price ($):</label>
                        <input type="number" step="0.01" name="price" class="form-control" value="${product.price}" min="0.01" placeholder="e.g. 99.99" required>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label fw-bold">Quantity in Stock:</label>
                        <input type="number" name="quantity" class="form-control" value="${product.quantity}" min="0" placeholder="e.g. 50" required>
                    </div>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-bold">Supplier Name:</label>
                    <input type="text" name="supplierName" class="form-control" value="${product.supplierName}" placeholder="e.g. Apex Tech Ltd" required>
                </div>

                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label fw-bold">Manufacturing Date:</label>
                        <input type="date" name="manufacturingDate" class="form-control" value="${product.manufacturingDate}" required>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label fw-bold">Expiry Date:</label>
                        <input type="date" name="expiryDate" class="form-control" value="${product.expiryDate}" required>
                    </div>
                </div>

                <div class="d-flex justify-content-between mt-4">
                    <a href="${pageContext.request.contextPath}/products" class="btn btn-secondary">Cancel</a>
                    <button type="submit" class="btn btn-primary fw-bold">Save Product</button>
                </div>
            </form>
        </div>
    </div>
</div>

</body>
</html>
