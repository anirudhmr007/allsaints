<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Online Banking System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container mt-4">
    <!-- Header -->
    <div class="d-flex justify-content-between align-items-center mb-3 pb-2 border-bottom">
        <h2 class="text-primary">Online Banking System</h2>
        <div>
            <a href="${pageContext.request.contextPath}/accounts/transaction" class="btn btn-warning fw-bold me-2">Deposit / Withdraw</a>
            <a href="${pageContext.request.contextPath}/accounts/register" class="btn btn-primary fw-bold">+ Open New Account</a>
        </div>
    </div>

    <!-- Alert Messages -->
    <c:if test="${not empty message}">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            ${message}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            ${error}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>
    <c:if test="${not empty currentBalanceMessage}">
        <div class="alert alert-info alert-dismissible fade show" role="alert">
            <strong>${currentBalanceMessage}</strong>
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <!-- Search / Check Balance by Account Number -->
    <div class="card p-3 mb-4 shadow-sm bg-white">
        <form action="${pageContext.request.contextPath}/accounts/search" method="get" class="row g-2 align-items-center">
            <div class="col-auto">
                <label class="fw-bold">Search by Account Number / Check Balance:</label>
            </div>
            <div class="col-auto">
                <input type="text" name="accountNumber" class="form-control" placeholder="e.g. ACC1000101" value="${searchedNumber}" required>
            </div>
            <div class="col-auto">
                <button type="submit" class="btn btn-outline-primary">Search</button>
                <a href="${pageContext.request.contextPath}/accounts" class="btn btn-secondary">Show All</a>
            </div>
        </form>
    </div>

    <!-- Accounts Table -->
    <div class="card shadow-sm">
        <div class="card-header bg-primary text-white">
            <h5 class="mb-0">Customer Bank Accounts</h5>
        </div>
        <div class="card-body p-0">
            <table class="table table-striped table-hover mb-0">
                <thead class="table-light">
                    <tr>
                        <th>Account ID</th>
                        <th>Account Number</th>
                        <th>Customer Name</th>
                        <th>Age</th>
                        <th>Gender</th>
                        <th>Contact Number</th>
                        <th>Email</th>
                        <th>Account Type</th>
                        <th>Account Balance ($)</th>
                        <th class="text-center">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${not empty accounts}">
                            <c:forEach var="a" items="${accounts}">
                                <tr>
                                    <td><strong>#${a.accountId}</strong></td>
                                    <td><code>${a.accountNumber}</code></td>
                                    <td>${a.customerName}</td>
                                    <td>${a.age}</td>
                                    <td>${a.gender}</td>
                                    <td>${a.contactNumber}</td>
                                    <td>${a.email}</td>
                                    <td><span class="badge bg-secondary">${a.accountType}</span></td>
                                    <td class="text-success fw-bold fs-6">$${a.accountBalance}</td>
                                    <td class="text-center">
                                        <a href="${pageContext.request.contextPath}/accounts/transaction?accountNumber=${a.accountNumber}" class="btn btn-sm btn-outline-success">Transact</a>
                                        <a href="${pageContext.request.contextPath}/accounts/delete/${a.accountId}" 
                                           class="btn btn-sm btn-danger"
                                           onclick="return confirm('Delete bank account ${a.accountNumber}?');">Delete</a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr>
                                <td colspan="10" class="text-center py-4 text-muted">No bank accounts registered.</td>
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
