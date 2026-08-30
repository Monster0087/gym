<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.gym.dao.TrainerDAO, com.gym.dao.TestimonialDAO, java.util.List" %>
<%@ page import="com.gym.model.Trainer, com.gym.model.Testimonial" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Powerlift - Transform Your Body</title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- Custom CSS -->
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/animations.css">
    
    <style>
        .hero {
            background: linear-gradient(rgba(0, 0, 0, 0.7), rgba(0, 0, 0, 0.7)),
                        url('https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?ixlib=rb-4.0.3&auto=format&fit=crop&w=1920&q=80') center/cover no-repeat;
            background-attachment: fixed;
        }
        
        /* ❌ NO BLUR - MAXIMUM SHARPNESS */
        * {
            backdrop-filter: none !important;
            -webkit-backdrop-filter: none !important;
            filter: none !important;
        }

        .glass, .glass-dark, .card-custom, .navbar.scrolled, .testimonial-card {
            background: rgba(10, 11, 16, 0.95) !important;
            border: 1px solid rgba(0, 240, 255, 0.2) !important;
        }
    </style>
</head>
<body>
    <jsp:include page="components/navbar.jsp" />

    <!-- Hero Section -->
    <section id="home" class="hero">
        <div class="container">
            <div class="hero-content">
                <h1 class="hero-title text-gradient">TRANSFORM YOUR BODY</h1>
                <p class="hero-subtitle">Build Strength, Gain Confidence, Change Your Life</p>
                <div class="hero-buttons">
                    <% if (session.getAttribute("user") != null) { %>
                        <a href="${pageContext.request.contextPath}/dashboard.jsp" class="btn btn-primary-custom me-3">MY DASHBOARD</a>
                    <% } else { %>
                        <a href="${pageContext.request.contextPath}/register.jsp" class="btn btn-primary-custom me-3">JOIN NOW</a>
                    <% } %>
                    <a href="#features" class="btn btn-outline-custom">LEARN MORE</a>
                </div>
            </div>
        </div>
    </section>

    <!-- Features Section -->
    <section id="features" class="py-5">
        <div class="container">
            <div class="text-center mb-5">
                <h2 class="text-gradient">WHY CHOOSE US</h2>
                <p class="lead">Experience the best fitness facilities and training</p>
            </div>
            
            <div class="row g-4">
                <div class="col-md-4">
                    <div class="card-custom animate-on-scroll">
                        <div class="feature-icon">
                            <i class="fas fa-dumbbell"></i>
                        </div>
                        <h3 class="card-title-custom">Premium Equipment</h3>
                        <p>State-of-the-art fitness equipment from leading brands for optimal workout experience.</p>
                    </div>
                </div>
                
                <div class="col-md-4">
                    <div class="card-custom animate-on-scroll">
                        <div class="feature-icon">
                            <i class="fas fa-user-tie"></i>
                        </div>
                        <h3 class="card-title-custom">Expert Trainers</h3>
                        <p>Certified professional trainers to guide you through your fitness journey.</p>
                    </div>
                </div>
                
                <div class="col-md-4">
                    <div class="card-custom animate-on-scroll">
                        <div class="feature-icon">
                            <i class="fas fa-apple-alt"></i>
                        </div>
                        <h3 class="card-title-custom">Nutrition Plans</h3>
                        <p>Personalized diet and nutrition plans to complement your workout routine.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Trainers Section -->
    <section class="py-5">
        <div class="container">
            <div class="text-center mb-5">
                <h2 class="text-gradient">MEET OUR TRAINERS</h2>
                <p class="lead">Learn from the best in the industry</p>
            </div>
            
            <div class="row g-4">
                <%
                    TrainerDAO trainerDAO = new TrainerDAO();
                    List<Trainer> trainers = trainerDAO.getFeaturedTrainers(4);
                    for (Trainer trainer : trainers) {
                %>
                <div class="col-md-3">
                    <div class="trainer-card card-custom animate-on-scroll">
                        <img src="<%= trainer.getImageUrl() != null && !trainer.getImageUrl().trim().isEmpty() ? trainer.getImageUrl() : "https://images.unsplash.com/photo-1597452485669-2c7bb5fef90d?ixlib=rb-4.0.3&auto=format&fit=crop&w=300&q=80" %>" 
                             alt="<%= trainer.getName() %>" class="trainer-image">
                        <h4><%= trainer.getName() %></h4>
                        <p class="text-primary"><%= trainer.getSpecialization() %></p>
                        <p><%= trainer.getExperienceYears() %> years experience</p>
                    </div>
                </div>
                <%
                    }
                %>
            </div>
        </div>
    </section>

    <!-- Testimonials Section -->
    <section class="py-5">
        <div class="container">
            <div class="text-center mb-5">
                <h2 class="text-gradient">CLIENT TESTIMONIALS</h2>
                <p class="lead">Real stories from real members</p>
            </div>
            
            <div class="row g-4">
                <%
                    TestimonialDAO testimonialDAO = new TestimonialDAO();
                    List<Testimonial> testimonials = testimonialDAO.getFeaturedTestimonials();
                    for (Testimonial testimonial : testimonials) {
                %>
                <div class="col-md-4">
                    <div class="testimonial-card animate-on-scroll">
                        <div class="rating mb-3">
                            <%
                                for (int i = 0; i < testimonial.getRating(); i++) {
                            %>
                            <i class="fas fa-star"></i>
                            <%
                                }
                            %>
                        </div>
                        <p class="mb-3">"<%= testimonial.getTestimonialText() %>"</p>
                        <div class="d-flex align-items-center">
                            <img src="<%= testimonial.getClientImage() != null && !testimonial.getClientImage().trim().isEmpty() ? testimonial.getClientImage() : (testimonial.getId() == 1 ? "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?ixlib=rb-4.0.3&auto=format&fit=crop&w=50&q=80" : (testimonial.getId() == 2 ? "https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-4.0.3&auto=format&fit=crop&w=50&q=80" : "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixlib=rb-4.0.3&auto=format&fit=crop&w=50&q=80")) %>" 
                                 alt="<%= testimonial.getClientName() %>" class="rounded-circle me-3" width="50" height="50">
                            <div>
                                <h6 class="mb-0"><%= testimonial.getClientName() %></h6>
                                <small class="text-muted">Premium Member</small>
                            </div>
                        </div>
                    </div>
                </div>
                <%
                    }
                %>
            </div>
        </div>
    </section>

    <!-- CTA Section -->
    <section class="py-5">
        <div class="container">
            <div class="glass-dark text-center p-5">
                <h2 class="text-gradient mb-4 animate-heading">READY TO START YOUR JOURNEY?</h2>
                <p class="lead mb-4">Join us today and transform your life</p>
                <% if (session.getAttribute("user") != null) { %>
                    <a href="${pageContext.request.contextPath}/dashboard.jsp" class="btn btn-primary-custom btn-lg">VIEW DASHBOARD</a>
                <% } else { %>
                    <a href="${pageContext.request.contextPath}/register.jsp" class="btn btn-primary-custom btn-lg">GET STARTED NOW</a>
                <% } %>
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


