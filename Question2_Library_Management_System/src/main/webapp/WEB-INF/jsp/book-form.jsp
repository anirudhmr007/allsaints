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
        <div class="card-header bg-success text-white">
            <h4 class="mb-0">${pageTitle}</h4>
        </div>
        <div class="card-body p-4">
            <form action="${pageContext.request.contextPath}/books/save" method="post">
                <input type="hidden" name="bookId" value="${book.bookId}">

                <div class="mb-3">
                    <label class="form-label fw-bold">Book Title:</label>
                    <input type="text" name="title" class="form-control" value="${book.title}" placeholder="e.g. Clean Code" required>
                </div>

                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label fw-bold">Author:</label>
                        <input type="text" name="author" class="form-control" value="${book.author}" placeholder="Author name" required>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label fw-bold">Publisher:</label>
                        <input type="text" name="publisher" class="form-control" value="${book.publisher}" placeholder="Publisher name" required>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label fw-bold">ISBN:</label>
                        <input type="text" name="isbn" class="form-control" value="${book.isbn}" placeholder="e.g. 978-0132350884" required>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label fw-bold">Edition:</label>
                        <input type="text" name="edition" class="form-control" value="${book.edition}" placeholder="e.g. 1st Edition" required>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-4 mb-3">
                        <label class="form-label fw-bold">Publication Year:</label>
                        <input type="number" name="publicationYear" class="form-control" value="${book.publicationYear}" placeholder="e.g. 2021" required>
                    </div>
                    <div class="col-md-4 mb-3">
                        <label class="form-label fw-bold">Category:</label>
                        <input type="text" name="category" class="form-control" value="${book.category}" placeholder="e.g. Computer Science" required>
                    </div>
                    <div class="col-md-4 mb-3">
                        <label class="form-label fw-bold">Available Copies:</label>
                        <input type="number" name="availableCopies" class="form-control" value="${book.availableCopies}" min="0" placeholder="e.g. 10" required>
                    </div>
                </div>

                <div class="d-flex justify-content-between mt-4">
                    <a href="${pageContext.request.contextPath}/books" class="btn btn-secondary">Cancel</a>
                    <button type="submit" class="btn btn-success fw-bold">Save Book</button>
                </div>
            </form>
        </div>
    </div>
</div>

</body>
</html>
