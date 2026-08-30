# 🚀 How to Run the Premium Gym Website Project

## ✅ Project Status: READY TO DEPLOY

Your project has been successfully compiled and the WAR file is ready at:
```
target/gym-website.war (4.6 MB)
```

## 📋 Prerequisites Check

### ✅ Already Available:
- ✅ Java (JDK 25.0.2)
- ✅ Apache Maven 3.9.12
- ✅ Project compiled successfully
- ✅ WAR file created

### ❌ Missing: Apache Tomcat

## 🛠️ Step-by-Step Instructions

### Option 1: Quick Setup (Recommended)

1. **Download Apache Tomcat 9**
   - Go to: https://tomcat.apache.org/download-90.cgi
   - Download "Core" version (Windows zip)
   - Extract to: `C:\tomcat9`

2. **Run the Deployment Script**
   - Double-click: `run-project.bat`
   - This will automatically deploy and start the application

3. **Access the Application**
   - Wait 30 seconds for Tomcat to start
   - Open: http://localhost:8080/gym-website/

### Option 2: Manual Setup

1. **Download and Install Tomcat**
   ```
   Download: https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.89/bin/apache-tomcat-9.0.89-windows-x64.zip
   Extract to: C:\tomcat9
   ```

2. **Deploy the WAR File**
   ```cmd
   copy target\gym-website.war C:\tomcat9\webapps\
   ```

3. **Start Tomcat**
   ```cmd
   cd C:\tomcat9\bin
   startup.bat
   ```

4. **Access the Application**
   ```
   http://localhost:8080/gym-website/
   ```

### Option 3: Using IDE (Eclipse/IntelliJ)

1. **Import Project**
   - File → Import → Maven → Existing Maven Projects
   - Select the gym folder

2. **Configure Tomcat Server**
   - Add Tomcat 9 server to your IDE
   - Point to your Tomcat installation directory

3. **Run on Server**
   - Right-click project → Run on Server
   - Select your Tomcat server

## 🗄️ Database Setup (Optional for Full Functionality)

For full functionality, you'll need MySQL database:

1. **Install MySQL 8.0+**
2. **Create Database**
   ```sql
   CREATE DATABASE gym_website CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
   ```

3. **Import Schema**
   ```cmd
   mysql -u root -p gym_website < database/schema.sql
   ```

4. **Update Database Connection**
   Edit: `src/main/java/com/gym/util/DatabaseUtil.java`
   ```java
   private static final String DB_USER = "root";
   private static final String DB_PASSWORD = "your_password";
   ```

## 🌐 Access Points

Once running, you can access:

- **Home Page**: http://localhost:8080/gym-website/
- **About**: http://localhost:8080/gym-website/about.jsp
- **Services**: http://localhost:8080/gym-website/services.jsp
- **Gallery**: http://localhost:8080/gym-website/gallery.jsp
- **Contact**: http://localhost:8080/gym-website/contact.jsp
- **Login**: http://localhost:8080/gym-website/login.jsp
- **Register**: http://localhost:8080/gym-website/register.jsp

## 🔧 Troubleshooting

### Common Issues:

1. **Port 8080 already in use**
   - Edit: `C:\tomcat9\conf\server.xml`
   - Change port from 8080 to 8081 or another available port

2. **Java version mismatch**
   - Ensure you're using Java 8 or higher
   - Update JAVA_HOME environment variable

3. **Database connection errors**
   - Check MySQL service is running
   - Verify database credentials in DatabaseUtil.java
   - Ensure the database schema is imported

4. **404 errors**
   - Verify WAR file is deployed correctly
   - Check Tomcat logs for errors
   - Ensure context path is correct

### Tomcat Management:

- **Start**: `C:\tomcat9\bin\startup.bat`
- **Stop**: `C:\tomcat9\bin\shutdown.bat`
- **Logs**: `C:\tomcat9\logs\catalina.out`
- **Manager**: http://localhost:8080/manager/html

## 🎯 Quick Test

To verify everything is working:

1. Open http://localhost:8080/gym-website/
2. You should see the Premium Gym homepage
3. Try registering a new user
4. Test the contact form
5. Browse the gallery

## 📱 Features to Test:

- ✅ Responsive design (try mobile view)
- ✅ Glassmorphism effects
- ✅ Form validation
- ✅ Navigation between pages
- ✅ User registration and login
- ✅ Contact form submission

## 🎉 Success!

Once you see the Premium Gym homepage, your project is running successfully!

---

**Need Help?**
- Check Tomcat logs: `C:\tomcat9\logs\catalina.out`
- Verify database connection if using MySQL
- Ensure all dependencies are loaded correctly

**Project Status: ✅ READY FOR DEPLOYMENT**
