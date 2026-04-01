package com.example.atscv.servlet;

import com.example.atscv.dao.UserDAO;
import com.example.atscv.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        request.getRequestDispatcher("profile.jsp").forward(request, response);
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
        String action = request.getParameter("action");
        UserDAO userDAO = new UserDAO();

        if ("updateProfile".equals(action)) {
            String fullName = request.getParameter("fullName");
            String email = request.getParameter("email");

            if (isBlank(fullName) || isBlank(email)) {
                request.setAttribute("errorMessage", "Full name and email are required.");
                request.getRequestDispatcher("profile.jsp").forward(request, response);
                return;
            }

            boolean updated = userDAO.updateProfile(user.getId(), fullName.trim(), email.trim());

            if (updated) {
                // Refresh session user object
                user.setFullName(fullName.trim());
                user.setEmail(email.trim());
                session.setAttribute("user", user);
                request.setAttribute("successMessage", "Profile updated successfully.");
            } else {
                request.setAttribute("errorMessage", "Update failed. The email address may already be in use.");
            }

        } else if ("changePassword".equals(action)) {
            String currentPassword = request.getParameter("currentPassword");
            String newPassword = request.getParameter("newPassword");
            String confirmPassword = request.getParameter("confirmPassword");

            if (isBlank(currentPassword) || isBlank(newPassword) || isBlank(confirmPassword)) {
                request.setAttribute("errorMessage", "All password fields are required.");
                request.getRequestDispatcher("profile.jsp").forward(request, response);
                return;
            }

            if (!newPassword.equals(confirmPassword)) {
                request.setAttribute("errorMessage", "New passwords do not match.");
                request.getRequestDispatcher("profile.jsp").forward(request, response);
                return;
            }

            if (newPassword.length() < 8) {
                request.setAttribute("errorMessage", "New password must be at least 8 characters.");
                request.getRequestDispatcher("profile.jsp").forward(request, response);
                return;
            }

            boolean changed = userDAO.changePassword(user.getId(), currentPassword, newPassword);

            if (changed) {
                request.setAttribute("successMessage", "Password changed successfully.");
            } else {
                request.setAttribute("errorMessage", "Current password is incorrect.");
            }
        } else {
            request.setAttribute("errorMessage", "Invalid action.");
        }

        request.getRequestDispatcher("profile.jsp").forward(request, response);
    }

    private boolean isBlank(String s) {
        return s == null || s.trim().isEmpty();
    }
}