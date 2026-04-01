package com.example.atscv.servlet;

import com.example.atscv.dao.UserDAO;
import com.example.atscv.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    // ── GET: show login page ──────────────────────────────────
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // If already logged in, send straight to dashboard
        HttpSession existing = request.getSession(false);
        if (existing != null && existing.getAttribute("user") != null) {
            response.sendRedirect("dashboard.jsp");
            return;
        }
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

    // ── POST: process login ───────────────────────────────────
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (email == null || email.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Email and password are required.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        UserDAO dao = new UserDAO();
        User user = dao.loginUser(email.trim(), password);

        if (user != null) {
            // Invalidate old session first (prevent session fixation)
            HttpSession oldSession = request.getSession(false);
            if (oldSession != null) oldSession.invalidate();

            // Create a fresh session
            HttpSession session = request.getSession(true);
            session.setAttribute("user", user);
            session.setMaxInactiveInterval(30 * 60); // 30 minutes

            response.sendRedirect("dashboard.jsp");
        } else {
            request.setAttribute("errorMessage", "Invalid email or password.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}