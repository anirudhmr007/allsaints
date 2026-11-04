<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Blood Donor Management System</title>
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
            <a class="nav-link text-white active" href="${pageContext.request.contextPath}/donors/list">
                <i class="bi bi-people-fill me-1"></i> Donors Directory
            </a>
            <a class="btn btn-light btn-sm text-danger fw-bold ms-2" href="${pageContext.request.contextPath}/donors/register">
                <i class="bi bi-person-plus-fill me-1"></i> Register New Donor
            </a>
        </div>
    </div>
</nav>

<div class="container">

    <!-- Flash Alerts -->
    <c:if test="${not empty successMessage}">
        <div class="alert alert-success alert-dismissible fade show shadow-sm" role="alert">
            <i class="bi bi-check-circle-fill me-2"></i> ${successMessage}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>
    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger alert-dismissible fade show shadow-sm" role="alert">
            <i class="bi bi-exclamation-triangle-fill me-2"></i> ${errorMessage}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>
    <c:if test="${not empty searchSuccess}">
        <div class="alert alert-info alert-dismissible fade show shadow-sm" role="alert">
            <i class="bi bi-info-circle-fill me-2"></i> ${searchSuccess}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>
    <c:if test="${not empty searchError}">
        <div class="alert alert-warning alert-dismissible fade show shadow-sm" role="alert">
            <i class="bi bi-exclamation-circle-fill me-2"></i> ${searchError}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <!-- Search Controls (Filter by Blood Group & Search by ID) -->
    <div class="card shadow-sm border-0 mb-4">
        <div class="card-body">
            <div class="row g-3 align-items-center">
                
                <!-- Blood Group Filter -->
                <div class="col-md-6">
                    <form action="${pageContext.request.contextPath}/donors/search-by-group" method="get" class="d-flex align-items-center gap-2">
                        <label class="fw-semibold text-danger text-nowrap"><i class="bi bi-funnel-fill me-1"></i>Filter by Blood Group:</label>
                        <select name="bloodGroup" class="form-select" onchange="this.form.submit()">
                            <option value="ALL">-- All Blood Groups --</option>
                            <option value="A+" ${selectedGroup == 'A+' ? 'selected' : ''}>A+</option>
                            <option value="A-" ${selectedGroup == 'A-' ? 'selected' : ''}>A-</option>
                            <option value="B+" ${selectedGroup == 'B+' ? 'selected' : ''}>B+</option>
                            <option value="B-" ${selectedGroup == 'B-' ? 'selected' : ''}>B-</option>
                            <option value="AB+" ${selectedGroup == 'AB+' ? 'selected' : ''}>AB+</option>
                            <option value="AB-" ${selectedGroup == 'AB-' ? 'selected' : ''}>AB-</option>
                            <option value="O+" ${selectedGroup == 'O+' ? 'selected' : ''}>O+</option>
                            <option value="O-" ${selectedGroup == 'O-' ? 'selected' : ''}>O-</option>
                        </select>
                        <c:if test="${not empty selectedGroup}">
                            <a href="${pageContext.request.contextPath}/donors/list" class="btn btn-outline-secondary btn-sm">Reset</a>
                        </c:if>
                    </form>
                </div>

                <!-- Search by Donor ID -->
                <div class="col-md-6">
                    <form action="${pageContext.request.contextPath}/donors/search-by-id" method="get" class="d-flex gap-2">
                        <div class="input-group">
                            <span class="input-group-text bg-white"><i class="bi bi-search"></i></span>
                            <input type="number" name="donorId" class="form-control" placeholder="Search by Donor ID..." value="${searchedId}" required>
                            <button class="btn btn-outline-danger" type="submit">Search ID</button>
                        </div>
                        <c:if test="${not empty searchedId}">
                            <a href="${pageContext.request.contextPath}/donors/list" class="btn btn-secondary">Reset</a>
                        </c:if>
                    </form>
                </div>

            </div>
        </div>
    </div>

    <!-- Donors Table -->
    <div class="card shadow-sm border-0">
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead class="table-danger text-dark">
                        <tr>
                            <th class="ps-3">Donor ID</th>
                            <th>Donor Name</th>
                            <th>Age</th>
                            <th>Gender</th>
                            <th>Blood Group</th>
                            <th>Contact</th>
                            <th>Email</th>
                            <th>Health Status</th>
                            <th>Last Donation</th>
                            <th>Donation Eligibility</th>
                            <th class="text-center pe-3">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${not empty donors}">
                                <c:forEach var="donor" items="${donors}">
                                    <tr>
                                        <td class="ps-3 fw-bold text-danger">#${donor.donorId}</td>
                                        <td class="fw-semibold">${donor.name}</td>
                                        <td>${donor.age} yrs</td>
                                        <td>${donor.gender}</td>
                                        <td>
                                            <span class="badge bg-danger rounded-pill px-2 py-1 fs-6">
                                                <i class="bi bi-droplet-fill me-1"></i>${donor.bloodGroup}
                                            </span>
                                        </td>
                                        <td>${donor.contactNumber}</td>
                                        <td><small class="text-muted">${donor.email}</small></td>
                                        <td>
                                            <span class="badge ${donor.healthFit ? 'bg-success' : 'bg-warning text-dark'}">
                                                ${donor.healthStatus}
                                            </span>
                                        </td>
                                        <td>
                                            <small>${empty donor.lastDonationDate ? 'Never Donated' : donor.lastDonationDate}</small>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${donor.fullyEligible}">
                                                    <span class="badge bg-success"><i class="bi bi-check-lg me-1"></i>Eligible</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-secondary" title="${donor.eligibilityReason}">
                                                        <i class="bi bi-x-circle me-1"></i>Ineligible
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="text-center pe-3">
                                            <div class="btn-group btn-group-sm">
                                                <a href="${pageContext.request.contextPath}/donors/view/${donor.donorId}" class="btn btn-outline-info" title="View Details">
                                                    <i class="bi bi-eye"></i>
                                                </a>
                                                <a href="${pageContext.request.contextPath}/donors/edit/${donor.donorId}" class="btn btn-outline-warning" title="Edit Donor">
                                                    <i class="bi bi-pencil-square"></i>
                                                </a>
                                                <a href="${pageContext.request.contextPath}/donors/delete/${donor.donorId}" 
                                                   class="btn btn-outline-danger" 
                                                   onclick="return confirm('Delete blood donor #${donor.donorId} (${donor.name})?');"
                                                   title="Delete Donor">
                                                    <i class="bi bi-trash"></i>
                                                </a>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="11" class="text-center py-5 text-muted">
                                        <i class="bi bi-droplet fs-1 d-block mb-2 text-danger"></i>
                                        No donor records match the selection.
                                        <div class="mt-2">
                                            <a href="${pageContext.request.contextPath}/donors/register" class="btn btn-danger btn-sm">
                                                <i class="bi bi-person-plus-fill me-1"></i> Register a Donor
                                            </a>
                                        </div>
                                    </td>
                                </tr>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
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

