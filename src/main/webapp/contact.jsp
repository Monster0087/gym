<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.gym.model.User" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact - Premium Gym</title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- Custom CSS -->
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/animations.css">
    
    <style>
        .contact-hero {
            background: linear-gradient(rgba(10, 11, 16, 0.8), rgba(10, 11, 16, 0.9)),
                        url('https://images.unsplash.com/photo-1571902943202-507ec2618e8f?ixlib=rb-4.0.3&auto=format&fit=crop&w=3840&q=80') center/cover no-repeat;
            background-attachment: fixed;
            min-height: 50vh;
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;
            margin-top: 80px;
        }
        
        .contact-content {
            text-align: center;
            z-index: 2;
        }
        
        .contact-title {
            font-size: 3.5rem;
            font-weight: 900;
            margin-bottom: 1rem;
            text-shadow: 2px 2px 10px rgba(0, 240, 255, 0.3);
            color: #ffffff;
        }
        
        .contact-form-container {
            background: rgba(10, 11, 16, 0.95);
            border: 1px solid rgba(0, 240, 255, 0.15);
            border-radius: 20px;
            padding: 3rem;
            box-shadow: 0 15px 40px rgba(0, 0, 0, 0.6), 0 0 20px rgba(0, 240, 255, 0.05);
            margin-bottom: 2rem;
            position: relative;
            z-index: 1;
        }
        
        .form-control-custom {
            background: rgba(26, 28, 41, 0.8);
            border: 1px solid rgba(0, 240, 255, 0.2);
            border-radius: 10px;
            padding: 1rem;
            color: #ffffff;
            transition: all 0.3s ease;
        }
        
        .form-control-custom:focus {
            background: rgba(26, 28, 41, 0.95);
            border-color: #00f0ff;
            box-shadow: 0 0 15px rgba(0, 240, 255, 0.2);
            outline: none;
            color: #ffffff;
        }
        
        .form-control-custom::placeholder {
            color: rgba(255, 255, 255, 0.5);
        }
        
        textarea.form-control-custom {
            min-height: 150px;
            resize: vertical;
        }
        
        .btn-contact {
            background: linear-gradient(135deg, #00f0ff 0%, #0077ff 100%);
            color: #0a0b10;
            border: none;
            padding: 1rem 2rem;
            font-size: 1.1rem;
            font-weight: 800;
            border-radius: 50px;
            text-transform: uppercase;
            letter-spacing: 2px;
            transition: all 0.3s ease;
            width: 100%;
            box-shadow: 0 10px 20px rgba(0, 240, 255, 0.3);
        }
        
        .btn-contact:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 30px rgba(0, 240, 255, 0.5);
            color: #ffffff;
        }
        
        .info-card {
            background: rgba(10, 11, 16, 0.7);
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
            border: 1px solid rgba(0, 240, 255, 0.1);
            border-radius: 20px;
            padding: 2rem;
            text-align: center;
            transition: all 0.3s ease;
            margin-bottom: 1.5rem;
            position: relative;
            z-index: 1;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.5);
        }
        
        .info-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 20px 40px rgba(0, 240, 255, 0.15);
            border-color: #00f0ff;
        }
        
        .info-icon {
            width: 60px;
            height: 60px;
            background: rgba(0, 240, 255, 0.1);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 1.5rem;
            font-size: 1.5rem;
            color: #00f0ff;
            transition: all 0.3s ease;
            box-shadow: 0 0 15px rgba(0, 240, 255, 0.2);
        }
        
        .info-card:hover .info-icon {
            transform: scale(1.1) rotate(5deg);
            background: #00f0ff;
            color: #0a0b10;
            box-shadow: 0 0 25px rgba(0, 240, 255, 0.5);
        }
        
        .btn-outline-custom {
            color: #00f0ff;
            border: 1px solid rgba(0, 240, 255, 0.5);
            background: transparent;
            border-radius: 50px;
            padding: 0.5rem 1.5rem;
            font-weight: 600;
            transition: all 0.3s ease;
            text-transform: uppercase;
            font-size: 0.9rem;
            letter-spacing: 1px;
        }
        
        .btn-outline-custom:hover {
            background: #00f0ff;
            color: #0a0b10;
            box-shadow: 0 5px 15px rgba(0, 240, 255, 0.3);
        }
        
        .map-container {
            background: rgba(10, 11, 16, 0.7);
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
            border: 1px solid rgba(0, 240, 255, 0.15);
            border-radius: 20px;
            overflow: hidden;
            height: 450px;
            position: relative;
            margin-bottom: 2rem;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.6);
        }
        
        .map-placeholder {
            width: 100%;
            height: 100%;
            background: url('https://images.unsplash.com/photo-1578662996442-48f60103fc96?ixlib=rb-4.0.3&auto=format&fit=crop&w=1200&q=80') center/cover no-repeat;
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;
        }
        
        .map-overlay {
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(10, 11, 16, 0.6);
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        .map-content {
            text-align: center;
            color: #ffffff;
            background: rgba(26, 28, 41, 0.8);
            backdrop-filter: blur(10px);
            padding: 2rem;
            border-radius: 15px;
            border: 1px solid rgba(0, 240, 255, 0.2);
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.5);
        }
        
        .social-links {
            display: flex;
            justify-content: center;
            gap: 1rem;
            margin-top: 2rem;
        }
        
        .social-link {
            width: 50px;
            height: 50px;
            background: rgba(26, 28, 41, 0.8);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #ffffff;
            font-size: 1.2rem;
            transition: all 0.3s ease;
            text-decoration: none;
            border: 1px solid rgba(0, 240, 255, 0.2);
        }
        
        .social-link:hover {
            background: #00f0ff;
            color: #0a0b10;
            border-color: #00f0ff;
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0, 240, 255, 0.3);
        }
        
        .alert-custom {
            background: rgba(0, 240, 255, 0.1);
            border: 1px solid rgba(0, 240, 255, 0.3);
            color: #00f0ff;
            padding: 1rem;
            border-radius: 10px;
            margin-bottom: 1.5rem;
            animation: fadeIn 0.3s ease;
        }
        
        .success-custom {
            background: rgba(0, 255, 128, 0.1);
            border: 1px solid rgba(0, 255, 128, 0.3);
            color: #00ff80;
            padding: 1rem;
            border-radius: 10px;
            margin-bottom: 1.5rem;
            animation: fadeIn 0.3s ease;
        }
        
        .working-hours {
            background: rgba(10, 11, 16, 0.7);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(0, 240, 255, 0.1);
            border-radius: 20px;
            padding: 2rem;
            margin-top: 1rem;
            position: relative;
            z-index: 1;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.5);
        }
        
        .hours-table {
            width: 100%;
            color: #ffffff;
        }
        
        .hours-table td {
            padding: 0.8rem 0;
            border-bottom: 1px solid rgba(255, 255, 255, 0.05);
        }
        
        .hours-table td:last-child {
            text-align: right;
            font-weight: 600;
            color: #00f0ff;
        }
        
        .hours-table tr:last-child td {
            border-bottom: none;
        }
        
        .contact-section {
            background: transparent;
            padding: 3rem 0;
            margin-bottom: 3rem;
            position: relative;
        }
        
        .faq-section {
            background: rgba(10, 11, 16, 0.7);
            backdrop-filter: blur(25px);
            border: 1px solid rgba(0, 240, 255, 0.15);
            border-radius: 20px;
            padding: 3rem;
            margin-top: 3rem;
            position: relative;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.6);
        }
        
        .faq-item {
            background: rgba(26, 28, 41, 0.5);
            border: 1px solid rgba(0, 240, 255, 0.1);
            border-radius: 15px;
            padding: 1.5rem;
            margin-bottom: 1rem;
            transition: all 0.3s ease;
            color: #ffffff;
        }
        
        .faq-item:hover {
            background: rgba(26, 28, 41, 0.9);
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(0, 240, 255, 0.1);
            border-color: #00f0ff;
        }
        
        .social-section {
            background: rgba(10, 11, 16, 0.7);
            backdrop-filter: blur(25px);
            border: 1px solid rgba(0, 240, 255, 0.15);
            border-radius: 20px;
            padding: 3rem;
            margin-top: 3rem;
            text-align: center;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.6);
        }
        
        .section-divider {
            height: 2px;
            background: linear-gradient(90deg, transparent, rgba(0, 240, 255, 0.3), transparent);
            margin: 3rem 0;
            border-radius: 1px;
        }
        
        .enhanced-card {
            background: rgba(10, 11, 16, 0.7);
            backdrop-filter: blur(25px);
            border: 1px solid rgba(0, 240, 255, 0.15);
            border-radius: 20px;
            box-shadow: 0 15px 40px rgba(0, 0, 0, 0.6);
            transition: all 0.3s ease;
        }
        
        .enhanced-card:hover {
            box-shadow: 0 20px 50px rgba(0, 240, 255, 0.1);
            transform: translateY(-5px);
            border-color: rgba(0, 240, 255, 0.3);
        }
        
        @media (max-width: 768px) {
            .contact-title {
                font-size: 2.5rem;
            }
            
            .contact-form-container {
                padding: 2rem;
            }
            
            .map-container {
                height: 300px;
            }
        }
        /* ❌ NO BLUR - MAXIMUM SHARPNESS */
        * {
            backdrop-filter: none !important;
            -webkit-backdrop-filter: none !important;
            filter: none !important;
        }

        .glass, .glass-dark, .card-custom, .navbar.scrolled, .contact-form-container, .info-card, .faq-item, .social-section {
            background: rgba(10, 11, 16, 0.95) !important;
            border: 1px solid rgba(0, 240, 255, 0.2) !important;
        }
    </style>
