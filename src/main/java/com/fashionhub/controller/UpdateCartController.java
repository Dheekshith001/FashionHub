package com.fashionhub.controller;

import java.io.IOException;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.fashionhub.dao.CartDAO;
import com.fashionhub.model.User;
import com.fashionhub.util.AuthUtil;

@WebServlet("/UpdateCartController")
public class UpdateCartController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {

        User user = AuthUtil.getCurrentUser(request);
        int cartId = Integer.parseInt(request.getParameter("cartId"));
        int qty = Integer.parseInt(request.getParameter("qty"));

        CartDAO dao = new CartDAO();
        dao.updateQuantity(cartId, user.getUserId(), qty);

        response.sendRedirect(request.getContextPath() + "/ViewCartController");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        doPost(request, response);
    }
}
