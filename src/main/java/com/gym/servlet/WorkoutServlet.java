package com.gym.servlet;

import com.gym.dao.WorkoutDAO;
import com.gym.model.Workout;
import com.gym.model.User;
import com.google.gson.Gson;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet("/api/workouts")
public class WorkoutServlet extends HttpServlet {
    private WorkoutDAO workoutDAO;

    @Override
    public void init() throws ServletException {
        workoutDAO = new WorkoutDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        HttpSession session = request.getSession(false);
        int userId = 0;
        if (session != null && session.getAttribute("user") != null) {
            userId = ((User) session.getAttribute("user")).getId();
        }
        
        List<Workout> workouts = workoutDAO.getAllWorkouts(userId);
        response.getWriter().write(new Gson().toJson(workouts));
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            out.print("{\"success\": false, \"message\": \"Not logged in\"}");
            return;
        }

        User user = (User) session.getAttribute("user");
        String workoutIdStr = request.getParameter("workoutId");
        
        if (workoutIdStr != null) {
            try {
                int workoutId = Integer.parseInt(workoutIdStr);
                boolean success = workoutDAO.completeWorkout(user.getId(), workoutId);
                int newCount = workoutDAO.getCompletedWorkoutsCount(user.getId());
                out.print("{\"success\": " + success + ", \"count\": " + newCount + "}");
            } catch (NumberFormatException e) {
                out.print("{\"success\": false, \"message\": \"Invalid workout ID\"}");
            }
        } else {
            out.print("{\"success\": false, \"message\": \"Missing workout ID\"}");
        }
    }
}
