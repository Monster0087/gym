-- Final Database Optimization for Workout Tracking
USE gym_website;

-- Ensure user_workouts has the correct structure and is clean
DROP TABLE IF EXISTS user_workouts;
CREATE TABLE user_workouts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    workout_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (workout_id) REFERENCES workouts(id) ON DELETE CASCADE,
    -- Add unique index to prevent multiple completions per day at the DB level
    -- We can't easily use DATE(created_at) in a unique index without a generated column,
    -- but we will handle it in the DAO logic.
    INDEX idx_user_workout_date (user_id, workout_id, created_at)
);

-- Optimization: Index for faster workout retrieval
CREATE INDEX idx_workouts_category ON workouts(category);

COMMIT;
