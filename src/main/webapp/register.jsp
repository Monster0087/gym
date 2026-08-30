<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - PowerLift Gym</title>
    
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
            padding: 2rem 0;
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
        
        .register-container {
            background: var(--glass-bg);
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
            border: 1px solid rgba(0, 240, 255, 0.1);
            border-radius: 20px;
            padding: 3rem;
            box-shadow: 0 0 30px var(--shadow-color);
            max-width: 500px;
            width: 100%;
            margin: 2rem;
        }
        
        .register-header {
            text-align: center;
            margin-bottom: 2rem;
        }
        
        .register-title {
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
        
        .btn-register {
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
            box-shadow: 0 10px 30px var(--shadow-color);
        }
        
        .btn-register:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 20px var(--shadow-color);
            color: var(--bg-dark);
        }
        
        .password-strength {
            height: 5px;
            border-radius: 3px;
            margin-top: 0.5rem;
            transition: all 0.3s ease;
        }
        
        .strength-weak { background: #ff4444; width: 33%; }
        .strength-medium { background: #ffbb33; width: 66%; }
        .strength-strong { background: #00C851; width: 100%; }
        
        .terms-checkbox {
            margin-bottom: 1.5rem;
        }
        
        .terms-checkbox label {
            color: rgba(255, 255, 255, 0.8);
            font-size: 0.9rem;
        }
        
        .terms-checkbox a {
            color: var(--primary-color);
            text-decoration: none;
        }
        
        .terms-checkbox a:hover {
            color: #ffffff;
            text-decoration: underline;
        }
        
        .back-link {
            text-align: center;
            margin-top: 2rem;
        }
        
        .back-link a {
            color: var(--primary-color);
            text-decoration: none;
            transition: all 0.3s ease;
        }
        
        .back-link a:hover {
            color: #ffffff;
            text-shadow: 0 0 10px var(--primary-color);
            text-decoration: none;
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
        
        .form-row {
            display: flex;
            gap: 1rem;
        }
        
        .form-row .form-floating-custom {
            flex: 1;
        }
        
        @media (max-width: 768px) {
            .form-row {
                flex-direction: column;
                gap: 0;
            }
        }
    </style>
</head>
<body>
    <div class="register-container">
        <div class="register-header">
            <i class="fas fa-dumbbell fa-3x mb-3" style="color: var(--primary-color);"></i>
            <h1 class="register-title">JOIN PowerLift Gym</h1>
            <p class="text-muted">Create your account and start your fitness journey</p>
        </div>
        
        <% if (request.getAttribute("error") != null) { %>
        <div class="alert-custom">
            <i class="fas fa-exclamation-triangle me-2"></i>
            <%= request.getAttribute("error") %>
        </div>
        <% } %>
        
        <form action="register" method="post" id="registerForm">
            <div class="form-row">
                <div class="form-floating-custom">
                    <i class="fas fa-user input-icon"></i>
                    <input type="text" class="form-control-custom" name="name" placeholder="Full Name" required>
                </div>
            </div>
            
            <div class="form-floating-custom">
                <i class="fas fa-envelope input-icon"></i>
                <input type="email" class="form-control-custom" name="email" placeholder="Email Address" required>
            </div>
            
            <div class="form-floating-custom">
                <i class="fas fa-phone input-icon"></i>
                <input type="tel" class="form-control-custom" name="phone" placeholder="Phone Number (Optional)">
            </div>
            
            <div class="form-floating-custom">
                <i class="fas fa-lock input-icon"></i>
                <input type="password" class="form-control-custom" name="password" id="password" placeholder="Password" required>
                <div class="password-strength" id="passwordStrength"></div>
            </div>
            
            <div class="form-floating-custom">
                <i class="fas fa-lock input-icon"></i>
                <input type="password" class="form-control-custom" name="confirmPassword" placeholder="Confirm Password" required>
            </div>
            
            <div class="terms-checkbox">
                <div class="form-check">
                    <input class="form-check-input" type="checkbox" id="terms" required>
                    <label class="form-check-label" for="terms">
                        I agree to the <a href="#">Terms of Service</a> and <a href="#">Privacy Policy</a>
                    </label>
                </div>
            </div>
            
            <button type="submit" class="btn btn-register">
                <i class="fas fa-user-plus me-2"></i>
                CREATE ACCOUNT
            </button>
        </form>
        
        <div class="back-link">
            <p>Already have an account? <a href="${pageContext.request.contextPath}/login.jsp">Login here</a></p>
            <p><a href="${pageContext.request.contextPath}/index.jsp" class="text-muted">← Back to Home</a></p>
        </div>
    </div>
    
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        // Password strength checker
        document.getElementById('password').addEventListener('input', function() {
            const password = this.value;
            const strengthBar = document.getElementById('passwordStrength');
            
            if (password.length === 0) {
                strengthBar.className = 'password-strength';
                return;
            }
            
            let strength = 0;
            
            // Check password strength
            if (password.length >= 6) strength++;
            if (password.length >= 10) strength++;
            if (/[a-z]/.test(password) && /[A-Z]/.test(password)) strength++;
            if (/[0-9]/.test(password)) strength++;
            if (/[^a-zA-Z0-9]/.test(password)) strength++;
            
            // Update strength bar
            strengthBar.className = 'password-strength';
            if (strength <= 2) {
                strengthBar.classList.add('strength-weak');
            } else if (strength <= 4) {
                strengthBar.classList.add('strength-medium');
            } else {
                strengthBar.classList.add('strength-strong');
            }
        });
        
        // Form validation
        document.getElementById('registerForm').addEventListener('submit', function(e) {
            const password = document.getElementById('password').value;
            const confirmPassword = document.querySelector('input[name="confirmPassword"]').value;
            const terms = document.getElementById('terms').checked;
            
            if (password !== confirmPassword) {
                e.preventDefault();
                showError('Passwords do not match');
                return;
            }
            
            if (password.length < 6) {
                e.preventDefault();
                showError('Password must be at least 6 characters long');
                return;
            }
            
            if (!terms) {
                e.preventDefault();
                showError('You must agree to the terms and conditions');
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
            
            const form = document.getElementById('registerForm');
            form.parentNode.insertBefore(alert, form);
            
            setTimeout(() => {
                alert.style.opacity = '0';
                setTimeout(() => alert.remove(), 300);
            }, 5000);
        }
        
        // Auto-hide alerts after 5 seconds
        setTimeout(() => {
            const alerts = document.querySelectorAll('.alert-custom');
            alerts.forEach(alert => {
                alert.style.opacity = '0';
                setTimeout(() => alert.remove(), 300);
            });
        }, 5000);
    </script>
    <!-- Multi-Tab Session Support -->
    <script src="${pageContext.request.contextPath}/js/multi-tab.js"></script>
</body>
</html>
