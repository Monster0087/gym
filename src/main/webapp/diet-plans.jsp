<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.gym.model.User" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Powerlift - Diet Plans & BMI Calculator</title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- Custom CSS -->
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/animations.css">
    
    <style>
        .page-header {
            padding: 150px 0 80px;
            background: linear-gradient(rgba(0, 0, 0, 0.8), rgba(0, 0, 0, 0.8)),
                        url('https://images.unsplash.com/photo-1490645935967-10de6ba17061?ixlib=rb-4.0.3&auto=format&fit=crop&w=1920&q=80') center/cover no-repeat;
            text-align: center;
        }
        
        .diet-result {
            display: none;
            opacity: 0;
            transform: translateY(20px);
            transition: all 0.5s ease;
        }
        
        .diet-result.show {
            display: block;
            opacity: 1;
            transform: translateY(0);
        }
        
        .plan-card {
            border-left: 5px solid var(--primary-color);
        }
        /* ❌ NO BLUR - MAXIMUM SHARPNESS */
        * {
            backdrop-filter: none !important;
            -webkit-backdrop-filter: none !important;
            filter: none !important;
        }

        .glass, .glass-dark, .card-custom, .navbar.scrolled, .plan-card {
            background: rgba(10, 11, 16, 0.95) !important;
            border: 1px solid rgba(0, 240, 255, 0.2) !important;
        }
    </style>
