package com.gym.model;

import java.time.LocalDate;

public class UserMembership {
    private int id;
    private int userId;
    private int planId;
    private LocalDate startDate;
    private LocalDate endDate;
    private String status;
    private String paymentStatus;
    private MembershipPlan plan;
    
    public UserMembership() {}
    
    public UserMembership(int userId, int planId, LocalDate startDate, LocalDate endDate) {
        this.userId = userId;
        this.planId = planId;
        this.startDate = startDate;
        this.endDate = endDate;
        this.status = "active";
        this.paymentStatus = "paid";
    }
    
    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    
    public int getPlanId() { return planId; }
    public void setPlanId(int planId) { this.planId = planId; }
    
    public LocalDate getStartDate() { return startDate; }
    public void setStartDate(LocalDate startDate) { this.startDate = startDate; }
    
    public LocalDate getEndDate() { return endDate; }
    public void setEndDate(LocalDate endDate) { this.endDate = endDate; }
    
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    
    public String getPaymentStatus() { return paymentStatus; }
    public void setPaymentStatus(String paymentStatus) { this.paymentStatus = paymentStatus; }
    
    public MembershipPlan getPlan() { return plan; }
    public void setPlan(MembershipPlan plan) { this.plan = plan; }
    
    @Override
    public String toString() {
        return "UserMembership{" +
                "id=" + id +
                ", userId=" + userId +
                ", planId=" + planId +
                ", startDate=" + startDate +
                ", endDate=" + endDate +
                ", status='" + status + '\'' +
                '}';
    }
}
