<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book Details - #${book.bookId}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<nav class="navbar navbar-expand-lg navbar-dark bg-success shadow-sm mb-4">
    <div class="container">
        <a class="navbar-brand fw-bold" href="${pageContext.request.contextPath}/books/list">
            <i class="bi bi-book-half me-2"></i>Campus Library Management
        </a>
        <div class="navbar-nav ms-auto">
            <a class="nav-link text-white" href="${pageContext.request.contextPath}/books/list">
                <i class="bi bi-arrow-left me-1"></i> Back to Catalog
            </a>
        </div>
    </div>
</nav>

<div class="container">
    <div class="row justify-content-center">
        <div class="col-lg-7">
            <div class="card shadow-sm border-0">
                <div class="card-header bg-success text-white py-3 d-flex justify-content-between align-items-center">
                    <h5 class="card-title mb-0 fw-bold">
                        <i class="bi bi-journal-bookmark-fill me-2"></i>Book Details: #${book.bookId}
                    </h5>
                    <span class="badge ${book.availableCopies > 0 ? 'bg-light text-success' : 'bg-danger'} rounded-pill px-3 py-2 fs-6">
                        ${book.availableCopies > 0 ? 'In Stock' : 'Out of Stock'}
                    </span>
                </div>
                <div class="card-body p-4">
                    <div class="text-center mb-4">
                        <div class="display-6 fw-bold text-dark">${book.title}</div>
                        <p class="text-muted mb-0">By <strong>${book.author}</strong></p>
                    </div>

                    <table class="table table-bordered align-middle">
                        <tbody>
                            <tr>
                                <th class="bg-light text-secondary" style="width: 35%;">Book ID</th>
                                <td class="fw-bold text-success">#${book.bookId}</td>
                            </tr>
                            <tr>
                                <th class="bg-light text-secondary">Publisher</th>
                                <td>${book.publisher}</td>
                            </tr>
                            <tr>
                                <th class="bg-light text-secondary">ISBN</th>
                                <td><code>${book.isbn}</code></td>
                            </tr>
                            <tr>
                                <th class="bg-light text-secondary">Edition</th>
                                <td>${book.edition}</td>
                            </tr>
                            <tr>
                                <th class="bg-light text-secondary">Publication Year</th>
                                <td>${book.publicationYear}</td>
                            </tr>
                            <tr>
                                <th class="bg-light text-secondary">Category</th>
                                <td><span class="badge bg-secondary">${book.category}</span></td>
                            </tr>
                            <tr>
                                <th class="bg-light text-secondary">Available Copies</th>
                                <td><strong class="text-success fs-5">${book.availableCopies}</strong> copies</td>
                            </tr>
                        </tbody>
                    </table>

                    <div class="d-flex justify-content-between mt-4">
                        <a href="${pageContext.request.contextPath}/books/list" class="btn btn-secondary">
                            <i class="bi bi-arrow-left me-1"></i> Back to Catalog
                        </a>
                        <div class="d-flex gap-2">
                            <a href="${pageContext.request.contextPath}/books/edit/${book.bookId}" class="btn btn-warning">
                                <i class="bi bi-pencil-square me-1"></i> Edit
                            </a>
                            <a href="${pageContext.request.contextPath}/books/delete/${book.bookId}" 
                               class="btn btn-danger"
                               onclick="return confirm('Are you sure you want to delete book #${book.bookId}?');">
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
    <small>&copy; Library Management System | Spring Boot MVC + PostgreSQL + JSP</small>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
