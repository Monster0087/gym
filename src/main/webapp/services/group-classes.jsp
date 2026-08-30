<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Group Classes - PowerLift Gym</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@700;900&family=Outfit:wght@300;400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="../css/style.css">
    <style>
        body { font-family: 'Outfit', sans-serif; background: #0a0b10; color: #fff; }
        .hero-section {
            background: linear-gradient(rgba(0,0,0,0.7), rgba(0,0,0,0.7)), url('https://images.unsplash.com/photo-1518611012118-2960c8b488a6?ixlib=rb-4.0.3&auto=format&fit=crop&w=1920&q=80') center/cover;
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
            <h1 class="text-gradient display-3" style="font-family: 'Orbitron';">GROUP CLASSES</h1>
            <p class="lead">Train together, win together.</p>
        </div>
    </header>
    <main class="container mb-5">
        <div class="content-card">
            <div class="row g-5">
                <div class="col-lg-7">
                    <h2 class="text-gradient mb-4">ENERGY & COMMUNITY</h2>
                    <p class="text-muted fs-5 mb-4">Experience the power of group energy. Our classes are led by expert instructors who will push you beyond your limits.</p>
                    <div class="row g-4">
                        <div class="col-md-6">
                            <div class="feature-box">
                                <i class="fas fa-bolt text-info fs-3 mb-3"></i>
                                <h5>HIIT & Cardio</h5>
                                <p class="small text-muted">High-intensity intervals to burn calories and boost endurance.</p>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="feature-box">
                                <i class="fas fa-leaf text-info fs-3 mb-3"></i>
                                <h5>Yoga & Pilates</h5>
                                <p class="small text-muted">Find your balance and core strength in our serenity studio.</p>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-5">
                    <div class="p-4 rounded-4" style="background: rgba(0,240,255,0.05); border: 1px solid rgba(0,240,255,0.2);">
                        <h4>VIEW SCHEDULE</h4>
                        <p class="small text-muted">Check our weekly class timetable.</p>
                        <a href="../trainers.jsp" class="btn btn-primary-gradient w-100 mb-3">VIEW CALENDAR</a>
                        <p class="text-center x-small text-muted">Join any class with a Premium membership.</p>
                    </div>
                </div>
            </div>
        </div>
    </main>
    <jsp:include page="../components/footer.jsp" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
