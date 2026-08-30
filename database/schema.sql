-- Premium Gym Website Database Schema
-- MySQL Database

-- Create Database
CREATE DATABASE IF NOT EXISTS gym_website CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE gym_website;

-- Users Table
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    phone VARCHAR(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_email (email)
);

-- Membership Plans Table
CREATE TABLE membership_plans (
    id INT AUTO_INCREMENT PRIMARY KEY,
    plan_name VARCHAR(50) NOT NULL,
    description TEXT,
    price DECIMAL(10,2) NOT NULL,
    duration_months INT NOT NULL,
    features JSON,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- User Memberships Table
CREATE TABLE user_memberships (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    plan_id INT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    status ENUM('active', 'expired', 'cancelled') DEFAULT 'active',
    payment_status ENUM('paid', 'pending', 'failed') DEFAULT 'paid',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (plan_id) REFERENCES membership_plans(id),
    INDEX idx_user_id (user_id),
    INDEX idx_status (status)
);

-- Trainers Table
CREATE TABLE trainers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    specialization VARCHAR(100) NOT NULL,
    experience_years INT NOT NULL,
    bio TEXT,
    image_url VARCHAR(255),
    email VARCHAR(100),
    phone VARCHAR(20),
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Contact Messages Table
CREATE TABLE contact_messages (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    message TEXT NOT NULL,
    status ENUM('new', 'read', 'replied') DEFAULT 'new',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_status (status),
    INDEX idx_created_at (created_at)
);

-- Testimonials Table
CREATE TABLE testimonials (
    id INT AUTO_INCREMENT PRIMARY KEY,
    client_name VARCHAR(100) NOT NULL,
    client_image VARCHAR(255),
    rating INT NOT NULL CHECK (rating >= 1 AND rating <= 5),
    testimonial_text TEXT NOT NULL,
    is_featured BOOLEAN DEFAULT FALSE,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_featured (is_featured),
    INDEX idx_active (is_active)
);

-- Gallery Images Table
CREATE TABLE gallery_images (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    description TEXT,
    image_url VARCHAR(255) NOT NULL,
    category VARCHAR(50) DEFAULT 'general',
    is_active BOOLEAN DEFAULT TRUE,
    display_order INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_category (category),
    INDEX idx_display_order (display_order)
);

-- Insert Default Membership Plans
INSERT INTO membership_plans (plan_name, description, price, duration_months, features) VALUES
('Basic', 'Perfect for beginners who want to get started with fitness', 499.00, 1,
 JSON_ARRAY('Access to gym equipment', 'Basic workout area', 'Locker room access')),
('Standard', 'Our most popular plan with great value', 999.00, 1,
 JSON_ARRAY('Access to gym equipment', 'Group fitness classes', 'Personal trainer consultation', 'Nutrition guidance')),
('Premium', 'All-inclusive plan for serious fitness enthusiasts', 1999.00, 1,
 JSON_ARRAY('Full gym access', 'Unlimited group classes', 'Weekly personal training', 'Custom diet plan', 'Sauna access', 'Guest privileges'));

-- Insert Sample Trainers
INSERT INTO trainers (name, specialization, experience_years, bio, image_url, email, phone) VALUES
('John Smith', 'Strength Training', 8, 'Specialized in powerlifting and bodybuilding with 8+ years of experience', '', 'john@gym.com', '555-0101'),
('Sarah Johnson', 'Yoga & Flexibility', 6, 'Certified yoga instructor focusing on flexibility and mindfulness', '', 'sarah@gym.com', '555-0102'),
('Mike Wilson', 'Cardio & HIIT', 5, 'Expert in high-intensity interval training and cardiovascular fitness', '', 'mike@gym.com', '555-0103'),
('Emma Davis', 'Nutrition & Weight Loss', 7, 'Registered dietitian specializing in weight management and sports nutrition', '', 'emma@gym.com', '555-0104');

-- Insert Sample Testimonials
INSERT INTO testimonials (client_name, client_image, rating, testimonial_text, is_featured, is_active) VALUES
('Alex Thompson', '', 5, 'Amazing gym with top-notch equipment and trainers. Completely transformed my fitness journey!', TRUE, TRUE),
('Maria Garcia', '', 5, 'The personal training program helped me achieve my weight loss goals. Highly recommend!', TRUE, TRUE),
('David Chen', '', 4, 'Great atmosphere and professional staff. The group classes are fantastic.', FALSE, TRUE),
('Lisa Anderson', '', 5, 'Best gym in town! Clean, well-maintained, and the community is very supportive.', TRUE, TRUE);

-- Insert Sample Gallery Images
INSERT INTO gallery_images (title, description, image_url, category, display_order) VALUES
('Modern Gym Equipment', 'State-of-the-art fitness equipment for all workout needs', 'images/gallery1.jpg', 'equipment', 1),
('Training Area', 'Spacious training area with professional flooring', 'images/gallery2.jpg', 'facility', 2),
('Group Fitness Class', 'Energetic group fitness classes with certified instructors', 'images/gallery3.jpg', 'classes', 3),
('Personal Training Session', 'One-on-one personal training with expert trainers', 'images/gallery4.jpg', 'training', 4),
('Cardio Zone', 'Dedicated cardio zone with modern machines', 'images/gallery5.jpg', 'equipment', 5),
('Relaxation Area', 'Comfortable relaxation area for post-workout recovery', 'images/gallery6.jpg', 'facility', 6);

-- Create Admin User (password: admin123 hashed with BCrypt)
INSERT INTO users (name, email, password, phone) VALUES
('Admin User', 'admin@gym.com', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9b2.1s9U/6b0j8W', '555-0000');

-- Create Indexes for Performance
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_user_memberships_user_status ON user_memberships(user_id, status);
CREATE INDEX idx_contact_messages_status_date ON contact_messages(status, created_at);
CREATE INDEX idx_testimonials_featured_active ON testimonials(is_featured, is_active);
CREATE INDEX idx_gallery_category_active ON gallery_images(category, is_active);

-- Set up foreign key constraints
ALTER TABLE user_memberships ADD CONSTRAINT fk_user_memberships_user 
FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE;

ALTER TABLE user_memberships ADD CONSTRAINT fk_user_memberships_plan 
FOREIGN KEY (plan_id) REFERENCES membership_plans(id);

-- View for Active Memberships with User Details
CREATE VIEW active_memberships_view AS
SELECT 
    um.id as membership_id,
    u.name as user_name,
    u.email as user_email,
    mp.plan_name,
    mp.price,
    um.start_date,
    um.end_date,
    um.status,
    um.payment_status
FROM user_memberships um
JOIN users u ON um.user_id = u.id
JOIN membership_plans mp ON um.plan_id = mp.id
WHERE um.status = 'active';

-- View for Featured Testimonials
CREATE VIEW featured_testimonials_view AS
SELECT 
    client_name,
    client_image,
    rating,
    testimonial_text
FROM testimonials
WHERE is_active = TRUE AND is_featured = TRUE
ORDER BY created_at DESC;

-- User Progress Tracking Table
CREATE TABLE user_progress (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    weight DECIMAL(5,2),
    height DECIMAL(5,2),
    bmi DECIMAL(5,2),
    recorded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_user_progress (user_id),
    INDEX idx_recorded_at (recorded_at)
);

COMMIT;
