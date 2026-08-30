<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.gym.dao.MembershipPlanDAO, java.util.List" %>
<%@ page import="com.gym.model.MembershipPlan" %>
<%@ page import="com.gym.model.User" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Services - PowerLift Gym</title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- Custom CSS -->
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/animations.css">
    
    <style>
        .services-hero {
            background: linear-gradient(rgba(0, 0, 0, 0.7), rgba(0, 0, 0, 0.7)),
                        url('https://images.unsplash.com/photo-1534258936925-c58bed479fcb?ixlib=rb-4.0.3&auto=format&fit=crop&w=1920&q=80') center/cover no-repeat;
            background-attachment: fixed;
            min-height: 50vh;
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;
        }
        
        .services-content {
            text-align: center;
            z-index: 2;
        }
        
        .services-title {
            font-size: 3.5rem;
            font-weight: 900;
            margin-bottom: 1rem;
            text-shadow: 2px 2px 10px rgba(0, 240, 255, 0.3);
            color: #ffffff;
            font-family: 'Orbitron', sans-serif;
        }
        
        .pricing-card {
            background: rgba(10, 11, 16, 0.95);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 20px;
            padding: 2.5rem 2rem;
            text-align: center;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
            height: 100%;
        }
        
        .pricing-card.featured {
            border: 2px solid #ff0000;
            transform: scale(1.05);
            box-shadow: 0 20px 40px rgba(255, 0, 0, 0.3);
        }
        
        .pricing-card.featured::before {
            content: 'MOST POPULAR';
            position: absolute;
            top: 20px;
            right: -30px;
            background: #ff0000;
            color: white;
            padding: 5px 40px;
            font-size: 0.8rem;
            font-weight: 600;
            transform: rotate(45deg);
        }
        
        .pricing-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 25px 50px rgba(255, 0, 0, 0.2);
            border-color: #ff0000;
        }
        
        .pricing-card.featured:hover {
            transform: scale(1.05) translateY(-10px);
        }
        
        .plan-name {
            font-size: 1.8rem;
            font-weight: 700;
            color: #ff0000;
            margin-bottom: 1rem;
        }
        
        .plan-price {
            font-size: 3rem;
            font-weight: 900;
            color: #ffffff;
            margin-bottom: 0.5rem;
        }
        
        .plan-price span {
            font-size: 1rem;
            color: rgba(255, 255, 255, 0.6);
        }
        
        .plan-duration {
            color: rgba(255, 255, 255, 0.6);
            margin-bottom: 2rem;
        }
        
        .plan-description {
            color: rgba(255, 255, 255, 0.9) !important;
            font-size: 1.05rem;
            margin-bottom: 1.5rem;
            min-height: 3rem;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        .plan-features {
            list-style: none;
            padding: 0;
            margin-bottom: 2rem;
            text-align: left;
        }
        
        .plan-features li {
            padding: 0.8rem 0;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
            display: flex;
            align-items: center;
        }
        
        .plan-features li:last-child {
            border-bottom: none;
        }
        
        .plan-features i {
            color: #00ff00;
            margin-right: 1rem;
            font-size: 1.2rem;
        }
        
        .btn-plan {
            background: linear-gradient(135deg, #ff0000 0%, #cc0000 100%);
            color: #ffffff;
            border: none;
            padding: 1rem 2rem;
            font-size: 1.1rem;
            font-weight: 600;
            border-radius: 50px;
            text-transform: uppercase;
            letter-spacing: 1px;
            transition: all 0.3s ease;
            width: 100%;
            box-shadow: 0 10px 30px rgba(255, 0, 0, 0.3);
        }
        
        .btn-plan:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 40px rgba(255, 0, 0, 0.4);
            color: #ffffff;
        }
        
        .btn-outline-plan {
            background: transparent;
            color: #ff0000;
            border: 2px solid #ff0000;
            padding: 1rem 2rem;
            font-size: 1.1rem;
            font-weight: 600;
            border-radius: 50px;
            text-transform: uppercase;
            letter-spacing: 1px;
            transition: all 0.3s ease;
            width: 100%;
        }
        
        .btn-outline-plan:hover {
            background: linear-gradient(135deg, #ff0000 0%, #cc0000 100%);
            color: #ffffff;
            transform: translateY(-3px);
            box-shadow: 0 15px 40px rgba(255, 0, 0, 0.4);
        }
        
        .service-feature {
            background: rgba(255, 255, 255, 0.05);
            backdrop-filter: blur(15px);
            -webkit-backdrop-filter: blur(15px);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 20px;
            padding: 2rem;
            text-align: center;
            transition: all 0.3s ease;
            height: 100%;
        }
        
        .service-feature:hover {
            transform: translateY(-10px);
            box-shadow: 0 20px 40px rgba(255, 0, 0, 0.2);
            border-color: #ff0000;
        }
        
        .service-icon {
            width: 80px;
            height: 80px;
            background: linear-gradient(135deg, #ff0000 0%, #cc0000 100%);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 1.5rem;
            font-size: 2rem;
            color: #ffffff;
            transition: all 0.3s ease;
        }
        
        .service-feature:hover .service-icon {
            transform: scale(1.1) rotate(360deg);
            box-shadow: 0 10px 30px rgba(255, 0, 0, 0.4);
        }
        
        .comparison-table {
            background: rgba(255, 255, 255, 0.05);
            backdrop-filter: blur(15px);
            -webkit-backdrop-filter: blur(15px);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 20px;
            padding: 2rem;
            overflow-x: auto;
        }
        
        .comparison-table table {
            width: 100%;
            color: #ffffff;
        }
        
        .comparison-table th {
            background: rgba(255, 0, 0, 0.2);
            padding: 1rem;
            text-align: center;
            font-weight: 600;
            border: 1px solid rgba(255, 255, 255, 0.1);
        }
        
        .comparison-table td {
            padding: 1rem;
            text-align: center;
            border: 1px solid rgba(255, 255, 255, 0.1);
        }
        
        .comparison-table .feature-name {
            text-align: left;
            font-weight: 500;
        }
        
        .check-icon {
            color: #00ff00;
            font-size: 1.2rem;
        }
        
        .cross-icon {
            color: #ff4444;
            font-size: 1.2rem;
        }
        
        @media (max-width: 768px) {
            .pricing-card.featured {
                transform: scale(1);
            }
            
            .services-title {
                font-size: 2.5rem;
            }
            
            .plan-price {
                font-size: 2rem;
            }
        }
        /* ❌ NO BLUR - MAXIMUM SHARPNESS */
        * {
            backdrop-filter: none !important;
            -webkit-backdrop-filter: none !important;
            filter: none !important;
        }

        .glass, .glass-dark, .card-custom, .navbar.scrolled, .pricing-card, .service-feature, .comparison-table {
            background: rgba(10, 11, 16, 0.95) !important;
            border: 1px solid rgba(0, 240, 255, 0.2) !important;
        }
    </style>
</head>
<body>
    <jsp:include page="components/navbar.jsp" />

    <!-- Services Hero -->
    <section class="services-hero">
        <div class="container">
            <div class="services-content">
                <h1 class="services-title text-gradient">OUR SERVICES</h1>
                <p class="lead ">Choose the perfect membership plan for your fitness journey</p>
            </div>
        </div>
    </section>

    <!-- Membership Plans -->
    <section class="py-5">
        <div class="container">
            <div class="text-center mb-5">
                <h2 class="text-gradient">MEMBERSHIP PLANS</h2>
                <p class="lead">Select the plan that fits your goals and lifestyle</p>
            </div>
            
            <div class="row g-4 align-items-center">
                <%
                    MembershipPlanDAO planDAO = new MembershipPlanDAO();
                    List<MembershipPlan> plans = planDAO.getAllActivePlans();
                    int planCount = 0;
                    for (MembershipPlan plan : plans) {
                        planCount++;
                        boolean isFeatured = planCount == 2; // Make the second plan featured
                %>
                <div class="col-md-4">
                    <div class="pricing-card <%= isFeatured ? "featured" : "" %> animate-on-scroll">
                        <h3 class="plan-name"><%= plan.getPlanName() %></h3>
                        <div class="plan-price">
                            ₹<%= String.format("%.0f", plan.getPrice()) %>
                            <span>/month</span>
                        </div>
                        <div class="plan-duration"><%= plan.getDurationMonths() %> month<%= plan.getDurationMonths() > 1 ? "s" : "" %> commitment</div>
                        
                        <p class="plan-description"><%= plan.getDescription() %></p>
                        
                        <ul class="plan-features">
                            <%
                                if (plan.getFeatures() != null) {
                                    for (String feature : plan.getFeatures()) {
                            %>
                            <li>
                                <i class="fas fa-check-circle"></i>
                                <%= feature %>
                            </li>
                            <%
                                    }
                                }
                            %>
                        </ul>
                        
                        <%
                            if (session.getAttribute("user") != null) {
                        %>
                        <a href="${pageContext.request.contextPath}/payment.jsp?planId=<%= plan.getId() %>" class="btn <%= isFeatured ? "btn-plan" : "btn-outline-plan" %>">
                            <%= isFeatured ? "UPGRADE NOW" : "SELECT PLAN" %>
                        </a>
                        <%
                            } else {
                        %>
                        <a href="${pageContext.request.contextPath}/login.jsp" class="btn <%= isFeatured ? "btn-plan" : "btn-outline-plan" %>">
                            <%= isFeatured ? "GET STARTED" : "SELECT PLAN" %>
                        </a>
                        <%
                            }
                        %>
                    </div>
                </div>
                <%
                    }
                %>
            </div>
        </div>
    </section>

    <!-- Additional Services -->
    <section class="py-5">
        <div class="container">
            <div class="text-center mb-5">
                <h2 class="text-gradient">ADDITIONAL SERVICES</h2>
                <p class="lead">Enhance your fitness journey with our specialized offerings</p>
            </div>
            
            <div class="row g-4">
                <div class="col-md-4">
                    <div class="service-feature animate-on-scroll">
                        <div class="service-icon">
                            <i class="fas fa-user-tie"></i>
                        </div>
                        <h4>Personal Training</h4>
                        <p>One-on-one sessions with certified trainers to create personalized workout plans and achieve your specific goals faster.</p>
                        <ul class="list-unstyled text-start">
                            <li><i class="fas fa-check text-success me-2"></i>Custom workout plans</li>
                            <li><i class="fas fa-check text-success me-2"></i>Nutritional guidance</li>
                            <li><i class="fas fa-check text-success me-2"></i>Progress tracking</li>
                            <li><i class="fas fa-check text-success me-2"></i>Flexible scheduling</li>
                        </ul>
                        <a href="${pageContext.request.contextPath}/services/personal-training.jsp" class="btn btn-outline-custom mt-3">Book Session</a>
                    </div>
                </div>
                
                <div class="col-md-4">
                    <div class="service-feature animate-on-scroll">
                        <div class="service-icon">
                            <i class="fas fa-apple-alt"></i>
                        </div>
                        <h4>Nutrition & Diet Plans</h4>
                        <p>Professional nutrition counseling and personalized diet plans to complement your fitness routine and maximize results.</p>
                        <ul class="list-unstyled text-start">
                            <li><i class="fas fa-check text-success me-2"></i>Custom meal plans</li>
                            <li><i class="fas fa-check text-success me-2"></i>Supplement guidance</li>
                            <li><i class="fas fa-check text-success me-2"></i>Weight management</li>
                            <li><i class="fas fa-check text-success me-2"></i>Regular consultations</li>
                        </ul>
                        <a href="${pageContext.request.contextPath}/services/nutrition-diet.jsp" class="btn btn-outline-custom mt-3">Get Consultation</a>
                    </div>
                </div>
                
                <div class="col-md-4">
                    <div class="service-feature animate-on-scroll">
                        <div class="service-icon">
                            <i class="fas fa-users"></i>
                        </div>
                        <h4>Group Classes</h4>
                        <p>Energizing group fitness classes led by expert instructors in a motivating group environment.</p>
                        <ul class="list-unstyled text-start">
                            <li><i class="fas fa-check text-success me-2"></i>Yoga & Pilates</li>
                            <li><i class="fas fa-check text-success me-2"></i>HIIT & Cardio</li>
                            <li><i class="fas fa-check text-success me-2"></i>Strength training</li>
                            <li><i class="fas fa-check text-success me-2"></i>Dance fitness</li>
                        </ul>
                        <a href="${pageContext.request.contextPath}/services/group-classes.jsp" class="btn btn-outline-custom mt-3">View Schedule</a>
                    </div>
                </div>
            </div>
            
            <div class="row g-4 mt-2">
                <div class="col-md-4">
                    <div class="service-feature animate-on-scroll">
                        <div class="service-icon">
                            <i class="fas fa-spa"></i>
                        </div>
                        <h4>Recovery & Wellness</h4>
                        <p>Recovery services including massage therapy, sauna, and wellness treatments to help your body heal and rejuvenate.</p>
                        <ul class="list-unstyled text-start">
                            <li><i class="fas fa-check text-success me-2"></i>Deep tissue massage</li>
                            <li><i class="fas fa-check text-success me-2"></i>Sauna & steam room</li>
                            <li><i class="fas fa-check text-success me-2"></i>Cold plunge therapy</li>
                            <li><i class="fas fa-check text-success me-2"></i>Stretching sessions</li>
                        </ul>
                        <a href="${pageContext.request.contextPath}/services/recovery-wellness.jsp" class="btn btn-outline-custom mt-3">Book Service</a>
                    </div>
                </div>
                
                <div class="col-md-4">
                    <div class="service-feature animate-on-scroll">
                        <div class="service-icon">
                            <i class="fas fa-mobile-alt"></i>
                        </div>
                        <h4>Virtual Training</h4>
                        <p>Online training programs and virtual coaching for those who prefer to work out from home or while traveling.</p>
                        <ul class="list-unstyled text-start">
                            <li><i class="fas fa-check text-success me-2"></i>Live virtual classes</li>
                            <li><i class="fas fa-check text-success me-2"></i>App-based workouts</li>
                            <li><i class="fas fa-check text-success me-2"></i>Video consultations</li>
                            <li><i class="fas fa-check text-success me-2"></i>Remote progress tracking</li>
                        </ul>
                        <a href="${pageContext.request.contextPath}/services/virtual-training.jsp" class="btn btn-outline-custom mt-3">Start Virtual</a>
                    </div>
                </div>
                
                <div class="col-md-4">
                    <div class="service-feature animate-on-scroll">
                        <div class="service-icon">
                            <i class="fas fa-trophy"></i>
                        </div>
                        <h4>Corporate Wellness</h4>
                        <p>Corporate wellness programs for businesses looking to improve employee health and productivity.</p>
                        <ul class="list-unstyled text-start">
                            <li><i class="fas fa-check text-success me-2"></i>Corporate memberships</li>
                            <li><i class="fas fa-check text-success me-2"></i>On-site fitness classes</li>
                            <li><i class="fas fa-check text-success me-2"></i>Wellness workshops</li>
                            <li><i class="fas fa-check text-success me-2"></i>Team building activities</li>
                        </ul>
                        <a href="${pageContext.request.contextPath}/services/corporate-wellness.jsp" class="btn btn-outline-custom mt-3">Learn More</a>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Plan Comparison -->
    <section class="py-5">
        <div class="container">
            <div class="text-center mb-5">
                <h2 class="text-gradient">PLAN COMPARISON</h2>
                <p class="lead">Compare features across all membership plans</p>
            </div>
            
            <div class="comparison-table">
                <table class="table table-dark table-hover table-dark table-hover">
                    <thead>
                        <tr>
                            <th>Features</th>
                            <%
                                for (MembershipPlan plan : plans) {
                            %>
                            <th><%= plan.getPlanName() %></th>
                            <%
                                }
                            %>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td class="feature-name">Gym Equipment Access</td>
                            <%
                                for (MembershipPlan plan : plans) {
                            %>
                            <td><i class="fas fa-check-circle check-icon"></i></td>
                            <%
                                }
                            %>
                        </tr>
                        <tr>
                            <td class="feature-name">Group Fitness Classes</td>
                            <td><i class="fas fa-times-circle cross-icon"></i></td>
                            <td><i class="fas fa-check-circle check-icon"></i></td>
                            <td><i class="fas fa-check-circle check-icon"></i></td>
                        </tr>
                        <tr>
                            <td class="feature-name">Personal Training</td>
                            <td><i class="fas fa-times-circle cross-icon"></i></td>
                            <td><i class="fas fa-check-circle check-icon"></i></td>
                            <td><i class="fas fa-check-circle check-icon"></i></td>
                        </tr>
                        <tr>
                            <td class="feature-name">Nutrition Guidance</td>
                            <td><i class="fas fa-times-circle cross-icon"></i></td>
                            <td><i class="fas fa-check-circle check-icon"></i></td>
                            <td><i class="fas fa-check-circle check-icon"></i></td>
                        </tr>
                        <tr>
                            <td class="feature-name">Sauna Access</td>
                            <td><i class="fas fa-times-circle cross-icon"></i></td>
                            <td><i class="fas fa-times-circle cross-icon"></i></td>
                            <td><i class="fas fa-check-circle check-icon"></i></td>
                        </tr>
                        <tr>
                            <td class="feature-name">Guest Privileges</td>
                            <td><i class="fas fa-times-circle cross-icon"></i></td>
                            <td><i class="fas fa-times-circle cross-icon"></i></td>
                            <td><i class="fas fa-check-circle check-icon"></i></td>
                        </tr>
                        <tr>
                            <td class="feature-name">24/7 Access</td>
                            <td><i class="fas fa-times-circle cross-icon"></i></td>
                            <td><i class="fas fa-times-circle cross-icon"></i></td>
                            <td><i class="fas fa-check-circle check-icon"></i></td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </section>

    <!-- CTA Section -->
    <section class="py-5">
        <div class="container">
            <div class="text-center">
                <h2 class="text-gradient mb-4">NOT SURE WHICH PLAN TO CHOOSE?</h2>
                <p class="lead mb-4">Schedule a free consultation with one of our fitness experts</p>
                <a href="${pageContext.request.contextPath}/contact.jsp" class="btn btn-primary-custom btn-lg">GET FREE CONSULTATION</a>
            </div>
        </div>
    </section>

    <jsp:include page="components/footer.jsp" />

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <!-- Custom JS -->
    <script src="js/script.js"></script>
</body>
</html>


