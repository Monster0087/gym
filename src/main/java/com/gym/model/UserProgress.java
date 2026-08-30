package com.gym.model;

import java.time.LocalDateTime;

public class UserProgress {
    private int id;
    private int userId;
    private double weight;
    private double height;
    private double bmi;
    private LocalDateTime recordedAt;

    public UserProgress() {}

    public UserProgress(int userId, double weight, double height, double bmi) {
        this.userId = userId;
        this.weight = weight;
        this.height = height;
        this.bmi = bmi;
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public double getWeight() { return weight; }
    public void setWeight(double weight) { this.weight = weight; }

    public double getHeight() { return height; }
    public void setHeight(double height) { this.height = height; }

    public double getBmi() { return bmi; }
    public void setBmi(double bmi) { this.bmi = bmi; }

    public LocalDateTime getRecordedAt() { return recordedAt; }
    public void setRecordedAt(LocalDateTime recordedAt) { this.recordedAt = recordedAt; }
}
