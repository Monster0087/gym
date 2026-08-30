<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.gym.dao.TrainerDAO, java.util.List" %>
<%@ page import="com.gym.model.Trainer" %>
<%@ page import="com.gym.model.User" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About Us - PowerLift Gym</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- Custom CSS -->
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/animations.css">

    <style>
        .about-hero {
            background: linear-gradient(rgba(0, 0, 0, 0.7), rgba(0, 0, 0, 0.7)),
                url('https://images.unsplash.com/photo-1593079744434-699da2af975f?ixlib=rb-4.0.3&auto=format&fit=crop&w=1920&q=80') center/cover no-repeat;
            background-attachment: fixed;
            min-height: 60vh;
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;
        }

        .about-content {
            text-align: center;
            z-index: 2;
        }

        .about-title {
            font-size: 3.5rem;
            font-weight: 900;
            margin-bottom: 1rem;
            text-shadow: 2px 2px 10px rgba(0, 240, 255, 0.3);
            color: #ffffff;
            font-family: 'Orbitron', sans-serif;
        }

        .timeline {
            position: relative;
            padding: 2rem 0;
        }

        .timeline::before {
            content: '';
            position: absolute;
            left: 50%;
            top: 0;
            bottom: 0;
            width: 2px;
            background: linear-gradient(135deg, #ff0000 0%, #cc0000 100%);
            transform: translateX(-50%);
        }

        .timeline-item {
            position: relative;
            margin-bottom: 3rem;
        }

        .timeline-item::before {
            content: '';
            position: absolute;
            left: 50%;
            top: 50%;
            width: 20px;
            height: 20px;
            background: #ff0000;
            border-radius: 50%;
            transform: translate(-50%, -50%);
            z-index: 1;
        }

        .timeline-content {
            background: rgba(10, 11, 16, 0.95);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 15px;
            padding: 2rem;
            width: 45%;
            transition: all 0.3s ease;
        }

        .timeline-item:nth-child(odd) .timeline-content {
            margin-left: auto;
        }

        .timeline-item:nth-child(even) .timeline-content {
            margin-right: auto;
        }

        .timeline-content:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 35px rgba(255, 0, 0, 0.2);
            border-color: rgba(255, 0, 0, 0.3);
        }

        .trainer-detail-card {
            background: rgba(10, 11, 16, 0.95);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 20px;
            padding: 2rem;
            text-align: center;
            transition: all 0.3s ease;
            height: 100%;
        }

        .trainer-detail-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 20px 40px rgba(255, 0, 0, 0.2);
            border-color: #ff0000;
        }

        .trainer-detail-image {
            width: 150px;
            height: 150px;
            border-radius: 50%;
            object-fit: cover;
            margin: 0 auto 1.5rem;
            border: 4px solid #ff0000;
            transition: all 0.3s ease;
        }

        .trainer-detail-card:hover .trainer-detail-image {
            transform: scale(1.1);
            box-shadow: 0 10px 30px rgba(255, 0, 0, 0.4);
        }

        .trainer-social {
            display: flex;
            justify-content: center;
            gap: 1rem;
            margin-top: 1rem;
        }

        .trainer-social a {
            width: 40px;
            height: 40px;
            background: rgba(255, 0, 0, 0.2);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #ff0000;
            transition: all 0.3s ease;
        }

        .trainer-social a:hover {
            background: #ff0000;
            color: #ffffff;
            transform: translateY(-3px);
        }

        .values-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 2rem;
            margin-top: 3rem;
        }

        .value-card {
            background: rgba(255, 255, 255, 0.05);
            backdrop-filter: blur(15px);
            -webkit-backdrop-filter: blur(15px);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 20px;
            padding: 2rem;
            text-align: center;
            transition: all 0.3s ease;
        }

        .value-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 20px 40px rgba(255, 0, 0, 0.2);
            border-color: #ff0000;
        }

        .value-icon {
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

        .value-card:hover .value-icon {
            transform: scale(1.1) rotate(360deg);
            box-shadow: 0 10px 30px rgba(255, 0, 0, 0.4);
        }

        @media (max-width: 768px) {
            .timeline::before {
                left: 30px;
            }

            .timeline-item::before {
                left: 30px;
            }

            .timeline-content {
                width: calc(100% - 60px);
                margin-left: 60px !important;
            }

            .about-title {
                font-size: 2.5rem;
            }
        }

        /* ❌ NO BLUR - MAXIMUM SHARPNESS */
        * {
            backdrop-filter: none !important;
            -webkit-backdrop-filter: none !important;
            filter: none !important;
        }

        .glass,
        .glass-dark,
        .card-custom,
        .navbar.scrolled,
        .timeline-content,
        .trainer-detail-card {
            background: rgba(10, 11, 16, 0.95) !important;
            border: 1px solid rgba(0, 240, 255, 0.2) !important;
        }
    </style>
</head>

<body>
    <jsp:include page="components/navbar.jsp" />

    <!-- About Hero -->
    <section class="about-hero">
        <div class="container">
            <div class="about-content">
                <h1 class="about-title text-gradient">ABOUT PowerLift Gym</h1>
                <p class="lead ">Transforming Lives Through Fitness Excellence Since 2010</p>
            </div>
        </div>
    </section>

    <!-- Mission & Vision -->
    <section class="py-5">
        <div class="container">
            <div class="row g-4">
                <div class="col-md-6">
                    <div class="card-custom animate-on-scroll">
                        <div class="value-icon">
                            <i class="fas fa-bullseye"></i>
                        </div>
                        <h3 class="text-gradient mb-3">Our Mission</h3>
                        <p>To empower individuals to achieve their fitness goals through state-of-the-art facilities,
                            expert guidance, and a supportive community that fosters personal growth and well-being.</p>
                        <p>We believe that fitness is not just about physical strength, but about building confidence,
                            discipline, and a healthier lifestyle that extends beyond the gym walls.</p>
                    </div>
                </div>

                <div class="col-md-6">
                    <div class="card-custom animate-on-scroll">
                        <div class="value-icon">
                            <i class="fas fa-eye"></i>
                        </div>
                        <h3 class="text-gradient mb-3">Our Vision</h3>
                        <p>To be the leading fitness destination that inspires and transforms lives, creating a
                            community where health and wellness are accessible to everyone.</p>
                        <p>We envision a world where everyone has the opportunity to achieve their optimal physical and
                            mental well-being through innovative fitness solutions and personalized support.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Our Story Timeline -->
    <section class="py-5">
        <div class="container">
            <div class="text-center mb-5">
                <h2 class="text-gradient">OUR JOURNEY</h2>
                <p class="lead">From a small fitness center to a premium wellness destination</p>
            </div>

            <div class="timeline">
                <div class="timeline-item animate-on-scroll">
                    <div class="timeline-content">
                        <h4 class="text-danger">2010 - The Beginning</h4>
                        <p>Started as a small 2000 sq ft fitness center with basic equipment and a dream to make fitness
                            accessible to everyone.</p>
                    </div>
                </div>

                <div class="timeline-item animate-on-scroll">
                    <div class="timeline-content">
                        <h4 class="text-danger">2014 - First Expansion</h4>
                        <p>Grew to a 10,000 sq ft facility, added premium equipment, and hired our first team of
                            certified trainers.</p>
                    </div>
                </div>

                <div class="timeline-item animate-on-scroll">
                    <div class="timeline-content">
                        <h4 class="text-danger">2018 - Wellness Integration</h4>
                        <p>Introduced nutrition counseling, yoga classes, and holistic wellness programs to complement
                            our fitness offerings.</p>
                    </div>
                </div>

                <div class="timeline-item animate-on-scroll">
                    <div class="timeline-content">
                        <h4 class="text-danger">2022 - Digital Transformation</h4>
                        <p>Launched our mobile app, virtual training programs, and AI-powered workout personalization.
                        </p>
                    </div>
                </div>

                <div class="timeline-item animate-on-scroll">
                    <div class="timeline-content">
                        <h4 class="text-danger">2024 - Premium Experience</h4>
                        <p>Now a 25,000 sq ft premium facility with cutting-edge technology, spa services, and a
                            community of 5000+ members.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Core Values -->
    <section class="py-5">
        <div class="container">
            <div class="text-center mb-5">
                <h2 class="text-gradient">OUR CORE VALUES</h2>
                <p class="lead">The principles that guide everything we do</p>
            </div>

            <div class="values-grid">
                <div class="value-card animate-on-scroll">
                    <div class="value-icon">
                        <i class="fas fa-heart"></i>
                    </div>
                    <h4>Passion</h4>
                    <p>We are passionate about fitness and genuinely care about helping our members achieve their goals.
                    </p>
                </div>

                <div class="value-card animate-on-scroll">
                    <div class="value-icon">
                        <i class="fas fa-award"></i>
                    </div>
                    <h4>Excellence</h4>
                    <p>We strive for excellence in everything we do, from equipment quality to customer service.</p>
                </div>

                <div class="value-card animate-on-scroll">
                    <div class="value-icon">
                        <i class="fas fa-users"></i>
                    </div>
                    <h4>Community</h4>
                    <p>We foster a supportive community where members motivate and inspire each other.</p>
                </div>

                <div class="value-card animate-on-scroll">
                    <div class="value-icon">
                        <i class="fas fa-lightbulb"></i>
                    </div>
                    <h4>Innovation</h4>
                    <p>We continuously innovate and adopt the latest fitness trends and technologies.</p>
                </div>

                <div class="value-card animate-on-scroll">
                    <div class="value-icon">
                        <i class="fas fa-shield-alt"></i>
                    </div>
                    <h4>Integrity</h4>
                    <p>We operate with honesty, transparency, and ethical business practices.</p>
                </div>

                <div class="value-card animate-on-scroll">
                    <div class="value-icon">
                        <i class="fas fa-chart-line"></i>
                    </div>
                    <h4>Growth</h4>
                    <p>We believe in continuous growth for our members, staff, and business.</p>
                </div>
            </div>
        </div>
    </section>

    <!-- Meet Our Trainers -->
    <section class="py-5">
        <div class="container">
            <div class="text-center mb-5">
                <h2 class="text-gradient">MEET OUR EXPERT TRAINERS</h2>
                <p class="lead">Learn from the best fitness professionals in the industry</p>
            </div>

            <div class="row g-4">
                <% TrainerDAO trainerDAO=new TrainerDAO(); List<Trainer> trainers = trainerDAO.getAllActiveTrainers();
                    for (Trainer trainer : trainers) {
                    %>
                    <div class="col-md-4">
                        <div class="trainer-detail-card animate-on-scroll">
                            <img src="<%= trainer.getImageUrl() != null && !trainer.getImageUrl().trim().isEmpty() ? trainer.getImageUrl() : "https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?ixlib=rb-4.0.3&auto=format&fit=crop&w=300&q=80" %>"
                                alt="<%= trainer.getName() %>" class="trainer-detail-image">

                            <h4>
                                <%= trainer.getName() %>
                            </h4>
                            <p class="text-danger mb-2">
                                <%= trainer.getSpecialization() %>
                            </p>
                            <p class="text-muted mb-3">
                                <%= trainer.getExperienceYears() %> years of experience
                            </p>

                            <p class="small">
                                <%= trainer.getBio() !=null ? trainer.getBio() : "Passionate fitness professional dedicated to helping clients achieve their goals through personalized training and expert guidance." %>
                            </p>

                            <div class="trainer-social">
                                <a href="#"><i class="fab fa-instagram"></i></a>
                                <a href="#"><i class="fab fa-facebook"></i></a>
                                <a href="#"><i class="fab fa-twitter"></i></a>
                                <a href="#"><i class="fab fa-linkedin"></i></a>
                            </div>
                        </div>
                    </div>
                    <% } %>
            </div>
        </div>
    </section>

    <!-- Stats Section -->
    <section class="py-5">
        <div class="container">
            <div class="glass-dark text-center p-5">
                <h2 class="text-gradient mb-5">BY THE NUMBERS</h2>

                <div class="row g-4">
                    <div class="col-md-3">
                        <h3 class="text-danger display-4">5000+</h3>
                        <p class="text-muted">Active Members</p>
                    </div>

                    <div class="col-md-3">
                        <h3 class="text-danger display-4">25+</h3>
                        <p class="text-muted">Expert Trainers</p>
                    </div>

                    <div class="col-md-3">
                        <h3 class="text-danger display-4">100+</h3>
                        <p class="text-muted">Classes Weekly</p>
                    </div>

                    <div class="col-md-3">
                        <h3 class="text-danger display-4">14</h3>
                        <p class="text-muted">Years of Excellence</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- CTA Section -->
    <section class="py-5">
        <div class="container">
            <div class="text-center">
                <h2 class="text-gradient mb-4">READY TO JOIN OUR COMMUNITY?</h2>
                <p class="lead mb-4">Become part of the PowerLift Gym family today</p>
                <div class="d-flex justify-content-center gap-3">
                    <% if (session.getAttribute("user") !=null) { %>
                        <a href="${pageContext.request.contextPath}/dashboard.jsp" class="btn btn-primary-custom btn-lg">View Dashboard</a>
                        <% } else { %>
                            <a href="${pageContext.request.contextPath}/register.jsp" class="btn btn-primary-custom btn-lg">Start Your Journey</a>
                            <% } %>
                                <a href="${pageContext.request.contextPath}/contact.jsp" class="btn btn-outline-custom btn-lg">Schedule a Tour</a>
                </div>
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