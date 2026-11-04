<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${isEdit ? 'Update Book' : 'Add New Book'} - Library Management</title>
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
        <div class="col-lg-8">
            <div class="card shadow-sm border-0">
                <div class="card-header bg-success text-white py-3">
                    <h5 class="card-title mb-0 fw-bold">
                        <i class="bi ${isEdit ? 'bi-pencil-square' : 'bi-plus-circle-fill'} me-2"></i>
                        ${isEdit ? 'Update Book Information' : 'Add New Book to Library'}
                    </h5>
                </div>
                <div class="card-body p-4">
                    <form action="${isEdit ? pageContext.request.contextPath.concat('/books/update/').concat(book.bookId) : pageContext.request.contextPath.concat('/books/new')}" method="post">
                        
                        <c:if test="${isEdit}">
                            <div class="mb-3">
                                <label class="form-label fw-semibold">Book ID</label>
                                <input type="text" class="form-control" value="${book.bookId}" disabled>
                            </div>
                        </c:if>

                        <!-- Title -->
                        <div class="mb-3">
                            <label for="title" class="form-label fw-semibold">Book Title <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" id="title" name="title" value="${book.title}" placeholder="e.g. Clean Architecture" required>
                        </div>

                        <!-- Author & Publisher -->
                        <div class="row g-3 mb-3">
                            <div class="col-md-6">
                                <label for="author" class="form-label fw-semibold">Author <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" id="author" name="author" value="${book.author}" placeholder="e.g. Robert C. Martin" required>
                            </div>
                            <div class="col-md-6">
                                <label for="publisher" class="form-label fw-semibold">Publisher <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" id="publisher" name="publisher" value="${book.publisher}" placeholder="e.g. Prentice Hall" required>
                            </div>
                        </div>

                        <!-- ISBN & Edition -->
                        <div class="row g-3 mb-3">
                            <div class="col-md-6">
                                <label for="isbn" class="form-label fw-semibold">ISBN Number <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" id="isbn" name="isbn" value="${book.isbn}" placeholder="e.g. 978-0134494166" required>
                            </div>
                            <div class="col-md-6">
                                <label for="edition" class="form-label fw-semibold">Edition <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" id="edition" name="edition" value="${book.edition}" placeholder="e.g. 1st Edition" required>
                            </div>
                        </div>

                        <!-- Publication Year, Category, Available Copies -->
                        <div class="row g-3 mb-4">
                            <div class="col-md-4">
                                <label for="publicationYear" class="form-label fw-semibold">Publication Year <span class="text-danger">*</span></label>
                                <input type="number" class="form-control" id="publicationYear" name="publicationYear" value="${book.publicationYear}" min="1000" max="2100" placeholder="e.g. 2022" required>
                            </div>
                            <div class="col-md-4">
                                <label for="category" class="form-label fw-semibold">Category <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" id="category" name="category" value="${book.category}" placeholder="e.g. Software Engineering" required>
                            </div>
                            <div class="col-md-4">
                                <label for="availableCopies" class="form-label fw-semibold">Available Copies <span class="text-danger">*</span></label>
                                <input type="number" class="form-control" id="availableCopies" name="availableCopies" value="${book.availableCopies}" min="0" placeholder="e.g. 10" required>
                            </div>
                        </div>

                        <div class="d-flex justify-content-between align-items-center">
                            <a href="${pageContext.request.contextPath}/books/list" class="btn btn-outline-secondary">
                                <i class="bi bi-x-circle me-1"></i> Cancel
                            </a>
                            <button type="submit" class="btn btn-success px-4">
                                <i class="bi ${isEdit ? 'bi-check-circle-fill' : 'bi-save-fill'} me-1"></i>
                                ${isEdit ? 'Save Changes' : 'Save Book'}
                            </button>
                        </div>

                    </form>
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

