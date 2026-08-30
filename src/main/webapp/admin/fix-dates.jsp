<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, com.gym.util.DatabaseUtil" %>
<!DOCTYPE html>
<html>
<head><title>Repair Memberships</title></head>
<body style="background: #0a0b10; color: #fff; font-family: sans-serif; padding: 50px; text-align: center;">
    <%
        com.gym.model.User admin = (com.gym.model.User) session.getAttribute("user");
        if (admin == null || !"ADMIN".equals(admin.getRole())) {
            out.print("Unauthorized");
            return;
        }

        int fixed = 0;
        try (Connection conn = DatabaseUtil.getConnection()) {
            // Find users with a plan but no membership record
            String sql = "SELECT id, plan_id FROM users WHERE plan_id > 0 AND id NOT IN (SELECT user_id FROM user_memberships WHERE status = 'active')";
            try (Statement stmt = conn.createStatement();
                 ResultSet rs = stmt.executeQuery(sql)) {
                
                String insertSql = "INSERT INTO user_memberships (user_id, plan_id, start_date, end_date, status) VALUES (?, ?, CURRENT_DATE, DATE_ADD(CURRENT_DATE, INTERVAL 1 MONTH), 'active')";
                try (PreparedStatement ps = conn.prepareStatement(insertSql)) {
                    while (rs.next()) {
                        ps.setInt(1, rs.getInt("id"));
                        ps.setInt(2, rs.getInt("plan_id"));
                        ps.executeUpdate();
                        fixed++;
                    }
                }
            }
        } catch (Exception e) {
            out.print("Error: " + e.getMessage());
            e.printStackTrace();
        }
    %>
    <h1 style="color: #00f0ff;">Success!</h1>
    <p>Fixed <%= fixed %> legacy membership records.</p>
    <a href="dashboard" style="color: #fff; text-decoration: none; border: 1px solid #00f0ff; padding: 10px 20px; border-radius: 5px;">Go Back to Admin Panel</a>
</body>
</html>
