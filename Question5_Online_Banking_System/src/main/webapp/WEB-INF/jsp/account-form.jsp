<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${isEdit ? 'Update Customer Account' : 'Register New Bank Account'} - Apex Bank</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<nav class="navbar navbar-expand-lg navbar-dark bg-primary shadow-sm mb-4">
    <div class="container">
        <a class="navbar-brand fw-bold" href="${pageContext.request.contextPath}/accounts/list">
            <i class="bi bi-bank2 me-2"></i>Global Apex Online Bank
        </a>
        <div class="navbar-nav ms-auto">
            <a class="nav-link text-white" href="${pageContext.request.contextPath}/accounts/list">
                <i class="bi bi-arrow-left me-1"></i> Back to Accounts
            </a>
        </div>
    </div>
</nav>

<div class="container">
    <div class="row justify-content-center">
        <div class="col-lg-8">
            <div class="card shadow-sm border-0">
                <div class="card-header bg-primary text-white py-3">
                    <h5 class="card-title mb-0 fw-bold">
                        <i class="bi ${isEdit ? 'bi-pencil-square' : 'bi-person-plus-fill'} me-2"></i>
                        ${isEdit ? 'Update Customer Bank Account' : 'Register Customer & Open Bank Account'}
                    </h5>
                </div>
                <div class="card-body p-4">
                    <form action="${isEdit ? pageContext.request.contextPath.concat('/accounts/update/').concat(account.accountId) : pageContext.request.contextPath.concat('/accounts/register')}" method="post">
                        
                        <!-- Account Number & Customer Name -->
                        <div class="row g-3 mb-3">
                            <div class="col-md-6">
                                <label for="accountNumber" class="form-label fw-semibold">Account Number <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" id="accountNumber" name="accountNumber" value="${account.accountNumber}" ${isEdit ? 'readonly' : ''} required>
                                <div class="form-text">Unique Bank Account Number identifier.</div>
                            </div>
                            <div class="col-md-6">
                                <label for="customerName" class="form-label fw-semibold">Customer Full Name <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" id="customerName" name="customerName" value="${account.customerName}" placeholder="e.g. Arthur Morgan" required>
                            </div>
                        </div>

                        <!-- Age & Gender -->
                        <div class="row g-3 mb-3">
                            <div class="col-md-6">
                                <label for="age" class="form-label fw-semibold">Age <span class="text-danger">*</span></label>
                                <input type="number" class="form-control" id="age" name="age" value="${account.age}" min="18" max="120" placeholder="Must be at least 18" required>
                            </div>
                            <div class="col-md-6">
                                <label for="gender" class="form-label fw-semibold">Gender <span class="text-danger">*</span></label>
                                <select class="form-select" id="gender" name="gender" required>
                                    <option value="" disabled ${empty account.gender ? 'selected' : ''}>-- Select Gender --</option>
                                    <option value="Male" ${account.gender == 'Male' ? 'selected' : ''}>Male</option>
                                    <option value="Female" ${account.gender == 'Female' ? 'selected' : ''}>Female</option>
                                    <option value="Other" ${account.gender == 'Other' ? 'selected' : ''}>Other</option>
                                </select>
                            </div>
                        </div>

                        <!-- Contact & Email -->
                        <div class="row g-3 mb-3">
                            <div class="col-md-6">
                                <label for="contactNumber" class="form-label fw-semibold">Contact Number <span class="text-danger">*</span></label>
                                <input type="tel" class="form-control" id="contactNumber" name="contactNumber" value="${account.contactNumber}" pattern="[0-9]{10}" placeholder="10-digit number" required>
                            </div>
                            <div class="col-md-6">
                                <label for="email" class="form-label fw-semibold">Email Address <span class="text-danger">*</span></label>
                                <input type="email" class="form-control" id="email" name="email" value="${account.email}" placeholder="customer@email.com" required>
                            </div>
                        </div>

                        <!-- Address -->
                        <div class="mb-3">
                            <label for="address" class="form-label fw-semibold">Residential Address <span class="text-danger">*</span></label>
                            <textarea class="form-control" id="address" name="address" rows="2" placeholder="Full residential street address, city, state" required>${account.address}</textarea>
                        </div>

                        <!-- Account Type & Initial Balance -->
                        <div class="row g-3 mb-4">
                            <div class="col-md-6">
                                <label for="accountType" class="form-label fw-semibold">Account Type <span class="text-danger">*</span></label>
                                <select class="form-select" id="accountType" name="accountType" required>
                                    <option value="" disabled ${empty account.accountType ? 'selected' : ''}>-- Select Type --</option>
                                    <option value="Savings" ${account.accountType == 'Savings' ? 'selected' : ''}>Savings Account</option>
                                    <option value="Current" ${account.accountType == 'Current' ? 'selected' : ''}>Current Account</option>
                                    <option value="Fixed Deposit" ${account.accountType == 'Fixed Deposit' ? 'selected' : ''}>Fixed Deposit Account</option>
                                    <option value="Salary" ${account.accountType == 'Salary' ? 'selected' : ''}>Salary Account</option>
                                </select>
                            </div>
                            <div class="col-md-6">
                                <label for="accountBalance" class="form-label fw-semibold">${isEdit ? 'Current Balance ($)' : 'Initial Deposit Balance ($)'} <span class="text-danger">*</span></label>
                                <input type="number" step="0.01" class="form-control" id="accountBalance" name="accountBalance" value="${account.accountBalance}" min="0" placeholder="e.g. 500.00" ${isEdit ? 'readonly' : ''} required>
                                <c:if test="${isEdit}">
                                    <div class="form-text">Use Deposit / Withdraw operations to adjust balance.</div>
                                </c:if>
                            </div>
                        </div>

                        <div class="d-flex justify-content-between align-items-center">
                            <a href="${pageContext.request.contextPath}/accounts/list" class="btn btn-outline-secondary">
                                <i class="bi bi-x-circle me-1"></i> Cancel
                            </a>
                            <button type="submit" class="btn btn-primary px-4 fw-semibold">
                                <i class="bi ${isEdit ? 'bi-check-circle-fill' : 'bi-credit-card-2-front-fill'} me-1"></i>
                                ${isEdit ? 'Save Changes' : 'Open Account'}
                            </button>
                        </div>

                    </form>
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
