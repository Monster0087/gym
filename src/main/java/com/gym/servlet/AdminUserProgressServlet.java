package com.gym.servlet;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.gym.dao.AdminDAO;
import com.gym.model.User;
import com.gym.model.UserProgress;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDateTime;
import java.util.List;

@WebServlet("/admin/user-progress")
public class AdminUserProgressServlet extends HttpServlet {

    private AdminDAO adminDAO;
    private Gson gson;

    @Override
    public void init() throws ServletException {
        adminDAO = new AdminDAO();
        gson = new GsonBuilder()
                .registerTypeAdapter(LocalDateTime.class, new com.gym.util.LocalDateTimeAdapter())
                .create();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }

        User user = (User) session.getAttribute("user");
        if (!"ADMIN".equals(user.getRole())) {
            response.setStatus(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        String userIdStr = request.getParameter("userId");
        if (userIdStr != null && !userIdStr.isEmpty()) {
            int userId = Integer.parseInt(userIdStr);
            List<UserProgress> progress = adminDAO.getUserProgress(userId);
            
            response.setContentType("application/json");
            PrintWriter out = response.getWriter();
            out.print(gson.toJson(progress));
            out.flush();
        }
    }
}
