package com.fashionhub.controller;

import java.io.IOException;
import java.util.ArrayList;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.fashionhub.dao.CartDAO;
import com.fashionhub.dao.ProductDAO;
import com.fashionhub.model.Cart;
import com.fashionhub.model.CartLineItem;
import com.fashionhub.model.Product;
import com.fashionhub.model.User;
import com.fashionhub.util.AuthUtil;

@WebServlet("/ViewCartController")
public class ViewCartController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        User user = AuthUtil.getCurrentUser(request);
        CartDAO cartDAO = new CartDAO();
        ProductDAO productDAO = new ProductDAO();

        ArrayList<Cart> rows = cartDAO.getCartItems(user.getUserId());
        ArrayList<CartLineItem> lines = new ArrayList<>();

        for (Cart c : rows) {
            Product p = productDAO.getProductById(c.getProductId());
            lines.add(new CartLineItem(c, p));
        }

        request.setAttribute("cartLines", lines);
        request.getRequestDispatcher("/customer/cart.jsp").forward(request, response);
    }
}
