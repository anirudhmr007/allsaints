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
        <div class="card-header bg-primary text-white">
            <h4 class="mb-0">${pageTitle}</h4>
        </div>
        <div class="card-body p-4">
            <form action="${pageContext.request.contextPath}/patients/save" method="post">
                <!-- Hidden ID for update -->
                <input type="hidden" name="patientId" value="${patient.patientId}">

                <div class="mb-3">
                    <label class="form-label fw-bold">Patient Name:</label>
                    <input type="text" name="name" class="form-control" value="${patient.name}" placeholder="Enter full name" required>
                </div>

                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label fw-bold">Age:</label>
                        <input type="number" name="age" class="form-control" value="${patient.age}" placeholder="Age" min="0" required>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label fw-bold">Gender:</label>
                        <select name="gender" class="form-select" required>
                            <option value="">-- Select Gender --</option>
                            <option value="Male" ${patient.gender == 'Male' ? 'selected' : ''}>Male</option>
                            <option value="Female" ${patient.gender == 'Female' ? 'selected' : ''}>Female</option>
                            <option value="Other" ${patient.gender == 'Other' ? 'selected' : ''}>Other</option>
                        </select>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label fw-bold">Contact Number:</label>
                        <input type="text" name="contactNumber" class="form-control" value="${patient.contactNumber}" placeholder="Phone number" required>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label fw-bold">Blood Group:</label>
                        <select name="bloodGroup" class="form-select" required>
                            <option value="">-- Select Blood Group --</option>
                            <option value="A+" ${patient.bloodGroup == 'A+' ? 'selected' : ''}>A+</option>
                            <option value="A-" ${patient.bloodGroup == 'A-' ? 'selected' : ''}>A-</option>
                            <option value="B+" ${patient.bloodGroup == 'B+' ? 'selected' : ''}>B+</option>
                            <option value="B-" ${patient.bloodGroup == 'B-' ? 'selected' : ''}>B-</option>
                            <option value="AB+" ${patient.bloodGroup == 'AB+' ? 'selected' : ''}>AB+</option>
                            <option value="AB-" ${patient.bloodGroup == 'AB-' ? 'selected' : ''}>AB-</option>
                            <option value="O+" ${patient.bloodGroup == 'O+' ? 'selected' : ''}>O+</option>
                            <option value="O-" ${patient.bloodGroup == 'O-' ? 'selected' : ''}>O-</option>
                        </select>
                    </div>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-bold">Email Address:</label>
                    <input type="email" name="email" class="form-control" value="${patient.email}" placeholder="patient@example.com" required>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-bold">Residential Address:</label>
                    <textarea name="address" class="form-control" rows="2" placeholder="Full address" required>${patient.address}</textarea>
                </div>

                <div class="d-flex justify-content-between mt-4">
                    <a href="${pageContext.request.contextPath}/patients" class="btn btn-secondary">Cancel</a>
                    <button type="submit" class="btn btn-success fw-bold">Save Patient</button>
                </div>
            </form>
        </div>
    </div>
</div>

</body>
</html>
