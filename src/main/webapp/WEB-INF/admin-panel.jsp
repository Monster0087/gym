<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.gym.model.AdminUserDTO, com.gym.model.Booking, java.util.List, java.sql.*, com.gym.util.DatabaseUtil" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Panel - PowerLift Gym</title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- Custom CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <!-- Chart.js -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    
    <style>
        body {
            background-color: #0a0b10;
            color: #ffffff;
        }
        
        .admin-header {
            background: linear-gradient(135deg, rgba(10, 11, 16, 0.95) 0%, rgba(26, 28, 41, 0.8) 100%);
            padding: 2rem 0;
            border-bottom: 1px solid rgba(0, 240, 255, 0.1);
            margin-bottom: 2rem;
        }
        
        .admin-card {
            background: rgba(26, 28, 41, 0.7);
            border: 1px solid rgba(0, 240, 255, 0.1);
            border-radius: 15px;
            padding: 1.5rem;
            backdrop-filter: blur(10px);
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.2);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            height: 100%;
        }
        
        .admin-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 12px 40px rgba(0, 240, 255, 0.15);
            border-color: rgba(0, 240, 255, 0.3);
        }
        
        .table-custom {
            color: #ffffff;
            background: transparent;
        }
        
        .table-custom thead th {
            border-bottom: 2px solid rgba(0, 240, 255, 0.3);
            color: #00f0ff;
            font-weight: 600;
            text-transform: uppercase;
            font-size: 0.85rem;
            letter-spacing: 1px;
            padding: 1rem;
        }
        
        .table-custom tbody td {
            border-bottom: 1px solid rgba(255, 255, 255, 0.05);
            padding: 1rem;
            vertical-align: middle;
        }
        
        .table-custom tbody tr:hover {
            background-color: rgba(0, 240, 255, 0.03);
        }
        
        .badge-cyan {
            background: rgba(0, 240, 255, 0.1);
            color: #00f0ff;
            border: 1px solid rgba(0, 240, 255, 0.3);
            padding: 5px 12px;
            border-radius: 4px;
            font-size: 0.85rem;
            display: inline-flex;
            align-items: center;
            font-weight: 600;
            letter-spacing: 0.5px;
        }

        .badge-cyan i {
            margin-right: 6px;
            font-size: 0.8rem;
        }
        
        .badge-warning-custom {
            background: rgba(255, 193, 7, 0.1);
            color: #ffc107;
            border: 1px solid #ffc107;
            padding: 0.4em 0.8em;
            border-radius: 20px;
        }
        
        .badge-danger-custom {
            background: rgba(220, 53, 69, 0.1);
            color: #dc3545;
            border: 1px solid #dc3545;
            padding: 0.4em 0.8em;
            border-radius: 20px;
        }
        
        .nav-pills .nav-link.active {
            background: linear-gradient(135deg, #00f0ff 0%, #0077ff 100%);
            color: #0a0b10;
            font-weight: 700;
        }
        
        .nav-pills .nav-link {
            color: #ffffff;
            border: 1px solid rgba(0, 240, 255, 0.2);
            margin-right: 0.5rem;
            border-radius: 30px;
        }
    </style>
</head>
<body>

    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark sticky-top" style="border-bottom: 1px solid rgba(0, 240, 255, 0.1);">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/index.jsp">
                <i class="fas fa-dumbbell text-primary-custom"></i> PowerLift Admin
            </a>
            
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/dashboard.jsp">Dashboard</a>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle active" href="#" id="userDropdown" role="button" data-bs-toggle="dropdown">
                            <i class="fas fa-user-shield me-1 text-primary-custom"></i> Admin
                        </a>
                        <ul class="dropdown-menu dropdown-menu-dark">
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/logout"><i class="fas fa-sign-out-alt me-2"></i> Logout</a></li>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="admin-header">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-md-8">
                    <h1 class="text-gradient mb-2"><i class="fas fa-cogs me-2"></i> Control Panel</h1>
                    <p class="text-muted">Manage members, view attendance, and track subscriptions.</p>
                </div>
            </div>
        </div>
    </div>

    <div class="container mb-5">
        
        <!-- Stats Row -->
        <div class="row g-4 mb-5">
            <div class="col-md-3">
                <div class="admin-card text-center">
                    <div class="display-4 text-gradient mb-2"><i class="fas fa-users"></i></div>
                    <h3 class="text-white" id="statTotalUsers">0</h3>
                    <p class="text-muted mb-0">Total Registered Users</p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="admin-card text-center">
                    <div class="display-4 text-gradient mb-2"><i class="fas fa-crown"></i></div>
                    <h3 class="text-white" id="statActiveMembers">0</h3>
                    <p class="text-muted mb-0">Active Memberships</p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="admin-card text-center">
                    <div class="display-4 text-gradient mb-2"><i class="fas fa-calendar-check"></i></div>
                    <h3 class="text-white" id="statTotalBookings">0</h3>
                    <p class="text-muted mb-0">Session Bookings</p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="admin-card text-center">
                    <div class="display-4 text-gradient mb-2"><i class="fas fa-user-shield"></i></div>
                    <h3 class="text-white">Admin</h3>
                    <p class="text-muted mb-0">Role Level</p>
                </div>
            </div>
        </div>
        
        <!-- Member Management -->
        <div class="admin-card">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h4 class="text-gradient mb-0">Member Management</h4>
                <div class="d-flex gap-2">
                    <a href="${pageContext.request.contextPath}/admin/fix-dates.jsp" class="btn btn-outline-info btn-sm">
                        <i class="fas fa-magic me-1"></i> Auto-Repair Dates
                    </a>
                    <button class="btn btn-primary-custom btn-sm" onclick="location.reload()">
                        <i class="fas fa-sync-alt me-1"></i> Refresh Data
                    </button>
                </div>
            </div>
            
            <div class="table-responsive">
                <table class="table table-custom table-hover">
                    <thead>
                        <tr>
                            <th>User Info</th>
                            <th>Contact</th>
                            <th>Current Plan</th>
                            <th>Start Date</th>
                            <th>End Date</th>
                            <th>Status</th>
                            <th>Total Attendance</th>
                            <th>Workouts</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% 
                            List<AdminUserDTO> users = (List<AdminUserDTO>) request.getAttribute("users");
                            int totalCount = 0;
                            int activeCount = 0;
                            
                            if(users != null && !users.isEmpty()) {
                                totalCount = users.size();
                                Connection jspConn = null;
                                try {
                                    jspConn = DatabaseUtil.getConnection();
                                    for(AdminUserDTO u : users) {
                                        String displayPlan = u.getPlanName();
                                        if (displayPlan != null) activeCount++;
                                        
                                        // Use dates from DTO
                                        java.time.LocalDate startDate = u.getPlanStartDate();
                                        java.time.LocalDate endDate = u.getPlanEndDate();
                                        
                                        if (displayPlan == null) {
                                            String fallbackSql = "SELECT mp.plan_name FROM users u JOIN membership_plans mp ON u.plan_id = mp.id WHERE u.id = ?";
                                            try (PreparedStatement ps = jspConn.prepareStatement(fallbackSql)) {
                                                ps.setInt(1, u.getUserId());
                                                try (ResultSet rsFallback = ps.executeQuery()) {
                                                    if (rsFallback.next()) {
                                                        displayPlan = rsFallback.getString("plan_name");
                                                    }
                                                }
                                            } catch (Exception e) {}
                                        }
                        %>
                        <tr>
                            <td>
                                <strong><%= u.getName() %></strong>
                                <% if ("ADMIN".equals(u.getRole())) { %>
                                    <span class="badge badge-danger-custom ms-2"><i class="fas fa-shield-alt"></i> ADMIN</span>
                                <% } %>
                            </td>
                            <td>
                                <div><i class="fas fa-envelope text-muted me-2"></i><small><%= u.getEmail() %></small></div>
                                <div><i class="fas fa-phone text-muted me-2"></i><small><%= u.getPhone() != null ? u.getPhone() : "N/A" %></small></div>
                            </td>
                            <td>
                                <% if(displayPlan != null) { %>
                                    <span class="badge-cyan">
                                        <i class="fas fa-dumbbell"></i>
                                        <%= displayPlan %>
                                    </span>
                                <% } else { %>
                                    <span class="badge bg-secondary">No Active Plan</span>
                                <% } %>
                            </td>
                            <td>
                                <small><%= startDate != null ? startDate : "N/A" %></small>
                            </td>
                            <td>
                                <small><%= endDate != null ? endDate : "N/A" %></small>
                            </td>
                            <td>
                                <% if(displayPlan != null) { %>
                                    <% if (endDate != null) { %>
                                        <% if (u.getDaysRemaining() > 10) { %>
                                            <span class="badge badge-cyan"><%= u.getDaysRemaining() %> Days Left</span>
                                        <% } else if (u.getDaysRemaining() > 0) { %>
                                            <span class="badge badge-warning-custom"><%= u.getDaysRemaining() %> Days Left</span>
                                        <% } else { %>
                                            <span class="badge badge-danger-custom">Expired</span>
                                        <% } %>
                                    <% } else { %>
                                        <span class="badge badge-cyan">Active</span>
                                    <% } %>
                                <% } else { %>
                                    -
                                <% } %>
                            </td>
                            <td>
                                <div class="d-flex align-items-center">
                                    <div class="me-2"><i class="fas fa-calendar-check text-primary-custom"></i></div>
                                    <div class="fw-bold"><%= u.getTotalAttendanceDays() %> Days</div>
                                </div>
                            </td>
                            <td>
                                <div class="d-flex align-items-center">
                                    <div class="me-2"><i class="fas fa-dumbbell text-info"></i></div>
                                    <div class="fw-bold"><%= u.getCompletedWorkouts() %></div>
                                </div>
                            </td>
                            <td>
                                <div class="dropdown">
                                    <button class="btn btn-sm btn-outline-light dropdown-toggle" type="button" data-bs-toggle="dropdown">
                                        Actions
                                    </button>
                                    <ul class="dropdown-menu dropdown-menu-dark">
                                        <li><a class="dropdown-item edit-user-btn" href="#" 
                                               data-id="<%= u.getUserId() %>" 
                                               data-name="<%= u.getName() %>" 
                                               data-email="<%= u.getEmail() %>" 
                                               data-phone="<%= u.getPhone() != null ? u.getPhone() : "" %>" 
                                               data-role="<%= u.getRole() %>">
                                            <i class="fas fa-edit me-2"></i>Edit User</a>
                                        </li>
                                         <li><a class="dropdown-item" href="mailto:<%= u.getEmail() %>"><i class="fas fa-envelope me-2"></i>Send Email</a></li>
                                         <li><a class="dropdown-item view-growth-btn" href="#" data-id="<%= u.getUserId() %>" data-name="<%= u.getName() %>"><i class="fas fa-chart-line me-2"></i>View Growth</a></li>
                                         <% if (u.getPlanName() != null && u.getDaysRemaining() > 0) { %>
                                            <li><a class="dropdown-item text-warning cancel-membership-btn" href="#" data-id="<%= u.getUserId() %>"><i class="fas fa-times-circle me-2"></i>Cancel Membership</a></li>
                                         <% } %>
                                         <li><hr class="dropdown-divider"></li>
                                        <li><a class="dropdown-item text-danger delete-user-btn" href="#" 
                                               data-id="<%= u.getUserId() %>">
                                            <i class="fas fa-trash me-2"></i>Delete</a>
                                        </li>
                                    </ul>
                                </div>
                            </td>
                        </tr>
                        <% 
                                    }
                                } catch (Exception e) {
                                    e.printStackTrace();
                                } finally {
                                    if (jspConn != null) jspConn.close();
                                }
                            } else {
                        %>
                        <tr>
                            <td colspan="6" class="text-center py-4 text-muted">No users found.</td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Session Bookings Section -->
        <div class="admin-card mt-5">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h4 class="text-gradient mb-0">Trainer Session Bookings</h4>
            </div>
            
            <div class="table-responsive">
                <table class="table table-custom table-hover">
                    <thead>
                        <tr>
                            <th>User Name</th>
                            <th>Trainer</th>
                            <th>Booking Date</th>
                            <th>Session Type</th>
                            <th>Message</th>
                            <th>Status</th>
                            <th>Booked On</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% 
                            List<Booking> bookingsList = (List<Booking>) request.getAttribute("bookings");
                            if(bookingsList != null && !bookingsList.isEmpty()) {
                                for(Booking b : bookingsList) {
                        %>
                        <tr>
                            <td><strong><%= b.getUserName() %></strong></td>
                            <td><span class="text-info"><%= b.getTrainerName() %></span></td>
                            <td><i class="fas fa-calendar-day me-2 text-primary-custom"></i><%= b.getBookingDate() %></td>
                            <td><%= b.getSessionType() %></td>
                            <td><small><%= b.getMessage() != null ? b.getMessage() : "-" %></small></td>
                            <td>
                                <% if("pending".equals(b.getStatus())) { %>
                                    <span class="badge badge-warning-custom">Pending</span>
                                <% } else if("confirmed".equals(b.getStatus())) { %>
                                    <span class="badge badge-cyan">Confirmed</span>
                                <% } else { %>
                                    <span class="badge bg-secondary"><%= b.getStatus() %></span>
                                <% } %>
                            </td>
                            <td><small class="text-muted"><%= b.getCreatedAt() %></small></td>
                        </tr>
                        <% 
                                }
                            } else {
                        %>
                        <tr>
                            <td colspan="7" class="text-center py-4 text-muted">No session bookings found.</td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>

    </div>

    <!-- Edit User Modal -->
    <div class="modal fade" id="editUserModal" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content" style="background-color: #0a0b10; border: 1px solid rgba(0, 240, 255, 0.3);">
                <div class="modal-header" style="border-bottom: 1px solid rgba(0, 240, 255, 0.1);">
                    <h5 class="modal-title text-gradient">Edit User</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <form action="${pageContext.request.contextPath}/admin/edit-user" method="POST">
                    <div class="modal-body">
                        <input type="hidden" name="userId" id="editUserId">
                        
                        <div class="mb-3">
                            <label class="form-label text-light">Full Name</label>
                            <input type="text" class="form-control bg-dark text-light border-secondary" name="name" id="editName" required>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label text-light">Email Address</label>
                            <input type="email" class="form-control bg-dark text-light border-secondary" name="email" id="editEmail" required>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label text-light">Phone Number</label>
                            <input type="text" class="form-control bg-dark text-light border-secondary" name="phone" id="editPhone">
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label text-light">Role</label>
                            <select class="form-select bg-dark text-light border-secondary" name="role" id="editRole">
                                <option value="USER">USER</option>
                                <option value="ADMIN">ADMIN</option>
                            </select>
                        </div>
                    </div>
                    <div class="modal-footer" style="border-top: 1px solid rgba(0, 240, 255, 0.1);">
                        <button type="button" class="btn btn-outline-light" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-primary-custom">Save Changes</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Delete Form (Hidden) -->
    <form id="deleteForm" action="${pageContext.request.contextPath}/admin/delete-user" method="POST" style="display: none;">
        <input type="hidden" name="userId" id="deleteUserId">
    </form>
    
    <!-- Cancel Membership Form (Hidden) -->
    <form id="cancelForm" action="${pageContext.request.contextPath}/admin/cancel-membership" method="POST" style="display: none;">
        <input type="hidden" name="userId" id="cancelUserId">
    </form>

    <!-- User Growth Modal -->
    <div class="modal fade" id="growthModal" tabindex="-1">
        <div class="modal-dialog modal-lg modal-dialog-centered">
            <div class="modal-content" style="background-color: #0a0b10; border: 1px solid rgba(0, 240, 255, 0.3);">
                <div class="modal-header" style="border-bottom: 1px solid rgba(0, 240, 255, 0.1);">
                    <h5 class="modal-title text-gradient">User Growth: <span id="growthUserName"></span></h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <div class="row g-4 mb-4">
                        <div class="col-md-4">
                            <div class="admin-card text-center p-3">
                                <h6 class="text-muted small">Current BMI</h6>
                                <h3 id="currentBMI" class="text-primary-custom">--</h3>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="admin-card text-center p-3">
                                <h6 class="text-muted small">Current Weight</h6>
                                <h3 id="currentWeight" class="text-primary-custom">-- kg</h3>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="admin-card text-center p-3">
                                <h6 class="text-muted small">Last Updated</h6>
                                <h3 id="lastUpdated" class="text-primary-custom" style="font-size: 1rem;">--</h3>
                            </div>
                        </div>
                    </div>
                    <div style="height: 300px; width: 100%;">
                        <canvas id="growthChart"></canvas>
                    </div>
                    <div class="table-responsive mt-4">
                        <table class="table table-custom table-sm">
                            <thead>
                                <tr>
                                    <th>Date</th>
                                    <th>Weight (kg)</th>
                                    <th>Height (cm)</th>
                                    <th>BMI</th>
                                </tr>
                            </thead>
                            <tbody id="growthTableBody">
                                <!-- Data populated by JS -->
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Update stats from calculated JSP values
            document.getElementById('statTotalUsers').textContent = '<%= totalCount %>';
            document.getElementById('statActiveMembers').textContent = '<%= activeCount %>';
            document.getElementById('statTotalBookings').textContent = '<%= request.getAttribute("totalBookings") != null ? request.getAttribute("totalBookings") : 0 %>';

            // Edit user button click
            const editBtns = document.querySelectorAll('.edit-user-btn');
            editBtns.forEach(btn => {
                btn.addEventListener('click', function(e) {
                    e.preventDefault();
                    const id = this.getAttribute('data-id');
                    const name = this.getAttribute('data-name');
                    const email = this.getAttribute('data-email');
                    const phone = this.getAttribute('data-phone');
                    const role = this.getAttribute('data-role');
                    
                    document.getElementById('editUserId').value = id;
                    document.getElementById('editName').value = name;
                    document.getElementById('editEmail').value = email;
                    document.getElementById('editPhone').value = phone;
                    document.getElementById('editRole').value = role;
                    
                    var editModal = new bootstrap.Modal(document.getElementById('editUserModal'));
                    editModal.show();
                });
            });

            // Delete user button click
            const deleteBtns = document.querySelectorAll('.delete-user-btn');
            deleteBtns.forEach(btn => {
                btn.addEventListener('click', function(e) {
                    e.preventDefault();
                    const userId = this.getAttribute('data-id');
                    if (confirm("Are you sure you want to completely delete this user? This action cannot be undone.")) {
                        document.getElementById('deleteUserId').value = userId;
                        document.getElementById('deleteForm').submit();
                    }
                });
            });

            // Cancel membership button click
            const cancelBtns = document.querySelectorAll('.cancel-membership-btn');
            cancelBtns.forEach(btn => {
                btn.addEventListener('click', function(e) {
                    e.preventDefault();
                    const userId = this.getAttribute('data-id');
                    if (confirm("Are you sure you want to cancel this user's active membership?")) {
                        document.getElementById('cancelUserId').value = userId;
                        document.getElementById('cancelForm').submit();
                    }
                });
            });

            // Growth Modal Logic
            let growthChartInstance = null;
            const growthModal = new bootstrap.Modal(document.getElementById('growthModal'));
            
            document.querySelectorAll('.view-growth-btn').forEach(btn => {
                btn.addEventListener('click', function(e) {
                    e.preventDefault();
                    const userId = this.getAttribute('data-id');
                    const userName = this.getAttribute('data-name');
                    document.getElementById('growthUserName').textContent = userName;
                    
                    // Clear previous data
                    document.getElementById('currentBMI').textContent = '--';
                    document.getElementById('currentWeight').textContent = '-- KG';
                    document.getElementById('lastUpdated').textContent = '--';
                    
                    fetch("${pageContext.request.contextPath}/admin/get-growth.jsp?userId=" + userId)
                        .then(res => res.json())
                        .then(data => {
                            populateGrowthData(data);
                            growthModal.show();
                        })
                        .catch(err => {
                            console.error('Error fetching growth data:', err);
                            alert('Could not fetch growth data. Please try again.');
                        });
                });
            });

            function populateGrowthData(data) {
                const tableBody = document.getElementById('growthTableBody');
                tableBody.innerHTML = '';
                
                if (!data || data.length === 0) {
                    tableBody.innerHTML = '<tr><td colspan="4" class="text-center py-4">No progress data available.</td></tr>';
                    if (growthChartInstance) growthChartInstance.destroy();
                    return;
                }

                // Sort by date ascending for chart
                const sortedData = [...data].sort((a, b) => new Date(a.recordedAt) - new Date(b.recordedAt));
                
                // Latest data for cards
                const latest = data[0];
                document.getElementById('currentBMI').textContent = latest.bmi;
                document.getElementById('currentWeight').textContent = latest.weight + ' kg';
                document.getElementById('lastUpdated').textContent = new Date(latest.recordedAt).toLocaleDateString();

                // Populate table
                data.forEach(p => {
                    const row = '<tr>' +
                        '<td>' + new Date(p.recordedAt).toLocaleDateString() + '</td>' +
                        '<td>' + p.weight + '</td>' +
                        '<td>' + (p.height) + '</td>' +
                        '<td><span class="badge badge-cyan">' + p.bmi + '</span></td>' +
                    '</tr>';
                    tableBody.innerHTML += row;
                });

                // Update Chart
                const ctx = document.getElementById('growthChart').getContext('2d');
                if (growthChartInstance) growthChartInstance.destroy();
                
                growthChartInstance = new Chart(ctx, {
                    type: 'line',
                    data: {
                        labels: sortedData.map(p => new Date(p.recordedAt).toLocaleDateString()),
                        datasets: [{
                            label: 'Weight (kg)',
                            data: sortedData.map(p => p.weight),
                            borderColor: '#00f0ff',
                            backgroundColor: 'rgba(0, 240, 255, 0.1)',
                            fill: true,
                            tension: 0.4
                        }, {
                            label: 'BMI',
                            data: sortedData.map(p => p.bmi),
                            borderColor: '#ff3232',
                            backgroundColor: 'rgba(255, 50, 50, 0.1)',
                            fill: true,
                            tension: 0.4,
                            yAxisID: 'y1'
                        }]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        scales: {
                            y: {
                                beginAtZero: false,
                                grid: { color: 'rgba(255,255,255,0.05)' },
                                ticks: { color: '#888' }
                            },
                            y1: {
                                position: 'right',
                                grid: { display: false },
                                ticks: { color: '#888' }
                            },
                            x: {
                                grid: { color: 'rgba(255,255,255,0.05)' },
                                ticks: { color: '#888' }
                            }
                        },
                        plugins: {
                            legend: { labels: { color: '#fff' } }
                        }
                    }
                });
            }
        });
    </script>
</body>
</html>
