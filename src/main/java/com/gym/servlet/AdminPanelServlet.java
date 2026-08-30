package com.gym.servlet;

import com.gym.dao.AdminDAO;
import com.gym.model.AdminUserDTO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/dashboard")
public class AdminPanelServlet extends HttpServlet {

    private AdminDAO adminDAO;

    @Override
    public void init() throws ServletException {
        adminDAO = new AdminDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<AdminUserDTO> users = adminDAO.getAllUsersWithDetails();
        request.setAttribute("users", users);
        
        com.gym.dao.BookingDAO bookingDAO = new com.gym.dao.BookingDAO();
        List<com.gym.model.Booking> bookings = bookingDAO.getAllBookings();
        request.setAttribute("bookings", bookings);
        
        // Calculate stats
        long totalUsers = users.size();
        long activeMembers = users.stream().filter(u -> u.getPlanName() != null && u.getDaysRemaining() > 0).count();
        
        request.setAttribute("totalUsers", totalUsers);
        request.setAttribute("activeMembers", activeMembers);
        request.setAttribute("totalBookings", (long) bookings.size());

        request.getRequestDispatcher("/WEB-INF/admin-panel.jsp").forward(request, response);
    }
}
