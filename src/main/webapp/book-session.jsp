<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.gym.dao.TrainerDAO, com.gym.model.Trainer, com.gym.model.User" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book Session - PowerLift Gym</title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600;800&family=Orbitron:wght@700;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="css/style.css">
    
    <style>
        body {
            font-family: 'Outfit', sans-serif;
            background: #0a0b10;
            color: #fff;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }
        
        .booking-container {
            margin-top: 120px;
            margin-bottom: 80px;
            flex: 1;
        }
        
        .glass-card {
            background: rgba(26, 28, 41, 0.8);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(0, 240, 255, 0.2);
            border-radius: 30px;
            padding: 3rem;
            box-shadow: 0 25px 60px rgba(0, 0, 0, 0.5);
        }
        
        .trainer-preview {
            text-align: center;
            padding: 2rem;
            background: rgba(255, 255, 255, 0.03);
            border-radius: 24px;
            border: 1px solid rgba(255, 255, 255, 0.05);
        }
        
        .trainer-preview img {
            width: 150px;
            height: 150px;
            border-radius: 50%;
            object-fit: cover;
            border: 3px solid #00f0ff;
            margin-bottom: 1.5rem;
            box-shadow: 0 0 20px rgba(0, 240, 255, 0.3);
        }
        
        .form-control-custom {
            background: rgba(255, 255, 255, 0.05);
            border: 1px solid rgba(255, 255, 255, 0.1);
            color: #fff;
            padding: 1rem;
            border-radius: 15px;
            transition: all 0.3s ease;
        }
        
        .form-control-custom:focus {
            background: rgba(255, 255, 255, 0.08);
            border-color: #00f0ff;
            color: #fff;
            box-shadow: 0 0 15px rgba(0, 240, 255, 0.2);
        }
        
        .btn-book {
            background: linear-gradient(135deg, #00f0ff 0%, #0077ff 100%);
            color: #0a0b10;
            border: none;
            padding: 1.2rem;
            border-radius: 15px;
            font-weight: 800;
            font-family: 'Orbitron';
            letter-spacing: 1px;
            transition: all 0.3s ease;
        }
        
        .btn-book:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 30px rgba(0, 240, 255, 0.4);
        }
    </style>
</head>
<body>

    <jsp:include page="components/navbar.jsp" />

    <%
        int trainerId = 0;
        try { trainerId = Integer.parseInt(request.getParameter("trainerId")); } catch(Exception e) {}
        
        TrainerDAO trainerDAO = new TrainerDAO();
        Trainer trainer = (trainerId > 0) ? trainerDAO.getTrainerById(trainerId) : null;
        
        User user = (User) session.getAttribute("user");
    %>

    <div class="booking-container">
        <div class="container">
            <% if (request.getAttribute("error") != null) { %>
                <div class="alert alert-danger alert-dismissible fade show mb-4" role="alert">
                    <i class="fas fa-exclamation-circle me-2"></i><%= request.getAttribute("error") %>
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            <% } %>
            <% if (session.getAttribute("bookingSuccess") != null) { %>
                <div class="alert alert-success alert-dismissible fade show mb-4" role="alert">
                    <i class="fas fa-check-circle me-2"></i><%= session.getAttribute("bookingSuccess") %>
                    <% session.removeAttribute("bookingSuccess"); %>
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            <% } %>
            <div class="row justify-content-center">
                <div class="col-lg-10">
                    <div class="glass-card">
                        <div class="row g-5">
                            <div class="col-md-5">
                                <div class="trainer-preview">
                                    <% if (trainer != null) { %>
                                        <img src="<%= trainer.getImageUrl() %>" alt="<%= trainer.getName() %>">
                                        <h3 class="font-orbitron text-gradient mb-1"><%= trainer.getName() %></h3>
                                        <p class="text-info fw-bold mb-3"><%= trainer.getSpecialization() %></p>
                                        <p class="text-muted small"><%= trainer.getExperienceYears() %> Years Experience</p>
                                        <hr class="border-secondary opacity-25">
                                        <p class="small text-muted px-3">Expert in personalized training and high-intensity performance coaching.</p>
                                    <% } else { %>
                                        <div class="mb-4"><i class="fas fa-user-circle fa-5x text-muted"></i></div>
                                        <h3 class="font-orbitron text-white">General Session</h3>
                                        <p class="text-muted">Book with any available trainer</p>
                                    <% } %>
                                </div>
                            </div>
                            
                            <div class="col-md-7">
                                <h2 class="font-orbitron text-white mb-4">BOOK YOUR SESSION</h2>
                                <form action="book-session-submit" method="POST">
                                    <input type="hidden" name="trainerId" value="<%= trainerId %>">
                                    <div class="row g-3">
                                        <div class="col-md-6">
                                            <label class="form-label text-muted small fw-bold">YOUR NAME</label>
                                            <input type="text" name="userName" class="form-control form-control-custom" value="<%= user != null ? user.getName() : "" %>" readonly>
                                        </div>
                                        <div class="col-md-6">
                                            <label class="form-label text-muted small fw-bold">EMAIL ADDRESS</label>
                                            <input type="email" name="email" class="form-control form-control-custom" value="<%= user != null ? user.getEmail() : "" %>" readonly>
                                        </div>
                                        <div class="col-12">
                                            <label class="form-label text-muted small fw-bold">PREFERRED DATE</label>
                                            <input type="date" name="bookingDate" class="form-control form-control-custom" required>
                                        </div>
                                        <div class="col-12">
                                            <label class="form-label text-muted small fw-bold">SESSION TYPE</label>
                                            <select name="sessionType" class="form-select form-control-custom">
                                                <option value="Personal Training (1-on-1)">Personal Training (1-on-1)</option>
                                                <option value="Strength Coaching">Strength Coaching</option>
                                                <option value="Weight Loss Program">Weight Loss Program</option>
                                                <option value="Nutrition Consultation">Nutrition Consultation</option>
                                            </select>
                                        </div>
                                        <div class="col-12">
                                            <label class="form-label text-muted small fw-bold">ADDITIONAL MESSAGE</label>
                                            <textarea name="message" class="form-control form-control-custom" rows="3" placeholder="Any specific goals or medical conditions?"></textarea>
                                        </div>
                                        <div class="col-12 mt-4">
                                            <button type="submit" class="btn btn-book w-100">CONFIRM BOOKING</button>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <jsp:include page="components/footer.jsp" />

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
