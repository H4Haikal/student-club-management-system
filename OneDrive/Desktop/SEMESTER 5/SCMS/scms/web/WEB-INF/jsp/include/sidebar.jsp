<%--
    sidebar.jsp - UMT ClubSphere Main Navigation
    Author: Haikal Danial Bin Mohd Rohaiza (S70622)
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="sidebar d-flex flex-column h-100">
    <!-- Header -->
    <div class="sidebar-header text-center py-4 border-bottom border-light border-opacity-25 flex-shrink-0">
        <img src="${pageContext.request.contextPath}/images/Logo_Rasmi_UMT.png"
             alt="UMT Logo" class="img-fluid mb-3" style="max-height: 90px; filter: drop-shadow(0 0 8px white);">
        <h4 class="text-white fw-bold mb-0">ClubSphere</h4>
        <small class="text-white opacity-75">Student Club Management System</small>
    </div>

    <!-- Scrollable Navigation -->
    <div class="flex-grow-1 overflow-auto px-3">
        <nav class="nav flex-column mt-4">
            <% String currentPath = request.getRequestURI();%>

            <a class="nav-link <%= currentPath.endsWith("/") || currentPath.endsWith("index.jsp") ? "active" : ""%>"
               href="${pageContext.request.contextPath}/">
                <i class="fas fa-home me-3"></i> Dashboard
            </a>

            <!-- Role-Based Menu -->
            <c:choose>
                <c:when test="${sessionScope.role == 'MPP'}">
                    <a class="nav-link <%= currentPath.contains("/mpp/club") ? "active" : ""%>"
                       href="${pageContext.request.contextPath}/mpp/club">
                        <i class="fas fa-users-cog me-3"></i> Manage Clubs
                    </a>
                    <a class="nav-link" href="#">
                        <i class="fas fa-file-alt me-3"></i> Review Proposals
                    </a>
                    <a class="nav-link" href="#">
                        <i class="fas fa-calendar-day me-3"></i> Master Calendar
                    </a>
                    <a class="nav-link" href="#">
                        <i class="fas fa-chart-bar me-3"></i> Reports & Analytics
                    </a>
                </c:when>
                <c:when test="${sessionScope.role == 'CHC'}">
                    <a class="nav-link" href="#">
                        <i class="fas fa-users me-3"></i> My Club
                    </a>
                    <a class="nav-link" href="#">
                        <i class="fas fa-lightbulb me-3"></i> Create Proposal
                    </a>
                    <a class="nav-link" href="#">
                        <i class="fas fa-calendar-alt me-3"></i> My Events
                    </a>
                    <a class="nav-link" href="#">
                        <i class="fas fa-bolt me-3"></i> Resource Booking
                    </a>
                    <a class="nav-link" href="#">
                        <i class="fas fa-file-invoice-dollar me-3"></i> Financial Claims
                    </a>
                </c:when>
            </c:choose>

            <hr class="my-4 border-light opacity-25">

            <a class="nav-link" href="#">
                <i class="fas fa-file-alt me-3"></i> Documents & Reports
            </a>
            <a class="nav-link" href="#">
                <i class="fas fa-cog me-3"></i> Settings
            </a>
            <a class="nav-link text-danger" href="#">
                <i class="fas fa-sign-out-alt me-3"></i> Logout
            </a>
        </nav>
    </div>

    <!-- Fixed Footer at Bottom -->
    <div class="sidebar-footer text-center py-3 small text-white opacity-75 border-top border-light border-opacity-25 flex-shrink-0">
        <strong>S70622</strong><br>
        Haikal Danial Bin Mohd Rohaiza<br>
        © 2025 UMT ClubSphere
    </div>
</div>