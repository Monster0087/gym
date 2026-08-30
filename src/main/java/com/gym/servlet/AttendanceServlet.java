package com.gym.servlet;

import com.gym.dao.AttendanceDAO;
import com.gym.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet("/api/attendance")
public class AttendanceServlet extends HttpServlet {

    private AttendanceDAO attendanceDAO;

    @Override
    public void init() throws ServletException {
        attendanceDAO = new AttendanceDAO();
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
        String action = request.getParameter("action");

        if ("mark".equals(action)) {
            boolean success = attendanceDAO.markAttendance(user.getId(), LocalDate.now());
            if (success) {
                out.print("{\"success\": true, \"message\": \"Attendance marked\"}");
            } else {
                // Could be already marked or error
                out.print("{\"success\": false, \"message\": \"Failed or already marked\"}");
            }
        } else {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            out.print("{\"success\": false, \"message\": \"Invalid action\"}");
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            out.print("{\"success\": false}");
            return;
        }

        User user = (User) session.getAttribute("user");
        
        boolean markedToday = attendanceDAO.isAttendanceMarked(user.getId(), LocalDate.now());
        LocalDate now = LocalDate.now();
        int monthlyCount = attendanceDAO.getMonthlyAttendanceCount(user.getId(), now.getMonthValue(), now.getYear());
        
        // Get weekly attendance (Mon to Sun)
        int dayOfWeek = now.getDayOfWeek().getValue(); // 1 (Mon) to 7 (Sun)
        LocalDate monday = now.minusDays(dayOfWeek - 1);
        LocalDate sunday = monday.plusDays(6);
        List<String> weeklyAttendance = attendanceDAO.getAttendanceDatesForRange(user.getId(), monday, sunday);
        
        String weeklyJson = "[" + String.join(",", weeklyAttendance.stream().map(d -> "\"" + d + "\"").collect(Collectors.toList())) + "]";
        
        out.print("{\"success\": true, \"markedToday\": " + markedToday + ", \"monthlyCount\": " + monthlyCount + ", \"weeklyAttendance\": " + weeklyJson + "}");
    }
}
