<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.gym.model.User" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gallery - PowerLift Gym</title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- Custom CSS -->
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/animations.css">
    
    <style>
        .gallery-hero {
            background: linear-gradient(rgba(0, 0, 0, 0.7), rgba(0, 0, 0, 0.7)),
                        url('https://images.unsplash.com/photo-1558611848-73f7eb4001a1?ixlib=rb-4.0.3&auto=format&fit=crop&w=1920&q=80') center/cover no-repeat;
            background-attachment: fixed;
            min-height: 50vh;
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;
        }
        
        .gallery-content {
            text-align: center;
            z-index: 2;
        }
        
        .gallery-title {
            font-size: 3.5rem;
            font-weight: 900;
            margin-bottom: 1rem;
            text-shadow: 2px 2px 10px rgba(0, 240, 255, 0.3);
            color: #ffffff;
            font-family: 'Orbitron', sans-serif;
        }
        
        .filter-buttons {
            display: flex;
            justify-content: center;
            flex-wrap: wrap;
            gap: 1rem;
            margin-bottom: 3rem;
        }
        
        .filter-btn {
            background: rgba(10, 11, 16, 0.95);
            border: 1px solid rgba(255, 255, 255, 0.2);
            color: #ffffff;
            padding: 0.8rem 1.5rem;
            border-radius: 25px;
            font-weight: 500;
            transition: all 0.3s ease;
            cursor: pointer;
        }
        
        .filter-btn:hover,
        .filter-btn.active {
            background: linear-gradient(135deg, #ff0000 0%, #cc0000 100%);
            border-color: #ff0000;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(255, 0, 0, 0.3);
        }
        
        .gallery-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 2rem;
            margin-bottom: 3rem;
        }
        
        .gallery-item {
            position: relative;
            overflow: hidden;
            border-radius: 15px;
            cursor: pointer;
            transition: all 0.3s ease;
            background: rgba(255, 255, 255, 0.05);
            aspect-ratio: 1;
        }
        
        .gallery-item:hover {
            transform: translateY(-10px);
            box-shadow: 0 20px 40px rgba(255, 0, 0, 0.3);
        }
        
        .gallery-item img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: all 0.3s ease;
        }
        
        .gallery-item:hover img {
            transform: scale(1.1);
        }
        
        .gallery-overlay {
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(135deg, rgba(255, 0, 0, 0.9) 0%, rgba(204, 0, 0, 0.9) 100%);
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            opacity: 0;
            transition: all 0.3s ease;
            padding: 1rem;
        }
        
        .gallery-item:hover .gallery-overlay {
            opacity: 1;
        }
        
        .gallery-overlay h4 {
            color: #ffffff;
            font-weight: 600;
            margin-bottom: 0.5rem;
            text-align: center;
        }
        
        .gallery-overlay p {
            color: rgba(255, 255, 255, 0.9);
            font-size: 0.9rem;
            text-align: center;
            margin-bottom: 1rem;
        }
        
        .gallery-overlay .zoom-icon {
            width: 50px;
            height: 50px;
            background: rgba(255, 255, 255, 0.2);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #ffffff;
            font-size: 1.2rem;
            transition: all 0.3s ease;
        }
        
        .gallery-overlay .zoom-icon:hover {
            background: rgba(255, 255, 255, 0.3);
            transform: scale(1.1);
        }
        
        /* Lightbox Styles */
        .lightbox {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.95);
            z-index: 9999;
            animation: fadeIn 0.3s ease;
        }
        
        .lightbox.active {
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        .lightbox-content {
            position: relative;
            max-width: 90%;
            max-height: 90%;
            animation: slideIn 0.3s ease;
        }
        
        .lightbox-content img {
            width: 100%;
            height: auto;
            border-radius: 10px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.5);
        }
        
        .lightbox-close {
            position: absolute;
            top: -40px;
            right: 0;
            background: none;
            border: none;
            color: #ffffff;
            font-size: 2rem;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        
        .lightbox-close:hover {
            color: #ff0000;
            transform: scale(1.1);
        }
        
        .lightbox-nav {
            position: absolute;
            top: 50%;
            transform: translateY(-50%);
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            -webkit-backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            color: #ffffff;
            border: none;
            width: 50px;
            height: 50px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: all 0.3s ease;
            font-size: 1.2rem;
        }
        
        .lightbox-nav:hover {
            background: rgba(255, 0, 0, 0.8);
            transform: translateY(-50%) scale(1.1);
        }
        
        .lightbox-prev {
            left: 20px;
        }
        
        .lightbox-next {
            right: 20px;
        }
        
        .lightbox-info {
            position: absolute;
            bottom: 20px;
            left: 50%;
            transform: translateX(-50%);
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            -webkit-backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            color: #ffffff;
            padding: 1rem 2rem;
            border-radius: 25px;
            text-align: center;
        }
        
        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }
        
        @keyframes slideIn {
            from {
                opacity: 0;
                transform: scale(0.9);
            }
            to {
                opacity: 1;
                transform: scale(1);
            }
        }
        
        @media (max-width: 768px) {
            .gallery-grid {
                grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
                gap: 1rem;
            }
            
            .gallery-title {
                font-size: 2.5rem;
            }
            
            .lightbox-nav {
                width: 40px;
                height: 40px;
                font-size: 1rem;
            }
            
            .lightbox-prev {
                left: 10px;
            }
            
            .lightbox-next {
                right: 10px;
            }
        }
        /* ❌ NO BLUR - MAXIMUM SHARPNESS */
        * {
            backdrop-filter: none !important;
            -webkit-backdrop-filter: none !important;
            filter: none !important;
        }

        .glass, .glass-dark, .card-custom, .navbar.scrolled, .filter-btn, .gallery-item, .lightbox-info {
            background: rgba(10, 11, 16, 0.95) !important;
            border: 1px solid rgba(0, 240, 255, 0.2) !important;
        }
    </style>
