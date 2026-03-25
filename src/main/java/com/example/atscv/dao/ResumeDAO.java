package com.example.atscv.dao;

import com.example.atscv.model.Resume;
import com.example.atscv.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

public class ResumeDAO {

    public int saveResume(Resume resume) {
        int generatedId = 0;

        String sql = "INSERT INTO resumes (" +
                "user_id, resume_title, first_name, last_name, phone, address, " +
                "linkedin_url, github_url, portfolio_url, professional_summary, " +
                "target_job_title, ats_score" +
                ") VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setInt(1, resume.getUserId());
            ps.setString(2, resume.getResumeTitle());
            ps.setString(3, resume.getFirstName());
            ps.setString(4, resume.getLastName());
            ps.setString(5, resume.getPhone());
            ps.setString(6, resume.getAddress());
            ps.setString(7, resume.getLinkedinUrl());
            ps.setString(8, resume.getGithubUrl());
            ps.setString(9, resume.getPortfolioUrl());
            ps.setString(10, resume.getProfessionalSummary());
            ps.setString(11, resume.getTargetJobTitle());
            ps.setDouble(12, resume.getAtsScore());

            int rows = ps.executeUpdate();

            if (rows > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        generatedId = rs.getInt(1);
                    }
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return generatedId;
    }
}