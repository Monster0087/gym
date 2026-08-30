<%@ page import="com.gym.model.User" %>
<nav class="navbar navbar-expand-lg navbar-dark glass fixed-top">
    <div class="container">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/index.jsp">
            <i class="fas fa-dumbbell"></i> PowerLift Gym
        </a>
        
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto align-items-center">
                <% String currentPath = request.getServletPath(); %>
                <li class="nav-item">
                    <a class="nav-link <%= currentPath.endsWith("index.jsp") ? "active" : "" %>" href="${pageContext.request.contextPath}/index.jsp">Home</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link <%= currentPath.endsWith("about.jsp") ? "active" : "" %>" href="${pageContext.request.contextPath}/about.jsp">About</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link <%= currentPath.contains("services") ? "active" : "" %>" href="${pageContext.request.contextPath}/services.jsp">Services</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link <%= currentPath.endsWith("gallery.jsp") ? "active" : "" %>" href="${pageContext.request.contextPath}/gallery.jsp">Gallery</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link <%= currentPath.endsWith("trainers.jsp") ? "active" : "" %>" href="${pageContext.request.contextPath}/trainers.jsp">Trainers</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link <%= currentPath.endsWith("diet-plans.jsp") ? "active" : "" %>" href="${pageContext.request.contextPath}/diet-plans.jsp">Diet Plans</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link <%= currentPath.endsWith("contact.jsp") ? "active" : "" %>" href="${pageContext.request.contextPath}/contact.jsp">Contact</a>
                </li>
                <% if (session != null && session.getAttribute("user") != null) { 
                    User user = (User) session.getAttribute("user");
                %>
                    <li class="nav-item">
                        <a class="nav-link <%= currentPath.endsWith("dashboard.jsp") ? "active" : "" %>" href="${pageContext.request.contextPath}/dashboard.jsp">Dashboard</a>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle user-nav-link" href="#" id="userDropdown" role="button" data-bs-toggle="dropdown">
                            <div class="d-flex align-items-center">
                                <% if (user.getProfileImage() != null && !user.getProfileImage().isEmpty()) { %>
                                    <img src="<%= user.getProfileImage() %>" class="nav-user-avatar" alt="User">
                                <% } else { %>
                                    <i class="fas fa-user-circle me-2 fs-5"></i>
                                <% } %>
                                <span class="user-name-nav"><%= user.getName() %></span>
                            </div>
                        </a>
                        <ul class="dropdown-menu dropdown-menu-dark dropdown-menu-end">
                            <% if ("ADMIN".equals(user.getRole())) { %>
                                <li><a class="dropdown-item text-info" href="${pageContext.request.contextPath}/admin/dashboard"><i class="fas fa-shield-alt me-2"></i> Admin Panel</a></li>
                            <% } %>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/profile"><i class="fas fa-user me-2"></i> Profile</a></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/settings.jsp"><i class="fas fa-cog me-2"></i> Settings</a></li>
                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-item text-danger" href="${pageContext.request.contextPath}/logout"><i class="fas fa-sign-out-alt me-2"></i> Logout</a></li>
                        </ul>
                    </li>
                <% } else { %>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/login.jsp">Login</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link register-btn" href="${pageContext.request.contextPath}/register.jsp">Register</a>
                    </li>
                <% } %>
            </ul>
        </div>
    </div>
</nav>

<!-- Multi-Tab Session Support -->
<script src="${pageContext.request.contextPath}/js/multi-tab.js"></script>
