package com.example.atscv.dao;

import com.example.atscv.model.Skill;
import com.example.atscv.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class SkillDAO {

    public boolean saveSkill(Skill skill) {
        String sql = "INSERT INTO skills (" +
                "resume_id, skill_name, skill_category, proficiency_level" +
                ") VALUES (?, ?, ?, ?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, skill.getResumeId());
            ps.setString(2, skill.getSkillName());
            ps.setString(3, skill.getSkillCategory());
            ps.setString(4, skill.getProficiencyLevel());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }
}