</head>
<body>
    <jsp:include page="components/navbar.jsp" />

    <!-- Page Header -->
    <header class="page-header">
        <div class="container">
            <h1 class="text-gradient display-3">PERSONALIZED DIET PLANS</h1>
            <p class="lead ">Calculate your BMI and get a diet plan tailored to your body</p>
        </div>
    </header>

    <!-- Calculator Section -->
    <section class="py-5">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-md-6">
                    <div class="card-custom">
                        <h3 class="card-title-custom text-center mb-4"><i class="fas fa-calculator me-2"></i>BMI Calculator</h3>
                        <form id="bmiForm">
                            <div class="mb-4">
                                <label for="weight" class="form-label ">Weight (kg)</label>
                                <input type="number" class="form-control form-control-custom" id="weight" placeholder="e.g. 75" required min="30" max="300" step="0.1">
                            </div>
                            <div class="mb-4">
                                <label for="height" class="form-label ">Height (cm)</label>
                                <input type="number" class="form-control form-control-custom" id="height" placeholder="e.g. 175" required min="100" max="250" step="1">
                            </div>
                            <div class="mb-4">
                                <label for="goal" class="form-label ">Your Fitness Goal</label>
                                <select id="goal" class="form-select form-control-custom" required>
                                    <option value="" disabled selected>Select your goal</option>
                                    <option value="gain">Weight Gain / Bulking</option>
                                    <option value="maintain">Maintain / Recomposition</option>
                                    <option value="loss">Fat Loss / Cutting</option>
                                </select>
                            </div>
                            <button type="submit" class="btn btn-primary-custom w-100 mt-2">CALCULATE & GET SMART PLAN</button>
                        </form>
                    </div>
                </div>
            </div>

            <!-- Results Section -->
            <div class="row justify-content-center mt-5">
                <div class="col-md-10">
                    <div id="resultContainer" class="diet-result card-custom glass-dark">
                        <div class="text-center mb-4">
                            <h2 class="text-gradient">YOUR RESULTS</h2>
                            <h4 id="bmiValueDisplay" class=" mt-3">BMI: <span id="bmiScore" class="text-primary fs-2">--</span></h4>
                            <span id="bmiCategory" class="badge bg-primary fs-5 mt-2 px-4 py-2 rounded-pill">--</span>
                            
                            <div id="saveProgressContainer" class="mt-4" style="display: none;">
                                <form action="save-progress" method="POST">
                                    <input type="hidden" name="weight" id="saveWeight">
                                    <input type="hidden" name="height" id="saveHeight">
                                    <input type="hidden" name="bmi" id="saveBMI">
                                    <button type="submit" class="btn btn-outline-custom w-100">
                                        <i class="fas fa-save me-2"></i>SAVE TO MY GROWTH LOG
                                    </button>
                                </form>
                            </div>
                        </div>
                        
                        <div class="plan-card mt-4 p-4 glass rounded">
                            <h3 id="planTitle" class="text-primary mb-3">Loading Plan...</h3>
                            <p id="planDescription" class="lead  mb-4"></p>
                            
                            <div class="row g-4 mt-2">
                                <div class="col-md-4">
                                    <div class="p-3 border border-secondary rounded">
                                        <h5 class="text-primary"><i class="fas fa-sun me-2"></i>Breakfast</h5>
                                        <ul id="breakfastList" class=" ps-3 mb-0"></ul>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="p-3 border border-secondary rounded">
                                        <h5 class="text-primary"><i class="fas fa-utensils me-2"></i>Lunch</h5>
                                        <ul id="lunchList" class=" ps-3 mb-0"></ul>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="p-3 border border-secondary rounded">
                                        <h5 class="text-primary"><i class="fas fa-moon me-2"></i>Dinner</h5>
                                        <ul id="dinnerList" class=" ps-3 mb-0"></ul>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="mt-4 p-3 bg-dark bg-opacity-50 rounded">
                                <h5 class="text-primary"><i class="fas fa-info-circle me-2"></i>Pro Tips</h5>
                                <ul id="proTips" class=" ps-3 mb-0"></ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <jsp:include page="components/footer.jsp" />

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <!-- Custom JS -->
    <script src="js/script.js"></script>
    
    <script>
        document.getElementById('bmiForm').addEventListener('submit', function(e) {
            e.preventDefault();
            
            const weight = parseFloat(document.getElementById('weight').value);
            const height = parseFloat(document.getElementById('height').value) / 100; // convert cm to m
            const goal = document.getElementById('goal').value;
            
            if (weight > 0 && height > 0 && goal) {
                const bmi = (weight / (height * height)).toFixed(1);
                generateSmartPlan(bmi, weight, goal);
            }
        });

        // Smart Diet Plan Logic
        function generateSmartPlan(bmi, weight, goal) {
            const container = document.getElementById('resultContainer');
            const scoreSpan = document.getElementById('bmiScore');
            const categorySpan = document.getElementById('bmiCategory');
            const titleEl = document.getElementById('planTitle');
            const descEl = document.getElementById('planDescription');
            
            // 1. Detect BMI Category
            let bmiCat = "";
            if (bmi < 18.5) bmiCat = "underweight";
            else if (bmi < 25) bmiCat = "normal";
            else if (bmi < 30) bmiCat = "overweight";
            else bmiCat = "obese";

            // 2. Detect Weight Range
            let weightRange = "";
            if (weight < 60) weightRange = "light";
            else if (weight <= 80) weightRange = "medium";
            else weightRange = "heavy";

            // 3. Define Comprehensive Plans
            const dietPlans = {
                underweight: {
                    light: {
                        gain: {
                            title: "High-Calorie Mass Gainer",
                            desc: "Focus on caloric density to build your foundation.",
                            breakfast: ["4 Whole Eggs with Cheese", "Large bowl of Oats with Peanut Butter & Honey", "Banana Shake with Whole Milk"],
                            lunch: ["250g Chicken Breast", "2 cups Brown Rice with Ghee", "Avocado & Nut Salad"],
                            dinner: ["Grilled Salmon or Beef", "Large Sweet Potato", "Pasta with Olive Oil", "Greek Yogurt"],
                            tips: ["Eat every 2 hours", "Don't drink water before meals", "Prioritize Squats & Deadlifts"]
                        }
                    },
                    medium: {
                        gain: {
                            title: "Lean Bulking Strategy",
                            desc: "Building muscle mass while keeping fat gain minimal.",
                            breakfast: ["3 Eggs + 2 Egg Whites", "Oatmeal with Berries", "1 scoop Whey in Milk"],
                            lunch: ["200g Lean Turkey", "1.5 cups Quinoa", "Steam Broccoli with Almonds"],
                            dinner: ["White Fish", "Medium Sweet Potato", "Large Green Salad", "Handful of Pistachios"],
                            tips: ["Track your protein (2g/kg)", "Sleep 8+ hours", "Progressive overload in gym"]
                        }
                    }
                },
                normal: {
                    medium: {
                        maintain: {
                            title: "Balanced Recomposition Plan",
                            desc: "Optimize your current physique by building muscle and burning fat.",
                            breakfast: ["3 Poached Eggs", "1 slice Whole Wheat Toast", "Greek Yogurt with Berries"],
                            lunch: ["150g Grilled Chicken", "1 cup Quinoa", "Large portion of Mixed Veggies"],
                            dinner: ["Baked Fish or Tofu", "Asparagus & Spinach", "Small Salad", "Apple"],
                            tips: ["Stay hydrated (4L water)", "Consistent training 4x week", "Avoid liquid calories"]
                        },
                        gain: {
                            title: "Athletic Growth Plan",
                            desc: "Elevating your fitness with increased nutrient intake.",
                            breakfast: ["Omelette with Peppers", "Oats with protein powder", "Almonds", "Banana"],
                            lunch: ["Lean Ground Beef", "1.5 cups Rice", "Spinach Stir-fry", "Orange"],
                            dinner: ["Grilled Chicken", "Baked Potato", "Brussels Sprouts", "Protein Shake"],
                            tips: ["Focus on pre-workout nutrition", "Heavy resistance training", "Rest 48h between muscle groups"]
                        },
                        loss: {
                            title: "Lean & Toned Plan",
                            desc: "Refining your physique with a slight caloric deficit.",
                            breakfast: ["3 Egg Whites & 1 Whole Egg", "Half Grapefruit", "Black Coffee"],
                            lunch: ["Tuna Salad (no mayo)", "Cucumber & Bell Pepper", "1 small Sweet Potato"],
                            dinner: ["Grilled Chicken Breast", "Steamed Zucchini", "Green Beans", "Herbal Tea"],
                            tips: ["High intensity interval training", "No sugar policy", "Early dinner (before 8 PM)"]
                        }
                    }
                },
                overweight: {
                    heavy: {
                        loss: {
                            title: "Active Fat Burning Plan",
                            desc: "Sustainable weight loss with high-volume, low-calorie foods.",
                            breakfast: ["2 Boiled Eggs", "Oatmeal with Water", "Green Tea (No Sugar)"],
                            lunch: ["Grilled Fish", "Massive Green Salad", "Lemon & Pepper Dressing"],
                            dinner: ["150g Chicken Breast", "Steamed Broccoli & Cauliflower", "Clear Veggie Soup"],
                            tips: ["Walk 10,000 steps daily", "Eliminate fried foods", "Drink water before meals"]
                        }
                    }
                },
                obese: {
                    heavy: {
                        loss: {
                            title: "Metabolic Reset Plan",
                            desc: "Strict whole-foods approach to jumpstart fat loss.",
                            breakfast: ["Egg White Omelette", "Spinach & Mushrooms", "Black Coffee"],
                            lunch: ["Boiled Chicken (no skin)", "Unlimited Steamed Greens", "Cucumber Salad"],
                            dinner: ["Grilled White Fish", "Clear Bone Broth", "Steamed Asparagus"],
                            tips: ["Zero sugar and Zero flour", "Consistent 45-min morning walks", "Prioritize fiber intake"]
                        }
                    }
                }
            };

            // 4. Select Plan (with robust fallbacks)
            const getPlan = () => {
                let category = dietPlans[bmiCat] || dietPlans.normal;
                let range = category[weightRange] || category[Object.keys(category)[0]];
                let final = range[goal] || range[Object.keys(range)[0]] || dietPlans.normal.medium.maintain;
                return final;
            };

            const plan = getPlan();

            // 5. Update UI
            scoreSpan.innerText = bmi;
            categorySpan.innerText = bmiCat.charAt(0).toUpperCase() + bmiCat.slice(1);
            
            // Set Category Colors
            const colors = { underweight: "bg-warning", normal: "bg-success", overweight: "bg-warning", obese: "bg-danger" };
            categorySpan.className = "badge " + colors[bmiCat] + " fs-5 mt-2 px-4 py-2 rounded-pill";
            
            // Show Save Button and set values
            document.getElementById('saveProgressContainer').style.display = 'block';
            document.getElementById('saveWeight').value = weight;
            document.getElementById('saveHeight').value = height / 100; // Store in meters
            document.getElementById('saveBMI').value = bmi;

            titleEl.innerText = plan.title;
            descEl.innerText = plan.desc;
            
            // Helper function to populate lists correctly
            const populateList = (elementId, items) => {
                const list = document.getElementById(elementId);
                if (!list) return;
                
                // Clear existing content
                list.innerHTML = "";
                
                // Add items with animation delay
                if (items && items.length > 0) {
                    items.forEach((item, index) => {
                        const li = document.createElement('li');
                        li.innerText = item;
                        li.style.opacity = '0';
                        li.style.animation = "fadeInUp 0.4s forwards " + (index * 0.1) + "s";
                        list.appendChild(li);
                    });
                } else {
                    list.innerHTML = "<li>Contact trainer for custom plan</li>";
                }
            };

            // Fill all sections
            populateList('breakfastList', plan.breakfast);
            populateList('lunchList', plan.lunch);
            populateList('dinnerList', plan.dinner);
            populateList('proTips', plan.tips);
            
            // Show result container
            container.classList.add('show');
            container.scrollIntoView({ behavior: 'smooth', block: 'start' });
        }
    </script>
</body>
</html>


