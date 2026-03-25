package com.example.atscv.servlet;

import com.example.atscv.dao.CertificationDAO;
import com.example.atscv.dao.EducationDAO;
import com.example.atscv.dao.ExperienceDAO;
import com.example.atscv.dao.ProjectDAO;
import com.example.atscv.dao.ResumeDAO;
import com.example.atscv.dao.SkillDAO;
import com.example.atscv.model.Certification;
import com.example.atscv.model.Education;
import com.example.atscv.model.Experience;
import com.example.atscv.model.Project;
import com.example.atscv.model.Resume;
import com.example.atscv.model.Skill;
import com.example.atscv.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Date;

@WebServlet("/buildCV")
public class CVBuilderServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("cvBuilder.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");
        int userId = user.getId();

        String resumeTitle = request.getParameter("resumeTitle");
        String targetJobTitle = request.getParameter("targetJobTitle");
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String linkedinUrl = request.getParameter("linkedinUrl");
        String githubUrl = request.getParameter("githubUrl");
        String portfolioUrl = request.getParameter("portfolioUrl");
        String professionalSummary = request.getParameter("professionalSummary");

        if (isBlank(resumeTitle) || isBlank(firstName) || isBlank(lastName)) {
            request.setAttribute("errorMessage", "Resume title, first name, and last name are required.");
            request.getRequestDispatcher("cvBuilder.jsp").forward(request, response);
            return;
        }

        Resume resume = new Resume();
        resume.setUserId(userId);
        resume.setResumeTitle(resumeTitle);
        resume.setTargetJobTitle(targetJobTitle);
        resume.setFirstName(firstName);
        resume.setLastName(lastName);
        resume.setPhone(phone);
        resume.setAddress(address);
        resume.setLinkedinUrl(linkedinUrl);
        resume.setGithubUrl(githubUrl);
        resume.setPortfolioUrl(portfolioUrl);
        resume.setProfessionalSummary(professionalSummary);
        resume.setAtsScore(0.00);

        ResumeDAO resumeDAO = new ResumeDAO();
        int resumeId = resumeDAO.saveResume(resume);

        if (resumeId <= 0) {
            request.setAttribute("errorMessage", "Failed to save CV.");
            request.getRequestDispatcher("cvBuilder.jsp").forward(request, response);
            return;
        }

        boolean educationSaved = saveEducationSection(request, resumeId);
        boolean experienceSaved = saveExperienceSection(request, resumeId);
        boolean skillSaved = saveSkillSection(request, resumeId);
        boolean projectSaved = saveProjectSection(request, resumeId);
        boolean certificationSaved = saveCertificationSection(request, resumeId);

        request.setAttribute(
                "successMessage",
                "CV saved. Resume ID: " + resumeId +
                        " | Education: " + statusText(educationSaved, request, "institutionName", "qualification") +
                        " | Experience: " + statusText(experienceSaved, request, "companyName", "jobTitle") +
                        " | Skill: " + statusText(skillSaved, request, "skillName") +
                        " | Project: " + statusText(projectSaved, request, "projectTitle") +
                        " | Certification: " + statusText(certificationSaved, request, "certificateName")
        );

        request.getRequestDispatcher("cvBuilder.jsp").forward(request, response);
    }

    private boolean saveEducationSection(HttpServletRequest request, int resumeId) {
        String institutionName = request.getParameter("institutionName");
        String qualification = request.getParameter("qualification");
        String fieldOfStudy = request.getParameter("fieldOfStudy");
        String grade = request.getParameter("grade");
        Date educationStartDate = parseDate(request.getParameter("educationStartDate"));
        Date educationEndDate = parseDate(request.getParameter("educationEndDate"));
        String educationDescription = request.getParameter("educationDescription");

        if (isBlank(institutionName) && isBlank(qualification)) {
            return false;
        }

        Education education = new Education();
        education.setResumeId(resumeId);
        education.setInstitutionName(institutionName);
        education.setQualification(qualification);
        education.setFieldOfStudy(fieldOfStudy);
        education.setStartDate(educationStartDate);
        education.setEndDate(educationEndDate);
        education.setGrade(grade);
        education.setDescription(educationDescription);

        EducationDAO dao = new EducationDAO();
        return dao.saveEducation(education);
    }

    private boolean saveExperienceSection(HttpServletRequest request, int resumeId) {
        String companyName = request.getParameter("companyName");
        String jobTitle = request.getParameter("jobTitle");
        String location = request.getParameter("jobLocation");
        String responsibilities = request.getParameter("responsibilities");
        String achievements = request.getParameter("achievements");
        boolean currentlyWorking = "true".equalsIgnoreCase(request.getParameter("currentlyWorking"));
        Date experienceStartDate = parseDate(request.getParameter("experienceStartDate"));
        Date experienceEndDate = parseDate(request.getParameter("experienceEndDate"));

        if (isBlank(companyName) && isBlank(jobTitle)) {
            return false;
        }

        Experience experience = new Experience();
        experience.setResumeId(resumeId);
        experience.setCompanyName(companyName);
        experience.setJobTitle(jobTitle);
        experience.setLocation(location);
        experience.setStartDate(experienceStartDate);
        experience.setEndDate(experienceEndDate);
        experience.setCurrentlyWorking(currentlyWorking);
        experience.setResponsibilities(responsibilities);
        experience.setAchievements(achievements);

        ExperienceDAO dao = new ExperienceDAO();
        return dao.saveExperience(experience);
    }

    private boolean saveSkillSection(HttpServletRequest request, int resumeId) {
        String skillName = request.getParameter("skillName");
        String skillCategory = request.getParameter("skillCategory");
        String proficiencyLevel = request.getParameter("proficiencyLevel");

        if (isBlank(skillName)) {
            return false;
        }

        Skill skill = new Skill();
        skill.setResumeId(resumeId);
        skill.setSkillName(skillName);
        skill.setSkillCategory(skillCategory);
        skill.setProficiencyLevel(proficiencyLevel);

        SkillDAO dao = new SkillDAO();
        return dao.saveSkill(skill);
    }

    private boolean saveProjectSection(HttpServletRequest request, int resumeId) {
        String projectTitle = request.getParameter("projectTitle");
        String technologiesUsed = request.getParameter("technologiesUsed");
        String projectLink = request.getParameter("projectLink");
        String projectDescription = request.getParameter("projectDescription");

        if (isBlank(projectTitle)) {
            return false;
        }

        Project project = new Project();
        project.setResumeId(resumeId);
        project.setProjectTitle(projectTitle);
        project.setTechnologiesUsed(technologiesUsed);
        project.setProjectLink(projectLink);
        project.setDescription(projectDescription);

        ProjectDAO dao = new ProjectDAO();
        return dao.saveProject(project);
    }

    private boolean saveCertificationSection(HttpServletRequest request, int resumeId) {
        String certificateName = request.getParameter("certificateName");
        String issuingOrganization = request.getParameter("issuingOrganization");
        Date issueDate = parseDate(request.getParameter("issueDate"));
        Date expiryDate = parseDate(request.getParameter("expiryDate"));
        String credentialId = request.getParameter("credentialId");
        String credentialUrl = request.getParameter("credentialUrl");

        if (isBlank(certificateName)) {
            return false;
        }

        Certification certification = new Certification();
        certification.setResumeId(resumeId);
        certification.setCertificateName(certificateName);
        certification.setIssuingOrganization(issuingOrganization);
        certification.setIssueDate(issueDate);
        certification.setExpiryDate(expiryDate);
        certification.setCredentialId(credentialId);
        certification.setCredentialUrl(credentialUrl);

        CertificationDAO dao = new CertificationDAO();
        return dao.saveCertification(certification);
    }

    private Date parseDate(String value) {
        if (value == null || value.trim().isEmpty()) {
            return null;
        }
        try {
            return Date.valueOf(value);
        } catch (Exception e) {
            return null;
        }
    }

    private boolean isBlank(String value) {
        return value == null || value.trim().isEmpty();
    }

    private String statusText(boolean saved, HttpServletRequest request, String... fieldNames) {
        boolean anyFilled = false;
        for (String fieldName : fieldNames) {
            String value = request.getParameter(fieldName);
            if (!isBlank(value)) {
                anyFilled = true;
                break;
            }
        }

        if (!anyFilled) {
            return "Skipped";
        }

        return saved ? "Saved" : "Failed";
    }
}