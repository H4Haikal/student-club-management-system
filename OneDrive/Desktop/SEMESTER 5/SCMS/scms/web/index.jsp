<%--
    Document : index.jsp
    Created on : 30 Dec 2025
    Author     : Haikal Danial Bin Mohd Rohaiza (S70622)
    Purpose    : Main Dashboard for UMT ClubSphere (MPP & CHC)
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>UMT ClubSphere - Dashboard</title>

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
            <!-- Header -->
            <div class="top-header">
                <div class="d-flex align-items-center">
                    <i class="fas fa-tachometer-alt fa-2x text-primary me-4"></i>
                    <h3 class="fw-bold mb-0">Dashboard Overview</h3>
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
                        <h2>Welcome back, ${sessionScope.fullName != null ? sessionScope.fullName : 'User'}!</h2>
                        <p class="lead mb-0 opacity-90">
                            UMT ClubSphere • Student Club Management System<br>
                            <fmt:formatDate value="<%=new java.util.Date()%>" pattern="EEEE, dd MMMM yyyy" />
                        </p>
                    </div>
                    <div class="col-md-4 text-md-end">
                        <div class="bg-white text-primary rounded-circle d-inline-flex align-items-center justify-content-center"
                             style="width: 120px; height: 120px; font-size: 4rem;">
                            <i class="fas fa-user-tie"></i>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Statistics Cards -->
            <div class="row g-4 mb-5">
                <div class="col-lg-3 col-md-6">
                    <div class="stat-card">
                        <div class="icon text-primary"><i class="fas fa-users"></i></div>
                        <div class="text-muted small">Active Clubs</div>
                        <h3>${activeClubs}</h3>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="stat-card">
                        <div class="icon text-success"><i class="fas fa-id-card"></i></div>
                        <div class="text-muted small">Total Members</div>
                        <h3>${totalMembers}</h3>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="stat-card">
                        <div class="icon text-warning"><i class="far fa-calendar-alt"></i></div>
                        <div class="text-muted small">Events This Week</div>
                        <h3>${eventsThisWeek}</h3>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="stat-card">
                        <div class="icon text-danger"><i class="fas fa-calendar-check"></i></div>
                        <div class="text-muted small">Total Events 2025</div>
                        <h3>${totalEvents2025}</h3>
                    </div>
                </div>
            </div>

            <!-- Activities & Upcoming Events -->
            <div class="row">
                <!-- Recent Activities -->
                <div class="col-lg-8 mb-4">
                    <h4 class="fw-bold mb-4">Recent Activities</h4>
                    <div class="activity-box">
                        <c:choose>
                            <c:when test="${not empty recentActivities}">
                                <c:forEach var="activity" items="${recentActivities}">
                                    <div class="activity-item">
                                        <div>
                                            <strong>${activity.title}</strong><br>
                                            <span class="text-muted">${activity.description}</span>
                                        </div>
                                        <small class="text-muted">${activity.timeAgo}</small>
                                    </div>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <div class="text-muted p-4 text-center">
                                    No recent activities recorded yet.
                                </div>
                            </c:otherwise>
                        </c:choose>
                        <a href="#" class="btn-view-all">View All Activities →</a>
                    </div>
                </div>

                <!-- Upcoming Events -->
                <div class="col-lg-4 mb-4">
                    <h4 class="fw-bold mb-4">Upcoming Events</h4>
                    <div class="event-box">
                        <c:choose>
                            <c:when test="${not empty upcomingEvents}">
                                <c:forEach var="event" items="${upcomingEvents}">
                                    <div class="event-card">
                                        <h6 class="fw-bold">${event.title}</h6>
                                        <small class="text-muted">${event.clubName}</small>
                                        <div class="mt-2">
                                            <i class="far fa-calendar me-2"></i>
                                            <fmt:formatDate value="${event.date}" pattern="dd MMMM yyyy" />
                                        </div>
                                        <div class="mt-1">
                                            <i class="fas fa-map-marker-alt me-2"></i>
                                            ${event.venue != null ? event.venue : 'Venue TBC'}
                                        </div>
                                    </div>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <div class="text-muted p-4 text-center">
                                    No upcoming events scheduled.
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>