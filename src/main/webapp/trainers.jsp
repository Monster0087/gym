<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.gym.dao.TrainerDAO, java.util.List" %>
<%@ page import="com.gym.model.Trainer" %>
<%@ page import="com.gym.model.User" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Powerlift - Our Trainers</title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- Custom CSS -->
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/animations.css">
    
    <style>
        .page-header {
            padding: 150px 0 80px;
            background: linear-gradient(rgba(0, 0, 0, 0.8), rgba(0, 0, 0, 0.8)),
                        url('https://images.unsplash.com/photo-1570129477492-45c003edd2be?ixlib=rb-4.0.3&auto=format&fit=crop&w=1920&q=80') center/cover no-repeat;
            text-align: center;
        }

        .trainer-image {
            width: 100% !important;
            height: 400px !important;
            border-radius: 15px !important;
            object-fit: cover !important;
            object-position: center 20% !important;
            margin-bottom: 1.5rem !important;
            border: 2px solid var(--primary-color) !important;
            transition: all 0.5s ease !important;
        }

        .trainer-card:hover .trainer-image {
            transform: scale(1.02) !important;
            border-color: #fff !important;
            box-shadow: 0 0 25px var(--primary-color) !important;
        }

        .trainer-card {
            padding: 1.2rem !important;
            background: rgba(10, 11, 16, 0.9) !important;
        }
        /* ❌ NO BLUR - MAXIMUM SHARPNESS */
        * {
            backdrop-filter: none !important;
            -webkit-backdrop-filter: none !important;
            filter: none !important;
        }

        .glass, .glass-dark, .card-custom, .navbar.scrolled, .trainer-card {
            background: rgba(10, 11, 16, 0.95) !important;
            border: 1px solid rgba(0, 240, 255, 0.2) !important;
        }
    </style>
</head>
<body>
    <jsp:include page="components/navbar.jsp" />

    <!-- Page Header -->
    <header class="page-header">
        <div class="container">
            <h1 class="text-gradient display-3">OUR TRAINERS</h1>
            <p class="lead ">Meet the experts who will help you achieve your goals</p>
        </div>
    </header>

    <!-- Trainers Section -->
    <section class="py-5">
        <div class="container">
            <div class="row g-4 mt-3">
                <%
                    TrainerDAO trainerDAO = new TrainerDAO();
                    List<Trainer> trainers = trainerDAO.getAllActiveTrainers();
                    
                    if(trainers != null && !trainers.isEmpty()) {
                        for (Trainer trainer : trainers) {
                %>
                <div class="col-md-4 col-lg-3">
                    <div class="trainer-card card-custom animate-on-scroll h-100 d-flex flex-column">
                        <img src="<%= trainer.getImageUrl() != null && !trainer.getImageUrl().isEmpty() ? trainer.getImageUrl() : "https://images.unsplash.com/photo-1583454110551-21f2fa2afe61?ixlib=rb-4.0.3&auto=format&fit=crop&w=300&q=80" %>" 
                             alt="<%= trainer.getName() %>" class="trainer-image mx-auto mt-3">
                        <h4 class="mt-3"><%= trainer.getName() %></h4>
                        <p class="text-primary fw-bold"><%= trainer.getSpecialization() %></p>
                        <p class="mb-1"><i class="fas fa-calendar-alt me-2 text-primary"></i><%= trainer.getExperienceYears() %> years experience</p>
                        <% if(trainer.getPhone() != null && !trainer.getPhone().isEmpty()) { %>
                        <p class="small mb-1"><i class="fas fa-phone me-2 text-primary"></i><%= trainer.getPhone() %></p>
                        <% } %>
                        <% if(trainer.getEmail() != null && !trainer.getEmail().isEmpty()) { %>
                        <p class="small mb-3"><i class="fas fa-envelope me-2 text-primary"></i><%= trainer.getEmail() %></p>
                        <% } %>
                        <div class="mt-auto">
                           <a href="${pageContext.request.contextPath}/book-session.jsp?trainerId=<%= trainer.getId() %>" class="btn btn-outline-custom btn-sm w-100">BOOK SESSION</a>
                        </div>
                    </div>
                </div>
                <%
                        }
                    } else {
                %>
                <div class="col-12 text-center py-5">
                    <h3 class="text-muted">Currently, there are no active trainers available.</h3>
                </div>
                <%
                    }
                %>
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


