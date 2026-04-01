package com.example.atscv.servlet;

import com.example.atscv.dao.UserDAO;
import com.example.atscv.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Basic validation
        if (isBlank(fullName) || isBlank(email) || isBlank(password)) {
            request.setAttribute("message", "All fields are required.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        if (password.length() < 8) {
            request.setAttribute("message", "Password must be at least 8 characters.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // Check for duplicate email before attempting insert
        if (userDAO.emailExists(email.trim())) {
            request.setAttribute("message", "An account with this email already exists. Please log in.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        User user = new User(fullName.trim(), email.trim(), password);
        boolean success = userDAO.registerUser(user);

        if (success) {
            response.sendRedirect("login.jsp?registered=success");
        } else {
            request.setAttribute("message", "Registration failed. Please try again.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }

    private boolean isBlank(String s) {
        return s == null || s.trim().isEmpty();
    }
}