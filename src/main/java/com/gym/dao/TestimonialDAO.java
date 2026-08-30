package com.gym.dao;

import com.gym.model.Testimonial;
import com.gym.util.DatabaseUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TestimonialDAO {
    
    public List<Testimonial> getFeaturedTestimonials() {
        List<Testimonial> testimonials = new ArrayList<>();
        String sql = "SELECT * FROM testimonials WHERE is_active = TRUE AND is_featured = TRUE ORDER BY created_at DESC";
        
        try (Connection conn = DatabaseUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                testimonials.add(mapResultSetToTestimonial(rs));
            }
        } catch (SQLException e) {
            System.err.println("Error getting featured testimonials: " + e.getMessage());
        }
        return testimonials;
    }
    
    public List<Testimonial> getAllActiveTestimonials() {
        List<Testimonial> testimonials = new ArrayList<>();
        String sql = "SELECT * FROM testimonials WHERE is_active = TRUE ORDER BY created_at DESC";
        
        try (Connection conn = DatabaseUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                testimonials.add(mapResultSetToTestimonial(rs));
            }
        } catch (SQLException e) {
            System.err.println("Error getting all active testimonials: " + e.getMessage());
        }
        return testimonials;
    }
    
    public Testimonial getTestimonialById(int id) {
        String sql = "SELECT * FROM testimonials WHERE id = ? AND is_active = TRUE";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, id);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                return mapResultSetToTestimonial(rs);
            }
        } catch (SQLException e) {
            System.err.println("Error getting testimonial by ID: " + e.getMessage());
        }
        return null;
    }
    
    public boolean createTestimonial(Testimonial testimonial) {
        String sql = "INSERT INTO testimonials (client_name, client_image, rating, testimonial_text, is_featured, is_active) VALUES (?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            pstmt.setString(1, testimonial.getClientName());
            pstmt.setString(2, testimonial.getClientImage());
            pstmt.setInt(3, testimonial.getRating());
            pstmt.setString(4, testimonial.getTestimonialText());
            pstmt.setBoolean(5, testimonial.isFeatured());
            pstmt.setBoolean(6, testimonial.isActive());
            
            int affectedRows = pstmt.executeUpdate();
            if (affectedRows > 0) {
                ResultSet rs = pstmt.getGeneratedKeys();
                if (rs.next()) {
                    testimonial.setId(rs.getInt(1));
                }
                return true;
            }
        } catch (SQLException e) {
            System.err.println("Error creating testimonial: " + e.getMessage());
        }
        return false;
    }
    
    public boolean updateTestimonial(Testimonial testimonial) {
        String sql = "UPDATE testimonials SET client_name = ?, client_image = ?, rating = ?, testimonial_text = ?, is_featured = ?, is_active = ? WHERE id = ?";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, testimonial.getClientName());
            pstmt.setString(2, testimonial.getClientImage());
            pstmt.setInt(3, testimonial.getRating());
            pstmt.setString(4, testimonial.getTestimonialText());
            pstmt.setBoolean(5, testimonial.isFeatured());
            pstmt.setBoolean(6, testimonial.isActive());
            pstmt.setInt(7, testimonial.getId());
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error updating testimonial: " + e.getMessage());
        }
        return false;
    }
    
    public boolean deleteTestimonial(int id) {
        String sql = "DELETE FROM testimonials WHERE id = ?";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, id);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error deleting testimonial: " + e.getMessage());
        }
        return false;
    }
    
    public boolean setFeatured(int id, boolean featured) {
        String sql = "UPDATE testimonials SET is_featured = ? WHERE id = ?";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setBoolean(1, featured);
            pstmt.setInt(2, id);
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error setting testimonial featured status: " + e.getMessage());
        }
        return false;
    }
    
    private Testimonial mapResultSetToTestimonial(ResultSet rs) throws SQLException {
        Testimonial testimonial = new Testimonial();
        testimonial.setId(rs.getInt("id"));
        testimonial.setClientName(rs.getString("client_name"));
        testimonial.setClientImage(rs.getString("client_image"));
        testimonial.setRating(rs.getInt("rating"));
        testimonial.setTestimonialText(rs.getString("testimonial_text"));
        testimonial.setFeatured(rs.getBoolean("is_featured"));
        testimonial.setActive(rs.getBoolean("is_active"));
        return testimonial;
    }
}
