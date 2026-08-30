<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
    String status = request.getParameter("status");
    String planName = request.getParameter("plan");
    String amountStr = request.getParameter("amount");
    String paymentId = request.getParameter("paymentId");
    String message = request.getParameter("message");

    if (status == null || status.isEmpty()) {
        status = "failed";
    }

    String dateStr = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss").format(new Date());
    
    // Validity date (typically +1 month or depending on plan duration)
    String validityStr = new SimpleDateFormat("dd-MM-yyyy").format(new Date(System.currentTimeMillis() + 30L * 24L * 60L * 60L * 1000L));
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment Status - PowerLift Gym</title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- Custom CSS -->
    <link rel="stylesheet" href="css/style.css">
    
    <style>
        .result-container {
            margin-top: 150px;
            margin-bottom: 80px;
        }
        
        .result-card {
            background: rgba(10, 11, 16, 0.85);
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 20px;
            padding: 3rem;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.5);
            max-width: 600px;
            margin: 0 auto;
        }

        .result-card.success-border {
            border-color: rgba(40, 167, 69, 0.3);
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.5), 0 0 20px rgba(40, 167, 69, 0.1);
        }

        .result-card.failed-border {
            border-color: rgba(220, 53, 69, 0.3);
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.5), 0 0 20px rgba(220, 53, 69, 0.1);
        }

        .result-card.cancelled-border {
            border-color: rgba(255, 193, 7, 0.3);
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.5), 0 0 20px rgba(255, 193, 7, 0.1);
        }
        
        .receipt-details {
            background: rgba(0, 0, 0, 0.4);
            border: 1px solid rgba(255, 255, 255, 0.08);
            border-radius: 12px;
            padding: 1.5rem;
            text-align: left;
            margin: 2rem 0;
        }

        .receipt-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 0.8rem;
            border-bottom: 1px dashed rgba(255, 255, 255, 0.05);
            padding-bottom: 0.5rem;
        }

        .receipt-row:last-child {
            border-bottom: none;
            margin-bottom: 0;
            padding-bottom: 0;
        }

        .receipt-label {
            color: #a0aab2;
        }

        .receipt-value {
            color: #ffffff;
            font-weight: 600;
        }
        
        .btn-action {
            background: var(--gradient-primary);
            color: #0a0b10;
            border: none;
            padding: 0.8rem 2rem;
            font-weight: 700;
            border-radius: 10px;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-block;
        }
        
        .btn-action:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 240, 255, 0.4);
            color: #ffffff;
        }

        .btn-secondary-action {
            background: rgba(255, 255, 255, 0.08);
            color: #ffffff;
            border: 1px solid rgba(255, 255, 255, 0.15);
            padding: 0.8rem 2rem;
            font-weight: 700;
            border-radius: 10px;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-block;
        }

        .btn-secondary-action:hover {
            background: rgba(255, 255, 255, 0.15);
            color: #ffffff;
        }
    </style>
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark glass fixed-top">
        <div class="container">
            <a class="navbar-brand" href="index.jsp">
                <i class="fas fa-dumbbell"></i> PowerLift Gym
            </a>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item"><a class="nav-link" href="index.jsp">Home</a></li>
                    <li class="nav-item"><a class="nav-link" href="services.jsp">Services</a></li>
                    <li class="nav-item"><a class="nav-link" href="/profile">Dashboard</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container result-container text-center">
        <% if ("success".equalsIgnoreCase(status)) { %>
            <!-- SUCCESS VIEW -->
            <div class="result-card success-border">
                <i class="fas fa-check-circle text-success fa-5x mb-4"></i>
                <h2 class="text-success mb-2">Payment Successful</h2>
                <h4 class="text-light mb-4">Membership Activated</h4>
                <p class="text-muted">Thank you for subscribing! Your membership plan is now active.</p>
                
                <div class="receipt-details">
                    <div class="receipt-row">
                        <span class="receipt-label">Membership Plan</span>
                        <span class="receipt-value"><%= planName != null ? planName : "Standard" %></span>
                    </div>
                    <div class="receipt-row">
                        <span class="receipt-label">Amount Paid</span>
                        <span class="receipt-value">₹<%= amountStr != null ? amountStr : "0" %></span>
                    </div>
                    <div class="receipt-row">
                        <span class="receipt-label">Payment ID</span>
                        <span class="receipt-value"><%= paymentId != null ? paymentId : "N/A" %></span>
                    </div>
                    <div class="receipt-row">
                        <span class="receipt-label">Date & Time</span>
                        <span class="receipt-value"><%= dateStr %></span>
                    </div>
                    <div class="receipt-row">
                        <span class="receipt-label">Valid Until</span>
                        <span class="receipt-value text-success"><%= validityStr %></span>
                    </div>
                </div>
                
                <a href="dashboard.jsp" class="btn-action">GO TO DASHBOARD</a>
            </div>
            
        <% } else if ("cancelled".equalsIgnoreCase(status)) { %>
            <!-- CANCELLED VIEW -->
            <div class="result-card cancelled-border">
                <i class="fas fa-exclamation-triangle text-warning fa-5x mb-4"></i>
                <h2 class="text-warning mb-2">Payment Cancelled</h2>
                <p class="text-muted mb-4">The payment request was cancelled by the user. If this was an accident, you can retry.</p>
                
                <div class="d-flex justify-content-center gap-3">
                    <a href="services.jsp" class="btn-action">TRY AGAIN</a>
                    <a href="dashboard.jsp" class="btn-secondary-action">BACK TO DASHBOARD</a>
                </div>
            </div>
            
        <% } else { %>
            <!-- FAILED VIEW -->
            <div class="result-card failed-border">
                <i class="fas fa-times-circle text-danger fa-5x mb-4"></i>
                <h2 class="text-danger mb-2">Payment Failed</h2>
                <p class="text-muted mb-4">
                    <%= message != null ? message : "We couldn't process your payment. Please verify your details or try another payment method." %>
                </p>
                
                <div class="d-flex justify-content-center gap-3">
                    <a href="services.jsp" class="btn-action">RETRY PAYMENT</a>
                    <a href="dashboard.jsp" class="btn-secondary-action">BACK TO DASHBOARD</a>
                </div>
            </div>
        <% } %>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
