package com.gym.model;

import java.sql.Timestamp;

public class Booking {
    private int id;
    private int userId;
    private int trainerId;
    private String bookingDate;
    private String sessionType;
    private String message;
    private String status;
    private Timestamp createdAt;
    
    // Join fields
    private String userName;
    private String trainerName;
    
    public Booking() {}
    
    public Booking(int userId, int trainerId, String bookingDate, String sessionType, String message) {
        this.userId = userId;
        this.trainerId = trainerId;
        this.bookingDate = bookingDate;
        this.sessionType = sessionType;
        this.message = message;
        this.status = "pending";
    }
    
    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    
    public int getTrainerId() { return trainerId; }
    public void setTrainerId(int trainerId) { this.trainerId = trainerId; }
    
    public String getBookingDate() { return bookingDate; }
    public void setBookingDate(String bookingDate) { this.bookingDate = bookingDate; }
    
    public String getSessionType() { return sessionType; }
    public void setSessionType(String sessionType) { this.sessionType = sessionType; }
    
    public String getMessage() { return message; }
    public void setMessage(String message) { this.message = message; }
    
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    
    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
    
    public String getUserName() { return userName; }
    public void setUserName(String userName) { this.userName = userName; }
    
    public String getTrainerName() { return trainerName; }
    public void setTrainerName(String trainerName) { this.trainerName = trainerName; }
}
