package com.gym.dao;

import com.gym.util.DatabaseUtil;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class AttendanceDAO {

    public boolean markAttendance(int userId, LocalDate date) {
        String sql = "INSERT INTO user_attendance (user_id, attendance_date, status) VALUES (?, ?, 'PRESENT')";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, userId);
            pstmt.setDate(2, Date.valueOf(date));
            
            return pstmt.executeUpdate() > 0;
            
        } catch (SQLException e) {
            // Might fail due to unique constraint if already marked, which is fine
            System.err.println("Attendance marking failed/ignored: " + e.getMessage());
        }
        return false;
    }

    public boolean isAttendanceMarked(int userId, LocalDate date) {
        String sql = "SELECT id FROM user_attendance WHERE user_id = ? AND attendance_date = ?";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, userId);
            pstmt.setDate(2, Date.valueOf(date));
            
            ResultSet rs = pstmt.executeQuery();
            return rs.next();
            
        } catch (SQLException e) {
            System.err.println("Error checking attendance: " + e.getMessage());
        }
        return false;
    }
    
    public int getMonthlyAttendanceCount(int userId, int month, int year) {
        String sql = "SELECT COUNT(*) FROM user_attendance WHERE user_id = ? AND MONTH(attendance_date) = ? AND YEAR(attendance_date) = ?";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, userId);
            pstmt.setInt(2, month);
            pstmt.setInt(3, year);
            
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
            
        } catch (SQLException e) {
            System.err.println("Error counting attendance: " + e.getMessage());
        }
        return 0;
    }

    public List<String> getAttendanceDatesForRange(int userId, LocalDate start, LocalDate end) {
        List<String> dates = new ArrayList<>();
        String sql = "SELECT attendance_date FROM user_attendance WHERE user_id = ? AND attendance_date BETWEEN ? AND ?";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, userId);
            pstmt.setDate(2, Date.valueOf(start));
            pstmt.setDate(3, Date.valueOf(end));
            
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                dates.add(rs.getDate("attendance_date").toString());
            }
            
        } catch (SQLException e) {
            System.err.println("Error fetching attendance range: " + e.getMessage());
        }
        return dates;
    }
}
