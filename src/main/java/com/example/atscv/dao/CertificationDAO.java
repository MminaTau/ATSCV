package com.example.atscv.dao;

import com.example.atscv.model.Certification;
import com.example.atscv.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class CertificationDAO {

    public boolean saveCertification(Certification certification) {
        String sql = "INSERT INTO certifications (" +
                "resume_id, certificate_name, issuing_organization, issue_date, " +
                "expiry_date, credential_id, credential_url" +
                ") VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, certification.getResumeId());
            ps.setString(2, certification.getCertificateName());
            ps.setString(3, certification.getIssuingOrganization());
            ps.setDate(4, certification.getIssueDate());
            ps.setDate(5, certification.getExpiryDate());
            ps.setString(6, certification.getCredentialId());
            ps.setString(7, certification.getCredentialUrl());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }
}