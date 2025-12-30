package dao;

import model.Club;
import util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ClubDAO {
    private AGMReportDAO agmDAO = new AGMReportDAO();

    public List<Club> getAllClubs() {
        List<Club> clubs = new ArrayList<>();
        String sql = "SELECT * FROM Clubs";
        int currentYear = 2025; // Based on current date; in prod, use java.time.Year.now().getValue()
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Club club = new Club();
                club.setClubId(rs.getInt("clubId"));
                club.setClubName(rs.getString("clubName"));
                club.setCategory(rs.getString("category"));
                club.setLogoPath(rs.getString("logoPath"));
                club.setEstablishedYear(rs.getInt("establishedYear"));
                club.setStatus(rs.getString("status"));
                // Add AGM info
                String agmStatus = agmDAO.getLastAGMStatus(club.getClubId(), currentYear);
                club.setLastAGMStatus(agmStatus);
                clubs.add(club);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return clubs;
    }

    public boolean updateClubStatus(int clubId, String newStatus) {
        String sql = "UPDATE Clubs SET status = ? WHERE clubId = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, newStatus);
            ps.setInt(2, clubId);
            int rows = ps.executeUpdate();
            if (rows > 0 && "suspended".equals(newStatus)) {
                // Placeholder for notification (e.g., email to club)
                System.out.println("Notification: Club " + clubId + " suspended.");
            }
            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}