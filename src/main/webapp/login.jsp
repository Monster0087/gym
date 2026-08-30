<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - PowerLift Gym</title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- Custom CSS -->
    <link rel="stylesheet" href="css/style.css">
    
    <style>
        body {
            background: url('images/login-bg-4k.png') no-repeat center center fixed;
            background-size: cover;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;
            z-index: 1;
            font-family: 'Inter', sans-serif;
        }
        
        body::before {
            content: '';
            position: absolute;
            top: 0; left: 0; right: 0; bottom: 0;
            background: radial-gradient(circle at center, rgba(10, 11, 16, 0.6) 0%, rgba(10, 11, 16, 0.95) 100%);
            z-index: -1;
        }
        
        .login-container {
            background: var(--glass-bg);
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
            border: 1px solid rgba(0, 240, 255, 0.1);
            border-radius: 20px;
            padding: 3rem;
            box-shadow: 0 0 30px var(--shadow-color);
            max-width: 450px;
            width: 100%;
            margin: 2rem;
        }
        
        .login-header {
            text-align: center;
            margin-bottom: 2rem;
        }
        
        .login-title {
            font-size: 2.5rem;
            font-weight: 800;
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            margin-bottom: 0.5rem;
        }
        
        .form-floating-custom {
            position: relative;
            margin-bottom: 1.5rem;
        }
        
        .form-control-custom {
            background: rgba(255, 255, 255, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 10px;
            padding: 1rem 1rem 1rem 3rem;
            color: #ffffff;
            transition: all 0.3s ease;
            width: 100%;
        }
        
        .form-control-custom:focus {
            background: rgba(255, 255, 255, 0.15);
            border-color: var(--primary-color);
            box-shadow: 0 0 20px var(--shadow-color);
            outline: none;
            color: #ffffff;
        }
        
        .form-control-custom::placeholder {
            color: rgba(255, 255, 255, 0.6);
        }
        
        .input-icon {
            position: absolute;
            left: 1rem;
            top: 50%;
            transform: translateY(-50%);
            color: rgba(255, 255, 255, 0.6);
            z-index: 10;
        }
        
        .btn-login {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 100%);
            color: var(--bg-dark);
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
        
        .btn-login:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 20px var(--shadow-color);
            color: var(--bg-dark);
        }
        
        .register-link {
            text-align: center;
            margin-top: 1.5rem;
            color: rgba(255, 255, 255, 0.8);
        }
        
        .register-link a {
            color: var(--primary-color);
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        
        .register-link a:hover {
            color: #ffffff;
            text-shadow: 0 0 10px var(--primary-color);
        }
        
        .divider {
            text-align: center;
            margin: 2rem 0;
            position: relative;
        }
        
        .divider::before {
            content: '';
            position: absolute;
            top: 50%;
            left: 0;
            right: 0;
            height: 1px;
            background: rgba(255, 255, 255, 0.2);
        }
        
        .divider span {
            background: rgba(15, 15, 15, 0.9);
            padding: 0 1rem;
            color: rgba(255, 255, 255, 0.6);
        }
        
        .social-login {
            display: flex;
            gap: 1rem;
            margin-bottom: 1.5rem;
        }
        
        .social-btn {
            flex: 1;
            padding: 0.8rem;
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 10px;
            background: rgba(255, 255, 255, 0.05);
            color: #ffffff;
            text-decoration: none;
            transition: all 0.3s ease;
            text-align: center;
        }
        
        .social-btn:hover {
            background: rgba(255, 255, 255, 0.1);
            transform: translateY(-2px);
            color: #ffffff;
        }
        
        .back-link {
            text-align: center;
            margin-top: 2rem;
        }
        
        .back-link a {
            color: #ff0000;
            text-decoration: none;
            transition: all 0.3s ease;
        }
        
        .back-link a:hover {
            color: #ff3333;
            text-decoration: underline;
        }
        
        .alert-custom {
            background: rgba(255, 0, 0, 0.1);
            border: 1px solid rgba(255, 0, 0, 0.3);
            color: #ff6666;
            padding: 1rem;
            border-radius: 10px;
            margin-bottom: 1.5rem;
            animation: fadeIn 0.3s ease;
        }
        
        .success-custom {
            background: rgba(0, 255, 0, 0.1);
            border: 1px solid rgba(0, 255, 0, 0.3);
            color: #66ff66;
            padding: 1rem;
            border-radius: 10px;
            margin-bottom: 1.5rem;
            animation: fadeIn 0.3s ease;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <div class="login-header">
            <i class="fas fa-dumbbell fa-3x text-danger mb-3"></i>
            <h1 class="login-title">WELCOME BACK</h1>
            <p class="text-muted">Login to your account</p>
        </div>
        
        <% if (request.getParameter("success") != null) { %>
        <div class="success-custom">
            <i class="fas fa-check-circle me-2"></i>
            Registration successful! Please login to continue.
        </div>
        <% } %>
        
        <% if (request.getAttribute("error") != null) { %>
        <div class="alert-custom">
            <i class="fas fa-exclamation-triangle me-2"></i>
            <%= request.getAttribute("error") %>
        </div>
        <% } %>
        
        <form action="login" method="post">
            <div class="form-floating-custom">
                <i class="fas fa-envelope input-icon"></i>
                <input type="email" class="form-control-custom" name="email" placeholder="Email address" required>
            </div>
            
            <div class="form-floating-custom">
                <i class="fas fa-lock input-icon"></i>
                <input type="password" class="form-control-custom" name="password" placeholder="Password" required>
            </div>
            
            <div class="d-flex justify-content-between align-items-center mb-3">
                <div class="form-check">
                    <input class="form-check-input" type="checkbox" id="remember">
                    <label class="form-check-label " for="remember">
                        Remember me
                    </label>
                </div>
                <a href="#" class="text-danger text-decoration-none">Forgot password?</a>
            </div>
            
            <button type="submit" class="btn btn-login">
                <i class="fas fa-sign-in-alt me-2"></i>
                LOGIN
            </button>
        </form>
        
        <div class="divider">
            <span>OR</span>
        </div>
        
        <div class="social-login">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/index.jsp">
                <i class="fas fa-dumbbell"></i> PowerLift Gym
            </a>
            <a href="#" class="social-btn">
                <i class="fab fa-facebook-f"></i>
            </a>
            <a href="#" class="social-btn">
                <i class="fab fa-twitter"></i>
            </a>
        </div>
        
        <div class="back-link">
            <p>Don't have an account? <a href="${pageContext.request.contextPath}/register.jsp">Register here</a></p>
            <p><a href="${pageContext.request.contextPath}/index.jsp" class="text-muted">â† Back to Home</a></p>
        </div>
    </div>
    
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        // Auto-hide alerts after 5 seconds
        setTimeout(() => {
            const alerts = document.querySelectorAll('.alert-custom, .success-custom');
            alerts.forEach(alert => {
                alert.style.opacity = '0';
                setTimeout(() => alert.remove(), 300);
            });
        }, 5000);
        
        // Form validation
        document.querySelector('form').addEventListener('submit', function(e) {
            const email = document.querySelector('input[name="email"]').value;
            const password = document.querySelector('input[name="password"]').value;
            
            if (!email || !password) {
                e.preventDefault();
                alert('Please fill in all fields');
            }
        });
    </script>
    <!-- Multi-Tab Session Support -->
    <script src="${pageContext.request.contextPath}/js/multi-tab.js"></script>
</body>
</html>

