package com.gym.servlet;

import com.gym.dao.BookingDAO;
import com.gym.model.Booking;
import com.gym.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/book-session-submit")
public class BookingServlet extends HttpServlet {
    
    private BookingDAO bookingDAO;
    
    @Override
    public void init() throws ServletException {
        bookingDAO = new BookingDAO();
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        String trainerIdStr = request.getParameter("trainerId");
        String bookingDate = request.getParameter("bookingDate");
        String sessionType = request.getParameter("sessionType");
        String message = request.getParameter("message");
        
        if (trainerIdStr == null || bookingDate == null || trainerIdStr.isEmpty() || bookingDate.isEmpty()) {
            request.setAttribute("error", "Trainer ID and Booking Date are required.");
            request.getRequestDispatcher("book-session.jsp").forward(request, response);
            return;
        }
        
        int trainerId = Integer.parseInt(trainerIdStr);
        Booking booking = new Booking(user.getId(), trainerId, bookingDate, sessionType, message);
        
        if (bookingDAO.createBooking(booking)) {
            session.setAttribute("bookingSuccess", "Successfully booked! Your session with the trainer is scheduled for " + bookingDate + ".");
            response.sendRedirect("dashboard.jsp");
        } else {
            request.setAttribute("error", "Failed to book session. Please try again.");
            request.getRequestDispatcher("book-session.jsp").forward(request, response);
        }
    }
}
