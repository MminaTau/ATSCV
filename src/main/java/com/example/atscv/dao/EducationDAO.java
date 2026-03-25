package com.example.atscv.dao;

import com.example.atscv.model.Education;
import com.example.atscv.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class EducationDAO {

    public boolean saveEducation(Education education) {
        String sql = "INSERT INTO education (" +
                "resume_id, institution_name, qualification, field_of_study, " +
                "start_date, end_date, grade, description" +
                ") VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, education.getResumeId());
            ps.setString(2, education.getInstitutionName());
            ps.setString(3, education.getQualification());
            ps.setString(4, education.getFieldOfStudy());
            ps.setDate(5, education.getStartDate());
            ps.setDate(6, education.getEndDate());
            ps.setString(7, education.getGrade());
            ps.setString(8, education.getDescription());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }
}