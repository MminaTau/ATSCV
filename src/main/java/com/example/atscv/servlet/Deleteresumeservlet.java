package main.java.com.example.atscv.servlet;

import com.example.atscv.dao.ResumeDAO;
import com.example.atscv.model.Resume;
import com.example.atscv.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/deleteResume")
public class DeleteResumeServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");
        String idStr = request.getParameter("id");

        if (idStr == null || idStr.trim().isEmpty()) {
            response.sendRedirect("myResumes");
            return;
        }

        try {
            int resumeId = Integer.parseInt(idStr);
            ResumeDAO dao = new ResumeDAO();
            Resume resume = dao.getResumeById(resumeId);

            // Only allow deletion of own resumes
            if (resume != null && resume.getUserId() == user.getId()) {
                dao.deleteResume(resumeId);
            }
        } catch (NumberFormatException e) {
            // invalid id — just redirect
        }

        response.sendRedirect("myResumes");
    }
}
