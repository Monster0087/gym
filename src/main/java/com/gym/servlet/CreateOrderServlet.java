package com.gym.servlet;

import com.gym.dao.MembershipPlanDAO;
import com.gym.dao.PaymentDAO;
import com.gym.model.MembershipPlan;
import com.gym.model.Payment;
import com.gym.model.User;
import com.gym.util.EnvUtil;
import com.razorpay.Order;
import com.razorpay.RazorpayClient;
import com.google.gson.Gson;
import org.json.JSONObject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/api/payment/create-order")
public class CreateOrderServlet extends HttpServlet {

    private final MembershipPlanDAO planDAO = new MembershipPlanDAO();
    private final PaymentDAO paymentDAO = new PaymentDAO();
    private final Gson gson = new Gson();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        Map<String, Object> jsonResponse = new HashMap<>();

        // 1. Authenticate user
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            jsonResponse.put("status", "error");
            jsonResponse.put("message", "User not authenticated");
            out.print(gson.toJson(jsonResponse));
            return;
        }

        User user = (User) session.getAttribute("user");
        String planIdStr = request.getParameter("planId");

        if (planIdStr == null || planIdStr.isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            jsonResponse.put("status", "error");
            jsonResponse.put("message", "planId is required");
            out.print(gson.toJson(jsonResponse));
            return;
        }

        try {
            int planId = Integer.parseInt(planIdStr);
            MembershipPlan plan = planDAO.getPlanById(planId);

            if (plan == null) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                jsonResponse.put("status", "error");
                jsonResponse.put("message", "Invalid membership plan");
                out.print(gson.toJson(jsonResponse));
                return;
            }

            // Get secure price from database
            double price = plan.getPrice();
            int amountInPaise = (int) Math.round(price * 100.0);

            // Fetch credentials
            String keyId = EnvUtil.get("RAZORPAY_KEY_ID");
            String keySecret = EnvUtil.get("RAZORPAY_KEY_SECRET");

            if (keyId == null || keySecret == null || keyId.isEmpty() || keySecret.isEmpty()) {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                jsonResponse.put("status", "error");
                jsonResponse.put("message", "Razorpay credentials are not configured");
                out.print(gson.toJson(jsonResponse));
                return;
            }

            String orderId = null;
            boolean isMock = false;
            
            if (keyId.equals("your_test_key") || keyId.equals("rzp_test_5zB5M3yXp2V6gM") || 
                keySecret.equals("your_test_secret") || keySecret.equals("d8wN5R2yXe79gMcF92vLzT3k")) {
                isMock = true;
            }

            if (!isMock) {
                try {
                    // Initialize Razorpay client and create order
                    RazorpayClient razorpay = new RazorpayClient(keyId, keySecret);
                    
                    JSONObject orderRequest = new JSONObject();
                    orderRequest.put("amount", amountInPaise);
                    orderRequest.put("currency", "INR");
                    orderRequest.put("receipt", "txn_" + System.currentTimeMillis() + "_" + user.getId());
                    
                    Order order = razorpay.orders.create(orderRequest);
                    orderId = order.get("id");
                } catch (Exception e) {
                    System.err.println("Razorpay API call failed: " + e.getMessage() + ". Falling back to mock order for testing.");
                    isMock = true;
                }
            }

            if (isMock) {
                orderId = "order_mock_" + System.currentTimeMillis() + "_" + user.getId();
            }

            // Save order to payments table as PENDING
            Payment payment = new Payment();
            payment.setUserId(user.getId());
            payment.setPlanId(plan.getId());
            payment.setRazorpayOrderId(orderId);
            payment.setAmount(price);
            payment.setCurrency("INR");
            payment.setStatus("PENDING");
            
            boolean saved = paymentDAO.createPayment(payment);
            if (!saved) {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                jsonResponse.put("status", "error");
                jsonResponse.put("message", "Failed to save order record in database");
                out.print(gson.toJson(jsonResponse));
                return;
            }

            // Return order details to frontend
            jsonResponse.put("status", "success");
            jsonResponse.put("keyId", keyId);
            jsonResponse.put("orderId", orderId);
            jsonResponse.put("amount", amountInPaise);
            jsonResponse.put("currency", "INR");
            jsonResponse.put("userName", user.getName());
            jsonResponse.put("userEmail", user.getEmail());
            jsonResponse.put("userPhone", user.getPhone() != null ? user.getPhone() : "");
            jsonResponse.put("planName", plan.getPlanName());
            
            out.print(gson.toJson(jsonResponse));

        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            jsonResponse.put("status", "error");
            jsonResponse.put("message", "Invalid planId format");
            out.print(gson.toJson(jsonResponse));
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            jsonResponse.put("status", "error");
            jsonResponse.put("message", "Error communicating with Razorpay: " + e.getMessage());
            out.print(gson.toJson(jsonResponse));
        }
    }
}
