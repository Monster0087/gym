<%@ page import="com.gym.model.User, com.gym.dao.MembershipPlanDAO, com.gym.dao.WorkoutDAO, java.sql.*, com.gym.util.DatabaseUtil" %>
<%@ page import="com.gym.model.MembershipPlan, java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - PowerLift Gym</title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600;800&family=Orbitron:wght@700;900&display=swap" rel="stylesheet">
    <!-- Custom CSS -->
    <link rel="stylesheet" href="css/style.css">
    
    <style>
        :root {
            --primary-cyan: #00f0ff;
            --primary-blue: #0077ff;
            --present-green: #00ff80;
            --dark-bg: #0a0b10;
            --card-bg: rgba(26, 28, 41, 0.75);
        }

        body {
            font-family: 'Outfit', sans-serif;
            background: linear-gradient(rgba(10, 11, 16, 0.92), rgba(10, 11, 16, 0.95)), 
                        url('https://images.unsplash.com/photo-1534438327276-14e5300c3a48?ixlib=rb-4.0.3&auto=format&fit=crop&w=3840&q=80') center/cover fixed no-repeat;
            color: #fff;
            min-height: 100vh;
        }
        
        .dashboard-header {
            background: linear-gradient(135deg, rgba(10, 11, 16, 0.98) 0%, rgba(26, 28, 41, 0.85) 100%);
            padding: 3rem 0;
            margin-bottom: 2.5rem;
            border-bottom: 1px solid rgba(0, 240, 255, 0.2);
            box-shadow: 0 15px 40px rgba(0, 0, 0, 0.6);
            margin-top: 80px;
        }
        
        .text-gradient {
            background: linear-gradient(135deg, var(--primary-cyan) 0%, var(--primary-blue) 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            font-family: 'Orbitron', sans-serif;
            font-weight: 900;
            letter-spacing: 1px;
        }

        .membership-card {
            background: var(--card-bg);
            backdrop-filter: blur(25px);
            border: 1px solid rgba(0, 240, 255, 0.15);
            border-radius: 28px;
            padding: 2.2rem;
            margin-bottom: 2.2rem;
            box-shadow: 0 25px 60px rgba(0, 0, 0, 0.5);
            transition: all 0.4s ease;
        }

        .membership-card:hover {
            border-color: rgba(0, 240, 255, 0.4);
            transform: translateY(-2px);
        }
        
        .stat-card {
            background: rgba(255, 255, 255, 0.03);
            backdrop-filter: blur(15px);
            border: 1px solid rgba(255, 255, 255, 0.05);
            border-radius: 24px;
            padding: 2rem;
            text-align: center;
            transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            height: 100%;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
        }
        
        .stat-card:hover {
            transform: translateY(-12px);
            border-color: var(--primary-cyan);
            background: rgba(0, 240, 255, 0.04);
            box-shadow: 0 15px 45px rgba(0, 240, 255, 0.15);
        }
        
        .stat-icon {
            width: 60px;
            height: 60px;
            background: rgba(0, 240, 255, 0.1);
            border-radius: 18px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 1.5rem;
            font-size: 1.5rem;
            color: var(--primary-cyan);
            box-shadow: 0 10px 25px rgba(0, 240, 255, 0.2);
        }
        
        .stat-number {
            font-size: 2.5rem;
            font-weight: 800;
            margin-bottom: 0.3rem;
            letter-spacing: -1px;
            color: #fff;
        }

        .attendance-day {
            width: 45px;
            height: 45px;
            border-radius: 14px;
            display: flex;
            align-items: center;
            justify-content: center;
            background: rgba(255, 255, 255, 0.04);
            border: 1px solid rgba(255, 255, 255, 0.1);
            font-size: 1rem;
            font-weight: 600;
            transition: all 0.3s ease;
            color: #888;
        }
        
        .attendance-day.present {
            background: linear-gradient(135deg, #00ff80 0%, #00cc66 100%);
            color: #0a0b10 !important;
            border-color: #00ff80;
            box-shadow: 0 0 20px rgba(0, 255, 128, 0.5);
        }
        
        .attendance-day.today {
            border: 2px solid var(--primary-cyan);
            box-shadow: 0 0 20px rgba(0, 240, 255, 0.4);
            color: #fff;
        }

        .btn-mark-attendance {
            background: linear-gradient(135deg, var(--primary-cyan) 0%, var(--primary-blue) 100%);
            color: #0a0b10;
            border: none;
            padding: 1.2rem;
            border-radius: 20px;
            font-weight: 800;
            width: 100%;
            transition: all 0.3s ease;
            text-transform: uppercase;
            letter-spacing: 1.5px;
            box-shadow: 0 15px 30px rgba(0, 240, 255, 0.3);
        }
        
        .btn-mark-attendance:hover {
            transform: scale(1.03) translateY(-2px);
            box-shadow: 0 20px 40px rgba(0, 240, 255, 0.5);
        }
        
        .btn-mark-attendance.marked {
            background: rgba(255, 255, 255, 0.08);
            color: #555;
            pointer-events: none;
            box-shadow: none;
            border: 1px solid rgba(255, 255, 255, 0.05);
        }

        .quick-action-card {
            background: rgba(255, 255, 255, 0.04);
            border: 1px solid rgba(255, 255, 255, 0.08);
            border-radius: 22px;
            padding: 1.8rem;
            text-align: center;
            text-decoration: none;
            color: #fff;
            display: block;
            transition: all 0.3s ease;
            cursor: pointer;
        }
        
        .quick-action-card:hover {
            background: rgba(0, 240, 255, 0.1);
            border-color: var(--primary-cyan);
            color: var(--primary-cyan);
            transform: translateY(-8px);
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.4);
        }

        .modal-content {
            background: #0f111a;
            border: 1px solid rgba(0, 240, 255, 0.4);
            border-radius: 30px;
            box-shadow: 0 0 80px rgba(0, 240, 255, 0.25);
            overflow: hidden;
        }

        .form-control-custom {
            background: rgba(255, 255, 255, 0.07);
            border: 1px solid rgba(255, 255, 255, 0.15);
            color: #fff;
            padding: 1.2rem;
            border-radius: 16px;
            transition: all 0.3s ease;
        }

        .btn-primary-gradient {
            background: linear-gradient(135deg, var(--primary-cyan) 0%, var(--primary-blue) 100%);
            border: none;
            color: #0a0b10;
            font-weight: 800;
            padding: 1.2rem 2.5rem;
            border-radius: 50px;
            transition: all 0.3s ease;
            letter-spacing: 1px;
        }

        .badge-status {
            background: rgba(0, 240, 255, 0.15);
            color: var(--primary-cyan);
            border: 1px solid rgba(0, 240, 255, 0.4);
            padding: 0.8rem 1.5rem;
            border-radius: 40px;
            font-size: 0.9rem;
            font-weight: 600;
        }

        .workout-item {
            background: rgba(255, 255, 255, 0.03);
            border: 1px solid rgba(255, 255, 255, 0.05);
            border-radius: 16px;
            padding: 1.2rem;
            margin-bottom: 1rem;
            transition: all 0.3s ease;
        }

        .workout-item:hover {
            background: rgba(0, 240, 255, 0.05);
            border-color: var(--primary-cyan);
        }
    </style>
</head>
<body>

    <!-- Modular Navbar -->
    <jsp:include page="components/navbar.jsp" />

    <% 
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        MembershipPlan currentPlan = null;
        int daysRemaining = 0;
        int completedWorkouts = 0;
        
        try {
            Connection conn = DatabaseUtil.getConnection();
            // Membership
            String sql = "SELECT mp.*, um.end_date FROM user_memberships um " +
                        "JOIN membership_plans mp ON um.plan_id = mp.id " +
                        "WHERE um.user_id = ? AND um.status = 'active' LIMIT 1";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, user.getId());
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                currentPlan = new MembershipPlan();
                currentPlan.setPlanName(rs.getString("plan_name"));
                java.sql.Date endDate = rs.getDate("end_date");
                if (endDate != null) {
                    long diff = endDate.getTime() - System.currentTimeMillis();
                    daysRemaining = (int) (diff / (1000 * 60 * 60 * 24));
                }
            }
            
            // Workouts count
            WorkoutDAO workoutDAO = new WorkoutDAO();
            completedWorkouts = workoutDAO.getCompletedWorkoutsCount(user.getId());
            
            conn.close();
        } catch (Exception e) { e.printStackTrace(); }
    %>

    <div class="dashboard-header">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-md-8">
                    <h1 class="text-white mb-2" style="font-family: 'Orbitron'; font-weight: 900;">WELCOME BACK, <span class="text-gradient"><%= user.getName().toUpperCase() %></span>!</h1>
                    <p class="text-muted" style="font-size: 1.1rem;">Track your progress and dominate your fitness goals.</p>
                </div>
                <div class="col-md-4 text-md-end">
                    <button class="btn btn-primary-gradient rounded-pill shadow-lg" data-bs-toggle="modal" data-bs-target="#logProgressModal">
                        <i class="fas fa-plus me-2"></i> LOG PROGRESS
                    </button>
                </div>
            </div>
        </div>
    </div>

    <div class="container pb-5">
        <% if ("success".equals(request.getParameter("payment"))) { %>
            <div class="alert alert-success alert-dismissible fade show mb-4 border-0 shadow-lg" role="alert" style="background: rgba(0, 255, 128, 0.15); color: #00ff80; border: 1px solid rgba(0, 255, 128, 0.3) !important; backdrop-filter: blur(10px);">
                <div class="d-flex align-items-center">
                    <i class="fas fa-check-circle fs-3 me-3"></i>
                    <div>
                        <strong>Payment Successfully!</strong> Your membership plan <strong><%= request.getParameter("plan") %></strong> has been activated.
                    </div>
                </div>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        <% } %>
        <!-- Stats Row -->
        <div class="row g-4 mb-5">
            <div class="col-md-3">
                <div class="stat-card">
                    <div class="stat-icon"><i class="fas fa-calendar-alt"></i></div>
                    <div class="stat-number" id="activeDays">0</div>
                    <p class="text-muted small mb-0">DAYS PRESENT (MONTH)</p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stat-card">
                    <div class="stat-icon"><i class="fas fa-dumbbell"></i></div>
                    <div class="stat-number" id="workoutCount"><%= completedWorkouts %></div>
                    <p class="text-muted small mb-0">WORKOUTS FINISHED</p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stat-card">
                    <div class="stat-icon"><i class="fas fa-trophy"></i></div>
                    <div class="stat-number" id="achievements">3</div>
                    <p class="text-muted small mb-0">ACHIEVEMENTS</p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stat-card">
                    <div class="stat-icon"><i class="fas fa-bullseye"></i></div>
                    <div class="stat-number" id="goalProgress">65%</div>
                    <p class="text-muted small mb-0">WEEKLY GOAL</p>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-lg-8">
                <!-- Attendance Tracker -->
                <div class="membership-card">
                    <div class="d-flex justify-content-between align-items-center mb-5">
                        <h4 class="text-gradient mb-0" style="letter-spacing: 2px;"><i class="fas fa-calendar-check me-2"></i> ATTENDANCE TRACKER</h4>
                        <span class="badge-status" id="attendanceStatus">
                            0 Days Present This Month
                        </span>
                    </div>
                    
                    <div class="row align-items-center">
                        <div class="col-md-5 mb-4 mb-md-0">
                            <button class="btn-mark-attendance" id="markAttendanceBtn" onclick="markAttendance()">
                                <i class="fas fa-fingerprint me-2"></i> MARK PRESENT TODAY
                            </button>
                        </div>
                        <div class="col-md-7">
                            <div class="d-flex justify-content-between mb-3 px-1">
                                <small class="text-muted fw-bold" id="presentCountLabel">0 / 7 DAYS PRESENT THIS WEEK</small>
                                <small class="text-muted fw-bold">CURRENT WEEK</small>
                            </div>
                            <div class="d-flex justify-content-between" id="weeklyAttendance" style="min-height: 45px;">
                                <!-- Populated by JS -->
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Progress History Chart -->
                <div class="membership-card">
                    <h4 class="text-gradient mb-5" style="letter-spacing: 2px;"><i class="fas fa-chart-line me-2"></i> YOUR PROGRESS HISTORY</h4>
                    <div style="height: 380px; width: 100%;">
                        <canvas id="userGrowthChart"></canvas>
                    </div>
                </div>
            </div>

            <div class="col-lg-4">
                <div class="membership-card mb-4">
                    <h5 class="text-white mb-4" style="font-family: 'Orbitron'; font-size: 1.1rem; letter-spacing: 2px;">QUICK ACTIONS</h5>
                    <div class="row g-3">
                        <div class="col-6"><a href="${pageContext.request.contextPath}/diet-plans.jsp" class="quick-action-card"><i class="fas fa-apple-alt d-block mb-3 fs-3"></i><small class="fw-bold">Diet Plan</small></a></div>
                        <div class="col-6"><a href="${pageContext.request.contextPath}/workouts.jsp" class="quick-action-card"><i class="fas fa-dumbbell d-block mb-3 fs-3"></i><small class="fw-bold">Workouts</small></a></div>
                        <div class="col-6"><a href="${pageContext.request.contextPath}/trainers.jsp" class="quick-action-card"><i class="fas fa-user-friends d-block mb-3 fs-3"></i><small class="fw-bold">Trainers</small></a></div>
                        <div class="col-6"><a href="${pageContext.request.contextPath}/contact.jsp" class="quick-action-card"><i class="fas fa-headset d-block mb-3 fs-3"></i><small class="fw-bold">Support</small></a></div>
                    </div>
                </div>
                
                <div class="membership-card">
                    <h5 class="text-white mb-4" style="font-family: 'Orbitron'; font-size: 1.1rem; letter-spacing: 2px;">MEMBERSHIP</h5>
                    <% if (currentPlan != null) { %>
                        <div class="p-4 rounded-4" style="background: rgba(0, 240, 255, 0.05); border: 1px solid rgba(0, 240, 255, 0.1);">
                            <div class="d-flex justify-content-between align-items-center mb-3">
                                <span class="text-muted small fw-bold">CURRENT PLAN:</span>
                                <span class="text-primary-cyan fw-bold"><%= currentPlan.getPlanName() %></span>
                            </div>
                            <div class="d-flex justify-content-between align-items-center">
                                <span class="text-muted small fw-bold">TIME LEFT:</span>
                                <span class="text-warning fw-bold"><%= daysRemaining %> DAYS</span>
                            </div>
                        </div>
                    <% } else { %>
                        <p class="text-muted small mb-4">No active membership plan found. Start your journey today!</p>
                        <a href="${pageContext.request.contextPath}/services.jsp" class="btn btn-primary-gradient w-100 py-3">CHOOSE A PLAN</a>
                    <% } %>
                </div>
            </div>
        </div>
    </div>

    <!-- Workouts Modal -->
    <div class="modal fade" id="workoutsModal" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered modal-lg">
            <div class="modal-content">
                <div class="modal-header border-0 px-4 pt-4">
                    <h5 class="modal-title text-gradient">AVAILABLE WORKOUTS</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body px-4 pb-4" id="workoutsList">
                    <!-- Populated by JS -->
                    <div class="text-center py-5">
                        <div class="spinner-border text-info" role="status"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Log Progress Modal -->
    <div class="modal fade" id="logProgressModal" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header border-0 px-4 pt-4">
                    <h5 class="modal-title text-gradient" style="font-size: 1.5rem;">LOG YOUR PROGRESS</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <form action="save-progress" method="POST">
                    <div class="modal-body px-4">
                        <div class="mb-4">
                            <label class="form-label text-muted small fw-bold mb-2">WEIGHT (KG)</label>
                            <input type="number" step="0.1" name="weight" class="form-control form-control-custom" placeholder="Enter your current weight" required>
                        </div>
                        <div class="mb-4">
                            <label class="form-label text-muted small fw-bold mb-2">HEIGHT (CM)</label>
                            <input type="number" step="0.1" name="height" class="form-control form-control-custom" placeholder="Enter your current height" required>
                        </div>
                    </div>
                    <div class="modal-footer border-0 px-4 pb-4 gap-2">
                        <button type="button" class="btn btn-outline-light rounded-pill px-5 py-3 fw-bold" data-bs-dismiss="modal">CANCEL</button>
                        <button type="submit" class="btn btn-primary-gradient rounded-pill px-5 py-3 fw-bold">SAVE PROGRESS</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            fetchAttendance();
            initUserGrowthChart();
            loadWorkouts();
        });

        function fetchAttendance() {
            fetch('${pageContext.request.contextPath}/api/attendance')
                .then(res => res.json())
                .then(data => {
                    if (data.success) {
                        updateAttendanceUI(data.markedToday, data.monthlyCount);
                        updateWeeklyDots(data.weeklyAttendance);
                    }
                })
                .catch(err => console.error("Fetch Attendance Error:", err));
        }

        function updateAttendanceUI(markedToday, monthlyCount) {
            document.getElementById('attendanceStatus').textContent = monthlyCount + ' Days Present This Month';
            document.getElementById('activeDays').textContent = monthlyCount;
            
            const btn = document.getElementById('markAttendanceBtn');
            if (markedToday) {
                btn.classList.add('marked');
                btn.innerHTML = '<i class="fas fa-check-circle me-2"></i> ATTENDANCE MARKED';
                btn.disabled = true;
            } else {
                btn.classList.remove('marked');
                btn.innerHTML = '<i class="fas fa-fingerprint me-2"></i> MARK PRESENT TODAY';
                btn.disabled = false;
            }
        }

        function updateWeeklyDots(weeklyData) {
            const container = document.getElementById('weeklyAttendance');
            if (!container) return;
            
            const days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
            const now = new Date();
            const day = now.getDay(); 
            const diffToMonday = now.getDate() - day + (day === 0 ? -6 : 1);
            const monday = new Date(now);
            monday.setDate(diffToMonday);
            monday.setHours(0, 0, 0, 0);
            
            let presentCount = 0;
            let html = '';
            for (let i = 0; i < 7; i++) {
                const current = new Date(monday);
                current.setDate(monday.getDate() + i);
                
                const year = current.getFullYear();
                const month = String(current.getMonth() + 1).padStart(2, '0');
                const date = String(current.getDate()).padStart(2, '0');
                const dateStr = `\${year}-\${month}-\${date}`;
                
                let classes = 'attendance-day';
                if (weeklyData && weeklyData.includes(dateStr)) {
                    classes += ' present';
                    presentCount++;
                }
                
                const todayStr = `\${now.getFullYear()}-\${String(now.getMonth() + 1).padStart(2, '0')}-\${String(now.getDate()).padStart(2, '0')}`;
                if (dateStr === todayStr) {
                    classes += ' today';
                }
                
                html += `<div class="\${classes}">\${days[i]}</div>`;
            }
            container.innerHTML = html;
            document.getElementById('presentCountLabel').textContent = presentCount + ' / 7 DAYS PRESENT THIS WEEK';
        }

        function loadWorkouts() {
            fetch('${pageContext.request.contextPath}/api/workouts')
                .then(res => res.json())
                .then(data => {
                    const list = document.getElementById('workoutsList');
                    list.innerHTML = '';
                    data.forEach(w => {
                        list.innerHTML += `
                            <div class="workout-item d-flex justify-content-between align-items-center">
                                <div>
                                    <h6 class="text-white mb-1 font-orbitron">\${w.name}</h6>
                                    <small class="text-muted">\${w.category} • \${w.difficulty}</small>
                                </div>
                                <button class="btn btn-sm btn-outline-info rounded-pill" onclick="completeWorkout(\${w.id}, this)">
                                    FINISH
                                </button>
                            </div>
                        `;
                    });
                });
        }

        function completeWorkout(id, btn) {
            btn.innerHTML = '<i class="fas fa-spinner fa-spin"></i>';
            btn.disabled = true;
            
            fetch('${pageContext.request.contextPath}/api/workouts', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: 'workoutId=' + id
            })
            .then(res => res.json())
            .then(data => {
                if (data.success) {
                    btn.innerHTML = '<i class="fas fa-check"></i> DONE';
                    btn.classList.replace('btn-outline-info', 'btn-success');
                    document.getElementById('workoutCount').textContent = data.count;
                } else {
                    btn.innerHTML = 'RETRY';
                    btn.disabled = false;
                }
            });
        }

        function initUserGrowthChart() {
            fetch('${pageContext.request.contextPath}/api/growth')
                .then(res => res.json())
                .then(data => {
                    if (data && data.length > 0) {
                        const ctx = document.getElementById('userGrowthChart').getContext('2d');
                        const sortedData = [...data].sort((a, b) => new Date(a.recordedAt) - new Date(b.recordedAt));
                        
                        new Chart(ctx, {
                            type: 'line',
                            data: {
                                labels: sortedData.map(p => new Date(p.recordedAt).toLocaleDateString()),
                                datasets: [{
                                    label: 'Weight (kg)',
                                    data: sortedData.map(p => p.weight),
                                    borderColor: '#00f0ff',
                                    backgroundColor: 'rgba(0, 240, 255, 0.15)',
                                    fill: true,
                                    tension: 0.4,
                                    pointBackgroundColor: '#00f0ff',
                                    pointBorderColor: '#fff',
                                    pointRadius: 5,
                                    borderWidth: 3
                                }, {
                                    label: 'BMI',
                                    data: sortedData.map(p => p.bmi),
                                    borderColor: '#ff3232',
                                    backgroundColor: 'rgba(255, 50, 50, 0.08)',
                                    fill: true,
                                    tension: 0.4,
                                    pointBackgroundColor: '#ff3232',
                                    pointBorderColor: '#fff',
                                    pointRadius: 5,
                                    borderWidth: 3
                                }]
                            },
                            options: { 
                                responsive: true, 
                                maintainAspectRatio: false,
                                plugins: {
                                    legend: { labels: { color: '#ccc', font: { family: 'Outfit', weight: '600' } } }
                                },
                                scales: {
                                    y: { grid: { color: 'rgba(255, 255, 255, 0.05)' }, ticks: { color: '#888' } },
                                    x: { grid: { display: false }, ticks: { color: '#888' } }
                                }
                            }
                        });
                    }
                });
        }

        function markAttendance() {
            const btn = document.getElementById('markAttendanceBtn');
            btn.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i> MARKING...';
            
            fetch('${pageContext.request.contextPath}/api/attendance', { 
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: 'action=mark'
            })
                .then(res => res.json())
                .then(data => { 
                    if (data.success) {
                        fetchAttendance();
                    } else {
                        alert(data.message || "Failed to mark attendance");
                        fetchAttendance();
                    }
                })
                .catch(err => {
                    console.error("Attendance Error:", err);
                    alert("Error marking attendance. Check console.");
                    btn.disabled = false;
                    btn.innerHTML = '<i class="fas fa-fingerprint me-2"></i> MARK PRESENT TODAY';
                });
        }
    </script>
    <jsp:include page="components/footer.jsp" />
</body>
</html>
