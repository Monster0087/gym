package com.gym.scratch;

import com.gym.util.DatabaseUtil;
import org.mindrot.jbcrypt.BCrypt;

import java.sql.Connection;
import java.sql.Statement;

public class DatabaseMigration {
    public static void main(String[] args) {
        try (Connection conn = DatabaseUtil.getConnection();
             Statement stmt = conn.createStatement()) {
            
            System.out.println("Starting Database Migration...");

            // 1. Add role to users
            try {
                stmt.execute("ALTER TABLE users ADD COLUMN role ENUM('USER', 'ADMIN') DEFAULT 'USER'");
                System.out.println("Added role column to users.");
            } catch (Exception e) {
                System.out.println("Role column might already exist.");
            }

            // 2. Create user_attendance table
            stmt.execute("CREATE TABLE IF NOT EXISTS user_attendance (" +
                    "id INT AUTO_INCREMENT PRIMARY KEY, " +
                    "user_id INT NOT NULL, " +
                    "attendance_date DATE NOT NULL, " +
                    "status ENUM('PRESENT') DEFAULT 'PRESENT', " +
                    "created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, " +
                    "UNIQUE KEY unique_attendance (user_id, attendance_date), " +
                    "FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE)");
            System.out.println("Checked user_attendance table.");

            // 3. Create user_progress table
            stmt.execute("CREATE TABLE IF NOT EXISTS user_progress (" +
                    "id INT AUTO_INCREMENT PRIMARY KEY, " +
                    "user_id INT NOT NULL, " +
                    "weight DECIMAL(5,2), " +
                    "height DECIMAL(5,2), " +
                    "bmi DECIMAL(5,2), " +
                    "recorded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, " +
                    "FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE)");
            System.out.println("Checked user_progress table.");

            // 4. Create user_memberships table (if missing)
            stmt.execute("CREATE TABLE IF NOT EXISTS user_memberships (" +
                    "id INT AUTO_INCREMENT PRIMARY KEY, " +
                    "user_id INT NOT NULL, " +
                    "plan_id INT NOT NULL, " +
                    "start_date DATE NOT NULL, " +
                    "end_date DATE NOT NULL, " +
                    "status ENUM('active', 'expired', 'cancelled') DEFAULT 'active', " +
                    "payment_status ENUM('paid', 'pending', 'failed') DEFAULT 'paid', " +
                    "created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, " +
                    "FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE)");
            System.out.println("Checked user_memberships table.");

            // 5. Create or update Admin User
            String email = "rohit87@gmail.com";
            String rawPassword = "Monster@87";
            String hashed = BCrypt.hashpw(rawPassword, BCrypt.gensalt());
            
            // Check if user exists
            java.sql.ResultSet rs = stmt.executeQuery("SELECT id FROM users WHERE email='" + email + "'");
            if (rs.next()) {
                stmt.execute("UPDATE users SET role='ADMIN', password='" + hashed + "' WHERE email='" + email + "'");
                System.out.println("Updated existing user to ADMIN.");
            } else {
                stmt.execute("INSERT INTO users (name, email, password, phone, role) VALUES ('Rohit Admin', '" + email + "', '" + hashed + "', '9999999999', 'ADMIN')");
                System.out.println("Inserted new ADMIN user.");
            }
            
            System.out.println("MIGRATION COMPLETE");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
