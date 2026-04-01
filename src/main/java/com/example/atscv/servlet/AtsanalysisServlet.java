package main.java.com.example.atscv.servlet;

import com.example.atscv.dao.ResumeDAO;
import com.example.atscv.dao.EducationDAO;
import com.example.atscv.dao.ExperienceDAO;
import com.example.atscv.dao.SkillDAO;
import com.example.atscv.model.Resume;
import com.example.atscv.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.*;
import java.util.stream.Collectors;

@WebServlet("/atsAnalysis")
public class AtsAnalysisServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        request.getRequestDispatcher("atsAnalysis.jsp").forward(request, response);
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

        String resumeIdStr = request.getParameter("resumeId");
        String jobDescription = request.getParameter("jobDescription");

        if (resumeIdStr == null || resumeIdStr.trim().isEmpty() ||
                jobDescription == null || jobDescription.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Please select a resume and paste a job description.");
            request.getRequestDispatcher("atsAnalysis.jsp").forward(request, response);
            return;
        }

        int resumeId;
        try {
            resumeId = Integer.parseInt(resumeIdStr);
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid resume selected.");
            request.getRequestDispatcher("atsAnalysis.jsp").forward(request, response);
            return;
        }

        ResumeDAO resumeDAO = new ResumeDAO();
        Resume resume = resumeDAO.getResumeById(resumeId);

        if (resume == null || resume.getUserId() != user.getId()) {
            request.setAttribute("errorMessage", "Resume not found.");
            request.getRequestDispatcher("atsAnalysis.jsp").forward(request, response);
            return;
        }

        // ── Build the full CV text to scan ───────────────────
        StringBuilder cvText = new StringBuilder();
        if (resume.getProfessionalSummary() != null) cvText.append(resume.getProfessionalSummary()).append(" ");
        if (resume.getTargetJobTitle() != null) cvText.append(resume.getTargetJobTitle()).append(" ");
        if (resume.getFirstName() != null) cvText.append(resume.getFirstName()).append(" ");
        if (resume.getLastName() != null) cvText.append(resume.getLastName()).append(" ");

        String cvContent = cvText.toString().toLowerCase();

        // ── Extract keywords from job description ─────────────
        Set<String> stopWords = new HashSet<>(Arrays.asList(
                "a", "an", "the", "and", "or", "but", "in", "on", "at", "to", "for",
                "of", "with", "by", "from", "is", "are", "was", "were", "be", "been",
                "being", "have", "has", "had", "do", "does", "did", "will", "would",
                "could", "should", "may", "might", "must", "can", "this", "that",
                "these", "those", "we", "you", "they", "he", "she", "it", "our",
                "your", "their", "its", "not", "no", "as", "if", "then", "than",
                "so", "up", "out", "about", "into", "through", "during", "also",
                "more", "other", "such", "including", "within", "across", "per"
        ));

        String[] words = jobDescription.toLowerCase().replaceAll("[^a-zA-Z0-9\\s+#]", " ").split("\\s+");

        // Count word frequency — keep meaningful words
        Map<String, Integer> freq = new LinkedHashMap<>();
        for (String w : words) {
            w = w.trim();
            if (w.length() >= 3 && !stopWords.contains(w)) {
                freq.put(w, freq.getOrDefault(w, 0) + 1);
            }
        }

        // Sort by frequency, take top 30
        List<String> topKeywords = freq.entrySet().stream()
                .sorted((a, b) -> b.getValue() - a.getValue())
                .limit(30)
                .map(Map.Entry::getKey)
                .collect(Collectors.toList());

        // ── Compare against CV content ────────────────────────
        List<String> matched = new ArrayList<>();
        List<String> missing = new ArrayList<>();

        for (String kw : topKeywords) {
            if (cvContent.contains(kw)) {
                matched.add(kw);
            } else {
                missing.add(kw);
            }
        }

        // ── Calculate score ───────────────────────────────────
        double score = topKeywords.isEmpty() ? 0 :
                Math.round(((double) matched.size() / topKeywords.size()) * 100.0);

        // Save score back to resume
        resumeDAO.updateAtsScore(resumeId, score);

        // ── Build result summary ──────────────────────────────
        String level = score >= 75 ? "Strong" : score >= 50 ? "Moderate" : "Weak";
        String suggestion = score >= 75
                ? "Your CV is well-aligned with this job description. Focus on quantifying achievements."
                : score >= 50
                ? "Your CV partially matches this role. Add the missing keywords to improve your score."
                : "Your CV needs significant improvement for this role. Incorporate more relevant keywords.";

        String analysisResult = String.format(
                "%s match (%d%%): %s", level, (int) score, suggestion
        );

        // ── Set attributes for JSP ─────────────────────────────
        request.setAttribute("atsScore", String.valueOf((int) score));
        request.setAttribute("analysisResult", analysisResult);
        request.setAttribute("matchedKeywords", String.join(", ", matched));
        request.setAttribute("missingKeywords", String.join(", ", missing));

        request.getRequestDispatcher("atsAnalysis.jsp").forward(request, response);
    }
}