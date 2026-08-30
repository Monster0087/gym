-- Clean up and ensure persistence works
USE gym_website;

-- Update existing rows just in case
UPDATE user_workouts SET created_at = CURRENT_TIMESTAMP WHERE created_at IS NULL;

-- Ensure the column is properly defined
ALTER TABLE user_workouts MODIFY COLUMN created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP;

COMMIT;
