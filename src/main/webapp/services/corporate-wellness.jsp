<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Corporate Wellness - PowerLift Gym</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@700;900&family=Outfit:wght@300;400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="../css/style.css">
    <style>
        body { font-family: 'Outfit', sans-serif; background: #0a0b10; color: #fff; }
        .hero-section {
            background: linear-gradient(rgba(0,0,0,0.7), rgba(0,0,0,0.7)), url('https://images.unsplash.com/photo-1542744173-8e7e53415bb0?ixlib=rb-4.0.3&auto=format&fit=crop&w=1920&q=80') center/cover;
            height: 60vh; display: flex; align-items: center; justify-content: center; text-align: center;
        }
        .content-card {
            background: rgba(26, 28, 41, 0.8); backdrop-filter: blur(20px); border: 1px solid rgba(0, 240, 255, 0.1);
            border-radius: 30px; padding: 3rem; margin-top: -100px; box-shadow: 0 20px 50px rgba(0,0,0,0.5);
        }
        .feature-box {
            background: rgba(255, 255, 255, 0.03); border: 1px solid rgba(255, 255, 255, 0.05);
            border-radius: 20px; padding: 2rem; height: 100%; transition: all 0.3s ease;
        }
        .feature-box:hover { border-color: #00f0ff; transform: translateY(-5px); }
    </style>
</head>
<body>
    <jsp:include page="../components/navbar.jsp" />
    <header class="hero-section">
        <div class="container">
            <h1 class="text-gradient display-3" style="font-family: 'Orbitron';">CORPORATE WELLNESS</h1>
            <p class="lead">Healthy employees, productive business.</p>
        </div>
    </header>
    <main class="container mb-5">
        <div class="content-card">
            <div class="row g-5">
                <div class="col-lg-7">
                    <h2 class="text-gradient mb-4">INVEST IN YOUR TEAM</h2>
                    <p class="text-muted fs-5 mb-4">A healthy workforce is a happy and productive one. Our corporate wellness programs are designed to reduce stress and improve team morale.</p>
                    <div class="row g-4">
                        <div class="col-md-6">
                            <div class="feature-box">
                                <i class="fas fa-building text-info fs-3 mb-3"></i>
                                <h5>Corporate Rates</h5>
                                <p class="small text-muted">Special discounted memberships for your entire organization.</p>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="feature-box">
                                <i class="fas fa-users-cog text-info fs-3 mb-3"></i>
                                <h5>Team Building</h5>
                                <p class="small text-muted">Custom fitness workshops designed for team bonding.</p>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-5">
                    <div class="p-4 rounded-4" style="background: rgba(0,240,255,0.05); border: 1px solid rgba(0,240,255,0.2);">
                        <h4>GET A QUOTE</h4>
                        <p class="small text-muted">Contact our corporate relations manager.</p>
                        <form action="../contact-submit" method="POST">
                            <div class="mb-3"><input type="text" class="form-control bg-dark text-white border-secondary" placeholder="Company Name" required></div>
                            <div class="mb-3"><input type="email" class="form-control bg-dark text-white border-secondary" placeholder="Work Email" required></div>
                            <button type="submit" class="btn btn-primary-gradient w-100">SEND REQUEST</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </main>
    <jsp:include page="../components/footer.jsp" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
