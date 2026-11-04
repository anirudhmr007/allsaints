<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Online Banking System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<nav class="navbar navbar-expand-lg navbar-dark bg-primary shadow-sm mb-4">
    <div class="container">
        <a class="navbar-brand fw-bold" href="${pageContext.request.contextPath}/accounts/list">
            <i class="bi bi-bank2 me-2"></i>Global Apex Online Bank
        </a>
        <div class="navbar-nav ms-auto gap-2">
            <a class="nav-link text-white active" href="${pageContext.request.contextPath}/accounts/list">
                <i class="bi bi-credit-card-2-front me-1"></i> Customer Accounts
            </a>
            <a class="nav-link text-white" href="${pageContext.request.contextPath}/accounts/transaction">
                <i class="bi bi-arrow-left-right me-1"></i> Deposit / Withdraw
            </a>
            <a class="nav-link text-white" href="${pageContext.request.contextPath}/accounts/balance">
                <i class="bi bi-wallet2 me-1"></i> Check Balance
            </a>
            <a class="btn btn-warning btn-sm text-dark fw-bold ms-2" href="${pageContext.request.contextPath}/accounts/register">
                <i class="bi bi-person-plus-fill me-1"></i> Register New Customer
            </a>
        </div>
    </div>
</nav>

<div class="container">

    <!-- Flash Messages -->
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
                    <h4 class="card-title fw-bold text-primary mb-1">
                        <i class="bi bi-person-vcard-fill me-2"></i>Registered Customer Accounts
                    </h4>
                    <p class="text-muted small mb-0">Total Accounts: ${accounts.size()}</p>
                </div>
                <div class="col-md-6">
                    <form action="${pageContext.request.contextPath}/accounts/search" method="get" class="d-flex gap-2">
                        <div class="input-group">
                            <span class="input-group-text bg-white"><i class="bi bi-search"></i></span>
                            <input type="text" name="accountNumber" class="form-control" placeholder="Search by Account Number (e.g. ACC1000101)..." value="${searchedNumber}" required>
                            <button class="btn btn-outline-primary" type="submit">Search</button>
                        </div>
                        <c:if test="${not empty searchedNumber}">
                            <a href="${pageContext.request.contextPath}/accounts/list" class="btn btn-secondary">Reset</a>
                        </c:if>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Accounts Table -->
    <div class="card shadow-sm border-0">
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead class="table-primary text-dark">
                        <tr>
                            <th class="ps-3">Account No</th>
                            <th>Customer Name</th>
                            <th>Age/Gender</th>
                            <th>Contact</th>
                            <th>Email</th>
                            <th>Account Type</th>
                            <th class="text-end">Account Balance</th>
                            <th class="text-center pe-3">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${not empty accounts}">
                                <c:forEach var="acc" items="${accounts}">
                                    <tr>
                                        <td class="ps-3 fw-bold text-primary"><code>${acc.accountNumber}</code></td>
                                        <td class="fw-semibold">${acc.customerName}</td>
                                        <td>${acc.age} yrs &bull; <small class="text-muted">${acc.gender}</small></td>
                                        <td>${acc.contactNumber}</td>
                                        <td><small class="text-muted">${acc.email}</small></td>
                                        <td>
                                            <span class="badge ${acc.accountType == 'Savings' ? 'bg-info' : (acc.accountType == 'Current' ? 'bg-secondary' : 'bg-success')}">
                                                ${acc.accountType}
                                            </span>
                                        </td>
                                        <td class="text-end fw-bold fs-6 text-success">
                                            $<fmt:formatNumber value="${acc.accountBalance}" type="number" minFractionDigits="2" maxFractionDigits="2"/>
                                        </td>
                                        <td class="text-center pe-3">
                                            <div class="btn-group btn-group-sm">
                                                <a href="${pageContext.request.contextPath}/accounts/transaction?accountNumber=${acc.accountNumber}&type=deposit" class="btn btn-outline-success" title="Deposit Money">
                                                    <i class="bi bi-plus-lg"></i> Deposit
                                                </a>
                                                <a href="${pageContext.request.contextPath}/accounts/transaction?accountNumber=${acc.accountNumber}&type=withdraw" class="btn btn-outline-danger" title="Withdraw Money">
                                                    <i class="bi bi-dash-lg"></i> Withdraw
                                                </a>
                                                <a href="${pageContext.request.contextPath}/accounts/edit/${acc.accountId}" class="btn btn-outline-warning" title="Edit Profile">
                                                    <i class="bi bi-pencil-square"></i>
                                                </a>
                                                <a href="${pageContext.request.contextPath}/accounts/delete/${acc.accountId}" 
                                                   class="btn btn-outline-secondary" 
                                                   onclick="return confirm('Delete customer account ${acc.accountNumber}?');"
                                                   title="Delete Account">
                                                    <i class="bi bi-trash"></i>
                                                </a>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="8" class="text-center py-5 text-muted">
                                        <i class="bi bi-credit-card fs-1 d-block mb-2 text-secondary"></i>
                                        No customer accounts found.
                                        <div class="mt-2">
                                            <a href="${pageContext.request.contextPath}/accounts/register" class="btn btn-primary btn-sm">
                                                <i class="bi bi-person-plus-fill me-1"></i> Register First Customer
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
    <small>&copy; Online Banking System | Spring Boot MVC + PostgreSQL + JPA</small>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

