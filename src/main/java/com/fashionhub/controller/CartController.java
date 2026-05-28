package com.fashionhub.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.fashionhub.dao.CartDAO;
import com.fashionhub.model.Cart;
import com.fashionhub.model.User;
import com.fashionhub.util.AuthUtil;

@WebServlet("/CartController")
public class CartController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int productId = Integer.parseInt(request.getParameter("id"));
        String size = request.getParameter("size");

        User user = AuthUtil.getCurrentUser(request);

        Cart cart = new Cart();
        cart.setUserId(user.getUserId());
        cart.setProductId(productId);
        cart.setSize(size);
        cart.setQuantity(1);

        CartDAO dao = new CartDAO();
        dao.addToCart(cart);
        Integer count =
        	    (Integer) request.getSession()
        	    .getAttribute("cartCount");

        	if(count == null){
        	    count = 0;
        	}

        	request.getSession()
        	       .setAttribute("cartCount", count + 1);

        // STAY ON SAME PAGE
        response.sendRedirect(request.getHeader("referer"));
    }
}