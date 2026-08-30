USE gym_website;
SELECT name, COUNT(*) as count FROM workouts GROUP BY name HAVING count > 1;
