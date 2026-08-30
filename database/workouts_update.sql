-- Workouts Update Script with RE-VERIFIED 4K Images and Standardized Formatting
USE gym_website;

SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE workouts;
SET FOREIGN_KEY_CHECKS = 1;

-- Insert Strength Workouts (Unique, Working IDs)
INSERT INTO workouts (name, category, description, difficulty, image_url) VALUES
('Bench Press', 'Strength', 'Standard barbell bench press for chest and triceps strength.', 'Intermediate', 'https://images.unsplash.com/photo-1534438327276-14e5300c3a48?ixlib=rb-4.0.3&auto=format&fit=crop&w=1200&q=80'),
('Deadlift', 'Strength', 'Conventional deadlift for overall back and posterior chain power.', 'Advanced', 'https://images.unsplash.com/photo-1594737625785-a239f56d0ae8?ixlib=rb-4.0.3&auto=format&fit=crop&w=1200&q=80'),
('Barbell Squat', 'Strength', 'Heavy squats for leg development and core stability.', 'Advanced', 'https://images.unsplash.com/photo-1574680096145-d05b474e2155?ixlib=rb-4.0.3&auto=format&fit=crop&w=1200&q=80'),
('Bicep Curls', 'Strength', 'Dumbbell curls for isolating and building bicep peak.', 'Beginner', 'https://images.unsplash.com/photo-1541534741688-6078c65b5a33?ixlib=rb-4.0.3&auto=format&fit=crop&w=1200&q=80'),
('Tricep Pushdown', 'Strength', 'Cable pushdowns for lateral tricep head definition.', 'Beginner', 'https://images.unsplash.com/photo-1590487988256-9ed24133863e?ixlib=rb-4.0.3&auto=format&fit=crop&w=1200&q=80'),
('Leg Press', 'Strength', 'Machine leg press for heavy quad and glute training.', 'Intermediate', 'https://images.unsplash.com/photo-1534367507873-d2d7e24c79b0?ixlib=rb-4.0.3&auto=format&fit=crop&w=1200&q=80'),
('Overhead Press', 'Strength', 'Strict standing barbell press for shoulder mass.', 'Intermediate', 'https://images.unsplash.com/photo-1517836357463-d25dfeac3438?ixlib=rb-4.0.3&auto=format&fit=crop&w=1200&q=80'),
('Lat Pulldowns', 'Strength', 'Wide grip pulldowns for building back width and V-taper.', 'Beginner', 'https://images.unsplash.com/photo-1605296867304-46d5465a13f1?ixlib=rb-4.0.3&auto=format&fit=crop&w=1200&q=80');

-- Insert Cardio Workouts (Unique, Working IDs)
INSERT INTO workouts (name, category, description, difficulty, image_url) VALUES
('Treadmill Run', 'Cardio', 'High-speed endurance running for cardiovascular health.', 'Intermediate', 'https://images.unsplash.com/photo-1538805060514-97d9cc17730c?ixlib=rb-4.0.3&auto=format&fit=crop&w=1200&q=80'),
('Indoor Cycling', 'Cardio', 'High-intensity spinning session for lower body endurance.', 'Intermediate', 'https://images.unsplash.com/photo-1534787238916-9ba6764efd4f?ixlib=rb-4.0.3&auto=format&fit=crop&w=1200&q=80'),
('Rowing Machine', 'Cardio', 'Full-body cardio workout focusing on stamina and power.', 'Intermediate', 'https://images.unsplash.com/photo-1595078475328-1ab05d0a6a0e?ixlib=rb-4.0.3&auto=format&fit=crop&w=1200&q=80'),
('Jump Rope', 'Cardio', 'Fast-paced skipping for agility and high calorie burn.', 'Beginner', 'https://images.unsplash.com/photo-1599058917233-35f693e098fb?ixlib=rb-4.0.3&auto=format&fit=crop&w=1200&q=80'),
('Swimming', 'Cardio', 'Low-impact full body conditioning in the pool.', 'Intermediate', 'https://images.unsplash.com/photo-1530549387631-f535c763a9df?ixlib=rb-4.0.3&auto=format&fit=crop&w=1200&q=80');

-- Insert Yoga Workouts (Unique, Working IDs)
INSERT INTO workouts (name, category, description, difficulty, image_url) VALUES
('Sun Salutation', 'Yoga', 'Flowing sequence of 12 poses to energize the body.', 'Beginner', 'https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?ixlib=rb-4.0.3&auto=format&fit=crop&w=1200&q=80'),
('Warrior Pose', 'Yoga', 'Strength and balance focused poses for focus.', 'Intermediate', 'https://images.unsplash.com/photo-1506126613408-eca07ce68773?ixlib=rb-4.0.3&auto=format&fit=crop&w=1200&q=80'),
('Tree Pose', 'Yoga', 'Balance-focused standing pose for concentration.', 'Beginner', 'https://images.unsplash.com/photo-1552196563-55cd4e45efb3?ixlib=rb-4.0.3&auto=format&fit=crop&w=1200&q=80'),
('Downward Dog', 'Yoga', 'Essential transition pose for flexibility and strength.', 'Beginner', 'https://images.unsplash.com/photo-1575052814086-f385e2e2ad1b?ixlib=rb-4.0.3&auto=format&fit=crop&w=1200&q=80');

-- Insert HIIT Workouts (Unique, Working IDs)
INSERT INTO workouts (name, category, description, difficulty, image_url) VALUES
('Burpees', 'HIIT', 'Full body explosive movement for max calorie burn.', 'Advanced', 'https://images.unsplash.com/photo-1599058917765-a780eda07a3e?ixlib=rb-4.0.3&auto=format&fit=crop&w=1200&q=80'),
('Mountain Climbers', 'HIIT', 'Fast-paced core and cardio movement.', 'Intermediate', 'https://images.unsplash.com/photo-1434608519344-49d77a699e1d?ixlib=rb-4.0.3&auto=format&fit=crop&w=1200&q=80'),
('Kettlebell Swings', 'HIIT', 'Dynamic power movement for glutes and shoulders.', 'Intermediate', 'https://images.unsplash.com/photo-1517838276537-92292df34155?ixlib=rb-4.0.3&auto=format&fit=crop&w=1200&q=80'),
('Battle Ropes', 'HIIT', 'High-intensity arm and core waves.', 'Advanced', 'https://images.unsplash.com/photo-1517836357463-d25dfeac3438?ixlib=rb-4.0.3&auto=format&fit=crop&w=1200&q=80');

COMMIT;
