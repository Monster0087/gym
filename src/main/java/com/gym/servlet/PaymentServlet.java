package com.gym.servlet;

import com.gym.dao.MembershipPlanDAO;
import com.gym.dao.UserDAO;
import com.gym.model.MembershipPlan;
import com.gym.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.net.URLEncoder;

@WebServlet("/process-payment")
public class PaymentServlet extends HttpServlet {

    private UserDAO userDAO;
    private MembershipPlanDAO planDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
        planDAO = new MembershipPlanDAO();
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
        String planIdStr = request.getParameter("planId");

        if (planIdStr != null && !planIdStr.isEmpty()) {
            try {
                int planId = Integer.parseInt(planIdStr);
                MembershipPlan plan = planDAO.getPlanById(planId);
                
                if (plan != null) {
                    // Update user's plan in database
                    boolean updated = userDAO.updateUserPlan(user.getId(), planId);
                    
                    if (updated) {
                        // Update user in session
                        user.setPlanId(planId);
                        session.setAttribute("user", user);
                        
                        String planName = URLEncoder.encode(plan.getPlanName(), "UTF-8");
                        response.sendRedirect("dashboard.jsp?payment=success&plan=" + planName);
                        return;
                    }
                }
            } catch (NumberFormatException e) {
                // Invalid plan ID
            }
        }
        
        response.sendRedirect("services.jsp?error=payment_failed");
    }
}
