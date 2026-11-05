<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Library Management System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container mt-4">
    <!-- Header -->
    <div class="d-flex justify-content-between align-items-center mb-3 pb-2 border-bottom">
        <h2 class="text-success">Library Management System</h2>
        <a href="${pageContext.request.contextPath}/books/add" class="btn btn-success fw-bold">+ Add New Book</a>
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

    <!-- Search by Book ID -->
    <div class="card p-3 mb-4 shadow-sm bg-white">
        <form action="${pageContext.request.contextPath}/books/search" method="get" class="row g-2 align-items-center">
            <div class="col-auto">
                <label class="fw-bold">Search Book by ID:</label>
            </div>
            <div class="col-auto">
                <input type="number" name="bookId" class="form-control" placeholder="Enter Book ID" value="${searchedId}" required>
            </div>
            <div class="col-auto">
                <button type="submit" class="btn btn-outline-success">Search</button>
                <a href="${pageContext.request.contextPath}/books" class="btn btn-secondary">Show All</a>
            </div>
        </form>
    </div>

    <!-- Books Table -->
    <div class="card shadow-sm">
        <div class="card-header bg-success text-white">
            <h5 class="mb-0">Available Books in Library</h5>
        </div>
        <div class="card-body p-0">
            <table class="table table-striped table-hover mb-0">
                <thead class="table-light">
                    <tr>
                        <th>Book ID</th>
                        <th>Title</th>
                        <th>Author</th>
                        <th>Publisher</th>
                        <th>ISBN</th>
                        <th>Edition</th>
                        <th>Year</th>
                        <th>Category</th>
                        <th>Available Copies</th>
                        <th class="text-center">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${not empty books}">
                            <c:forEach var="b" items="${books}">
                                <tr>
                                    <td><strong>#${b.bookId}</strong></td>
                                    <td>${b.title}</td>
                                    <td>${b.author}</td>
                                    <td>${b.publisher}</td>
                                    <td><code>${b.isbn}</code></td>
                                    <td>${b.edition}</td>
                                    <td>${b.publicationYear}</td>
                                    <td><span class="badge bg-secondary">${b.category}</span></td>
                                    <td><span class="badge ${b.availableCopies > 0 ? 'bg-success' : 'bg-danger'}">${b.availableCopies}</span></td>
                                    <td class="text-center">
                                        <a href="${pageContext.request.contextPath}/books/edit/${b.bookId}" class="btn btn-sm btn-warning">Edit</a>
                                        <a href="${pageContext.request.contextPath}/books/delete/${b.bookId}" 
                                           class="btn btn-sm btn-danger"
                                           onclick="return confirm('Delete book #${b.bookId}?');">Delete</a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr>
                                <td colspan="10" class="text-center py-4 text-muted">No books found in the library catalogue.</td>
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
