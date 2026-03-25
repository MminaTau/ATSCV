package com.example.atscv.dao;

import com.example.atscv.model.Project;
import com.example.atscv.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class ProjectDAO {

    public boolean saveProject(Project project) {
        String sql = "INSERT INTO projects (" +
                "resume_id, project_title, technologies_used, project_link, description" +
                ") VALUES (?, ?, ?, ?, ?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, project.getResumeId());
            ps.setString(2, project.getProjectTitle());
            ps.setString(3, project.getTechnologiesUsed());
            ps.setString(4, project.getProjectLink());
            ps.setString(5, project.getDescription());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }
}