package com.gym.dao;

import com.gym.model.ContactMessage;
import com.gym.util.DatabaseUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ContactMessageDAO {
    
    public boolean createMessage(ContactMessage message) {
        String sql = "INSERT INTO contact_messages (name, email, phone, message, status) VALUES (?, ?, ?, ?, ?)";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            pstmt.setString(1, message.getName());
            pstmt.setString(2, message.getEmail());
            pstmt.setString(3, message.getPhone());
            pstmt.setString(4, message.getMessage());
            pstmt.setString(5, message.getStatus());
            
            int affectedRows = pstmt.executeUpdate();
            if (affectedRows > 0) {
                ResultSet rs = pstmt.getGeneratedKeys();
                if (rs.next()) {
                    message.setId(rs.getInt(1));
                }
                return true;
            }
        } catch (SQLException e) {
            System.err.println("Error creating contact message: " + e.getMessage());
        }
        return false;
    }
    
    public ContactMessage getMessageById(int id) {
        String sql = "SELECT * FROM contact_messages WHERE id = ?";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, id);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                return mapResultSetToMessage(rs);
            }
        } catch (SQLException e) {
            System.err.println("Error getting message by ID: " + e.getMessage());
        }
        return null;
    }
    
    public List<ContactMessage> getAllMessages() {
        List<ContactMessage> messages = new ArrayList<>();
        String sql = "SELECT * FROM contact_messages ORDER BY created_at DESC";
        
        try (Connection conn = DatabaseUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                messages.add(mapResultSetToMessage(rs));
            }
        } catch (SQLException e) {
            System.err.println("Error getting all messages: " + e.getMessage());
        }
        return messages;
    }
    
    public List<ContactMessage> getMessagesByStatus(String status) {
        List<ContactMessage> messages = new ArrayList<>();
        String sql = "SELECT * FROM contact_messages WHERE status = ? ORDER BY created_at DESC";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, status);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                messages.add(mapResultSetToMessage(rs));
            }
        } catch (SQLException e) {
            System.err.println("Error getting messages by status: " + e.getMessage());
        }
        return messages;
    }
    
    public boolean updateMessageStatus(int id, String status) {
        String sql = "UPDATE contact_messages SET status = ? WHERE id = ?";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, status);
            pstmt.setInt(2, id);
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error updating message status: " + e.getMessage());
        }
        return false;
    }
    
    public boolean deleteMessage(int id) {
        String sql = "DELETE FROM contact_messages WHERE id = ?";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, id);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error deleting message: " + e.getMessage());
        }
        return false;
    }
    
    public int getUnreadCount() {
        String sql = "SELECT COUNT(*) FROM contact_messages WHERE status = 'new'";
        
        try (Connection conn = DatabaseUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.err.println("Error getting unread count: " + e.getMessage());
        }
        return 0;
    }
    
    private ContactMessage mapResultSetToMessage(ResultSet rs) throws SQLException {
        ContactMessage message = new ContactMessage();
        message.setId(rs.getInt("id"));
        message.setName(rs.getString("name"));
        message.setEmail(rs.getString("email"));
        message.setPhone(rs.getString("phone"));
        message.setMessage(rs.getString("message"));
        message.setStatus(rs.getString("status"));
        message.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
        return message;
    }
}
