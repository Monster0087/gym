package com.gym.dao;

import com.gym.model.Trainer;
import com.gym.util.DatabaseUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TrainerDAO {
    
    public List<Trainer> getAllActiveTrainers() {
        List<Trainer> trainers = new ArrayList<>();
        String sql = "SELECT * FROM trainers WHERE is_active = TRUE ORDER BY name ASC";
        
        try (Connection conn = DatabaseUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                trainers.add(mapResultSetToTrainer(rs));
            }
        } catch (SQLException e) {
            System.err.println("Error getting all active trainers: " + e.getMessage());
        }
        return trainers;
    }
    
    public Trainer getTrainerById(int id) {
        String sql = "SELECT * FROM trainers WHERE id = ? AND is_active = TRUE";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, id);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                return mapResultSetToTrainer(rs);
            }
        } catch (SQLException e) {
            System.err.println("Error getting trainer by ID: " + e.getMessage());
        }
        return null;
    }
    
    public boolean createTrainer(Trainer trainer) {
        String sql = "INSERT INTO trainers (name, specialization, experience_years, bio, image_url, email, phone, is_active) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            pstmt.setString(1, trainer.getName());
            pstmt.setString(2, trainer.getSpecialization());
            pstmt.setInt(3, trainer.getExperienceYears());
            pstmt.setString(4, trainer.getBio());
            pstmt.setString(5, trainer.getImageUrl());
            pstmt.setString(6, trainer.getEmail());
            pstmt.setString(7, trainer.getPhone());
            pstmt.setBoolean(8, trainer.isActive());
            
            int affectedRows = pstmt.executeUpdate();
            if (affectedRows > 0) {
                ResultSet rs = pstmt.getGeneratedKeys();
                if (rs.next()) {
                    trainer.setId(rs.getInt(1));
                }
                return true;
            }
        } catch (SQLException e) {
            System.err.println("Error creating trainer: " + e.getMessage());
        }
        return false;
    }
    
    public boolean updateTrainer(Trainer trainer) {
        String sql = "UPDATE trainers SET name = ?, specialization = ?, experience_years = ?, bio = ?, image_url = ?, email = ?, phone = ?, is_active = ? WHERE id = ?";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, trainer.getName());
            pstmt.setString(2, trainer.getSpecialization());
            pstmt.setInt(3, trainer.getExperienceYears());
            pstmt.setString(4, trainer.getBio());
            pstmt.setString(5, trainer.getImageUrl());
            pstmt.setString(6, trainer.getEmail());
            pstmt.setString(7, trainer.getPhone());
            pstmt.setBoolean(8, trainer.isActive());
            pstmt.setInt(9, trainer.getId());
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error updating trainer: " + e.getMessage());
        }
        return false;
    }
    
    public boolean deleteTrainer(int id) {
        String sql = "DELETE FROM trainers WHERE id = ?";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, id);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error deleting trainer: " + e.getMessage());
        }
        return false;
    }
    
    public boolean deactivateTrainer(int id) {
        String sql = "UPDATE trainers SET is_active = FALSE WHERE id = ?";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, id);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error deactivating trainer: " + e.getMessage());
        }
        return false;
    }
    
    public List<Trainer> getFeaturedTrainers(int limit) {
        List<Trainer> trainers = new ArrayList<>();
        String sql = "SELECT * FROM trainers WHERE is_active = TRUE ORDER BY experience_years DESC LIMIT ?";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, limit);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                trainers.add(mapResultSetToTrainer(rs));
            }
        } catch (SQLException e) {
            System.err.println("Error getting featured trainers: " + e.getMessage());
        }
        return trainers;
    }
    
    private Trainer mapResultSetToTrainer(ResultSet rs) throws SQLException {
        Trainer trainer = new Trainer();
        trainer.setId(rs.getInt("id"));
        trainer.setName(rs.getString("name"));
        trainer.setSpecialization(rs.getString("specialization"));
        trainer.setExperienceYears(rs.getInt("experience_years"));
        trainer.setBio(rs.getString("bio"));
        trainer.setImageUrl(rs.getString("image_url"));
        trainer.setEmail(rs.getString("email"));
        trainer.setPhone(rs.getString("phone"));
        trainer.setActive(rs.getBoolean("is_active"));
        return trainer;
    }
}
