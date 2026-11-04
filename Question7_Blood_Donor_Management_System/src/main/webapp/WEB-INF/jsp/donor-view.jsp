<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Blood Donor Medical Card - #${donor.donorId}</title>
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
        <div class="col-lg-7">
            <div class="card shadow-sm border-0">
                <div class="card-header bg-danger text-white py-3 d-flex justify-content-between align-items-center">
                    <h5 class="card-title mb-0 fw-bold">
                        <i class="bi bi-person-vcard me-2"></i>Donor Profile: #${donor.donorId}
                    </h5>
                    <span class="badge bg-white text-danger fs-5 px-3 py-2 rounded-pill fw-bold">
                        <i class="bi bi-droplet-fill me-1"></i>${donor.bloodGroup}
                    </span>
                </div>
                <div class="card-body p-4">
                    <div class="text-center mb-4">
                        <div class="display-6 fw-bold text-dark">${donor.name}</div>
                        <p class="text-muted mb-0">${donor.gender} &bull; ${donor.age} Years Old</p>
                    </div>

                    <!-- Eligibility Callout -->
                    <div class="alert ${donor.fullyEligible ? 'alert-success' : 'alert-warning'} d-flex align-items-center mb-4">
                        <i class="bi ${donor.fullyEligible ? 'bi-check-circle-fill' : 'bi-exclamation-triangle-fill'} fs-3 me-3"></i>
                        <div>
                            <strong>Eligibility Status: ${donor.fullyEligible ? 'ELIGIBLE TO DONATE' : 'CURRENTLY INELIGIBLE'}</strong><br>
                            <small>${donor.eligibilityReason}</small>
                        </div>
                    </div>

                    <table class="table table-bordered align-middle">
                        <tbody>
                            <tr>
                                <th class="bg-light text-secondary" style="width: 38%;">Donor ID</th>
                                <td class="fw-bold text-danger">#${donor.donorId}</td>
                            </tr>
                            <tr>
                                <th class="bg-light text-secondary">Blood Group</th>
                                <td><span class="badge bg-danger fs-6">${donor.bloodGroup}</span></td>
                            </tr>
                            <tr>
                                <th class="bg-light text-secondary">Health Status</th>
                                <td><span class="badge ${donor.healthFit ? 'bg-success' : 'bg-warning text-dark'} fs-6">${donor.healthStatus}</span></td>
                            </tr>
                            <tr>
                                <th class="bg-light text-secondary">Contact Number</th>
                                <td>${donor.contactNumber}</td>
                            </tr>
                            <tr>
                                <th class="bg-light text-secondary">Email Address</th>
                                <td><a href="mailto:${donor.email}">${donor.email}</a></td>
                            </tr>
                            <tr>
                                <th class="bg-light text-secondary">Address</th>
                                <td>${donor.address}</td>
                            </tr>
                            <tr>
                                <th class="bg-light text-secondary">Last Donation Date</th>
                                <td>${empty donor.lastDonationDate ? 'First-time donor (No prior record)' : donor.lastDonationDate}</td>
                            </tr>
                            <tr>
                                <th class="bg-light text-secondary">Days Since Last Donation</th>
                                <td>
                                    <c:choose>
                                        <c:when test="${not empty donor.daysSinceLastDonation}">
                                            <strong>${donor.daysSinceLastDonation} days</strong>
                                            <span class="badge ${donor.daysSinceLastDonation >= 90 ? 'bg-success' : 'bg-secondary'} ms-2">
                                                ${donor.daysSinceLastDonation >= 90 ? '90+ days reached' : 'Under 90 days'}
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="text-muted">N/A (First time)</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                        </tbody>
                    </table>

                    <div class="d-flex justify-content-between mt-4">
                        <a href="${pageContext.request.contextPath}/donors/list" class="btn btn-secondary">
                            <i class="bi bi-arrow-left me-1"></i> Back to Directory
                        </a>
                        <div class="d-flex gap-2">
                            <a href="${pageContext.request.contextPath}/donors/edit/${donor.donorId}" class="btn btn-warning">
                                <i class="bi bi-pencil-square me-1"></i> Edit
                            </a>
                            <a href="${pageContext.request.contextPath}/donors/delete/${donor.donorId}" 
                               class="btn btn-danger"
                               onclick="return confirm('Are you sure you want to delete donor #${donor.donorId}?');">
                                <i class="bi bi-trash me-1"></i> Delete
                            </a>
                        </div>
                    </div>
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