</head>
<body>
    <jsp:include page="components/navbar.jsp" />

    <!-- Contact Hero -->
    <section class="contact-hero">
        <div class="container">
            <div class="contact-content">
                <h1 class="contact-title text-gradient animate-heading">GET IN TOUCH</h1>
                <p class="lead ">We'd love to hear from you. Send us a message and we'll respond as soon as possible.</p>
            </div>
        </div>
    </section>

    <!-- Contact Section -->
    <section class="py-5 contact-section">
        <div class="container">
            <div class="row justify-content-center mb-5">
                <!-- Contact Form -->
                <div class="col-lg-10">
                    <div class="contact-form-container enhanced-card">
                        <h3 class="text-gradient mb-4">Send Us a Message</h3>
                        
                        <% if (request.getAttribute("success") != null) { %>
                        <div class="success-custom">
                            <i class="fas fa-check-circle me-2"></i>
                            <%= request.getAttribute("success") %>
                        </div>
                        <% } %>
                        
                        <% if (request.getAttribute("error") != null) { %>
                        <div class="alert-custom">
                            <i class="fas fa-exclamation-triangle me-2"></i>
                            <%= request.getAttribute("error") %>
                        </div>
                        <% } %>
                        
                        <form action="contact" method="post" id="contactForm">
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <label class="form-label ">Your Name *</label>
                                    <input type="text" class="form-control-custom" name="name" 
                                           value="<%= request.getAttribute("name") != null ? request.getAttribute("name") : "" %>"
                                           placeholder="John Doe" required>
                                </div>
                                
                                <div class="col-md-6">
                                    <label class="form-label ">Email Address *</label>
                                    <input type="email" class="form-control-custom" name="email" 
                                           value="<%= request.getAttribute("email") != null ? request.getAttribute("email") : "" %>"
                                           placeholder="john@example.com" required>
                                </div>
                                
                                <div class="col-md-6">
                                    <label class="form-label ">Phone Number</label>
                                    <input type="tel" class="form-control-custom" name="phone" 
                                           value="<%= request.getAttribute("phone") != null ? request.getAttribute("phone") : "" %>"
                                           placeholder="7218636893">
                                </div>
                                
                                <div class="col-md-6">
                                    <label class="form-label ">Subject</label>
                                    <select class="form-control-custom" name="subject">
                                        <option value="">Select a subject</option>
                                        <option value="membership">Membership Inquiry</option>
                                        <option value="training">Personal Training</option>
                                        <option value="classes">Group Classes</option>
                                        <option value="facilities">Facilities Tour</option>
                                        <option value="feedback">Feedback</option>
                                        <option value="other">Other</option>
                                    </select>
                                </div>
                                
                                <div class="col-12">
                                    <label class="form-label ">Message *</label>
                                    <textarea class="form-control-custom" name="message" 
                                              placeholder="Tell us how we can help you..." required><%= request.getAttribute("message") != null ? request.getAttribute("message") : "" %></textarea>
                                </div>
                                
                                <div class="col-12">
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" id="newsletter">
                                        <label class="form-check-label " for="newsletter">
                                            I'd like to receive news and special offers from Premium Gym
                                        </label>
                                    </div>
                                </div>
                                
                                <div class="col-12">
                                    <button type="submit" class="btn btn-contact">
                                        <i class="fas fa-paper-plane me-2"></i>
                                        SEND MESSAGE
                                    </button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
                
            <!-- Contact Information -->
            <div class="row g-4 justify-content-center">
                <div class="col-md-6">
                    <div class="info-card enhanced-card h-100">
                        <div class="info-icon">
                            <i class="fas fa-map-marker-alt"></i>
                        </div>
                        <h4>Visit Us</h4>
                        <p>123 Fitness Street<br>Gym City, GC 12345<br>United States</p>
                        <a href="#" class="btn btn-outline-custom btn-sm">Get Directions</a>
                    </div>
                </div>
                
                <div class="col-md-6">
                    <div class="info-card enhanced-card h-100">
                        <div class="info-icon">
                            <i class="fas fa-phone"></i>
                        </div>
                        <h4>Call Us</h4>
                        <p>Main: 7218636893<br>
                        Membership: 7218636893<br>
                        Training: 7218636893</p>
                        <a href="tel:7218636893" class="btn btn-outline-custom btn-sm">Call Now</a>
                    </div>
                </div>
                
                <div class="col-md-6">
                    <div class="info-card enhanced-card h-100">
                        <div class="info-icon">
                            <i class="fas fa-envelope"></i>
                        </div>
                        <h4>Email Us</h4>
                        <p>General: rohitjadhav992117@gmail.com<br>
                        Support: ajeethawale875@gmail.com</p>
                        <a href="mailto:rohitjadhav992117@gmail.com" class="btn btn-outline-custom btn-sm">Send Email</a>
                    </div>
                </div>
                
                <div class="col-md-6">
                    <div class="info-card enhanced-card h-100">
                        <div class="info-icon">
                            <i class="fas fa-clock"></i>
                        </div>
                        <h4>Working Hours</h4>
                        <table class="hours-table">
                            <tr>
                                <td>Monday - Friday</td>
                                <td>5:00 AM - 11:00 PM</td>
                            </tr>
                            <tr>
                                <td>Saturday</td>
                                <td>6:00 AM - 10:00 PM</td>
                            </tr>
                            <tr>
                                <td>Sunday</td>
                                <td>7:00 AM - 9:00 PM</td>
                            </tr>
                            <tr>
                                <td>Holidays</td>
                                <td>8:00 AM - 8:00 PM</td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Map Section -->
    <section class="py-5">
        <div class="container">
            <div class="row">
                <div class="col-12">
                    <h3 class="text-gradient text-center mb-4">Find Us on the Map</h3>
                    <div class="map-container enhanced-card">
                        <div class="map-placeholder">
                            <div class="map-overlay">
                                <div class="map-content">
                                    <i class="fas fa-map-marked-alt fa-3x mb-3"></i>
                                    <h4>Interactive Map</h4>
                                    <p>Click here to open Google Maps</p>
                                    <a href="https://maps.google.com" target="_blank" class="btn btn-primary-custom mt-3">
                                        <i class="fas fa-external-link-alt me-2"></i>
                                        Open Maps
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Social Media Section -->
    <section class="py-5 social-section">
        <div class="container">
            <div class="text-center">
                <h3 class="text-gradient mb-4">Follow Us on Social Media</h3>
                <p class="text-muted mb-4">Stay updated with our latest news, events, and fitness tips</p>
                
                <div class="social-links">
                    <a href="https://facebook.com" target="_blank" class="social-link">
                        <i class="fab fa-facebook-f"></i>
                    </a>
                    <a href="https://instagram.com" target="_blank" class="social-link">
                        <i class="fab fa-instagram"></i>
                    </a>
                    <a href="https://twitter.com" target="_blank" class="social-link">
                        <i class="fab fa-twitter"></i>
                    </a>
                    <a href="https://youtube.com" target="_blank" class="social-link">
                        <i class="fab fa-youtube"></i>
                    </a>
                    <a href="https://linkedin.com" target="_blank" class="social-link">
                        <i class="fab fa-linkedin-in"></i>
                    </a>
                    <a href="https://tiktok.com" target="_blank" class="social-link">
                        <i class="fab fa-tiktok"></i>
                    </a>
                </div>
            </div>
        </div>
    </section>

    <!-- FAQ Section -->
    <section class="py-5">
        <div class="container">
            <div class="text-center mb-5">
                <h2 class="text-gradient">Frequently Asked Questions</h2>
                <p class="lead">Quick answers to common questions</p>
            </div>
            
            <div class="faq-section">
                <div class="row">
                    <div class="col-md-6">
                        <div class="faq-item">
                            <h5 class="text-danger mb-3">Do I need to book in advance?</h5>
                            <p>While walk-ins are welcome, we recommend booking classes and personal training sessions in advance to secure your spot, especially during peak hours.</p>
                        </div>
                        
                        <div class="faq-item">
                            <h5 class="text-danger mb-3">What should I bring to my first visit?</h5>
                            <p>Bring comfortable workout clothes, a water bottle, and a towel. We provide lockers for your belongings, but you'll need to bring your own lock.</p>
                        </div>
                        
                        <div class="faq-item">
                            <h5 class="text-danger mb-3">Is there a free trial?</h5>
                            <p>Yes! We offer a 3-day free trial for new members. Contact us to schedule your trial period and experience our facilities.</p>
                        </div>
                    </div>
                    
                    <div class="col-md-6">
                        <div class="faq-item">
                            <h5 class="text-danger mb-3">Can I freeze my membership?</h5>
                            <p>Yes, you can freeze your membership for up to 3 months per year for medical reasons or travel. Contact our membership team for details.</p>
                        </div>
                        
                        <div class="faq-item">
                            <h5 class="text-danger mb-3">Do you offer student discounts?</h5>
                            <p>Yes, we offer special student discounts with valid ID. Students can save up to 20% on all membership plans.</p>
                        </div>
                        
                        <div class="faq-item">
                            <h5 class="text-danger mb-3">Is parking available?</h5>
                            <p>Yes, we have free parking for all members with over 100 spaces available, including accessible parking spots.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <jsp:include page="components/footer.jsp" />

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        // Form validation
        document.getElementById('contactForm').addEventListener('submit', function(e) {
            const name = document.querySelector('input[name="name"]').value.trim();
            const email = document.querySelector('input[name="email"]').value.trim();
            const message = document.querySelector('textarea[name="message"]').value.trim();
            
            if (!name || !email || !message) {
                e.preventDefault();
                showError('Please fill in all required fields');
                return;
            }
            
            // Basic email validation
            if (!email.match(/^[^\s@]+@[^\s@]+\.[^\s@]+$/)) {
                e.preventDefault();
                showError('Please enter a valid email address');
                return;
            }
            
            if (message.length < 10) {
                e.preventDefault();
                showError('Message must be at least 10 characters long');
                return;
            }
        });
        
        function showError(message) {
            const existingAlert = document.querySelector('.alert-custom');
            if (existingAlert) {
                existingAlert.remove();
            }
            
            const alert = document.createElement('div');
            alert.className = 'alert-custom';
            alert.innerHTML = '<i class="fas fa-exclamation-triangle me-2"></i>' + message;
            
            const form = document.getElementById('contactForm');
            form.parentNode.insertBefore(alert, form);
            
            setTimeout(() => {
                alert.style.opacity = '0';
                setTimeout(() => alert.remove(), 300);
            }, 5000);
        }
        
        // Auto-hide alerts after 5 seconds
        setTimeout(() => {
            const alerts = document.querySelectorAll('.alert-custom, .success-custom');
            alerts.forEach(alert => {
                alert.style.opacity = '0';
                setTimeout(() => alert.remove(), 300);
            });
        }, 5000);
        
        // Phone number formatting
        document.querySelector('input[name="phone"]').addEventListener('input', function(e) {
            let value = e.target.value.replace(/\D/g, '');
            if (value.length > 0) {
                if (value.length <= 3) {
                    value = value;
                } else if (value.length <= 6) {
                    value = value.slice(0, 3) + '-' + value.slice(3);
                } else if (value.length <= 10) {
                    value = value.slice(0, 3) + '-' + value.slice(3, 6) + '-' + value.slice(6);
                } else {
                    value = value.slice(0, 3) + '-' + value.slice(3, 6) + '-' + value.slice(6, 10);
                }
            }
            e.target.value = value;
        });
    </script>
    <script src="js/script.js"></script>
</body>
</html>


