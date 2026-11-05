<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Blood Donor Management System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container mt-4">
    <!-- Header -->
    <div class="d-flex justify-content-between align-items-center mb-3 pb-2 border-bottom">
        <h2 class="text-danger">Blood Donor Management System</h2>
        <a href="${pageContext.request.contextPath}/donors/add" class="btn btn-danger fw-bold">+ Register New Donor</a>
    </div>

    <!-- Alert Messages -->
    <c:if test="${not empty message}">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            ${message}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            ${error}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <!-- Search Controls: By Blood Group & By Donor ID -->
    <div class="card p-3 mb-4 shadow-sm bg-white">
        <div class="row g-3">
            <!-- Search by Blood Group -->
            <div class="col-md-6">
                <form action="${pageContext.request.contextPath}/donors/search-by-group" method="get" class="d-flex align-items-center gap-2">
                    <label class="fw-bold text-nowrap">Filter by Blood Group:</label>
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
                </form>
            </div>
            <!-- Search by Donor ID -->
            <div class="col-md-6">
                <form action="${pageContext.request.contextPath}/donors/search-by-id" method="get" class="d-flex gap-2">
                    <input type="number" name="donorId" class="form-control" placeholder="Search by Donor ID" value="${searchedId}" required>
                    <button type="submit" class="btn btn-outline-danger text-nowrap">Search ID</button>
                    <a href="${pageContext.request.contextPath}/donors" class="btn btn-secondary text-nowrap">Reset</a>
                </form>
            </div>
        </div>
    </div>

    <!-- Donors Table -->
    <div class="card shadow-sm">
        <div class="card-header bg-danger text-white">
            <h5 class="mb-0">Registered Blood Donors</h5>
        </div>
        <div class="card-body p-0">
            <table class="table table-striped table-hover mb-0">
                <thead class="table-light">
                    <tr>
                        <th>Donor ID</th>
                        <th>Name</th>
                        <th>Age</th>
                        <th>Gender</th>
                        <th>Blood Group</th>
                        <th>Contact Number</th>
                        <th>Email</th>
                        <th>Address</th>
                        <th>Last Donation Date</th>
                        <th>Health Status</th>
                        <th class="text-center">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${not empty donors}">
                            <c:forEach var="d" items="${donors}">
                                <tr>
                                    <td><strong>#${d.donorId}</strong></td>
                                    <td>${d.name}</td>
                                    <td>${d.age}</td>
                                    <td>${d.gender}</td>
                                    <td><span class="badge bg-danger fs-6">${d.bloodGroup}</span></td>
                                    <td>${d.contactNumber}</td>
                                    <td>${d.email}</td>
                                    <td>${d.address}</td>
                                    <td>${empty d.lastDonationDate ? 'Never Donated' : d.lastDonationDate}</td>
                                    <td><span class="badge ${d.healthStatus == 'Fit' ? 'bg-success' : 'bg-warning text-dark'}">${d.healthStatus}</span></td>
                                    <td class="text-center">
                                        <a href="${pageContext.request.contextPath}/donors/edit/${d.donorId}" class="btn btn-sm btn-warning">Edit</a>
                                        <a href="${pageContext.request.contextPath}/donors/delete/${d.donorId}" 
                                           class="btn btn-sm btn-danger"
                                           onclick="return confirm('Delete donor #${d.donorId}?');">Delete</a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr>
                                <td colspan="11" class="text-center py-4 text-muted">No blood donors found.</td>
                            </tr>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
