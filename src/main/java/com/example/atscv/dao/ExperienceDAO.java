package com.example.atscv.dao;

import com.example.atscv.model.Experience;
import com.example.atscv.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class ExperienceDAO {

    public boolean saveExperience(Experience experience) {
        String sql = "INSERT INTO experience (" +
                "resume_id, company_name, job_title, location, start_date, end_date, " +
                "currently_working, responsibilities, achievements" +
                ") VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, experience.getResumeId());
            ps.setString(2, experience.getCompanyName());
            ps.setString(3, experience.getJobTitle());
            ps.setString(4, experience.getLocation());
            ps.setDate(5, experience.getStartDate());
            ps.setDate(6, experience.getEndDate());
            ps.setBoolean(7, experience.isCurrentlyWorking());
            ps.setString(8, experience.getResponsibilities());
            ps.setString(9, experience.getAchievements());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }
}
