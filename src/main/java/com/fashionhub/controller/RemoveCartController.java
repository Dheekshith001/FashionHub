package com.fashionhub.controller;

import java.io.IOException;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.fashionhub.dao.CartDAO;
import com.fashionhub.model.User;
import com.fashionhub.util.AuthUtil;

@WebServlet("/RemoveCartController")
public class RemoveCartController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {

        User user = AuthUtil.getCurrentUser(request);
        int cartId = Integer.parseInt(request.getParameter("id"));

        CartDAO dao = new CartDAO();

        dao.removeCartItem(cartId, user.getUserId());

        int count = dao.getCartItems(user.getUserId()).size();

        request.getSession().setAttribute("cartCount", count);

        response.sendRedirect(request.getContextPath() + "/ViewCartController");
    }
}
