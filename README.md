# 🏋️ PowerLift Gym - Premium Fitness Management Platform

![PowerLift Gym Banner](https://images.unsplash.com/photo-1534438327276-14e5300c3a48?ixlib=rb-4.0.3&auto=format&fit=crop&w=1200&q=80)

**PowerLift Gym** is a high-performance, full-stack fitness management system designed to provide a premium, modern experience for both gym members and administrators. Built with a robust **Java Enterprise** backend and a sleek **Glassmorphism** frontend, it offers localized services, real-time tracking, and advanced session management.

---

## 🚀 Key Features

### 👤 Member Experience
*   **Persistent Workout Tracker**: Daily exercise logging with permanent progress saving and automatic 24-hour resets.
*   **Trainer Session Booking**: Seamlessly schedule 1-on-1 sessions with expert trainers directly from the dashboard.
*   **Currency Localization (₹)**: Full support for Indian Rupees (INR) with localized membership pricing (₹499, ₹999, ₹1999).
*   **Health & Growth Logs**: Track BMI, weight, and height with interactive charts powered by Chart.js.
*   **Visual Exercise Library**: 21+ HD workout guides across Strength, Cardio, Yoga, and HIIT.
*   **Instant Payment Feedback**: Sleek "Payment Successfully!" notifications upon membership activation.

### 🛡️ Admin Command Center
*   **Member Lifecycle Management**: Comprehensive tools to view, edit, and manage member statuses.
*   **Booking Oversight**: Dedicated panel to track and manage trainer session requests.
*   **Real-time Analytics**: Visual dashboard showing total members, active subscriptions, and booking volume.
*   **Automated Data Repair**: Integrated tools to fix legacy data and maintain system integrity.

---

## 💻 Technology Stack

| Layer | Technologies |
| :--- | :--- |
| **Frontend** | JSP, Vanilla CSS3 (Glassmorphism), JavaScript (ES6+), Bootstrap 5, Font Awesome |
| **Backend** | Java 11 (Servlets), JDBC, BCrypt Security, Gson (JSON Serialization) |
| **Database** | MySQL 8.0 (Optimized with clustered indexes) |
| **Architecture**| MVC Pattern, Multi-Tab Session Isolation, Custom Filter Chains |
| **Tools** | Maven, Apache Tomcat 9, Chart.js |

---

## 🧩 Technical Spotlight: Multi-Tab Session Isolation

PowerLift Gym implements a custom **Multi-Tab Session Isolation** system to prevent data leakage between different browser tabs.

-   **The Problem**: Standard `HttpSession` is shared across all tabs of the same browser, causing "last-tab-wins" state issues.
-   **The Solution**: A hybrid approach using a `MultiTabSessionWrapper`.
    -   **Frontend**: Generates a unique `tabId` in `sessionStorage` and appends it to all internal links and forms.
    -   **Backend**: A custom wrapper isolates session attributes using the `tabId` as a prefix (e.g., `tab_123:userId`).
    -   **Transparency**: Standard Servlet code (`session.getAttribute()`) works without modification thanks to the wrapper implementation.

---

## 🛠️ Quick Installation

### 1. Database Setup
1.  Create a MySQL database named `gym_website`.
2.  Import the core schema: `mysql -u root -p gym_website < database/schema.sql`.
3.  Apply the latest feature updates:
    -   `database/workouts_update.sql` (Exercise library expansion).
    -   `database/update_prices_inr.sql` (Localization to ₹).

### 2. Environment Configuration
Update `src/main/java/com/gym/util/DatabaseUtil.java` with your MySQL credentials:
```java
private static final String DB_URL = "jdbc:mysql://localhost:3306/gym_website?serverTimezone=Asia/Kolkata";
private static final String DB_USER = "root";
private static final String DB_PASSWORD = "your_password";
```

### 3. Build & Launch (Development)
The easiest way to run the project during development is using the Maven Jetty plugin:

```bash
# Start the development server
mvn jetty:run
```

Once the server starts, access the application at:
**[http://localhost:8080/gym-website/](http://localhost:8080/gym-website/)**

### 4. Production Deployment
To create a production-ready WAR file:
```bash
mvn clean package
```
The generated `target/gym-website.war` can be deployed to any Servlet 4.0+ container (like Apache Tomcat 9).

---

## 🔧 Troubleshooting

### Port 8080 already in use
If you see an error like `Address already in use: bind`, it means another process (likely a previous instance of the server) is already running on port 8080. 
- **Solution**: Stop the existing process or change the port in `pom.xml` under the `jetty-maven-plugin` configuration.

### Database Connection Failures
- Ensure MySQL service is running.
- Verify that you have created the `gym_website` database and imported the SQL scripts in the `database/` folder.
- Double-check your credentials in `DatabaseUtil.java`.

---

## 📂 Project Structure

```text
gym/
├── database/            # SQL Schemas, update scripts, and migrations
├── src/main/java/       # Core Logic
│   ├── com.gym.dao      # Data Access Layer (optimized with prepared statements)
│   ├── com.gym.model    # Business Objects (User, Trainer, Booking, Workout)
│   ├── com.gym.servlet  # Request Controllers (MVC Pattern)
│   └── com.gym.util     # Multi-Tab Session Wrapper & Database Utilities
└── src/main/webapp/     # Frontend Layer
    ├── components/      # Reusable UI fragments (Navbar, Footer)
    ├── css/             # Custom Glassmorphism styling and animations
    ├── js/              # Multi-tab logic and interactive Chart.js modules
    └── WEB-INF/         # Secure descriptors and admin-protected JSPs
```

---

## 🔒 Security & Performance
*   **BCrypt Hashing**: All user passwords are encrypted using high-entropy salt.
*   **Thread-Safe Connections**: Connection pooling managed via `DatabaseUtil`.
*   **Timezone Synchronization**: Forced `Asia/Kolkata` (IST) alignment for accurate daily resets.
*   **Resource Optimization**: Minimized asset requests and custom-designed 4K backgrounds for premium visual impact.

---

**Elevate your fitness journey with PowerLift Gym.**
*Built with ❤️ by Antigravity AI*
