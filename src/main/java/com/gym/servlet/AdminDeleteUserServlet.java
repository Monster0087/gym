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

@WebServlet("/admin/delete-user")
public class AdminDeleteUserServlet extends HttpServlet {

    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Security check is already done by AdminFilter, but double checking is good practice
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            return;
        }

        try {
            int userId = Integer.parseInt(request.getParameter("userId"));
            
            // Delete the user from database
            boolean success = userDAO.deleteUser(userId);
            
            // Redirect back to dashboard with a status parameter
            response.sendRedirect(request.getContextPath() + "/admin/dashboard" + (success ? "?msg=deleted" : "?error=delete_failed"));
            
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/dashboard?error=invalid_id");
        }
    }
}
