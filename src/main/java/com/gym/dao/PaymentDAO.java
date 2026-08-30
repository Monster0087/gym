package com.gym.dao;

import com.gym.model.Payment;
import com.gym.util.DatabaseUtil;

import java.sql.*;

public class PaymentDAO {

    public boolean createPayment(Payment payment) {
        String sql = "INSERT INTO payments (user_id, plan_id, razorpay_order_id, amount, currency, status) VALUES (?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            pstmt.setInt(1, payment.getUserId());
            pstmt.setInt(2, payment.getPlanId());
            pstmt.setString(3, payment.getRazorpayOrderId());
            pstmt.setDouble(4, payment.getAmount());
            pstmt.setString(5, payment.getCurrency());
            pstmt.setString(6, payment.getStatus());
            
            int affectedRows = pstmt.executeUpdate();
            if (affectedRows > 0) {
                try (ResultSet rs = pstmt.getGeneratedKeys()) {
                    if (rs.next()) {
                        payment.setId(rs.getInt(1));
                    }
                }
                return true;
            }
        } catch (SQLException e) {
            System.err.println("Error creating payment: " + e.getMessage());
        }
        return false;
    }

    public Payment getPaymentByOrderId(String orderId) {
        String sql = "SELECT * FROM payments WHERE razorpay_order_id = ?";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, orderId);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    Payment payment = new Payment();
                    payment.setId(rs.getInt("id"));
                    payment.setUserId(rs.getInt("user_id"));
                    payment.setPlanId(rs.getInt("plan_id"));
                    payment.setRazorpayPaymentId(rs.getString("razorpay_payment_id"));
                    payment.setRazorpayOrderId(rs.getString("razorpay_order_id"));
                    payment.setAmount(rs.getDouble("amount"));
                    payment.setCurrency(rs.getString("currency"));
                    payment.setStatus(rs.getString("status"));
                    payment.setCreatedAt(rs.getTimestamp("created_at"));
                    return payment;
                }
            }
        } catch (SQLException e) {
            System.err.println("Error getting payment by order ID: " + e.getMessage());
        }
        return null;
    }

    public boolean updatePaymentStatus(String orderId, String status) {
        String sql = "UPDATE payments SET status = ? WHERE razorpay_order_id = ?";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, status);
            pstmt.setString(2, orderId);
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error updating payment status: " + e.getMessage());
        }
        return false;
    }

    public boolean updatePaymentSuccess(String orderId, String paymentId, String status) {
        String sql = "UPDATE payments SET razorpay_payment_id = ?, status = ? WHERE razorpay_order_id = ?";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, paymentId);
            pstmt.setString(2, status);
            pstmt.setString(3, orderId);
            
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error updating payment success details: " + e.getMessage());
        }
        return false;
    }
}
