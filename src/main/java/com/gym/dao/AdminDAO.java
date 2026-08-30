package com.gym.dao;

import com.gym.model.AdminUserDTO;
import com.gym.model.UserProgress;
import com.gym.util.DatabaseUtil;

import java.sql.*;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.List;

public class AdminDAO {

    public List<AdminUserDTO> getAllUsersWithDetails() {
        List<AdminUserDTO> list = new ArrayList<>();
        
        String sql = "SELECT u.id, u.name, u.email, u.phone, u.role, u.plan_id, " +
                     "(SELECT plan_name FROM membership_plans WHERE id = u.plan_id) as plan_name, " +
                     "um.start_date, um.end_date, " +
                     "(SELECT COUNT(*) FROM user_attendance ua WHERE ua.user_id = u.id) as attendance_count, " +
                     "(SELECT COUNT(*) FROM user_workouts uw WHERE uw.user_id = u.id) as workout_count " +
                     "FROM users u " +
                     "LEFT JOIN user_memberships um ON u.id = um.user_id AND um.status = 'active' " +
                     "ORDER BY u.created_at DESC";
                     
        try (Connection conn = DatabaseUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                AdminUserDTO dto = new AdminUserDTO();
                dto.setUserId(rs.getInt("id"));
                dto.setName(rs.getString("name"));
                dto.setEmail(rs.getString("email"));
                dto.setPhone(rs.getString("phone"));
                dto.setRole(rs.getString("role"));
                
                dto.setPlanName(rs.getString("plan_name"));
                Date startDate = rs.getDate("start_date");
                Date endDate = rs.getDate("end_date");
                
                if (startDate != null) dto.setPlanStartDate(startDate.toLocalDate());
                if (endDate != null) {
                    dto.setPlanEndDate(endDate.toLocalDate());
                    long days = ChronoUnit.DAYS.between(LocalDate.now(), endDate.toLocalDate());
                    dto.setDaysRemaining(days < 0 ? 0 : days);
                } else {
                    dto.setDaysRemaining(0);
                }
                
                dto.setTotalAttendanceDays(rs.getInt("attendance_count"));
                dto.setCompletedWorkouts(rs.getInt("workout_count"));
                
                list.add(dto);
            }
        } catch (SQLException e) {
            System.err.println("Error getting all user details: " + e.getMessage());
        }
        
        return list;
    }
    public boolean cancelMembership(int userId) {
        String sql = "UPDATE user_memberships SET status = 'cancelled' WHERE user_id = ? AND status = 'active'";
        String updateUserSql = "UPDATE users SET plan_id = 0 WHERE id = ?";
        
        Connection conn = null;
        try {
            conn = DatabaseUtil.getConnection();
            conn.setAutoCommit(false);
            
            try (PreparedStatement pstmt1 = conn.prepareStatement(sql)) {
                pstmt1.setInt(1, userId);
                pstmt1.executeUpdate();
            }
            
            try (PreparedStatement pstmt2 = conn.prepareStatement(updateUserSql)) {
                pstmt2.setInt(1, userId);
                pstmt2.executeUpdate();
            }
            
            conn.commit();
            return true;
        } catch (SQLException e) {
            if (conn != null) {
                try { conn.rollback(); } catch (SQLException ex) { ex.printStackTrace(); }
            }
            System.err.println("Error cancelling membership: " + e.getMessage());
        } finally {
            if (conn != null) {
                try { conn.setAutoCommit(true); conn.close(); } catch (SQLException ex) { ex.printStackTrace(); }
            }
        }
        return false;
    }

    public List<UserProgress> getUserProgress(int userId) {
        List<UserProgress> list = new ArrayList<>();
        String sql = "SELECT * FROM user_progress WHERE user_id = ? ORDER BY recorded_at DESC";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, userId);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                UserProgress p = new UserProgress();
                p.setId(rs.getInt("id"));
                p.setUserId(rs.getInt("user_id"));
                p.setWeight(rs.getDouble("weight"));
                p.setHeight(rs.getDouble("height"));
                p.setBmi(rs.getDouble("bmi"));
                p.setRecordedAt(rs.getTimestamp("recorded_at").toLocalDateTime());
                list.add(p);
            }
        } catch (SQLException e) {
            System.err.println("Error getting user progress: " + e.getMessage());
        }
        return list;
    }
}
