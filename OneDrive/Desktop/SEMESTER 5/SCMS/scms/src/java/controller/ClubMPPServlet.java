package controller;

import dao.ClubDAO;
import model.Club;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/mpp/club")
public class ClubMPPServlet extends HttpServlet {

    private ClubDAO clubDAO = new ClubDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();

        // === TEMPORARY: Fake login as MPP for testing ===
        session.setAttribute("role", "MPP");
        session.setAttribute("userId", "MPP001");
        session.setAttribute("fullName", "Ahmad Bin Ali");
        // ================================================

        String role = (String) session.getAttribute("role");
        if ("MPP".equals(role)) {
            List<Club> clubs = clubDAO.getAllClubs();
            request.setAttribute("clubs", clubs);
            request.getRequestDispatcher("/WEB-INF/jsp/ClubListMPP.jsp").forward(request, response);
        } else {
            response.sendRedirect("login.jsp");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int clubId = Integer.parseInt(request.getParameter("clubId"));
        String newStatus = request.getParameter("status");
        boolean success = clubDAO.updateClubStatus(clubId, newStatus);
        request.setAttribute("message", success ? "Club status updated successfully." : "Failed to update club status.");
        doGet(request, response); // Refresh list
    }
}