</head>
<body>
    <jsp:include page="components/navbar.jsp" />

    <!-- Gallery Hero -->
    <section class="gallery-hero">
        <div class="container">
            <div class="gallery-content">
                <h1 class="gallery-title text-gradient">OUR GALLERY</h1>
                <p class="lead ">Explore our world-class facilities and vibrant fitness community</p>
            </div>
        </div>
    </section>

    <!-- Gallery Section -->
    <section class="py-5">
        <div class="container">
            <!-- Filter Buttons -->
            <div class="filter-buttons">
                <button class="filter-btn active" data-filter="all">All</button>
                <button class="filter-btn" data-filter="equipment">Equipment</button>
                <button class="filter-btn" data-filter="facility">Facility</button>
                <button class="filter-btn" data-filter="training">Training</button>
                <button class="filter-btn" data-filter="classes">Classes</button>
                <button class="filter-btn" data-filter="community">Community</button>
            </div>
            
            <!-- Gallery Grid -->
            <div class="gallery-grid">
                <!-- Equipment Gallery -->
                <div class="gallery-item" data-category="equipment">
                    <img src="https://images.unsplash.com/photo-1534438327276-14e5300c3a48?ixlib=rb-4.0.3&auto=format&fit=crop&w=600&q=80" alt="Modern Gym Equipment">
                    <div class="gallery-overlay">
                        <h4>State-of-the-Art Equipment</h4>
                        <p>Premium fitness equipment from leading brands</p>
                        <div class="zoom-icon">
                            <i class="fas fa-search-plus"></i>
                        </div>
                    </div>
                </div>
                
                <div class="gallery-item" data-category="equipment">
                    <img src="https://images.unsplash.com/photo-1540497077202-7c8a3999166f?ixlib=rb-4.0.3&auto=format&fit=crop&w=600&q=80" alt="Weight Training Area">
                    <div class="gallery-overlay">
                        <h4>Weight Training Zone</h4>
                        <p>Comprehensive free weights and machines</p>
                        <div class="zoom-icon">
                            <i class="fas fa-search-plus"></i>
                        </div>
                    </div>
                </div>
                
                <div class="gallery-item" data-category="equipment">
                    <img src="https://images.unsplash.com/photo-1584735935682-2f2b69dff9d2?ixlib=rb-4.0.3&auto=format&fit=crop&w=600&q=80" alt="Cardio Machines">
                    <div class="gallery-overlay">
                        <h4>Cardio Section</h4>
                        <p>Latest treadmills, ellipticals, and bikes</p>
                        <div class="zoom-icon">
                            <i class="fas fa-search-plus"></i>
                        </div>
                    </div>
                </div>
                
                <!-- Facility Gallery -->
                <div class="gallery-item" data-category="facility">
                    <img src="https://images.unsplash.com/photo-1593079831268-3381b0db4a77?ixlib=rb-4.0.3&auto=format&fit=crop&w=600&q=80" alt="Gym Interior">
                    <div class="gallery-overlay">
                        <h4>Spacious Interior</h4>
                        <p>Modern, clean, and motivating environment</p>
                        <div class="zoom-icon">
                            <i class="fas fa-search-plus"></i>
                        </div>
                    </div>
                </div>
                
                <div class="gallery-item" data-category="facility">
                    <img src="https://images.unsplash.com/photo-1534438327276-14e5300c3a48?ixlib=rb-4.0.3&auto=format&fit=crop&w=600&q=80" alt="Locker Room">
                    <div class="gallery-overlay">
                        <h4>Premium Locker Rooms</h4>
                        <p>Clean and comfortable changing facilities</p>
                        <div class="zoom-icon">
                            <i class="fas fa-search-plus"></i>
                        </div>
                    </div>
                </div>
                
                <div class="gallery-item" data-category="facility">
                    <img src="https://images.unsplash.com/photo-1571902943202-507ec2618e8f?ixlib=rb-4.0.3&auto=format&fit=crop&w=600&q=80" alt="Lounge Area">
                    <div class="gallery-overlay">
                        <h4>Relaxation Lounge</h4>
                        <p>Comfortable space to relax and socialize</p>
                        <div class="zoom-icon">
                            <i class="fas fa-search-plus"></i>
                        </div>
                    </div>
                </div>
                
                <!-- Training Gallery -->
                <div class="gallery-item" data-category="training">
                    <img src="https://images.unsplash.com/photo-1581009146145-b5ef050c2e1e?ixlib=rb-4.0.3&auto=format&fit=crop&w=600&q=80" alt="Personal Training">
                    <div class="gallery-overlay">
                        <h4>Personal Training</h4>
                        <p>One-on-one sessions with expert trainers</p>
                        <div class="zoom-icon">
                            <i class="fas fa-search-plus"></i>
                        </div>
                    </div>
                </div>
                
                <div class="gallery-item" data-category="training">
                    <img src="https://images.unsplash.com/photo-1517836357463-d25dfeac3438?ixlib=rb-4.0.3&auto=format&fit=crop&w=600&q=80" alt="Strength Training">
                    <div class="gallery-overlay">
                        <h4>Strength Training</h4>
                        <p>Building muscle and power with expert guidance</p>
                        <div class="zoom-icon">
                            <i class="fas fa-search-plus"></i>
                        </div>
                    </div>
                </div>
                
                <div class="gallery-item" data-category="training">
                    <img src="https://images.unsplash.com/photo-1526506118085-60ce8714f8c5?ixlib=rb-4.0.3&auto=format&fit=crop&w=600&q=80" alt="Functional Training">
                    <div class="gallery-overlay">
                        <h4>Functional Training</h4>
                        <p>Real-world movement patterns and exercises</p>
                        <div class="zoom-icon">
                            <i class="fas fa-search-plus"></i>
                        </div>
                    </div>
                </div>
                
                <!-- Classes Gallery -->
                <div class="gallery-item" data-category="classes">
                    <img src="https://images.unsplash.com/photo-1518310383802-640c2de311b2?ixlib=rb-4.0.3&auto=format&fit=crop&w=600&q=80" alt="Yoga Class">
                    <div class="gallery-overlay">
                        <h4>Yoga Classes</h4>
                        <p>Find your balance and inner peace</p>
                        <div class="zoom-icon">
                            <i class="fas fa-search-plus"></i>
                        </div>
                    </div>
                </div>
                
                <div class="gallery-item" data-category="classes">
                    <img src="https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?ixlib=rb-4.0.3&auto=format&fit=crop&w=600&q=80" alt="HIIT Class">
                    <div class="gallery-overlay">
                        <h4>HIIT Workouts</h4>
                        <p>High-intensity interval training sessions</p>
                        <div class="zoom-icon">
                            <i class="fas fa-search-plus"></i>
                        </div>
                    </div>
                </div>
                
                <div class="gallery-item" data-category="classes">
                    <img src="https://images.unsplash.com/photo-1571902943202-507ec2618e8f?ixlib=rb-4.0.3&auto=format&fit=crop&w=600&q=80" alt="Group Fitness">
                    <div class="gallery-overlay">
                        <h4>Group Fitness</h4>
                        <p>Energetic group workout sessions</p>
                        <div class="zoom-icon">
                            <i class="fas fa-search-plus"></i>
                        </div>
                    </div>
                </div>
                
                <!-- Community Gallery -->
                <div class="gallery-item" data-category="community">
                    <img src="https://images.unsplash.com/photo-1526401485004-46910ecc8e51?ixlib=rb-4.0.3&auto=format&fit=crop&w=600&q=80" alt="Gym Community">
                    <div class="gallery-overlay">
                        <h4>Our Community</h4>
                        <p>Supportive fitness family</p>
                        <div class="zoom-icon">
                            <i class="fas fa-search-plus"></i>
                        </div>
                    </div>
                </div>
                
                <div class="gallery-item" data-category="community">
                    <img src="https://images.unsplash.com/photo-1574680096145-d05b474e2155?ixlib=rb-4.0.3&auto=format&fit=crop&w=600&q=80" alt="Members Working Out">
                    <div class="gallery-overlay">
                        <h4>Member Success</h4>
                        <p>Real people achieving real results</p>
                        <div class="zoom-icon">
                            <i class="fas fa-search-plus"></i>
                        </div>
                    </div>
                </div>
                
                <div class="gallery-item" data-category="community">
                    <img src="https://images.unsplash.com/photo-1521737604893-d14cc237f11d?ixlib=rb-4.0.3&auto=format&fit=crop&w=600&q=80" alt="Team Spirit">
                    <div class="gallery-overlay">
                        <h4>Team Spirit</h4>
                        <p>Together we achieve more</p>
                        <div class="zoom-icon">
                            <i class="fas fa-search-plus"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Lightbox -->
    <div class="lightbox" id="lightbox">
        <div class="lightbox-content">
            <button class="lightbox-close" onclick="closeLightbox()">
                <i class="fas fa-times"></i>
            </button>
            <button class="lightbox-nav lightbox-prev" onclick="navigateLightbox(-1)">
                <i class="fas fa-chevron-left"></i>
            </button>
            <img id="lightbox-image" src="" alt="">
            <button class="lightbox-nav lightbox-next" onclick="navigateLightbox(1)">
                <i class="fas fa-chevron-right"></i>
            </button>
            <div class="lightbox-info">
                <h4 id="lightbox-title"></h4>
                <p id="lightbox-description"></p>
            </div>
        </div>
    </div>

    <!-- CTA Section -->
    <section class="py-5">
        <div class="container">
            <div class="text-center">
                <h2 class="text-gradient mb-4">WANT TO SEE IT IN PERSON?</h2>
                <p class="lead mb-4">Book a free tour of our facilities with one of our staff members</p>
                <div class="d-flex justify-content-center gap-3">
                    <% if (session.getAttribute("user") != null) { %>
                        <a href="${pageContext.request.contextPath}/dashboard.jsp" class="btn btn-primary-custom btn-lg">View Dashboard</a>
                    <% } else { %>
                        <a href="${pageContext.request.contextPath}/register.jsp" class="btn btn-primary-custom btn-lg">Join Now</a>
                    <% } %>
                    <a href="${pageContext.request.contextPath}/contact.jsp" class="btn btn-outline-custom btn-lg">Schedule a Tour</a>
                </div>
            </div>
        </div>
    </section>

    <jsp:include page="components/footer.jsp" />

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        // Gallery data
        const galleryData = [
            {
                src: 'https://images.unsplash.com/photo-1596357399117-574765366472?ixlib=rb-4.0.3&auto=format&fit=crop&w=1200&q=80',
                title: 'State-of-the-Art Equipment',
                description: 'Premium fitness equipment from leading brands',
                category: 'equipment'
            },
            {
                src: 'https://images.unsplash.com/photo-1519505907962-0a6cb0167c73?ixlib=rb-4.0.3&auto=format&fit=crop&w=1200&q=80',
                title: 'Weight Training Zone',
                description: 'Comprehensive free weights and machines',
                category: 'equipment'
            },
            {
                src: 'https://images.unsplash.com/photo-1584735935682-2f2b69dff9d2?ixlib=rb-4.0.3&auto=format&fit=crop&w=1200&q=80',
                title: 'Cardio Section',
                description: 'Latest treadmills, ellipticals, and bikes',
                category: 'equipment'
            },
            {
                src: 'https://images.unsplash.com/photo-1593079831268-3381b0db4a77?ixlib=rb-4.0.3&auto=format&fit=crop&w=1200&q=80',
                title: 'Spacious Interior',
                description: 'Modern, clean, and motivating environment',
                category: 'facility'
            },
            {
                src: 'https://images.unsplash.com/photo-1534438327276-14e5300c3a48?ixlib=rb-4.0.3&auto=format&fit=crop&w=1200&q=80',
                title: 'Premium Locker Rooms',
                description: 'Clean and comfortable changing facilities',
                category: 'facility'
            },
            {
                src: 'https://images.unsplash.com/photo-1548690312-e3b507d17a12?ixlib=rb-4.0.3&auto=format&fit=crop&w=1200&q=80',
                title: 'Relaxation Lounge',
                description: 'Comfortable space to relax and socialize',
                category: 'facility'
            },
            {
                src: 'https://images.unsplash.com/photo-1581009146145-b5ef050c2e1e?ixlib=rb-4.0.3&auto=format&fit=crop&w=1200&q=80',
                title: 'Personal Training',
                description: 'One-on-one sessions with expert trainers',
                category: 'training'
            },
            {
                src: 'https://images.unsplash.com/photo-1517836357463-d25dfeac3438?ixlib=rb-4.0.3&auto=format&fit=crop&w=1200&q=80',
                title: 'Strength Training',
                description: 'Building muscle and power with expert guidance',
                category: 'training'
            },
            {
                src: 'https://images.unsplash.com/photo-1526506118085-60ce8714f8c5?ixlib=rb-4.0.3&auto=format&fit=crop&w=1200&q=80',
                title: 'Functional Training',
                description: 'Real-world movement patterns and exercises',
                category: 'training'
            },
            {
                src: 'https://images.unsplash.com/photo-1524594152303-9fd13543fe6e?ixlib=rb-4.0.3&auto=format&fit=crop&w=1200&q=80',
                title: 'Yoga Classes',
                description: 'Find your balance and inner peace',
                category: 'classes'
            },
            {
                src: 'https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?ixlib=rb-4.0.3&auto=format&fit=crop&w=1200&q=80',
                title: 'HIIT Workouts',
                description: 'High-intensity interval training sessions',
                category: 'classes'
            },
            {
                src: 'https://images.unsplash.com/photo-1571902943202-507ec2618e8f?ixlib=rb-4.0.3&auto=format&fit=crop&w=1200&q=80',
                title: 'Group Fitness',
                description: 'Energetic group workout sessions',
                category: 'classes'
            },
            {
                src: 'https://images.unsplash.com/photo-1526401485004-46910ecc8e51?ixlib=rb-4.0.3&auto=format&fit=crop&w=1200&q=80',
                title: 'Our Community',
                description: 'Supportive fitness family',
                category: 'community'
            },
            {
                src: 'https://images.unsplash.com/photo-1574680096145-d05b474e2155?ixlib=rb-4.0.3&auto=format&fit=crop&w=1200&q=80',
                title: 'Member Success',
                description: 'Real people achieving real results',
                category: 'community'
            },
            {
                src: 'https://images.unsplash.com/photo-1521737604893-d14cc237f11d?ixlib=rb-4.0.3&auto=format&fit=crop&w=1200&q=80',
                title: 'Team Spirit',
                description: 'Together we achieve more',
                category: 'community'
            }
        ];
        
        let currentImageIndex = 0;
        let currentFilter = 'all';
        
        // Filter functionality
        document.querySelectorAll('.filter-btn').forEach(btn => {
            btn.addEventListener('click', function() {
                // Update active button
                document.querySelectorAll('.filter-btn').forEach(b => b.classList.remove('active'));
                this.classList.add('active');
                
                // Update filter
                currentFilter = this.dataset.filter;
                
                // Filter gallery items
                const items = document.querySelectorAll('.gallery-item');
                items.forEach(item => {
                    if (currentFilter === 'all' || item.dataset.category === currentFilter) {
                        item.style.display = 'block';
                        setTimeout(() => {
                            item.style.opacity = '1';
                            item.style.transform = 'scale(1)';
                        }, 10);
                    } else {
                        item.style.opacity = '0';
                        item.style.transform = 'scale(0.8)';
                        setTimeout(() => {
                            item.style.display = 'none';
                        }, 300);
                    }
                });
            });
        });
        
        // Lightbox functionality
        document.querySelectorAll('.gallery-item').forEach((item, index) => {
            item.addEventListener('click', function() {
                currentImageIndex = index;
                openLightbox(index);
            });
        });
        
        function openLightbox(index) {
            const lightbox = document.getElementById('lightbox');
            const image = document.getElementById('lightbox-image');
            const title = document.getElementById('lightbox-title');
            const description = document.getElementById('lightbox-description');
            
            const data = galleryData[index];
            image.src = data.src;
            title.textContent = data.title;
            description.textContent = data.description;
            
            lightbox.classList.add('active');
            document.body.style.overflow = 'hidden';
        }
        
        function closeLightbox() {
            const lightbox = document.getElementById('lightbox');
            lightbox.classList.remove('active');
            document.body.style.overflow = 'auto';
        }
        
        function navigateLightbox(direction) {
            currentImageIndex += direction;
            
            if (currentImageIndex < 0) {
                currentImageIndex = galleryData.length - 1;
            } else if (currentImageIndex >= galleryData.length) {
                currentImageIndex = 0;
            }
            
            const image = document.getElementById('lightbox-image');
            const title = document.getElementById('lightbox-title');
            const description = document.getElementById('lightbox-description');
            
            const data = galleryData[currentImageIndex];
            
            // Fade out
            image.style.opacity = '0';
            
            setTimeout(() => {
                image.src = data.src;
                title.textContent = data.title;
                description.textContent = data.description;
                
                // Fade in
                image.style.opacity = '1';
            }, 300);
        }
        
        // Keyboard navigation
        document.addEventListener('keydown', function(e) {
            const lightbox = document.getElementById('lightbox');
            if (lightbox.classList.contains('active')) {
                if (e.key === 'Escape') {
                    closeLightbox();
                } else if (e.key === 'ArrowLeft') {
                    navigateLightbox(-1);
                } else if (e.key === 'ArrowRight') {
                    navigateLightbox(1);
                }
            }
        });
        
        // Click outside to close
        document.getElementById('lightbox').addEventListener('click', function(e) {
            if (e.target === this) {
                closeLightbox();
            }
        });
    </script>
    <script src="js/script.js"></script>
</body>
</html>


