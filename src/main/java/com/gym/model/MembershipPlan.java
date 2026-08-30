package com.gym.model;

import java.time.LocalDate;
import java.util.List;

public class MembershipPlan {
    private int id;
    private String planName;
    private String description;
    private double price;
    private int durationMonths;
    private List<String> features;
    private boolean isActive;
    
    public MembershipPlan() {}
    
    public MembershipPlan(String planName, String description, double price, int durationMonths, List<String> features) {
        this.planName = planName;
        this.description = description;
        this.price = price;
        this.durationMonths = durationMonths;
        this.features = features;
        this.isActive = true;
    }
    
    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    
    public String getPlanName() { return planName; }
    public void setPlanName(String planName) { this.planName = planName; }
    
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    
    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }
    
    public int getDurationMonths() { return durationMonths; }
    public void setDurationMonths(int durationMonths) { this.durationMonths = durationMonths; }
    
    public List<String> getFeatures() { return features; }
    public void setFeatures(List<String> features) { this.features = features; }
    
    public boolean isActive() { return isActive; }
    public void setActive(boolean active) { isActive = active; }
    
    @Override
    public String toString() {
        return "MembershipPlan{" +
                "id=" + id +
                ", planName='" + planName + '\'' +
                ", price=" + price +
                ", durationMonths=" + durationMonths +
                '}';
    }
}
