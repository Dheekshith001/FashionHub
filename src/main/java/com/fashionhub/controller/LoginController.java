package com.fashionhub.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.fashionhub.dao.UserDAO;
import com.fashionhub.model.User;
import com.fashionhub.util.AuthUtil;

@WebServlet("/LoginController")
public class LoginController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.sendRedirect(req.getContextPath() + "/customer/auth.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String returnUrlParam = req.getParameter("returnUrl");

        UserDAO dao = new UserDAO();
        User user = dao.loginUser(email, password);

        if (user != null) {

            HttpSession session = req.getSession(true);
            session.setAttribute(AuthUtil.SESSION_USER, user);

            String target = AuthUtil.resolvePostLoginRedirect(req, session, returnUrlParam);
            resp.sendRedirect(target);

        } else {

            req.setAttribute("error", "Invalid Email or Password");
            req.getRequestDispatcher("/customer/auth.jsp").forward(req, resp);
        }
    }
}
