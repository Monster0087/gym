-- Ensure user_workouts has a created_at column for daily tracking
USE gym_website;

SET @dbname = 'gym_website';
SET @tablename = 'user_workouts';
SET @columnname = 'created_at';
SET @preparedStatement = (SELECT IF(
  (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS
   WHERE TABLE_SCHEMA = @dbname
     AND TABLE_NAME = @tablename
     AND COLUMN_NAME = @columnname) > 0,
  'SELECT 1',
  'ALTER TABLE user_workouts ADD COLUMN created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP'
));
PREPARE stmt FROM @preparedStatement;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

COMMIT;
