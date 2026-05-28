package com.fashionhub.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.fashionhub.dao.UserDAO;
import com.fashionhub.model.User;

@WebServlet("/RegisterController")
public class RegisterController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        try {

            String name = req.getParameter("name");
            String email = req.getParameter("email");
            String password = req.getParameter("password");
            String phone = req.getParameter("phone");
            String gender = req.getParameter("gender");
            String dob = req.getParameter("dob");
            String address = req.getParameter("address");
            String city = req.getParameter("city");
            String state = req.getParameter("state");
            String pincode = req.getParameter("pincode");

            User user = new User();

            user.setName(name);
            user.setEmail(email);
            user.setPassword(password);
            user.setPhone(phone);
            user.setGender(gender);
            user.setDob(dob);
            user.setAddress(address);
            user.setCity(city);
            user.setState(state);
            user.setPincode(pincode);
            user.setProfileImage("default.png");

            UserDAO dao = new UserDAO();

            boolean status = dao.registerUser(user);

            if (status) {
                req.setAttribute("success",
                        "Registration successful! Please sign in.");
            } else {
                req.setAttribute("error",
                        "Registration failed. Please try again.");
                req.setAttribute("authOpenTab", "register");
            }

            req.getRequestDispatcher("/customer/auth.jsp")
                    .forward(req, resp);

        } catch (Exception e) {

            e.printStackTrace(); // prints exact error in Eclipse console

            req.setAttribute("error",
                    "System Error : " + e.getMessage());

            req.setAttribute("authOpenTab", "register");

            req.getRequestDispatcher("/customer/auth.jsp")
                    .forward(req, resp);
        }
    }
}