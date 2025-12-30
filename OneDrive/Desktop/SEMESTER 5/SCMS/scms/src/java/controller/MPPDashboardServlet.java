package controller;

import dao.MPPDashboardDAO;  // Make sure this matches your DAO class name
import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.ActivityItem;
import model.EventItem;

/**
 * Servlet for MPP Dashboard Handles root URL ("/") and loads real data for
 * index.jsp
 */
@WebServlet(urlPatterns = {"", "/dashboard", "/index"})  // Critical: handles project root
public class MPPDashboardServlet extends HttpServlet {

    private MPPDashboardDAO mppDashboardDAO = new MPPDashboardDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        // === TEMPORARY LOGIN FOR TESTING - REMOVE AFTER LOGIN SYSTEM ===
        session.setAttribute("role", "MPP");
        session.setAttribute("fullName", "Ahmad Bin Ali");
        // ================================================================

        // Inside doGet()
        request.setAttribute("recentActivities", mppDashboardDAO.getRecentActivities());
        request.setAttribute("upcomingEvents", mppDashboardDAO.getUpcomingEvents());

        // Fetch real statistics from database
        request.setAttribute("activeClubs", mppDashboardDAO.getActiveClubs());
        request.setAttribute("totalMembers", mppDashboardDAO.getTotalMembers());
        request.setAttribute("eventsThisWeek", mppDashboardDAO.getEventsThisWeek());
        request.setAttribute("totalEvents2025", mppDashboardDAO.getTotalEvents2025());

        List<EventItem> events = new ArrayList<>();

        Calendar cal = Calendar.getInstance();
        cal.set(2026, Calendar.FEBRUARY, 20); // Feb = 1 (0=Jan, 1=Feb)
        Date date1 = cal.getTime();

        cal.set(2026, Calendar.MARCH, 15); // Mar = 2
        Date date2 = cal.getTime();

        events.add(new EventItem("AI & Machine Learning Workshop", "UMT Tech Club", date1, "Dewan Al-Ghazali"));
        events.add(new EventItem("Cultural Night 2026", "Cultural Dance Society", date2, "Main Hall"));

        request.setAttribute("upcomingEvents", events);

        // Forward to the main dashboard JSP
        request.getRequestDispatcher("/index.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response); // Same behavior for POST
    }
}
