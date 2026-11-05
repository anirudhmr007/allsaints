<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Deposit / Withdraw Money</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container mt-4" style="max-width: 750px;">
    
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h3>Banking Operations: Deposit & Withdraw</h3>
        <a href="${pageContext.request.contextPath}/accounts" class="btn btn-outline-secondary">&larr; Back to Accounts</a>
    </div>

    <div class="row g-4">
        <!-- Deposit Box -->
        <div class="col-md-6">
            <div class="card shadow-sm border-success">
                <div class="card-header bg-success text-white">
                    <h5 class="mb-0">Deposit Money</h5>
                </div>
                <div class="card-body">
                    <form action="${pageContext.request.contextPath}/accounts/deposit" method="post">
                        <div class="mb-3">
                            <label class="form-label fw-bold">Select Account:</label>
                            <select name="accountNumber" class="form-select" required>
                                <option value="">-- Choose Account --</option>
                                <c:forEach var="acc" items="${accounts}">
                                    <option value="${acc.accountNumber}" ${acc.accountNumber == selectedAccountNumber ? 'selected' : ''}>
                                        ${acc.accountNumber} - ${acc.customerName} (Bal: $${acc.accountBalance})
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-bold">Deposit Amount ($):</label>
                            <input type="number" step="0.01" name="amount" class="form-control" placeholder="Amount > 0" min="0.01" required>
                        </div>
                        <button type="submit" class="btn btn-success w-100 fw-bold">Confirm Deposit</button>
                    </form>
                </div>
            </div>
        </div>

        <!-- Withdraw Box -->
        <div class="col-md-6">
            <div class="card shadow-sm border-danger">
                <div class="card-header bg-danger text-white">
                    <h5 class="mb-0">Withdraw Money</h5>
                </div>
                <div class="card-body">
                    <form action="${pageContext.request.contextPath}/accounts/withdraw" method="post">
                        <div class="mb-3">
                            <label class="form-label fw-bold">Select Account:</label>
                            <select name="accountNumber" class="form-select" required>
                                <option value="">-- Choose Account --</option>
                                <c:forEach var="acc" items="${accounts}">
                                    <option value="${acc.accountNumber}" ${acc.accountNumber == selectedAccountNumber ? 'selected' : ''}>
                                        ${acc.accountNumber} - ${acc.customerName} (Bal: $${acc.accountBalance})
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-bold">Withdraw Amount ($):</label>
                            <input type="number" step="0.01" name="amount" class="form-control" placeholder="Amount > 0" min="0.01" required>
                            <small class="text-muted">Cannot exceed available balance.</small>
                        </div>
                        <button type="submit" class="btn btn-danger w-100 fw-bold">Confirm Withdrawal</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>
