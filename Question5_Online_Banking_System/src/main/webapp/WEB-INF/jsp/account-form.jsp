<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Open New Bank Account</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container mt-4" style="max-width: 650px;">
    <div class="card shadow">
        <div class="card-header bg-primary text-white">
            <h4 class="mb-0">Register New Customer & Open Bank Account</h4>
        </div>
        <div class="card-body p-4">
            <form action="${pageContext.request.contextPath}/accounts/save" method="post">
                
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label fw-bold">Account Number:</label>
                        <input type="text" name="accountNumber" class="form-control" value="${account.accountNumber}" required>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label fw-bold">Customer Name:</label>
                        <input type="text" name="customerName" class="form-control" placeholder="Full name" required>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label fw-bold">Age:</label>
                        <input type="number" name="age" class="form-control" min="18" placeholder="Must be 18+" required>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label fw-bold">Gender:</label>
                        <select name="gender" class="form-select" required>
                            <option value="">-- Select Gender --</option>
                            <option value="Male">Male</option>
                            <option value="Female">Female</option>
                            <option value="Other">Other</option>
                        </select>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label fw-bold">Contact Number:</label>
                        <input type="text" name="contactNumber" class="form-control" placeholder="Phone number" required>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label fw-bold">Email Address:</label>
                        <input type="email" name="email" class="form-control" placeholder="customer@bank.com" required>
                    </div>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-bold">Address:</label>
                    <textarea name="address" class="form-control" rows="2" placeholder="Residential address" required></textarea>
                </div>

                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label fw-bold">Account Type:</label>
                        <select name="accountType" class="form-select" required>
                            <option value="Savings">Savings Account</option>
                            <option value="Current">Current Account</option>
                            <option value="Fixed Deposit">Fixed Deposit</option>
                        </select>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label fw-bold">Initial Balance ($):</label>
                        <input type="number" step="0.01" name="accountBalance" class="form-control" min="0" placeholder="e.g. 500.00" required>
                    </div>
                </div>

                <div class="d-flex justify-content-between mt-4">
                    <a href="${pageContext.request.contextPath}/accounts" class="btn btn-secondary">Cancel</a>
                    <button type="submit" class="btn btn-primary fw-bold">Create Bank Account</button>
                </div>
            </form>
        </div>
    </div>
</div>

</body>
</html>
