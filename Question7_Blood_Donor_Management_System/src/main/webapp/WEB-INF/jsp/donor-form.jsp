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
        <div class="card-header bg-danger text-white">
            <h4 class="mb-0">${pageTitle}</h4>
        </div>
        <div class="card-body p-4">
            <form action="${pageContext.request.contextPath}/donors/save" method="post">
                <input type="hidden" name="donorId" value="${donor.donorId}">

                <div class="mb-3">
                    <label class="form-label fw-bold">Donor Full Name:</label>
                    <input type="text" name="name" class="form-control" value="${donor.name}" placeholder="e.g. John Doe" required>
                </div>

                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label fw-bold">Age (18 - 65):</label>
                        <input type="number" name="age" class="form-control" value="${donor.age}" placeholder="Must be 18 to 65" min="18" max="65" required>
                        <small class="text-muted">Eligibility: 18 - 65 years.</small>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label fw-bold">Gender:</label>
                        <select name="gender" class="form-select" required>
                            <option value="">-- Select Gender --</option>
                            <option value="Male" ${donor.gender == 'Male' ? 'selected' : ''}>Male</option>
                            <option value="Female" ${donor.gender == 'Female' ? 'selected' : ''}>Female</option>
                            <option value="Other" ${donor.gender == 'Other' ? 'selected' : ''}>Other</option>
                        </select>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label fw-bold">Blood Group:</label>
                        <select name="bloodGroup" class="form-select" required>
                            <option value="">-- Select Blood Group --</option>
                            <option value="A+" ${donor.bloodGroup == 'A+' ? 'selected' : ''}>A+</option>
                            <option value="A-" ${donor.bloodGroup == 'A-' ? 'selected' : ''}>A-</option>
                            <option value="B+" ${donor.bloodGroup == 'B+' ? 'selected' : ''}>B+</option>
                            <option value="B-" ${donor.bloodGroup == 'B-' ? 'selected' : ''}>B-</option>
                            <option value="AB+" ${donor.bloodGroup == 'AB+' ? 'selected' : ''}>AB+</option>
                            <option value="AB-" ${donor.bloodGroup == 'AB-' ? 'selected' : ''}>AB-</option>
                            <option value="O+" ${donor.bloodGroup == 'O+' ? 'selected' : ''}>O+</option>
                            <option value="O-" ${donor.bloodGroup == 'O-' ? 'selected' : ''}>O-</option>
                        </select>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label fw-bold">Contact Number:</label>
                        <input type="text" name="contactNumber" class="form-control" value="${donor.contactNumber}" placeholder="Phone number" required>
                    </div>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-bold">Email:</label>
                    <input type="email" name="email" class="form-control" value="${donor.email}" placeholder="donor@email.com" required>
                </div>

                <div class="mb-3">
                    <label class="form-label fw-bold">Address:</label>
                    <textarea name="address" class="form-control" rows="2" placeholder="Address" required>${donor.address}</textarea>
                </div>

                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label fw-bold">Last Donation Date:</label>
                        <input type="date" name="lastDonationDate" class="form-control" value="${donor.lastDonationDate}">
                        <small class="text-muted">Leave empty if first time. Must be >= 90 days ago.</small>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label fw-bold">Health Status:</label>
                        <select name="healthStatus" class="form-select" required>
                            <option value="Fit" ${donor.healthStatus == 'Fit' ? 'selected' : ''}>Fit (Healthy)</option>
                            <option value="Under Medication" ${donor.healthStatus == 'Under Medication' ? 'selected' : ''}>Under Medication</option>
                            <option value="Unfit" ${donor.healthStatus == 'Unfit' ? 'selected' : ''}>Unfit</option>
                        </select>
                    </div>
                </div>

                <div class="d-flex justify-content-between mt-4">
                    <a href="${pageContext.request.contextPath}/donors" class="btn btn-secondary">Cancel</a>
                    <button type="submit" class="btn btn-danger fw-bold">Save Blood Donor</button>
                </div>
            </form>
        </div>
    </div>
</div>

</body>
</html>
