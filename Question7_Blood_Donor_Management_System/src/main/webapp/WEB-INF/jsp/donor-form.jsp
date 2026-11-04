<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${isEdit ? 'Update Donor' : 'Register New Blood Donor'} - Red Ribbon</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<nav class="navbar navbar-expand-lg navbar-dark bg-danger shadow-sm mb-4">
    <div class="container">
        <a class="navbar-brand fw-bold" href="${pageContext.request.contextPath}/donors/list">
            <i class="bi bi-heart-pulse-fill me-2"></i>Red Ribbon Blood Bank Registry
        </a>
        <div class="navbar-nav ms-auto">
            <a class="nav-link text-white" href="${pageContext.request.contextPath}/donors/list">
                <i class="bi bi-arrow-left me-1"></i> Back to Directory
            </a>
        </div>
    </div>
</nav>

<div class="container">
    <div class="row justify-content-center">
        <div class="col-lg-8">
            <div class="card shadow-sm border-0">
                <div class="card-header bg-danger text-white py-3">
                    <h5 class="card-title mb-0 fw-bold">
                        <i class="bi ${isEdit ? 'bi-pencil-square' : 'bi-person-plus-fill'} me-2"></i>
                        ${isEdit ? 'Update Blood Donor Record' : 'Register Blood Donor with Eligibility Screening'}
                    </h5>
                </div>
                <div class="card-body p-4">
                    <form action="${isEdit ? pageContext.request.contextPath.concat('/donors/update/').concat(donor.donorId) : pageContext.request.contextPath.concat('/donors/register')}" method="post">
                        
                        <!-- Name & Age -->
                        <div class="row g-3 mb-3">
                            <div class="col-md-8">
                                <label for="name" class="form-label fw-semibold">Donor Full Name <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" id="name" name="name" value="${donor.name}" placeholder="e.g. Liam Hemsworth" required>
                            </div>
                            <div class="col-md-4">
                                <label for="age" class="form-label fw-semibold">Age (18-65) <span class="text-danger">*</span></label>
                                <input type="number" class="form-control" id="age" name="age" value="${donor.age}" min="18" max="65" placeholder="18 - 65" required>
                                <div class="form-text">Must be legally between 18 and 65 years.</div>
                            </div>
                        </div>

                        <!-- Gender & Blood Group -->
                        <div class="row g-3 mb-3">
                            <div class="col-md-6">
                                <label for="gender" class="form-label fw-semibold">Gender <span class="text-danger">*</span></label>
                                <select class="form-select" id="gender" name="gender" required>
                                    <option value="" disabled ${empty donor.gender ? 'selected' : ''}>-- Select Gender --</option>
                                    <option value="Male" ${donor.gender == 'Male' ? 'selected' : ''}>Male</option>
                                    <option value="Female" ${donor.gender == 'Female' ? 'selected' : ''}>Female</option>
                                    <option value="Other" ${donor.gender == 'Other' ? 'selected' : ''}>Other</option>
                                </select>
                            </div>
                            <div class="col-md-6">
                                <label for="bloodGroup" class="form-label fw-semibold">Blood Group <span class="text-danger">*</span></label>
                                <select class="form-select" id="bloodGroup" name="bloodGroup" required>
                                    <option value="" disabled ${empty donor.bloodGroup ? 'selected' : ''}>-- Select Blood Group --</option>
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
                        </div>

                        <!-- Contact & Email -->
                        <div class="row g-3 mb-3">
                            <div class="col-md-6">
                                <label for="contactNumber" class="form-label fw-semibold">Contact Number <span class="text-danger">*</span></label>
                                <input type="tel" class="form-control" id="contactNumber" name="contactNumber" value="${donor.contactNumber}" pattern="[0-9]{10}" placeholder="10-digit mobile number" required>
                            </div>
                            <div class="col-md-6">
                                <label for="email" class="form-label fw-semibold">Email Address <span class="text-danger">*</span></label>
                                <input type="email" class="form-control" id="email" name="email" value="${donor.email}" placeholder="donor@email.com" required>
                            </div>
                        </div>

                        <!-- Address -->
                        <div class="mb-3">
                            <label for="address" class="form-label fw-semibold">Address <span class="text-danger">*</span></label>
                            <textarea class="form-control" id="address" name="address" rows="2" placeholder="Residential address" required>${donor.address}</textarea>
                        </div>

                        <!-- Last Donation Date & Health Status -->
                        <div class="row g-3 mb-4">
                            <div class="col-md-6">
                                <label for="lastDonationDate" class="form-label fw-semibold">Last Donation Date</label>
                                <input type="date" class="form-control" id="lastDonationDate" name="lastDonationDate" value="${donor.lastDonationDate}">
                                <div class="form-text">Leave blank if this is the donor's first time donating.</div>
                            </div>
                            <div class="col-md-6">
                                <label for="healthStatus" class="form-label fw-semibold">Health Status <span class="text-danger">*</span></label>
                                <select class="form-select" id="healthStatus" name="healthStatus" required>
                                    <option value="Fit" ${donor.healthStatus == 'Fit' ? 'selected' : ''}>Fit (Eligible to donate)</option>
                                    <option value="Under Medication" ${donor.healthStatus == 'Under Medication' ? 'selected' : ''}>Under Medication (Temporary Ineligible)</option>
                                    <option value="Low Hemoglobin" ${donor.healthStatus == 'Low Hemoglobin' ? 'selected' : ''}>Low Hemoglobin</option>
                                    <option value="Unfit" ${donor.healthStatus == 'Unfit' ? 'selected' : ''}>Unfit / Medical Deferral</option>
                                </select>
                            </div>
                        </div>

                        <div class="d-flex justify-content-between align-items-center">
                            <a href="${pageContext.request.contextPath}/donors/list" class="btn btn-outline-secondary">
                                <i class="bi bi-x-circle me-1"></i> Cancel
                            </a>
                            <button type="submit" class="btn btn-danger px-4 fw-bold">
                                <i class="bi ${isEdit ? 'bi-check-circle-fill' : 'bi-heart-fill'} me-1"></i>
                                ${isEdit ? 'Save Changes' : 'Register Blood Donor'}
                            </button>
                        </div>

                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<footer class="text-center text-muted py-4 mt-5">
    <small>&copy; Blood Donor Management System | Spring Boot MVC + PostgreSQL + JSP</small>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

