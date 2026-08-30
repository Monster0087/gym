package com.gym.servlet;

import com.gym.dao.UserDAO;
import com.gym.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/contact")
public class ContactServlet extends HttpServlet {
    
    private UserDAO userDAO;
    
    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("contact.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String message = request.getParameter("message");
        
        // Basic validation
        if (name == null || name.trim().isEmpty() ||
            email == null || email.trim().isEmpty() ||
            message == null || message.trim().isEmpty()) {
            
            request.setAttribute("error", "Name, email, and message are required");
            request.getRequestDispatcher("contact.jsp").forward(request, response);
            return;
        }
        
        // Basic email validation
        if (!email.matches("^[A-Za-z0-9+_.-]+@(.+)$")) {
            request.setAttribute("error", "Please enter a valid email address");
            request.getRequestDispatcher("contact.jsp").forward(request, response);
            return;
        }
        
        // Create contact message
        com.gym.model.ContactMessage contactMessage = new com.gym.model.ContactMessage(name, email, phone, message);
        com.gym.dao.ContactMessageDAO contactDAO = new com.gym.dao.ContactMessageDAO();
        
        if (contactDAO.createMessage(contactMessage)) {
            request.setAttribute("success", "Your message has been sent successfully! We'll get back to you soon.");
            // Clear form fields
            request.setAttribute("name", "");
            request.setAttribute("email", "");
            request.setAttribute("phone", "");
            request.setAttribute("message", "");
        } else {
            request.setAttribute("error", "Failed to send message. Please try again.");
        }
        
        request.getRequestDispatcher("contact.jsp").forward(request, response);
    }
}
