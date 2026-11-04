<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Library Management System</title>
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
            <a class="nav-link text-white active" href="${pageContext.request.contextPath}/books/list">
                <i class="bi bi-collection me-1"></i> Book Catalog
            </a>
            <a class="btn btn-light btn-sm ms-2 text-success fw-semibold" href="${pageContext.request.contextPath}/books/new">
                <i class="bi bi-plus-circle-fill me-1"></i> Add New Book
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
                    <h4 class="card-title fw-bold text-success mb-1">
                        <i class="bi bi-journal-bookmark-fill me-2"></i>Available Books Catalog
                    </h4>
                    <p class="text-muted small mb-0">Total Books displayed: ${books.size()}</p>
                </div>
                <div class="col-md-6">
                    <form action="${pageContext.request.contextPath}/books/search" method="get" class="d-flex gap-2">
                        <div class="input-group">
                            <span class="input-group-text bg-white"><i class="bi bi-search"></i></span>
                            <input type="number" name="bookId" class="form-control" placeholder="Search by Book ID..." value="${searchedId}" required>
                            <button class="btn btn-outline-success" type="submit">Search</button>
                        </div>
                        <c:if test="${not empty searchedId}">
                            <a href="${pageContext.request.contextPath}/books/list" class="btn btn-secondary">Reset</a>
                        </c:if>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Books Table -->
    <div class="card shadow-sm border-0">
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead class="table-success text-dark">
                        <tr>
                            <th class="ps-3">Book ID</th>
                            <th>Title</th>
                            <th>Author</th>
                            <th>Publisher</th>
                            <th>ISBN</th>
                            <th>Edition</th>
                            <th>Year</th>
                            <th>Category</th>
                            <th class="text-center">Available Copies</th>
                            <th class="text-center pe-3">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${not empty books}">
                                <c:forEach var="book" items="${books}">
                                    <tr>
                                        <td class="ps-3 fw-bold text-success">#${book.bookId}</td>
                                        <td class="fw-semibold">${book.title}</td>
                                        <td>${book.author}</td>
                                        <td><small>${book.publisher}</small></td>
                                        <td><code>${book.isbn}</code></td>
                                        <td>${book.edition}</td>
                                        <td>${book.publicationYear}</td>
                                        <td><span class="badge bg-secondary">${book.category}</span></td>
                                        <td class="text-center">
                                            <span class="badge ${book.availableCopies > 0 ? 'bg-success' : 'bg-danger'} rounded-pill px-3 py-1">
                                                ${book.availableCopies}
                                            </span>
                                        </td>
                                        <td class="text-center pe-3">
                                            <div class="btn-group btn-group-sm">
                                                <a href="${pageContext.request.contextPath}/books/view/${book.bookId}" class="btn btn-outline-info" title="View Details">
                                                    <i class="bi bi-eye"></i>
                                                </a>
                                                <a href="${pageContext.request.contextPath}/books/edit/${book.bookId}" class="btn btn-outline-warning" title="Edit Book">
                                                    <i class="bi bi-pencil-square"></i>
                                                </a>
                                                <a href="${pageContext.request.contextPath}/books/delete/${book.bookId}" 
                                                   class="btn btn-outline-danger" 
                                                   onclick="return confirm('Are you sure you want to delete book #${book.bookId} (${book.title})?');"
                                                   title="Delete Book">
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
                                        <i class="bi bi-journal-x fs-1 d-block mb-2 text-secondary"></i>
                                        No book records found.
                                        <div class="mt-2">
                                            <a href="${pageContext.request.contextPath}/books/new" class="btn btn-success btn-sm">
                                                <i class="bi bi-plus-circle-fill me-1"></i> Add the First Book
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
    <small>&copy; Library Management System | Spring Boot MVC + PostgreSQL + JSP</small>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
