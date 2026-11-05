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
        <div class="card-header bg-dark text-white">
            <h4 class="mb-0">${pageTitle}</h4>
        </div>
        <div class="card-body p-4">
            <form action="${pageContext.request.contextPath}/employees/save" method="post">
                <input type="hidden" name="employeeId" value="${employee.employeeId}">

                <div class="mb-3">
                    <label class="form-label fw-bold">Full Name:</label>
                    <input type="text" name="name" class="form-control" value="${employee.name}" placeholder="Employee full name" required>
                </div>

                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label fw-bold">Age:</label>
                        <input type="number" name="age" class="form-control" value="${employee.age}" min="18" placeholder="Age (e.g. 28)" required>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label fw-bold">Gender:</label>
                        <select name="gender" class="form-select" required>
                            <option value="">-- Select Gender --</option>
                            <option value="Male" ${employee.gender == 'Male' ? 'selected' : ''}>Male</option>
                            <option value="Female" ${employee.gender == 'Female' ? 'selected' : ''}>Female</option>
                            <option value="Other" ${employee.gender == 'Other' ? 'selected' : ''}>Other</option>
                        </select>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label fw-bold">Contact Number:</label>
                        <input type="text" name="contactNumber" class="form-control" value="${employee.contactNumber}" placeholder="Contact phone" required>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label fw-bold">Email:</label>
                        <input type="email" name="email" class="form-control" value="${employee.email}" placeholder="employee@company.com" required>
                    </div>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-bold">Address:</label>
                    <input type="text" name="address" class="form-control" value="${employee.address}" placeholder="Residential address" required>
                </div>

                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label fw-bold">Department:</label>
                        <input type="text" name="department" class="form-control" value="${employee.department}" placeholder="e.g. IT, HR, Finance" required>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label fw-bold">Designation:</label>
                        <input type="text" name="designation" class="form-control" value="${employee.designation}" placeholder="e.g. Developer, Manager" required>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label fw-bold">Date of Joining:</label>
                        <input type="date" name="dateOfJoining" class="form-control" value="${employee.dateOfJoining}" required>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label fw-bold">Salary ($):</label>
                        <input type="number" step="0.01" name="salary" class="form-control" value="${employee.salary}" min="0" placeholder="e.g. 65000" required>
                    </div>
                </div>

                <div class="d-flex justify-content-between mt-4">
                    <a href="${pageContext.request.contextPath}/employees" class="btn btn-secondary">Cancel</a>
                    <button type="submit" class="btn btn-dark fw-bold">Save Employee</button>
                </div>
            </form>
        </div>
    </div>
</div>

</body>
</html>
