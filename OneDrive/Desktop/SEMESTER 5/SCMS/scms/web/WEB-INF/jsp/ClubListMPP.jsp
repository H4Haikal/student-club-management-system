<%--
    Document : ClubListMPP
    Created on : 30 Dec 2025
    Author     : Haikal Danial Bin Mohd Rohaiza (S70622)
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Manage Clubs - UMT ClubSphere</title>

        <!-- Bootstrap 5 -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Font Awesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
        <!-- External Global Styles -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    </head>
    <body>

        <!-- Include Sidebar -->
        <%@ include file="/WEB-INF/jsp/include/sidebar.jsp" %>

        <div class="main-content">
            <!-- Top Header -->
            <div class="top-header">
                <div class="d-flex align-items-center">
                    <i class="fas fa-users-cog fa-2x text-primary me-4"></i>
                    <h3 class="fw-bold mb-0">Manage Clubs</h3>
                </div>
                <div>
                    <button class="btn btn-outline-primary rounded-circle position-relative p-3">
                        <i class="far fa-bell fs-4"></i>
                        <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">
                            5
                        </span>
                    </button>
                </div>
            </div>

            <!-- Welcome Card -->
            <div class="welcome-card">
                <div class="row align-items-center">
                    <div class="col-md-8">
                        <h2>Club Management (MPP View)</h2>
                        <p class="lead mb-0 opacity-90">
                            Update club status based on AGM report submission.<br>
                            Suggested: If AGM 'Missing', suspend; else active.
                        </p>
                    </div>
                    <div class="col-md-4 text-md-end">
                        <div class="bg-white text-primary rounded-circle d-inline-flex align-items-center justify-content-center"
                             style="width: 100px; height: 100px; font-size: 3.5rem;">
                            <i class="fas fa-users-cog"></i>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Success Message -->
            <c:if test="${not empty message}">
                <div class="alert alert-success alert-dismissible fade show mb-4" role="alert">
                    <strong>${message}</strong>
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>

            <!-- Clubs Table Card -->
            <div class="activity-box">  <!-- Reusing activity-box class for white card look -->
                <div class="table-responsive">
                    <table class="table table-striped table-hover align-middle">
                        <thead class="table-dark">
                            <tr>
                                <th>ID</th>
                                <th>Name</th>
                                <th>Category</th>
                                <th>Established</th>
                                <th>Last AGM Status</th>
                                <th>Current Status</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="club" items="${clubs}">
                                <tr>
                                    <td><strong>${club.clubId}</strong></td>
                                    <td>${club.clubName}</td>
                                    <td>${club.category}</td>
                                    <td>${club.establishedYear}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${club.lastAGMStatus == 'missing'}">
                                                <span class="badge bg-danger">Missing</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-success">${club.lastAGMStatus}</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <span class="badge bg-${club.status == 'active' ? 'success' : club.status == 'suspended' ? 'warning' : 'secondary'}">
                                            ${club.status}
                                        </span>
                                    </td>
                                    <td>
                                        <form action="${pageContext.request.contextPath}/mpp/club" method="post" class="d-inline">
                                            <input type="hidden" name="clubId" value="${club.clubId}">
                                            <select name="status" class="form-select form-select-sm d-inline w-auto">
                                                <option value="active" ${club.status == 'active' ? 'selected' : ''}>Active</option>
                                                <option value="suspended" ${club.status == 'suspended' ? 'selected' : ''}>Suspended</option>
                                                <option value="inactive" ${club.status == 'inactive' ? 'selected' : ''}>Inactive</option>
                                            </select>
                                            <button type="submit" class="btn btn-primary btn-sm ms-2">Update</button>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>