<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*, com.gym.util.DatabaseUtil, com.google.gson.Gson" %>
<%
    // Security check
    com.gym.model.User admin = (com.gym.model.User) session.getAttribute("user");
    if (admin == null || !"ADMIN".equals(admin.getRole())) {
        response.setStatus(403);
        return;
    }

    String userIdStr = request.getParameter("userId");
    List<Map<String, Object>> progressList = new ArrayList<>();
    
    if (userIdStr != null) {
        try (Connection conn = DatabaseUtil.getConnection()) {
            String sql = "SELECT * FROM user_progress WHERE user_id = ? ORDER BY recorded_at DESC";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, Integer.parseInt(userIdStr));
                try (ResultSet rs = ps.executeQuery()) {
                    while (rs.next()) {
                        Map<String, Object> p = new HashMap<>();
                        p.put("id", rs.getInt("id"));
                        p.put("weight", rs.getDouble("weight"));
                        p.put("height", rs.getDouble("height"));
                        p.put("bmi", rs.getDouble("bmi"));
                        p.put("recordedAt", rs.getTimestamp("recorded_at").toString());
                        progressList.add(p);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    out.print(new Gson().toJson(progressList));
    out.flush();
%>
