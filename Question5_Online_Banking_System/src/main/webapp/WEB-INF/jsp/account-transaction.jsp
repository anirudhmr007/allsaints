<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Account Transactions - Deposit & Withdrawal</title>
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
            <a class="nav-link text-white active" href="${pageContext.request.contextPath}/accounts/transaction">
                <i class="bi bi-arrow-left-right me-1"></i> Deposit / Withdraw
            </a>
        </div>
    </div>
</nav>

<div class="container">

    <!-- Flash Alerts -->
    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger alert-dismissible fade show shadow-sm" role="alert">
            <i class="bi bi-exclamation-triangle-fill me-2"></i> ${errorMessage}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <div class="row justify-content-center">
        <div class="col-lg-8">
            <div class="card shadow-sm border-0">
                <div class="card-header bg-primary text-white py-3">
                    <h5 class="card-title mb-0 fw-bold">
                        <i class="bi bi-cash-coin me-2"></i>Bank Account Transaction Portal
                    </h5>
                </div>
                <div class="card-body p-4">

                    <!-- Tab Navigation for Deposit vs Withdraw -->
                    <ul class="nav nav-pills nav-fill mb-4" id="transactionTabs" role="tablist">
                        <li class="nav-item" role="presentation">
                            <button class="nav-link ${transType != 'withdraw' ? 'active' : ''} fw-bold" id="deposit-tab" data-bs-toggle="pill" data-bs-target="#deposit-pane" type="button" role="tab">
                                <i class="bi bi-arrow-down-circle-fill me-2 text-success"></i>Deposit Funds
                            </button>
                        </li>
                        <li class="nav-item" role="presentation">
                            <button class="nav-link ${transType == 'withdraw' ? 'active' : ''} fw-bold" id="withdraw-tab" data-bs-toggle="pill" data-bs-target="#withdraw-pane" type="button" role="tab">
                                <i class="bi bi-arrow-up-circle-fill me-2 text-danger"></i>Withdraw Funds
                            </button>
                        </li>
                    </ul>

                    <div class="tab-content" id="transactionTabsContent">
                        
                        <!-- DEPOSIT TAB -->
                        <div class="tab-pane fade ${transType != 'withdraw' ? 'show active' : ''}" id="deposit-pane" role="tabpanel">
                            <form action="${pageContext.request.contextPath}/accounts/deposit" method="post">
                                <div class="mb-3">
                                    <label class="form-label fw-semibold">Select / Enter Account Number <span class="text-danger">*</span></label>
                                    <input type="text" name="accountNumber" class="form-control form-control-lg" list="accountsList" value="${selectedNumber}" placeholder="e.g. ACC1000101" required>
                                    <datalist id="accountsList">
                                        <c:forEach var="acc" items="${allAccounts}">
                                            <option value="${acc.accountNumber}">${acc.customerName} (Bal: $${acc.accountBalance})</option>
                                        </c:forEach>
                                    </datalist>
                                </div>
                                <div class="mb-4">
                                    <label class="form-label fw-semibold">Deposit Amount ($) <span class="text-danger">*</span></label>
                                    <div class="input-group input-group-lg">
                                        <span class="input-group-text">$</span>
                                        <input type="number" step="0.01" min="0.01" name="amount" class="form-control" placeholder="0.00" required>
                                    </div>
                                    <div class="form-text">Amount must be strictly greater than $0.00.</div>
                                </div>
                                <button type="submit" class="btn btn-success btn-lg w-100 fw-bold">
                                    <i class="bi bi-check-circle-fill me-2"></i>Process Deposit
                                </button>
                            </form>
                        </div>

                        <!-- WITHDRAW TAB -->
                        <div class="tab-pane fade ${transType == 'withdraw' ? 'show active' : ''}" id="withdraw-pane" role="tabpanel">
                            <form action="${pageContext.request.contextPath}/accounts/withdraw" method="post">
                                <div class="mb-3">
                                    <label class="form-label fw-semibold">Select / Enter Account Number <span class="text-danger">*</span></label>
                                    <input type="text" name="accountNumber" class="form-control form-control-lg" list="accountsListWithdraw" value="${selectedNumber}" placeholder="e.g. ACC1000101" required>
                                    <datalist id="accountsListWithdraw">
                                        <c:forEach var="acc" items="${allAccounts}">
                                            <option value="${acc.accountNumber}">${acc.customerName} (Bal: $${acc.accountBalance})</option>
                                        </c:forEach>
                                    </datalist>
                                </div>
                                <div class="mb-4">
                                    <label class="form-label fw-semibold">Withdrawal Amount ($) <span class="text-danger">*</span></label>
                                    <div class="input-group input-group-lg">
                                        <span class="input-group-text">$</span>
                                        <input type="number" step="0.01" min="0.01" name="amount" class="form-control" placeholder="0.00" required>
                                    </div>
                                    <div class="form-text">Withdrawal is validated against current account balance. Overdrafts will be rejected.</div>
                                </div>
                                <button type="submit" class="btn btn-danger btn-lg w-100 fw-bold">
                                    <i class="bi bi-arrow-up-circle-fill me-2"></i>Process Withdrawal
                                </button>
                            </form>
                        </div>

                    </div>

                </div>
            </div>
        </div>
    </div>
</div>

<footer class="text-center text-muted py-4 mt-5">
    <small>&copy; Online Banking System | Spring Boot MVC + PostgreSQL + JSP</small>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

