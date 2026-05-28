package com.fashionhub.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.fashionhub.dao.UserDAO;
import com.fashionhub.util.AuthUtil;

@WebServlet("/ForgotPasswordController")
public class ForgotPasswordController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/customer/forgotPassword.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String email = req.getParameter("email");
        String newPassword = req.getParameter("newPassword");
        String confirmPassword = req.getParameter("confirmPassword");

        if (email == null || email.isBlank() || newPassword == null || newPassword.isBlank()
                || confirmPassword == null || confirmPassword.isBlank()) {
            req.setAttribute("error", "All fields are required.");
            req.getRequestDispatcher("/customer/forgotPassword.jsp").forward(req, resp);
            return;
        }

        if (!newPassword.equals(confirmPassword)) {
            req.setAttribute("error", "Passwords do not match.");
            req.getRequestDispatcher("/customer/forgotPassword.jsp").forward(req, resp);
            return;
        }

        UserDAO dao = new UserDAO();
        if (!dao.emailExists(email.trim())) {
            req.setAttribute("error", "No account found for that email.");
            req.getRequestDispatcher("/customer/forgotPassword.jsp").forward(req, resp);
            return;
        }

        boolean updated = dao.updatePasswordByEmail(email.trim(), newPassword);
        if (!updated) {
            req.setAttribute("error", "Could not update password. Please try again.");
            req.getRequestDispatcher("/customer/forgotPassword.jsp").forward(req, resp);
            return;
        }

        HttpSession session = req.getSession(true);
        session.setAttribute(AuthUtil.SESSION_AUTH_SUCCESS, "Password updated successfully");
        resp.sendRedirect(req.getContextPath() + "/customer/auth.jsp");
    }
}
