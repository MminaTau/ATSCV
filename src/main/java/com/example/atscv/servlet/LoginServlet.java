package com.example.atscv.servlet;

import com.example.atscv.dao.UserDAO;
import com.example.atscv.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        UserDAO dao = new UserDAO();
        User user = dao.loginUser(email, password);

        if (user != null) {
            // ✅ Create session
            HttpSession session = request.getSession();
            session.setAttribute("user", user);

            // ✅ Redirect to dashboard
            response.sendRedirect("dashboard.jsp");

        } else {
            // ❌ Login failed
            request.setAttribute("errorMessage", "Invalid email or password");

            request.getRequestDispatcher("login.jsp")
                    .forward(request, response);
        }
    }
}