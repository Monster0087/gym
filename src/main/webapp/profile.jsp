<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.gym.model.User" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Profile - PowerLift Gym</title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- Custom CSS -->
    <link rel="stylesheet" href="css/style.css">
    
    <style>
        .profile-header {
            background: linear-gradient(135deg, rgba(10, 11, 16, 0.8) 0%, rgba(26, 28, 41, 0.9) 100%);
            padding: 8rem 0 3rem;
            margin-bottom: 2rem;
            border-bottom: 1px solid rgba(0, 240, 255, 0.1);
        }
        
        body {
            background: linear-gradient(rgba(10, 11, 16, 0.85), rgba(10, 11, 16, 0.9)), 
                        url('https://images.unsplash.com/photo-1594882645126-14020914d58d?ixlib=rb-4.0.3&auto=format&fit=crop&w=3840&q=80') center/cover fixed no-repeat;
        }
        
        .profile-avatar {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            border: 4px solid var(--primary-color);
            background: var(--glass-bg);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 3rem;
            color: var(--primary-color);
            margin: 0 auto 1rem;
            position: relative;
            box-shadow: 0 0 20px var(--shadow-color);
        }
        
        .avatar-upload {
            position: absolute;
            bottom: 0;
            right: 0;
            background: var(--primary-color);
            color: var(--secondary-color);
            width: 35px;
            height: 35px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            border: 2px solid var(--bg-dark);
            transition: all 0.3s ease;
        }
        
        .avatar-upload:hover {
            transform: scale(1.1);
            background: #fff;
        }
        
        .profile-card {
            background: rgba(255, 255, 255, 0.05);
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 20px;
            padding: 2rem;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.3);
            margin-bottom: 2rem;
        }
        
        .form-section {
            background: rgba(255, 255, 255, 0.03);
            border-radius: 15px;
            padding: 1.5rem;
            margin-bottom: 1.5rem;
        }
        
        .form-section h5 {
            color: #ff0000;
            margin-bottom: 1.5rem;
            padding-bottom: 0.5rem;
            border-bottom: 1px solid rgba(255, 0, 0, 0.3);
        }
        
        .form-control-custom {
            background: rgba(255, 255, 255, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 10px;
            padding: 0.8rem 1rem;
            color: #ffffff;
            transition: all 0.3s ease;
        }
        
        .form-control-custom:focus {
            background: rgba(255, 255, 255, 0.15);
            border-color: #ff0000;
            box-shadow: 0 0 20px rgba(255, 0, 0, 0.3);
            outline: none;
            color: #ffffff;
        }
        
        .form-control-custom::placeholder {
            color: rgba(255, 255, 255, 0.6);
        }
        
        .btn-profile {
            background: linear-gradient(135deg, #ff0000 0%, #cc0000 100%);
            color: #ffffff;
            border: none;
            padding: 0.8rem 2rem;
            font-size: 1rem;
            font-weight: 600;
            border-radius: 50px;
            text-transform: uppercase;
            letter-spacing: 1px;
            transition: all 0.3s ease;
            box-shadow: 0 10px 30px rgba(255, 0, 0, 0.3);
        }
        
        .btn-profile:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 40px rgba(255, 0, 0, 0.4);
            color: #ffffff;
        }
        
        .btn-outline-profile {
            background: transparent;
            color: #ff0000;
            border: 2px solid #ff0000;
            padding: 0.8rem 2rem;
            font-size: 1rem;
            font-weight: 600;
            border-radius: 50px;
            text-transform: uppercase;
            letter-spacing: 1px;
            transition: all 0.3s ease;
        }
        
        .btn-outline-profile:hover {
            background: linear-gradient(135deg, #ff0000 0%, #cc0000 100%);
            color: #ffffff;
            transform: translateY(-3px);
            box-shadow: 0 15px 40px rgba(255, 0, 0, 0.4);
        }
        
        .password-toggle {
            position: absolute;
            right: 1rem;
            top: 50%;
            transform: translateY(-50%);
            background: none;
            border: none;
            color: rgba(255, 255, 255, 0.6);
            cursor: pointer;
            z-index: 10;
        }
        
        .password-toggle:hover {
            color: #ff0000;
        }
        
        .password-input-wrapper {
            position: relative;
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
        
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1rem;
            margin-top: 1rem;
        }
        
        .stat-item {
            background: rgba(255, 255, 255, 0.05);
            border-radius: 10px;
            padding: 1rem;
            text-align: center;
        }
        
        .stat-value {
            font-size: 1.5rem;
            font-weight: 700;
            color: #ff0000;
        }
        
        .stat-label {
            color: rgba(255, 255, 255, 0.6);
            font-size: 0.9rem;
        }
    </style>
</head>
<body>
    <jsp:include page="components/navbar.jsp" />

    <!-- Profile Header -->
    <div class="profile-header">
        <div class="container text-center">
            <div class="profile-avatar">
                <% 
                    User currentUser = (User) request.getAttribute("user");
                    String profileImg = (currentUser != null && currentUser.getProfileImage() != null) ? currentUser.getProfileImage() : "";
                %>
                <img id="avatarPreview" src="<%= profileImg %>" style="width: 100%; height: 100%; border-radius: 50%; object-fit: cover; display: <%= profileImg.isEmpty() ? "none" : "block" %>;">
                <i class="fas fa-user" id="avatarIcon" style="display: <%= profileImg.isEmpty() ? "block" : "none" %>;"></i>
                <label for="pfpUpload" class="avatar-upload" title="Upload Profile Picture">
                    <i class="fas fa-camera"></i>
                </label>
                <input type="file" id="pfpUpload" class="d-none" accept="image/*" onchange="previewAvatar(this)">
            </div>
            <h2 class="text-gradient mb-2 animate-on-scroll">
                <%= session.getAttribute("userName") != null ? session.getAttribute("userName") : "User Profile" %>
            </h2>
            <p class="text-muted animate-on-scroll">Manage your account settings and preferences</p>
        </div>
    </div>

    <div class="container">
        <% if (request.getAttribute("success") != null) { %>
        <div class="success-custom">
            <i class="fas fa-check-circle me-2"></i>
            <%= request.getAttribute("success") %>
        </div>
        <% } %>
        
        <% if ("success".equals(request.getParameter("payment"))) { %>
        <div class="success-custom" style="border-color: #00f0ff; color: #00f0ff; background: rgba(0, 240, 255, 0.1);">
            <i class="fas fa-check-circle me-2"></i>
            <strong>Payment Successful!</strong> Your subscription to the <strong><%= request.getParameter("plan") != null ? request.getParameter("plan") : "Premium" %></strong> plan is now active.
        </div>
        <% } %>
        
        <% if (request.getAttribute("error") != null) { %>
        <div class="alert-custom">
            <i class="fas fa-exclamation-triangle me-2"></i>
            <%= request.getAttribute("error") %>
        </div>
        <% } %>
        
        <div class="row">
            <!-- Profile Form -->
            <div class="col-12">
                <div class="profile-card">
                    <form action="profile" method="post">
                        <input type="hidden" name="profileImageBase64" id="profileImageBase64">
                        <!-- Personal Information -->
                        <div class="form-section">
                            <h5><i class="fas fa-user me-2"></i>Personal Information</h5>
                            
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <label class="form-label ">Full Name</label>
                                    <input type="text" class="form-control-custom" name="name" 
                                           value="<%= request.getAttribute("user") != null ? 
                                                   ((User)request.getAttribute("user")).getName() : 
                                                   session.getAttribute("userName") %>" required>
                                </div>
                                
                                <div class="col-md-6">
                                    <label class="form-label ">Email Address</label>
                                    <input type="email" class="form-control-custom" name="email" 
                                           value="<%= request.getAttribute("user") != null ? 
                                                   ((User)request.getAttribute("user")).getEmail() : "" %>" required>
                                </div>
                                
                                <div class="col-md-6">
                                    <label class="form-label ">Phone Number</label>
                                    <input type="tel" class="form-control-custom" name="phone" 
                                           value="<%= request.getAttribute("user") != null ? 
                                                   ((User)request.getAttribute("user")).getPhone() : "" %>">
                                </div>
                                
                                <div class="col-md-6">
                                    <label class="form-label ">Member Since</label>
                                    <input type="text" class="form-control-custom" value="<%= new java.text.SimpleDateFormat("MMMM yyyy").format(new java.util.Date()) %>" readonly>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Change Password -->
                        <div class="form-section">
                            <h5><i class="fas fa-lock me-2"></i>Change Password</h5>
                            
                            <div class="row g-3">
                                <div class="col-12">
                                    <label class="form-label ">Current Password</label>
                                    <div class="password-input-wrapper">
                                        <input type="password" class="form-control-custom" name="currentPassword" id="currentPassword">
                                        <button type="button" class="password-toggle" onclick="togglePassword('currentPassword')">
                                            <i class="fas fa-eye"></i>
                                        </button>
                                    </div>
                                </div>
                                
                                <div class="col-md-6">
                                    <label class="form-label ">New Password</label>
                                    <div class="password-input-wrapper">
                                        <input type="password" class="form-control-custom" name="newPassword" id="newPassword">
                                        <button type="button" class="password-toggle" onclick="togglePassword('newPassword')">
                                            <i class="fas fa-eye"></i>
                                        </button>
                                    </div>
                                </div>
                                
                                <div class="col-md-6">
                                    <label class="form-label ">Confirm New Password</label>
                                    <div class="password-input-wrapper">
                                        <input type="password" class="form-control-custom" name="confirmPassword" id="confirmPassword">
                                        <button type="button" class="password-toggle" onclick="togglePassword('confirmPassword')">
                                            <i class="fas fa-eye"></i>
                                        </button>
                                    </div>
                                </div>
                            </div>
                            
                            <small class="text-muted">Leave password fields empty if you don't want to change your password</small>
                        </div>
                        
                        <!-- Preferences -->
                        <div class="form-section">
                            <h5><i class="fas fa-cog me-2"></i>Preferences</h5>
                            
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" id="emailNotifications" checked>
                                        <label class="form-check-label " for="emailNotifications">
                                            Email Notifications
                                        </label>
                                    </div>
                                </div>
                                
                                <div class="col-md-6">
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" id="smsNotifications">
                                        <label class="form-check-label " for="smsNotifications">
                                            SMS Notifications
                                        </label>
                                    </div>
                                </div>
                                
                                <div class="col-md-6">
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" id="marketingEmails">
                                        <label class="form-check-label " for="marketingEmails">
                                            Marketing Emails
                                        </label>
                                    </div>
                                </div>
                                
                                <div class="col-md-6">
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" id="publicProfile">
                                        <label class="form-check-label " for="publicProfile">
                                            Public Profile
                                        </label>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="d-flex gap-3">
                            <button type="submit" class="btn btn-profile">
                                <i class="fas fa-save me-2"></i>
                                Save Changes
                            </button>
                            <button type="button" class="btn btn-outline-profile" onclick="resetForm()">
                                <i class="fas fa-undo me-2"></i>
                                Reset
                            </button>
                        </div>
                    </form>
                </div>

                <!-- Account Statistics, Quick Actions, Security Row -->
                <div class="row g-4 mt-2">
                    <!-- Account Stats -->
                    <div class="col-md-4">
                        <div class="profile-card h-100">
                            <h5 class="text-gradient mb-4">Account Statistics</h5>
                            <div class="stats-grid">
                                <div class="stat-item">
                                    <div class="stat-value">0</div>
                                    <div class="stat-label">Workouts</div>
                                </div>
                                <div class="stat-item">
                                    <div class="stat-value">0</div>
                                    <div class="stat-label">Classes</div>
                                </div>
                                <div class="stat-item">
                                    <div class="stat-value">0</div>
                                    <div class="stat-label">Achievements</div>
                                </div>
                                <div class="stat-item">
                                    <div class="stat-value">0%</div>
                                    <div class="stat-label">Progress</div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Quick Actions -->
                    <div class="col-md-4">
                        <div class="profile-card h-100">
                            <h5 class="text-gradient mb-4">Quick Actions</h5>
                            <div class="d-grid gap-2">
                                <a href="dashboard.jsp" class="btn btn-outline-custom">
                                    <i class="fas fa-tachometer-alt me-2"></i> Dashboard
                                </a>
                                <a href="services.jsp" class="btn btn-outline-custom">
                                    <i class="fas fa-credit-card me-2"></i> Membership
                                </a>
                                <a href="logout" class="btn btn-outline-custom text-danger">
                                    <i class="fas fa-sign-out-alt me-2"></i> Logout
                                </a>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Account Security -->
                    <div class="col-md-4">
                        <div class="profile-card h-100">
                            <h5 class="text-gradient mb-4">Security</h5>
                            <div class="mb-3">
                                <div class="d-flex justify-content-between align-items-center mb-2">
                                    <span>2FA</span>
                                    <span class="badge bg-warning text-dark">Disabled</span>
                                </div>
                                <button class="btn btn-sm btn-outline-custom">Enable</button>
                            </div>
                            <div class="mb-3">
                                <div class="d-flex justify-content-between align-items-center mb-2">
                                    <span>Login Alerts</span>
                                    <span class="badge bg-success">Enabled</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        function togglePassword(fieldId) {
            const field = document.getElementById(fieldId);
            const icon = event.target;
            
            if (field.type === 'password') {
                field.type = 'text';
                icon.classList.remove('fa-eye');
                icon.classList.add('fa-eye-slash');
            } else {
                field.type = 'password';
                icon.classList.remove('fa-eye-slash');
                icon.classList.add('fa-eye');
            }
        }
        
        function resetForm() {
            if (confirm('Are you sure you want to reset all changes?')) {
                document.querySelector('form').reset();
            }
        }
        
        // Form validation
        document.querySelector('form').addEventListener('submit', function(e) {
            const currentPassword = document.getElementById('currentPassword').value;
            const newPassword = document.getElementById('newPassword').value;
            const confirmPassword = document.getElementById('confirmPassword').value;
            
            // Check if password change is attempted
            if (currentPassword || newPassword || confirmPassword) {
                if (!currentPassword || !newPassword || !confirmPassword) {
                    e.preventDefault();
                    showError('Please fill in all password fields to change password');
                    return;
                }
                
                if (newPassword !== confirmPassword) {
                    e.preventDefault();
                    showError('New passwords do not match');
                    return;
                }
                
                if (newPassword.length < 6) {
                    e.preventDefault();
                    showError('New password must be at least 6 characters long');
                    return;
                }
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
            
            const form = document.querySelector('form');
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
        
        function previewAvatar(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function(e) {
                    document.getElementById('avatarPreview').src = e.target.result;
                    document.getElementById('avatarPreview').style.display = 'block';
                    document.getElementById('avatarIcon').style.display = 'none';
                    document.getElementById('profileImageBase64').value = e.target.result;
                }
                reader.readAsDataURL(input.files[0]);
            }
        }
    </script>
    <jsp:include page="components/footer.jsp" />
</body>
</html>


