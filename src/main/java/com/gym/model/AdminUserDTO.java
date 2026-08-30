package com.gym.model;

import java.time.LocalDate;

public class AdminUserDTO {
    private int userId;
    private String name;
    private String email;
    private String phone;
    private String role;
    
    // Membership details
    private String planName;
    private LocalDate planStartDate;
    private LocalDate planEndDate;
    private long daysRemaining;
    
    // Attendance
    private int totalAttendanceDays;
    private int completedWorkouts;
    
    public AdminUserDTO() {}

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }

    public String getPlanName() { return planName; }
    public void setPlanName(String planName) { this.planName = planName; }

    public LocalDate getPlanStartDate() { return planStartDate; }
    public void setPlanStartDate(LocalDate planStartDate) { this.planStartDate = planStartDate; }

    public LocalDate getPlanEndDate() { return planEndDate; }
    public void setPlanEndDate(LocalDate planEndDate) { this.planEndDate = planEndDate; }

    public long getDaysRemaining() { return daysRemaining; }
    public void setDaysRemaining(long daysRemaining) { this.daysRemaining = daysRemaining; }

    public int getTotalAttendanceDays() { return totalAttendanceDays; }
    public void setTotalAttendanceDays(int totalAttendanceDays) { this.totalAttendanceDays = totalAttendanceDays; }

    public int getCompletedWorkouts() { return completedWorkouts; }
    public void setCompletedWorkouts(int completedWorkouts) { this.completedWorkouts = completedWorkouts; }
}
