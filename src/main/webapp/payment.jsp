<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.gym.dao.MembershipPlanDAO" %>
<%@ page import="com.gym.model.MembershipPlan" %>
<%@ page import="com.gym.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String planIdStr = request.getParameter("planId");
    MembershipPlan plan = null;
    if (planIdStr != null && !planIdStr.isEmpty()) {
        try {
            int planId = Integer.parseInt(planIdStr);
            MembershipPlanDAO planDAO = new MembershipPlanDAO();
            plan = planDAO.getPlanById(planId);
        } catch (NumberFormatException e) {
            // Invalid plan ID
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Checkout - PowerLift Gym</title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- Custom CSS -->
    <link rel="stylesheet" href="css/style.css">
    
    <style>
        .checkout-container {
            margin-top: 120px;
            margin-bottom: 80px;
        }
        
        .payment-card {
            background: rgba(10, 11, 16, 0.85);
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
            border: 1px solid rgba(0, 240, 255, 0.2);
            border-radius: 20px;
            padding: 2.5rem;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.5), 0 0 20px rgba(0, 240, 255, 0.1);
        }
        
        .order-summary {
            background: linear-gradient(135deg, rgba(0, 240, 255, 0.1) 0%, rgba(0, 119, 255, 0.05) 100%);
            border: 1px solid rgba(0, 240, 255, 0.3);
            border-radius: 15px;
            padding: 2rem;
            height: 100%;
        }
        
        .price-display {
            font-size: 2.5rem;
            font-weight: 800;
            color: var(--primary-color);
            text-shadow: 0 0 10px rgba(0, 240, 255, 0.5);
        }
        
        .nav-pills .nav-link {
            color: #ffffff;
            background: rgba(255, 255, 255, 0.05);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 10px;
            margin-right: 10px;
            padding: 1rem 1.5rem;
            transition: all 0.3s ease;
        }
        
        .nav-pills .nav-link.active {
            background: var(--gradient-primary);
            color: #0a0b10;
            border-color: transparent;
            font-weight: 700;
            box-shadow: 0 5px 15px rgba(0, 240, 255, 0.4);
        }
        
        .form-control-payment {
            background: rgba(0, 0, 0, 0.5);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 10px;
            padding: 0.8rem 1rem;
            color: #ffffff;
        }
        
        .form-control-payment:focus {
            background: rgba(0, 0, 0, 0.7);
            border-color: var(--primary-color);
            box-shadow: 0 0 15px rgba(0, 240, 255, 0.2);
            color: #ffffff;
        }
        
        .form-label {
            color: rgba(255, 255, 255, 0.8);
            font-size: 0.9rem;
            margin-bottom: 0.5rem;
        }
        
        .btn-pay {
            background: var(--gradient-primary);
            color: #0a0b10;
            border: none;
            padding: 1.2rem;
            font-size: 1.2rem;
            font-weight: 800;
            border-radius: 15px;
            text-transform: uppercase;
            letter-spacing: 2px;
            width: 100%;
            transition: all 0.3s ease;
            box-shadow: 0 10px 20px rgba(0, 240, 255, 0.3);
            margin-top: 2rem;
        }
        
        .btn-pay:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 30px rgba(0, 240, 255, 0.5);
            color: #ffffff;
        }
        
        .processing-overlay {
            position: fixed;
            top: 0; left: 0; right: 0; bottom: 0;
            background: rgba(10, 11, 16, 0.9);
            z-index: 9999;
            display: none;
            flex-direction: column;
            align-items: center;
            justify-content: center;
        }
        
        .spinner-glow {
            width: 80px;
            height: 80px;
            border: 5px solid rgba(0, 240, 255, 0.1);
            border-top: 5px solid var(--primary-color);
            border-radius: 50%;
            animation: spin 1s linear infinite;
            box-shadow: 0 0 20px rgba(0, 240, 255, 0.5);
            margin-bottom: 2rem;
        }
        
        .processing-text {
            font-size: 1.5rem;
            font-family: 'Orbitron', sans-serif;
            color: var(--primary-color);
            text-shadow: 0 0 10px rgba(0, 240, 255, 0.5);
            letter-spacing: 2px;
        }
        
        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
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
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item"><a class="nav-link" href="index.jsp">Home</a></li>
                    <li class="nav-item"><a class="nav-link" href="services.jsp">Services</a></li>
                    <li class="nav-item"><a class="nav-link" href="/profile">Dashboard</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Processing Overlay -->
    <div class="processing-overlay" id="processingOverlay">
        <div class="spinner-glow"></div>
        <div class="processing-text">PROCESSING PAYMENT...</div>
    </div>

    <div class="container checkout-container">
        <div class="text-center mb-5">
            <h1 class="text-gradient">SECURE CHECKOUT</h1>
            <p class="lead">Complete your membership purchase</p>
        </div>
        
        <% if (plan == null) { %>
            <div class="alert alert-danger text-center">
                Invalid Plan Selected. Please return to <a href="services.jsp">Services</a> and select a valid plan.
            </div>
        <% } else { %>
            <div class="row g-5">
                <!-- Payment Methods -->
                <div class="col-lg-7">
                    <div class="payment-card">
                        <h3 class="text-gradient mb-4">Payment Method</h3>
                        
                        <ul class="nav nav-pills mb-4" id="paymentTabs" role="tablist">
                            <li class="nav-item" role="presentation">
                                <button class="nav-link active" id="upi-tab" data-bs-toggle="pill" data-bs-target="#upi" type="button" role="tab">
                                    <i class="fas fa-mobile-alt me-2"></i>UPI
                                </button>
                            </li>
                            <li class="nav-item" role="presentation">
                                <button class="nav-link" id="card-tab" data-bs-toggle="pill" data-bs-target="#card" type="button" role="tab">
                                    <i class="far fa-credit-card me-2"></i>Credit/Debit Card
                                </button>
                            </li>
                        </ul>
                        
                        <div class="tab-content" id="paymentTabsContent">
                            <!-- UPI Form -->
                            <div class="tab-pane fade show active" id="upi" role="tabpanel">
                                <form id="upiForm" onsubmit="processPayment(event)">
                                    <div class="mb-4">
                                        <label class="form-label">Enter UPI ID</label>
                                        <div class="input-group">
                                            <span class="input-group-text bg-dark border-secondary text-light"><i class="fas fa-at"></i></span>
                                            <input type="text" class="form-control form-control-payment border-secondary" placeholder="username@upi" required>
                                        </div>
                                        <div class="form-text text-muted mt-2">You will receive a payment request on your UPI app.</div>
                                    </div>
                                    
                                    <div class="d-flex justify-content-center my-4">
                                        <img src="https://upload.wikimedia.org/wikipedia/commons/e/e1/UPI-Logo-vector.svg" alt="UPI" height="40" class="opacity-75">
                                    </div>
                                    
                                    <button type="submit" class="btn-pay">
                                        <i class="fas fa-lock me-2"></i>PAY ₹<%= String.format("%.0f", plan.getPrice()) %>
                                    </button>
                                </form>
                            </div>
                            
                            <!-- Card Form -->
                            <div class="tab-pane fade" id="card" role="tabpanel">
                                <form id="cardForm" onsubmit="processPayment(event)">
                                    <div class="mb-3">
                                        <label class="form-label">Cardholder Name</label>
                                        <input type="text" class="form-control form-control-payment" placeholder="JOHN DOE" required>
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Card Number</label>
                                        <div class="input-group">
                                            <span class="input-group-text bg-dark border-secondary text-light"><i class="far fa-credit-card"></i></span>
                                            <input type="text" class="form-control form-control-payment border-secondary" placeholder="0000 0000 0000 0000" maxlength="19" required>
                                        </div>
                                    </div>
                                    <div class="row g-3 mb-4">
                                        <div class="col-md-6">
                                            <label class="form-label">Expiry Date</label>
                                            <input type="text" class="form-control form-control-payment" placeholder="MM/YY" maxlength="5" required>
                                        </div>
                                        <div class="col-md-6">
                                            <label class="form-label">CVV</label>
                                            <input type="password" class="form-control form-control-payment" placeholder="***" maxlength="4" required>
                                        </div>
                                    </div>
                                    
                                    <div class="d-flex gap-2 my-4 opacity-50">
                                        <i class="fab fa-cc-visa fa-2x"></i>
                                        <i class="fab fa-cc-mastercard fa-2x"></i>
                                        <i class="fab fa-cc-amex fa-2x"></i>
                                    </div>
                                    
                                    <button type="submit" class="btn-pay">
                                        <i class="fas fa-lock me-2"></i>PAY ₹<%= String.format("%.0f", plan.getPrice()) %>
                                    </button>
                                </form>
                            </div>
                        </div>
                        
                    </div>
                </div>
                
                <!-- Order Summary -->
                <div class="col-lg-5">
                    <div class="order-summary">
                        <h3 class="text-gradient mb-4">Order Summary</h3>
                        
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <h4 class="mb-0 text-light"><%= plan.getPlanName() %></h4>
                            <span class="badge bg-primary rounded-pill"><%= plan.getDurationMonths() %> Months</span>
                        </div>
                        
                        <p class="text-muted border-bottom border-secondary pb-3 mb-4"><%= plan.getDescription() %></p>
                        
                        <div class="d-flex justify-content-between mb-2">
                            <span class="text-muted">Subtotal</span>
                            <span>₹<%= String.format("%.0f", plan.getPrice()) %></span>
                        </div>
                        <div class="d-flex justify-content-between mb-3 border-bottom border-secondary pb-3">
                            <span class="text-muted">Taxes & Fees</span>
                            <span>₹0</span>
                        </div>
                        
                        <div class="d-flex justify-content-between align-items-center mb-4">
                            <span class="fs-5">Total Due</span>
                            <span class="price-display">₹<%= String.format("%.0f", plan.getPrice()) %></span>
                        </div>
                        
                        <div class="mt-4 pt-4 border-top border-secondary">
                            <h6 class="text-primary mb-3"><i class="fas fa-check-circle me-2"></i>Plan Includes:</h6>
                            <ul class="list-unstyled text-muted">
                                <% for (String feature : plan.getFeatures()) { %>
                                    <li class="mb-2"><i class="fas fa-check text-success me-2"></i><%= feature %></li>
                                <% } %>
                            </ul>
                        </div>
                        
                        <div class="mt-4 text-center">
                            <i class="fas fa-shield-alt text-primary fa-2x mb-2"></i>
                            <p class="small text-muted mb-0">Secure 256-bit SSL Encryption<br>Guaranteed Safe Checkout</p>
                        </div>
                    </div>
                </div>
            </div>
        <% } %>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <!-- Razorpay Checkout Script -->
    <script src="https://checkout.razorpay.com/v1/checkout.js"></script>
    
    <script>
        function processPayment(event) {
            event.preventDefault();
            
            // Show processing overlay
            document.getElementById('processingOverlay').style.display = 'flex';
            document.querySelector('.processing-text').textContent = 'GENERATING ORDER...';

            const planId = '<%= plan != null ? plan.getId() : "" %>';
            const contextPath = '${pageContext.request.contextPath}';

            // 1. Call Backend Order Creation endpoint
            fetch(contextPath + '/api/payment/create-order?planId=' + planId, {
                method: 'POST'
            })
            .then(response => {
                if (!response.ok) {
                    throw new Error('Order creation failed with status ' + response.status);
                }
                return response.json();
            })
            .then(data => {
                if (data.status === 'success') {
                    document.getElementById('processingOverlay').style.display = 'none';
                    openRazorpayCheckout(data);
                } else {
                    throw new Error(data.message || 'Unknown error');
                }
            })
            .catch(error => {
                console.error('Payment initialization error:', error);
                document.getElementById('processingOverlay').style.display = 'none';
                alert('Payment initialization failed: ' + error.message);
            });
        }

        function openRazorpayCheckout(data) {
            if (data.orderId.startsWith("order_mock_")) {
                console.log("Mock Mode Active. Opening simulated checkout.");
                setTimeout(() => {
                    const confirmPayment = confirm(
                        "--- POWERLIFT GYM SANDBOX ---\n\n" +
                        "Razorpay Key ID is in test placeholder mode.\n" +
                        "Simulating Sandbox Checkout for: " + data.planName + " (₹" + (data.amount/100) + ")\n\n" +
                        "Click OK to Simulate SUCCESSFUL Payment\n" +
                        "Click CANCEL to Simulate CANCELLED Payment"
                    );
                    
                    if (confirmPayment) {
                        verifyPayment("pay_mock_" + Date.now(), data.orderId, "mock_sig");
                    } else {
                        cancelOrder(data.orderId);
                    }
                }, 100);
                return;
            }

            var options = {
                "key": data.keyId,
                "amount": data.amount,
                "currency": data.currency,
                "name": "PowerLift Gym",
                "description": data.planName + " Membership Subscription",
                "order_id": data.orderId,
                "handler": function (response) {
                    // Send details to verification endpoint
                    verifyPayment(response.razorpay_payment_id, response.razorpay_order_id, response.razorpay_signature);
                },
                "prefill": {
                    "name": data.userName,
                    "email": data.userEmail,
                    "contact": data.userPhone
                },
                "theme": {
                    "color": "#00f0ff"
                },
                "modal": {
                    "ondismiss": function() {
                        cancelOrder(data.orderId);
                    }
                }
            };
            
            var rzp1 = new Razorpay(options);
            rzp1.open();
        }

        function verifyPayment(paymentId, orderId, signature) {
            document.getElementById('processingOverlay').style.display = 'flex';
            document.querySelector('.processing-text').textContent = 'VERIFYING SIGNATURE...';
            
            const contextPath = '${pageContext.request.contextPath}';
            const params = new URLSearchParams();
            params.append('razorpay_payment_id', paymentId);
            params.append('razorpay_order_id', orderId);
            params.append('razorpay_signature', signature);
            
            fetch(contextPath + '/api/payment/verify', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
                body: params
            })
            .then(response => {
                if (!response.ok) {
                    throw new Error('Signature verification request failed');
                }
                return response.json();
            })
            .then(data => {
                document.getElementById('processingOverlay').style.display = 'none';
                if (data.status === 'success') {
                    window.location.href = contextPath + '/payment-result.jsp?status=success' +
                        '&plan=' + encodeURIComponent(data.planName) +
                        '&amount=' + encodeURIComponent(data.amount) +
                        '&paymentId=' + encodeURIComponent(data.paymentId);
                } else {
                    window.location.href = contextPath + '/payment-result.jsp?status=failed&message=' + encodeURIComponent(data.message || 'Verification failed');
                }
            })
            .catch(error => {
                console.error('Verification error:', error);
                document.getElementById('processingOverlay').style.display = 'none';
                window.location.href = contextPath + '/payment-result.jsp?status=failed&message=' + encodeURIComponent(error.message);
            });
        }

        function cancelOrder(orderId) {
            const contextPath = '${pageContext.request.contextPath}';
            const params = new URLSearchParams();
            params.append('razorpay_order_id', orderId);
            
            fetch(contextPath + '/api/payment/cancel', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
                body: params
            })
            .then(() => {
                window.location.href = contextPath + '/payment-result.jsp?status=cancelled';
            })
            .catch(err => {
                console.error('Error logging cancellation:', err);
                window.location.href = contextPath + '/payment-result.jsp?status=cancelled';
            });
        }
    </script>
</body>
</html>
