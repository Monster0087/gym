package com.gym.dao;

import com.gym.model.Workout;
import com.gym.util.DatabaseUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class WorkoutDAO {

    /**
     * Retrieves all workouts and checks if they are completed by the user TODAY.
     */
    public List<Workout> getAllWorkouts(int userId) {
        List<Workout> workouts = new ArrayList<>();
        // Standard MySQL CURDATE() comparison ensures daily reset.
        String sql = "SELECT w.*, " +
                     "(SELECT COUNT(*) FROM user_workouts uw " +
                     " WHERE uw.workout_id = w.id AND uw.user_id = ? AND DATE(uw.created_at) = CURDATE()) as completed_today " +
                     "FROM workouts w ORDER BY w.category, w.name";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                Workout w = new Workout();
                w.setId(rs.getInt("id"));
                w.setName(rs.getString("name"));
                w.setCategory(rs.getString("category"));
                w.setDescription(rs.getString("description"));
                w.setDifficulty(rs.getString("difficulty"));
                w.setImageUrl(rs.getString("image_url"));
                // Map the subquery result to the model
                w.setCompleted(rs.getInt("completed_today") > 0);
                workouts.add(w);
            }
        } catch (SQLException e) {
            System.err.println("Error in getAllWorkouts: " + e.getMessage());
            e.printStackTrace();
        }
        return workouts;
    }

    /**
     * Marks a workout as finished for a user. Prevents duplicate entries for the same day.
     */
    public boolean completeWorkout(int userId, int workoutId) {
        // 1. Double check if already completed today to prevent duplicate logs
        String checkSql = "SELECT COUNT(*) FROM user_workouts WHERE user_id = ? AND workout_id = ? AND DATE(created_at) = CURDATE()";
        String insertSql = "INSERT INTO user_workouts (user_id, workout_id, created_at) VALUES (?, ?, CURRENT_TIMESTAMP)";
        
        try (Connection conn = DatabaseUtil.getConnection()) {
            // Check first
            try (PreparedStatement psCheck = conn.prepareStatement(checkSql)) {
                psCheck.setInt(1, userId);
                psCheck.setInt(2, workoutId);
                ResultSet rs = psCheck.executeQuery();
                if (rs.next() && rs.getInt(1) > 0) {
                    return true; // Already completed, treat as success
                }
            }
            
            // Insert new log
            try (PreparedStatement psInsert = conn.prepareStatement(insertSql)) {
                psInsert.setInt(1, userId);
                psInsert.setInt(2, workoutId);
                return psInsert.executeUpdate() > 0;
            }
        } catch (SQLException e) {
            System.err.println("Error in completeWorkout: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Returns total workouts completed by user today for dashboard updates.
     */
    public int getCompletedWorkoutsCount(int userId) {
        String sql = "SELECT COUNT(*) FROM user_workouts WHERE user_id = ? AND DATE(created_at) = CURDATE()";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
}
