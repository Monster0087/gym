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

@WebServlet("/save-progress")
public class SaveProgressServlet extends HttpServlet {

    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");
        
        try {
            double weight = Double.parseDouble(request.getParameter("weight"));
            double height = Double.parseDouble(request.getParameter("height"));
            
            // Calculate BMI: weight (kg) / [height (m)]^2
            double heightInMeters = height / 100.0;
            double bmi = weight / (heightInMeters * heightInMeters);
            
            // Round to 1 decimal place
            bmi = Math.round(bmi * 10.0) / 10.0;

            boolean success = userDAO.saveProgress(user.getId(), weight, heightInMeters, bmi);
            
            if (success) {
                response.sendRedirect("dashboard.jsp?progress=saved");
            } else {
                response.sendRedirect("dashboard.jsp?error=save_failed");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("dashboard.jsp?error=invalid_data");
        }
    }
}
