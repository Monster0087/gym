<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isErrorPage="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Error - PowerLift Gym</title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- Custom CSS -->
    <link rel="stylesheet" href="css/style.css">
    
    <style>
        .error-container {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            background: linear-gradient(135deg, #0f0f0f 0%, #1a1a1a 50%, #0f0f0f 100%);
            text-align: center;
        }
        
        .error-content {
            background: rgba(255, 255, 255, 0.05);
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 20px;
            padding: 3rem;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.3);
            max-width: 600px;
            margin: 2rem;
        }
        
        .error-code {
            font-size: 8rem;
            font-weight: 900;
            color: #ff0000;
            text-shadow: 0 0 20px rgba(255, 0, 0, 0.5);
            margin-bottom: 1rem;
            animation: pulse 2s infinite;
        }
        
        @keyframes pulse {
            0%, 100% { opacity: 1; }
            50% { opacity: 0.7; }
        }
        
        .error-title {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 1rem;
            color: #ffffff;
        }
        
        .error-message {
            font-size: 1.2rem;
            color: rgba(255, 255, 255, 0.8);
            margin-bottom: 2rem;
        }
        
        .error-icon {
            font-size: 4rem;
            color: #ff0000;
            margin-bottom: 2rem;
            animation: bounce 2s infinite;
        }
        
        @keyframes bounce {
            0%, 20%, 50%, 80%, 100% { transform: translateY(0); }
            40% { transform: translateY(-20px); }
            60% { transform: translateY(-10px); }
        }
        
        .btn-error {
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
            text-decoration: none;
            display: inline-block;
            box-shadow: 0 10px 30px rgba(255, 0, 0, 0.3);
        }
        
        .btn-error:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 40px rgba(255, 0, 0, 0.4);
            color: #ffffff;
        }
        
        .btn-outline-error {
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
            text-decoration: none;
            display: inline-block;
        }
        
        .btn-outline-error:hover {
            background: linear-gradient(135deg, #ff0000 0%, #cc0000 100%);
            color: #ffffff;
            transform: translateY(-3px);
            box-shadow: 0 15px 40px rgba(255, 0, 0, 0.4);
        }
        
        .error-details {
            background: rgba(255, 0, 0, 0.1);
            border: 1px solid rgba(255, 0, 0, 0.3);
            border-radius: 10px;
            padding: 1rem;
            margin-top: 2rem;
            text-align: left;
            font-family: 'Courier New', monospace;
            font-size: 0.9rem;
            color: #ff6666;
        }
    </style>
</head>
<body>
    <div class="error-container">
        <div class="error-content">
            <div class="error-icon">
                <i class="fas fa-exclamation-triangle"></i>
            </div>
            
            <div class="error-code"><%= request.getAttribute("javax.servlet.error.status_code") != null ? request.getAttribute("javax.servlet.error.status_code") : "Err" %></div>
            
            <h1 class="error-title">
                <%= request.getAttribute("javax.servlet.error.status_code") != null && request.getAttribute("javax.servlet.error.status_code").equals(404) ? "Page Not Found" : "Server Error" %>
            </h1>
            
            <p class="error-message">
                <%= request.getAttribute("javax.servlet.error.message") != null ? request.getAttribute("javax.servlet.error.message") : "Something went wrong. Even the strongest muscles need a break sometimes!" %>
            </p>
            
            <div class="d-flex justify-content-center gap-3 flex-wrap">
                <a href="index.jsp" class="btn btn-error">
                    <i class="fas fa-home me-2"></i>
                    Go Home
                </a>
                <a href="javascript:history.back()" class="btn btn-outline-error">
                    <i class="fas fa-arrow-left me-2"></i>
                    Go Back
                </a>
            </div>
            
            <div class="mt-4">
                <h5 class=" mb-3">Looking for something specific?</h5>
                <div class="row g-2">
                    <div class="col-6">
                        <a href="about.jsp" class="btn btn-outline-custom btn-sm w-100">About Us</a>
                    </div>
                    <div class="col-6">
                        <a href="services.jsp" class="btn btn-outline-custom btn-sm w-100">Services</a>
                    </div>
                    <div class="col-6">
                        <a href="gallery.jsp" class="btn btn-outline-custom btn-sm w-100">Gallery</a>
                    </div>
                    <div class="col-6">
                        <a href="contact.jsp" class="btn btn-outline-custom btn-sm w-100">Contact</a>
                    </div>
                </div>
            </div>
            
            <div class="text-center mt-4">
                <p class="text-muted">
                    <i class="fas fa-dumbbell me-2"></i>
                    Stay strong, keep pushing forward!
                </p>
            </div>
            
            <!-- Error details (only shown in development) -->
            <%
                String userAgent = request.getHeader("User-Agent");
                Object originalURI = request.getAttribute("javax.servlet.error.request_uri");
                Object statusCode = request.getAttribute("javax.servlet.error.status_code");
                Throwable exception = (Throwable) request.getAttribute("javax.servlet.error.exception");
            %>
            
            <div class="error-details">
                <strong>Error Details:</strong><br>
                Status Code: <%= statusCode != null ? statusCode : "N/A" %><br>
                Original URL: <%= originalURI != null ? originalURI : request.getRequestURI() %><br>
                User Agent: <%= userAgent != null ? userAgent : "Unknown" %><br>
                Timestamp: <%= new java.util.Date() %><br>
                Referrer: <%= request.getHeader("Referer") != null ? request.getHeader("Referer") : "Direct Access" %>
                <% if (exception != null) { %>
                    <br>Exception: <%= exception.getMessage() %>
                <% } %>
            </div>
        </div>
    </div>
    
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        // Auto-redirect after 30 seconds
        setTimeout(function() {
            if (confirm('Would you like to go to the home page?')) {
                window.location.href = 'index.jsp';
            }
        }, 30000);
        
        // Add some interactive elements
        document.addEventListener('DOMContentLoaded', function() {
            // Add hover effect to error code
            const errorCode = document.querySelector('.error-code');
            if (errorCode) {
                errorCode.addEventListener('mouseenter', function() {
                    this.style.transform = 'scale(1.1) rotate(5deg)';
                });
                
                errorCode.addEventListener('mouseleave', function() {
                    this.style.transform = 'scale(1) rotate(0deg)';
                });
            }
            
            // Add click animation to buttons
            const buttons = document.querySelectorAll('.btn');
            buttons.forEach(button => {
                button.addEventListener('click', function(e) {
                    // Create ripple effect
                    const ripple = document.createElement('span');
                    ripple.style.position = 'absolute';
                    ripple.style.borderRadius = '50%';
                    ripple.style.background = 'rgba(255, 255, 255, 0.5)';
                    ripple.style.width = ripple.style.height = '40px';
                    ripple.style.marginTop = '-20px';
                    ripple.style.marginLeft = '-20px';
                    ripple.style.animation = 'ripple 0.6s ease-out';
                    
                    const rect = this.getBoundingClientRect();
                    ripple.style.left = (e.clientX - rect.left) + 'px';
                    ripple.style.top = (e.clientY - rect.top) + 'px';
                    
                    this.style.position = 'relative';
                    this.style.overflow = 'hidden';
                    this.appendChild(ripple);
                    
                    setTimeout(() => ripple.remove(), 600);
                });
            });
        });
        
        // Add ripple animation
        const style = document.createElement('style');
        style.textContent = `
            @keyframes ripple {
                to {
                    transform: scale(4);
                    opacity: 0;
                }
            }
        `;
        document.head.appendChild(style);
    </script>
</body>
</html>

