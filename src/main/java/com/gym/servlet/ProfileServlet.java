package com.gym.servlet;

import com.gym.dao.UserDAO;
import com.gym.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {
    
    private UserDAO userDAO;
    
    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        User user = (User) session.getAttribute("user");
        request.setAttribute("user", user);
        request.getRequestDispatcher("profile.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        User user = (User) session.getAttribute("user");
        
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");
        String profileImageBase64 = request.getParameter("profileImageBase64");
        
        // Basic validation
        if (name == null || name.trim().isEmpty() ||
            email == null || email.trim().isEmpty()) {
            
            request.setAttribute("error", "Name and email are required");
            request.setAttribute("user", user);
            request.getRequestDispatcher("profile.jsp").forward(request, response);
            return;
        }
        
        // Update basic info
        user.setName(name);
        user.setEmail(email);
        user.setPhone(phone);
        if (profileImageBase64 != null && !profileImageBase64.trim().isEmpty()) {
            user.setProfileImage(profileImageBase64);
        }
        
        if (userDAO.updateUser(user)) {
            // Update session user
            session.setAttribute("user", user);
            session.setAttribute("userName", user.getName());
            
            request.setAttribute("success", "Profile updated successfully!");
        } else {
            request.setAttribute("error", "Failed to update profile");
        }
        
        // Handle password change if provided
        if (currentPassword != null && !currentPassword.trim().isEmpty() &&
            newPassword != null && !newPassword.trim().isEmpty()) {
            
            if (!newPassword.equals(confirmPassword)) {
                request.setAttribute("error", "New passwords do not match");
            } else if (newPassword.length() < 6) {
                request.setAttribute("error", "New password must be at least 6 characters long");
            } else if (!userDAO.authenticateUser(user.getEmail(), currentPassword)) {
                request.setAttribute("error", "Current password is incorrect");
            } else {
                if (userDAO.updatePassword(user.getId(), newPassword)) {
                    request.setAttribute("success", "Profile and password updated successfully!");
                } else {
                    request.setAttribute("error", "Failed to update password");
                }
            }
        }
        
        request.setAttribute("user", user);
        request.getRequestDispatcher("profile.jsp").forward(request, response);
    }
}
