-- Fix Missing Images with more reliable Unsplash URLs
USE gym_website;

UPDATE workouts SET image_url = 'https://images.unsplash.com/photo-1541534741688-6078c65b5a33?auto=format&fit=crop&q=80&w=1200' WHERE name = 'Bench Press';
UPDATE workouts SET image_url = 'https://images.unsplash.com/photo-1581009146145-b5ef03a19d7b?auto=format&fit=crop&q=80&w=1200' WHERE name = 'Bicep Curls';
UPDATE workouts SET image_url = 'https://images.unsplash.com/photo-1591076482161-421a3a0f200c?auto=format&fit=crop&q=80&w=1200' WHERE name = 'Leg Press';
UPDATE workouts SET image_url = 'https://images.unsplash.com/photo-1541534741688-6078c65b5a33?auto=format&fit=crop&q=80&w=1200' WHERE name = 'Overhead Press';
UPDATE workouts SET image_url = 'https://images.unsplash.com/photo-1599058917233-35f693e098fb?auto=format&fit=crop&q=80&w=1200' WHERE name = 'Jump Rope';
UPDATE workouts SET image_url = 'https://images.unsplash.com/photo-1530549387631-f535c763a9df?auto=format&fit=crop&q=80&w=1200' WHERE name = 'Swimming';
UPDATE workouts SET image_url = 'https://images.unsplash.com/photo-1599058917765-a780eda07a3e?auto=format&fit=crop&q=80&w=1200' WHERE name = 'Burpees';
UPDATE workouts SET image_url = 'https://images.unsplash.com/photo-1517838276537-92292df34155?auto=format&fit=crop&q=80&w=1200' WHERE name = 'Kettlebell Swings';

-- Ensure all other images are also high quality
UPDATE workouts SET image_url = 'https://images.unsplash.com/photo-1534438327276-14e5300c3a48?auto=format&fit=crop&q=80&w=1200' WHERE name = 'Deadlift';
UPDATE workouts SET image_url = 'https://images.unsplash.com/photo-1574680096145-d05b474e2155?auto=format&fit=crop&q=80&w=1200' WHERE name = 'Barbell Squat';
UPDATE workouts SET image_url = 'https://images.unsplash.com/photo-1590487988256-9ed24133863e?auto=format&fit=crop&q=80&w=1200' WHERE name = 'Tricep Pushdown';
UPDATE workouts SET image_url = 'https://images.unsplash.com/photo-1605296867304-46d5465a13f1?auto=format&fit=crop&q=80&w=1200' WHERE name = 'Lat Pulldowns';

COMMIT;
