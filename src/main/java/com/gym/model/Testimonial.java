package com.gym.model;

public class Testimonial {
    private int id;
    private String clientName;
    private String clientImage;
    private int rating;
    private String testimonialText;
    private boolean isFeatured;
    private boolean isActive;
    
    public Testimonial() {}
    
    public Testimonial(String clientName, String clientImage, int rating, String testimonialText) {
        this.clientName = clientName;
        this.clientImage = clientImage;
        this.rating = rating;
        this.testimonialText = testimonialText;
        this.isFeatured = false;
        this.isActive = true;
    }
    
    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    
    public String getClientName() { return clientName; }
    public void setClientName(String clientName) { this.clientName = clientName; }
    
    public String getClientImage() { return clientImage; }
    public void setClientImage(String clientImage) { this.clientImage = clientImage; }
    
    public int getRating() { return rating; }
    public void setRating(int rating) { this.rating = rating; }
    
    public String getTestimonialText() { return testimonialText; }
    public void setTestimonialText(String testimonialText) { this.testimonialText = testimonialText; }
    
    public boolean isFeatured() { return isFeatured; }
    public void setFeatured(boolean featured) { isFeatured = featured; }
    
    public boolean isActive() { return isActive; }
    public void setActive(boolean active) { isActive = active; }
    
    @Override
    public String toString() {
        return "Testimonial{" +
                "id=" + id +
                ", clientName='" + clientName + '\'' +
                ", rating=" + rating +
                ", featured=" + isFeatured +
                '}';
    }
}
