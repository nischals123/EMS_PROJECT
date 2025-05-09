package dao;

import model.Attendance;
import utils.DbUtils;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AttendanceDAO {

    public Attendance getTodayAttendance(int userId) {
        Attendance attendance = null;
        String query = "SELECT * FROM attendance WHERE user_id = ? AND date = CURDATE()";

        try (Connection conn = DbUtils.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    attendance = new Attendance();
                    attendance.setId(rs.getInt("id"));
                    attendance.setUserId(rs.getInt("user_id"));
                    attendance.setDate(rs.getDate("date"));
                    attendance.setStatus(rs.getString("status"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return attendance;
    }

    public List<Attendance> getAttendanceHistory(int userId, String yearMonth) {
        List<Attendance> history = new ArrayList<>();
        String query = "SELECT * FROM attendance WHERE user_id = ? AND DATE_FORMAT(date, '%Y-%m') = ? ORDER BY date DESC";

        try (Connection conn = DbUtils.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, userId);
            ps.setString(2, yearMonth);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Attendance att = new Attendance();
                    att.setId(rs.getInt("id"));
                    att.setUserId(rs.getInt("user_id"));
                    att.setDate(rs.getDate("date"));
                    att.setStatus(rs.getString("status"));
                    history.add(att);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return history;
    }

    public boolean markTimeIn(int userId) {
        String query = "INSERT INTO attendance (user_id, date, status, time_in) " +
                       "VALUES (?, CURDATE(), 'Present', CURRENT_TIME()) " +
                       "ON DUPLICATE KEY UPDATE time_in = CURRENT_TIME(), status = 'Present'";

        try (Connection conn = DbUtils.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, userId);
            int rows = ps.executeUpdate();
            System.out.println("markTimeIn() affected rows: " + rows);
            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean markTimeOut(int userId) {
        String query = "UPDATE attendance SET time_out = CURRENT_TIME(), status = 'Present' " +
                       "WHERE user_id = ? AND date = CURDATE() AND time_out IS NULL";

        try (Connection conn = DbUtils.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, userId);
            int rows = ps.executeUpdate();
            System.out.println("markTimeOut() affected rows: " + rows);
            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
