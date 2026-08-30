package com.gym.servlet;

import com.gym.dao.UserDAO;
import com.gym.model.User;
import com.gym.util.DatabaseUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet("/admin/edit-user")
public class AdminEditUserServlet extends HttpServlet {

    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            return;
        }

        try {
            int userId = Integer.parseInt(request.getParameter("userId"));
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String role = request.getParameter("role");
            
            // 1. Update basic info using UserDAO
            User user = userDAO.getUserById(userId);
            if (user != null) {
                user.setName(name);
                user.setEmail(email);
                user.setPhone(phone);
                userDAO.updateUser(user);
                
                // 2. Update role directly since UserDAO.updateUser doesn't handle role yet
                updateUserRole(userId, role);
                
                response.sendRedirect(request.getContextPath() + "/admin/dashboard?msg=updated");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/dashboard?error=user_not_found");
            }
            
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/dashboard?error=invalid_data");
        }
    }
    
    private void updateUserRole(int userId, String role) {
        String sql = "UPDATE users SET role = ? WHERE id = ?";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, role);
            pstmt.setInt(2, userId);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            System.err.println("Error updating role: " + e.getMessage());
        }
    }
}
