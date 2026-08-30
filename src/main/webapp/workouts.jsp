<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Workouts - PowerLift Gym</title>
    
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
        
        .workouts-hero {
            background: linear-gradient(135deg, #0a0b10 0%, #1a1c29 100%);
            height: 30vh;
            display: flex;
            align-items: center;
            justify-content: center;
            text-align: center;
            border-bottom: 2px solid var(--primary-color);
            position: relative;
            overflow: hidden;
        }
        
        .workouts-hero::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            right: 0;
            height: 100px;
            background: linear-gradient(to top, #0a0b10, transparent);
            pointer-events: none;
        }
        
        .workout-card {
            background: rgba(26, 28, 41, 0.6);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(0, 240, 255, 0.1);
            border-radius: 20px;
            overflow: hidden;
            transition: all 0.3s ease;
            height: 100%;
            display: flex;
            flex-direction: column;
        }
        
        .workout-card:hover {
            transform: translateY(-10px);
            border-color: rgba(0, 240, 255, 0.4);
            box-shadow: 0 15px 40px rgba(0, 240, 255, 0.15);
        }
        
        .workout-img-container {
            position: relative;
            height: 220px;
            overflow: hidden;
        }

        .workout-img {
            height: 100%;
            width: 100%;
            object-fit: cover;
            transition: transform 0.5s ease;
        }

        .workout-card:hover .workout-img {
            transform: scale(1.1);
        }
        
        .difficulty-badge {
            position: absolute;
            top: 15px;
            right: 15px;
            padding: 5px 12px;
            border-radius: 30px;
            font-size: 0.75rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 1px;
            z-index: 2;
        }
        
        .difficulty-Beginner { background: #00ff00; color: #000; }
        .difficulty-Intermediate { background: #ffff00; color: #000; }
        .difficulty-Advanced { background: #ff0000; color: #fff; }
        
        .category-badge {
            display: inline-block;
            background: rgba(0, 240, 255, 0.1);
            color: #00f0ff;
            padding: 2px 10px;
            border-radius: 5px;
            font-size: 0.8rem;
            margin-bottom: 0.5rem;
        }
        
        .btn-finish {
            background: linear-gradient(135deg, #00f0ff 0%, #0077ff 100%);
            border: none;
            color: #0a0b10;
            font-weight: 700;
            transition: all 0.3s ease;
            margin-top: auto;
        }
        
        .btn-finish:hover:not(:disabled) {
            transform: scale(1.02);
            box-shadow: 0 5px 15px rgba(0, 240, 255, 0.4);
        }
        
        .btn-finish.done {
            background: #198754 !important;
            color: white !important;
            cursor: default;
            opacity: 1 !important;
            border: none !important;
        }
        
        .filter-btn {
            background: rgba(255, 255, 255, 0.05);
            border: 1px solid rgba(255, 255, 255, 0.1);
            color: #fff;
            border-radius: 30px;
            padding: 8px 20px;
            margin: 5px;
            transition: all 0.3s ease;
        }
        
        .filter-btn.active {
            background: #00f0ff;
            color: #0a0b10;
            border-color: #00f0ff;
        }

        .difficulty-badge-static {
            padding: 5px 12px;
            font-size: 0.7rem;
            font-weight: 700;
            letter-spacing: 1px;
            text-transform: uppercase;
        }
        
        .difficulty-Beginner { background: #00ff00; color: #000; }
        .difficulty-Intermediate { background: #ffff00; color: #000; }
        .difficulty-Advanced { background: #ff0000; color: #fff; }

        .nav-user-avatar {
            width: 30px;
            height: 30px;
            border-radius: 50%;
            object-fit: cover;
            border: 2px solid var(--primary-color);
            margin-right: 8px;
        }

        .user-name-nav {
            font-weight: 600;
            font-size: 0.9rem;
            max-width: 100px;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }
        
        .register-btn {
            background: var(--gradient-primary);
            color: #0a0b10 !important;
            padding: 0.5rem 1.5rem !important;
            border-radius: 50px;
            font-weight: 700;
            margin-left: 10px;
        }
    </style>
</head>
<body>
    <jsp:include page="components/navbar.jsp" />

    <section class="workouts-hero">
        <div class="container">
            <h1 class="display-3 font-orbitron text-gradient">DAILY WORKOUTS</h1>
            <p class="lead">Your progress is saved automatically. Crush your goals!</p>
        </div>
    </section>

    <div class="container py-5">
        <div class="text-center mb-5">
            <div id="categoryFilters" class="mb-4">
                <button class="filter-btn active" data-category="all">All Workouts</button>
                <button class="filter-btn" data-category="Strength">Strength</button>
                <button class="filter-btn" data-category="Cardio">Cardio</button>
                <button class="filter-btn" data-category="Yoga">Yoga</button>
                <button class="filter-btn" data-category="HIIT">HIIT</button>
            </div>
        </div>

        <div class="row g-4" id="workoutsGrid">
            <!-- Workouts will be populated by JS -->
            <div class="col-12 text-center py-5" id="loader">
                <div class="spinner-border text-info" role="status"></div>
                <p class="mt-3">Fetching your workout progress...</p>
            </div>
        </div>
    </div>

    <jsp:include page="components/footer.jsp" />

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        let allWorkouts = [];
        let currentFilter = 'all';
        
        document.addEventListener('DOMContentLoaded', function() {
            fetchWorkouts();
            
            // Filter logic
            const filterBtns = document.querySelectorAll('.filter-btn');
            filterBtns.forEach(btn => {
                btn.addEventListener('click', function() {
                    filterBtns.forEach(b => b.classList.remove('active'));
                    this.classList.add('active');
                    currentFilter = this.getAttribute('data-category');
                    renderWorkouts(currentFilter);
                });
            });
        });

        function fetchWorkouts() {
            // Added cache-busting parameter 't'
            fetch('${pageContext.request.contextPath}/api/workouts?t=' + Date.now())
                .then(res => res.json())
                .then(data => {
                    allWorkouts = data;
                    renderWorkouts(currentFilter);
                })
                .catch(err => {
                    console.error('Error fetching workouts:', err);
                    document.getElementById('workoutsGrid').innerHTML = '<div class="col-12 text-center text-danger">Session expired or connection lost. Please reload.</div>';
                });
        }

        function renderWorkouts(category) {
            const grid = document.getElementById('workoutsGrid');
            grid.innerHTML = '';
            
            const filtered = category === 'all' 
                ? allWorkouts 
                : allWorkouts.filter(w => w.category === category);
            
            if (filtered.length === 0) {
                grid.innerHTML = '<div class="col-12 text-center py-5 text-muted">No workouts found in this category.</div>';
                return;
            }

            filtered.forEach(w => {
                // Precise check for isCompleted from backend
                const isDone = w.isCompleted || w.completed || false;
                const card = `
                    <div class="col-md-6 col-lg-4">
                        <div class="workout-card p-4">
                            <div class="d-flex justify-content-between align-items-start mb-3">
                                <span class="category-badge mb-0">\${w.category}</span>
                                <span class="badge rounded-pill difficulty-badge-static difficulty-\${w.difficulty}">\${w.difficulty}</span>
                            </div>
                            <h4 class="mb-2 font-orbitron text-uppercase" style="font-size: 1.2rem;">\${w.name}</h4>
                            <p class="small text-muted mb-4" style="line-height: 1.5;">\${w.description || 'Intensive daily training session focused on peak performance.'}</p>
                            <button id="btn-workout-\${w.id}" 
                                    class="btn btn-finish w-100 py-3 mt-auto \${isDone ? 'done' : ''}" 
                                    onclick="completeWorkout(\${w.id}, this)" 
                                    \${isDone ? 'disabled' : ''}>
                                <i class="fas \${isDone ? 'fa-check-double' : 'fa-check'} me-2"></i> 
                                \${isDone ? 'COMPLETED' : 'MARK FINISHED'}
                            </button>
                        </div>
                    </div>
                `;
                grid.innerHTML += card;
            });
        }

        function completeWorkout(id, btn) {
            // Immediate feedback
            const originalContent = btn.innerHTML;
            btn.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i> SYNCING...';
            btn.disabled = true;
            
            fetch('${pageContext.request.contextPath}/api/workouts', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: 'workoutId=' + id
            })
            .then(res => res.json())
            .then(data => {
                if (data.success) {
                    btn.innerHTML = '<i class="fas fa-check-double me-2"></i> COMPLETED';
                    btn.classList.add('done');
                    // Update local data state so filters don't reset it
                    const workout = allWorkouts.find(w => w.id === id);
                    if (workout) workout.isCompleted = true;
                } else {
                    btn.innerHTML = originalContent;
                    btn.disabled = false;
                    alert('Could not save progress. Please try again.');
                }
            })
            .catch(err => {
                console.error('Error saving progress:', err);
                btn.innerHTML = 'ERROR';
                btn.disabled = false;
            });
        }
    </script>
</body>
</html>
