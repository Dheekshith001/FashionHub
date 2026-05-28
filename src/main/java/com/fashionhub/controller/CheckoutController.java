package com.fashionhub.controller;

import java.io.IOException;
import java.util.ArrayList;

import com.fashionhub.dao.CartDAO;
import com.fashionhub.dao.OrderDAO;
import com.fashionhub.dao.ProductDAO;
import com.fashionhub.dao.UserDAO;
import com.fashionhub.model.Cart;
import com.fashionhub.model.CartLineItem;
import com.fashionhub.model.Product;
import com.fashionhub.model.User;
import com.fashionhub.util.AuthUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/CheckoutController")
public class CheckoutController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        User user = AuthUtil.getCurrentUser(request);

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/customer/auth.jsp");
            return;
        }

        CartDAO cartDAO = new CartDAO();
        ProductDAO productDAO = new ProductDAO();
        UserDAO userDAO = new UserDAO();

        // FETCH FULL USER DETAILS FROM DB
        User checkoutUser = userDAO.getUserById(user.getUserId());

        ArrayList<Cart> carts = cartDAO.getCartItems(user.getUserId());

        ArrayList<CartLineItem> lines = new ArrayList<>();

        double subtotal = 0;

        if (carts != null) {

            for (Cart c : carts) {

                Product p = productDAO.getProductById(c.getProductId());

                if (p != null) {

                    lines.add(new CartLineItem(c, p));

                    subtotal += p.getPrice() * c.getQuantity();
                }
            }
        }

        request.setAttribute("checkoutUser", checkoutUser);
        request.setAttribute("checkoutItems", lines);
        request.setAttribute("subtotal", subtotal);
        request.setAttribute("totalAmount", subtotal + 10);

        request.getRequestDispatcher("/customer/checkout.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        User user = AuthUtil.getCurrentUser(request);

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/customer/auth.jsp");
            return;
        }

        CartDAO cartDAO = new CartDAO();
        ProductDAO productDAO = new ProductDAO();

        ArrayList<Cart> carts = cartDAO.getCartItems(user.getUserId());

        if (carts == null || carts.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/ViewCartController");
            return;
        }

        ArrayList<CartLineItem> lines = new ArrayList<>();

        for (Cart c : carts) {

            Product p = productDAO.getProductById(c.getProductId());

            if (p == null) {
                continue;
            }

            lines.add(new CartLineItem(c, p));
        }

        if (lines.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/ViewCartController");
            return;
        }

        OrderDAO orderDAO = new OrderDAO();

        boolean ok = orderDAO.placeOrderFromCart(user.getUserId(), lines);

        if (!ok) {

            request.setAttribute(
                    "checkoutError",
                    "We could not place your order.");

            request.getRequestDispatcher("/customer/checkout.jsp")
                    .forward(request, response);

            return;
        }

        // CLEAR CART AFTER ORDER
        cartDAO.clearCartForUser(user.getUserId());

        HttpSession session = request.getSession(true);
        session.setAttribute("cartCount", 0);

        session.setAttribute(
                AuthUtil.SESSION_ORDERS_FLASH,
                "Thank you — your order is confirmed.");

        response.sendRedirect(request.getContextPath() + "/customer/orderSuccess.jsp");
        }
}