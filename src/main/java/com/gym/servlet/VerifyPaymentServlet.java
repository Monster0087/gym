package com.gym.servlet;

import com.gym.dao.MembershipPlanDAO;
import com.gym.dao.PaymentDAO;
import com.gym.dao.UserDAO;
import com.gym.model.MembershipPlan;
import com.gym.model.Payment;
import com.gym.model.User;
import com.gym.util.EnvUtil;
import com.google.gson.Gson;
import com.razorpay.Utils;
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

@WebServlet("/api/payment/verify")
public class VerifyPaymentServlet extends HttpServlet {

    private final PaymentDAO paymentDAO = new PaymentDAO();
    private final UserDAO userDAO = new UserDAO();
    private final MembershipPlanDAO planDAO = new MembershipPlanDAO();
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

        String paymentId = request.getParameter("razorpay_payment_id");
        String orderId = request.getParameter("razorpay_order_id");
        String signature = request.getParameter("razorpay_signature");

        if (paymentId == null || orderId == null || signature == null ||
            paymentId.isEmpty() || orderId.isEmpty() || signature.isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            jsonResponse.put("status", "error");
            jsonResponse.put("message", "Missing Razorpay verification parameters");
            out.print(gson.toJson(jsonResponse));
            return;
        }

        try {
            // Get credentials
            String keySecret = EnvUtil.get("RAZORPAY_KEY_SECRET");

            // Verify signature
            JSONObject options = new JSONObject();
            options.put("razorpay_payment_id", paymentId);
            options.put("razorpay_order_id", orderId);
            options.put("razorpay_signature", signature);

            boolean isSignatureValid = false;
            if (orderId.startsWith("order_mock_")) {
                isSignatureValid = paymentId.startsWith("pay_mock_") || signature.equals("mock_sig");
            } else {
                try {
                    isSignatureValid = Utils.verifyPaymentSignature(options, keySecret);
                } catch (Exception e) {
                    System.err.println("Signature verification failed with exception: " + e.getMessage());
                }
            }

            if (isSignatureValid) {
                // Fetch payment record
                Payment payment = paymentDAO.getPaymentByOrderId(orderId);
                if (payment == null) {
                    response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                    jsonResponse.put("status", "error");
                    jsonResponse.put("message", "Payment record not found for the given order ID");
                    out.print(gson.toJson(jsonResponse));
                    return;
                }

                // Protect against duplicate activation (idempotency)
                if ("SUCCESS".equals(payment.getStatus())) {
                    MembershipPlan plan = planDAO.getPlanById(payment.getPlanId());
                    jsonResponse.put("status", "success");
                    jsonResponse.put("planName", plan != null ? plan.getPlanName() : "");
                    jsonResponse.put("amount", payment.getAmount());
                    jsonResponse.put("paymentId", payment.getRazorpayPaymentId());
                    out.print(gson.toJson(jsonResponse));
                    return;
                }

                // Update payment details in DB to SUCCESS
                paymentDAO.updatePaymentSuccess(orderId, paymentId, "SUCCESS");

                // Activate User Membership plan in database
                boolean activated = userDAO.updateUserPlan(payment.getUserId(), payment.getPlanId());

                if (activated) {
                    // Update user inside the session
                    User user = (User) session.getAttribute("user");
                    user.setPlanId(payment.getPlanId());
                    session.setAttribute("user", user);

                    MembershipPlan plan = planDAO.getPlanById(payment.getPlanId());

                    jsonResponse.put("status", "success");
                    jsonResponse.put("planName", plan != null ? plan.getPlanName() : "Premium");
                    jsonResponse.put("amount", payment.getAmount());
                    jsonResponse.put("paymentId", paymentId);
                    out.print(gson.toJson(jsonResponse));
                } else {
                    response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                    jsonResponse.put("status", "error");
                    jsonResponse.put("message", "Payment verified but membership activation failed in database");
                    out.print(gson.toJson(jsonResponse));
                }
            } else {
                // Verification failed
                paymentDAO.updatePaymentStatus(orderId, "FAILED");
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                jsonResponse.put("status", "error");
                jsonResponse.put("message", "Cryptographic signature verification failed");
                out.print(gson.toJson(jsonResponse));
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            jsonResponse.put("status", "error");
            jsonResponse.put("message", "Server error during verification: " + e.getMessage());
            out.print(gson.toJson(jsonResponse));
        }
    }
}
