package dao;

import util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class AGMReportDAO {

    public String getLastAGMStatus(int clubId, int currentYear) {
        String sql = "SELECT status FROM AGM_Report WHERE clubId = ? AND reportYear = ? ORDER BY submittedAt DESC LIMIT 1";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, clubId);
            ps.setInt(2, currentYear);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getString("status"); // e.g., 'accepted', 'submitted', 'missing'
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return "Missing"; // Default if no report
    }
}