<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Check Account Balance - Apex Bank</title>
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
            <a class="nav-link text-white" href="${pageContext.request.contextPath}/accounts/list">
                <i class="bi bi-arrow-left me-1"></i> Customer Accounts
            </a>
            <a class="nav-link text-white active" href="${pageContext.request.contextPath}/accounts/balance">
                <i class="bi bi-wallet2 me-1"></i> Balance Inquiry
            </a>
        </div>
    </div>
</nav>

<div class="container">
    <div class="row justify-content-center">
        <div class="col-lg-6">
            
            <div class="card shadow-sm border-0 mb-4">
                <div class="card-header bg-primary text-white py-3">
                    <h5 class="card-title mb-0 fw-bold">
                        <i class="bi bi-search me-2"></i>Account Balance Inquiry
                    </h5>
                </div>
                <div class="card-body p-4">
                    <form action="${pageContext.request.contextPath}/accounts/balance" method="get">
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Enter Account Number</label>
                            <input type="text" name="accountNumber" class="form-control form-control-lg" placeholder="e.g. ACC1000101" value="${param.accountNumber}" required>
                        </div>
                        <button type="submit" class="btn btn-primary w-100 fw-bold">
                            <i class="bi bi-wallet2 me-2"></i>Check Current Balance
                        </button>
                    </form>
                </div>
            </div>

            <c:if test="${not empty errorMessage}">
                <div class="alert alert-danger shadow-sm" role="alert">
                    <i class="bi bi-exclamation-triangle-fill me-2"></i> ${errorMessage}
                </div>
            </c:if>

            <c:if test="${not empty account}">
                <div class="card shadow-sm border-0 border-top border-4 border-success">
                    <div class="card-body p-4 text-center">
                        <span class="badge bg-secondary mb-2">${account.accountType} Account</span>
                        <h4 class="fw-bold mb-1">${account.customerName}</h4>
                        <p class="text-muted small mb-4">Account Number: <code>${account.accountNumber}</code></p>

                        <div class="p-4 bg-light rounded-3 mb-4">
                            <div class="text-muted small text-uppercase fw-semibold mb-1">Available Account Balance</div>
                            <div class="display-4 fw-bold text-success">
                                $<fmt:formatNumber value="${account.accountBalance}" type="number" minFractionDigits="2" maxFractionDigits="2"/>
                            </div>
                        </div>

                        <div class="d-flex justify-content-center gap-2">
                            <a href="${pageContext.request.contextPath}/accounts/transaction?accountNumber=${account.accountNumber}&type=deposit" class="btn btn-success">
                                <i class="bi bi-plus-lg me-1"></i> Deposit Money
                            </a>
                            <a href="${pageContext.request.contextPath}/accounts/transaction?accountNumber=${account.accountNumber}&type=withdraw" class="btn btn-danger">
                                <i class="bi bi-dash-lg me-1"></i> Withdraw Money
                            </a>
                        </div>
                    </div>
                </div>
            </c:if>

        </div>
    </div>
</div>

<footer class="text-center text-muted py-4 mt-5">
    <small>&copy; Online Banking System | Spring Boot MVC + PostgreSQL + JSP</small>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
