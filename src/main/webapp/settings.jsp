<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.gym.model.User" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Account Settings - PowerLift Gym</title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@700;900&family=Outfit:wght@300;400;600&display=swap" rel="stylesheet">
    <!-- Custom CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    
    <style>
        body {
            background-color: #0a0b10;
            color: #ffffff;
            font-family: 'Outfit', sans-serif;
        }
        
        .settings-header {
            background: linear-gradient(rgba(0,0,0,0.7), rgba(0,0,0,0.7)), url('https://images.unsplash.com/photo-1594882645126-14020914d58d?ixlib=rb-4.0.3&auto=format&fit=crop&w=1920&q=80') center/cover;
            height: 30vh;
            display: flex;
            align-items: center;
            justify-content: center;
            text-align: center;
            border-bottom: 1px solid rgba(0, 240, 255, 0.1);
        }
        
        .settings-card {
            background: rgba(26, 28, 41, 0.6);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(0, 240, 255, 0.1);
            border-radius: 20px;
            padding: 2.5rem;
            margin-top: -50px;
            box-shadow: 0 20px 50px rgba(0, 0, 0, 0.5);
        }
        
        .form-label {
            color: rgba(255, 255, 255, 0.6);
            font-size: 0.85rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-bottom: 0.5rem;
        }
        
        .form-control-custom {
            background: rgba(255, 255, 255, 0.05);
            border: 1px solid rgba(255, 255, 255, 0.1);
            color: #fff;
            padding: 1rem;
            border-radius: 12px;
            transition: all 0.3s ease;
        }
        
        .form-control-custom:focus {
            background: rgba(255, 255, 255, 0.08);
            border-color: #00f0ff;
            color: #fff;
            box-shadow: 0 0 15px rgba(0, 240, 255, 0.2);
        }
        
        .section-title {
            color: #00f0ff;
            font-family: 'Orbitron';
            font-size: 1.2rem;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .section-title i {
            font-size: 1rem;
        }
        
        .btn-save {
            background: linear-gradient(135deg, #00f0ff 0%, #0077ff 100%);
            border: none;
            color: #0a0b10;
            font-weight: 700;
            padding: 1rem 2rem;
            border-radius: 12px;
            transition: all 0.3s ease;
        }
        
        .btn-save:hover {
            transform: scale(1.02);
            box-shadow: 0 10px 25px rgba(0, 240, 255, 0.4);
        }
        
        .avatar-edit {
            position: relative;
            width: 120px;
            height: 120px;
            margin: 0 auto 2rem;
        }
        
        .avatar-edit img {
            width: 100%;
            height: 100%;
            border-radius: 50%;
            object-fit: cover;
            border: 3px solid #00f0ff;
        }
        
        .edit-overlay {
            position: absolute;
            bottom: 5px;
            right: 5px;
            background: #00f0ff;
            color: #0a0b10;
            width: 35px;
            height: 35px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            border: 3px solid #0a0b10;
        }
    </style>
</head>
<body>
    <jsp:include page="components/navbar.jsp" />

    <%
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }
    %>

    <section class="settings-header">
        <div class="container">
            <h1 class="display-4 font-orbitron text-gradient">SETTINGS</h1>
            <p class="lead">Manage your profile and account preferences</p>
        </div>
    </section>

    <div class="container pb-5">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="settings-card">
                    <form action="profile" method="POST">
                        <input type="hidden" name="profileImageBase64" id="profileImageBase64">
                        
                        <div class="avatar-edit">
                            <img id="avatarPreview" src="<%= (user.getProfileImage() != null && !user.getProfileImage().isEmpty()) ? user.getProfileImage() : "https://cdn-icons-png.flaticon.com/512/3135/3135715.png" %>" alt="Avatar">
                            <label for="pfpUpload" class="edit-overlay">
                                <i class="fas fa-camera"></i>
                            </label>
                            <input type="file" id="pfpUpload" class="d-none" accept="image/*" onchange="previewAvatar(this)">
                        </div>

                        <div class="row g-4">
                            <!-- Personal Info -->
                            <div class="col-12">
                                <h3 class="section-title"><i class="fas fa-user"></i> Personal Information</h3>
                            </div>
                            
                            <div class="col-md-6">
                                <label class="form-label">Full Name</label>
                                <input type="text" name="name" class="form-control form-control-custom" value="<%= user.getName() %>" required>
                            </div>
                            
                            <div class="col-md-6">
                                <label class="form-label">Email Address</label>
                                <input type="email" name="email" class="form-control form-control-custom" value="<%= user.getEmail() %>" required>
                            </div>
                            
                            <div class="col-md-6">
                                <label class="form-label">Phone Number</label>
                                <input type="tel" name="phone" class="form-control form-control-custom" value="<%= (user.getPhone() != null) ? user.getPhone() : "" %>">
                            </div>

                            <!-- Security -->
                            <div class="col-12 mt-5">
                                <h3 class="section-title"><i class="fas fa-shield-alt"></i> Security</h3>
                            </div>
                            
                            <div class="col-12">
                                <label class="form-label">Current Password</label>
                                <input type="password" name="currentPassword" class="form-control form-control-custom" placeholder="Required for password change">
                            </div>
                            
                            <div class="col-md-6">
                                <label class="form-label">New Password</label>
                                <input type="password" name="newPassword" class="form-control form-control-custom">
                            </div>
                            
                            <div class="col-md-6">
                                <label class="form-label">Confirm New Password</label>
                                <input type="password" name="confirmPassword" class="form-control form-control-custom">
                            </div>

                            <div class="col-12 mt-5">
                                <button type="submit" class="btn btn-save w-100">
                                    <i class="fas fa-save me-2"></i> SAVE ALL CHANGES
                                </button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="components/footer.jsp" />

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        function previewAvatar(input) {
            if (input.files && input.files[0]) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    document.getElementById('avatarPreview').src = e.target.result;
                    document.getElementById('profileImageBase64').value = e.target.result;
                }
                reader.readAsDataURL(input.files[0]);
            }
        }
    </script>
</body>
</html>
