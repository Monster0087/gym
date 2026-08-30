package com.gym.dao;

import com.gym.model.MembershipPlan;
import com.gym.util.DatabaseUtil;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MembershipPlanDAO {
    
    private final Gson gson = new Gson();
    
    public List<MembershipPlan> getAllActivePlans() {
        List<MembershipPlan> plans = new ArrayList<>();
        String sql = "SELECT * FROM membership_plans WHERE is_active = TRUE ORDER BY price ASC";
        
        try (Connection conn = DatabaseUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                plans.add(mapResultSetToPlan(rs));
            }
        } catch (SQLException e) {
            System.err.println("Error getting all active plans: " + e.getMessage());
        }
        return plans;
    }
    
    public MembershipPlan getPlanById(int id) {
        String sql = "SELECT * FROM membership_plans WHERE id = ?";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, id);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                return mapResultSetToPlan(rs);
            }
        } catch (SQLException e) {
            System.err.println("Error getting plan by ID: " + e.getMessage());
        }
        return null;
    }
    
    public boolean createPlan(MembershipPlan plan) {
        String sql = "INSERT INTO membership_plans (plan_name, description, price, duration_months, features, is_active) VALUES (?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            pstmt.setString(1, plan.getPlanName());
            pstmt.setString(2, plan.getDescription());
            pstmt.setDouble(3, plan.getPrice());
            pstmt.setInt(4, plan.getDurationMonths());
            pstmt.setString(5, gson.toJson(plan.getFeatures()));
            pstmt.setBoolean(6, plan.isActive());
            
            int affectedRows = pstmt.executeUpdate();
            if (affectedRows > 0) {
                ResultSet rs = pstmt.getGeneratedKeys();
                if (rs.next()) {
                    plan.setId(rs.getInt(1));
                }
                return true;
            }
        } catch (SQLException e) {
            System.err.println("Error creating plan: " + e.getMessage());
        }
        return false;
    }
    
    public boolean updatePlan(MembershipPlan plan) {
        String sql = "UPDATE membership_plans SET plan_name = ?, description = ?, price = ?, duration_months = ?, features = ?, is_active = ? WHERE id = ?";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, plan.getPlanName());
            pstmt.setString(2, plan.getDescription());
            pstmt.setDouble(3, plan.getPrice());
            pstmt.setInt(4, plan.getDurationMonths());
            pstmt.setString(5, gson.toJson(plan.getFeatures()));
            pstmt.setBoolean(6, plan.isActive());
            pstmt.setInt(7, plan.getId());
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error updating plan: " + e.getMessage());
        }
        return false;
    }
    
    public boolean deletePlan(int id) {
        String sql = "DELETE FROM membership_plans WHERE id = ?";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, id);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error deleting plan: " + e.getMessage());
        }
        return false;
    }
    
    public boolean deactivatePlan(int id) {
        String sql = "UPDATE membership_plans SET is_active = FALSE WHERE id = ?";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, id);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error deactivating plan: " + e.getMessage());
        }
        return false;
    }
    
    private MembershipPlan mapResultSetToPlan(ResultSet rs) throws SQLException {
        MembershipPlan plan = new MembershipPlan();
        plan.setId(rs.getInt("id"));
        plan.setPlanName(rs.getString("plan_name"));
        plan.setDescription(rs.getString("description"));
        plan.setPrice(rs.getDouble("price"));
        plan.setDurationMonths(rs.getInt("duration_months"));
        plan.setActive(rs.getBoolean("is_active"));
        
        // Parse JSON features
        String featuresJson = rs.getString("features");
        if (featuresJson != null && !featuresJson.isEmpty()) {
            List<String> features = gson.fromJson(featuresJson, new TypeToken<List<String>>(){}.getType());
            plan.setFeatures(features);
        }
        
        return plan;
    }
}
