package com.fashionhub.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.fashionhub.dao.ProductDAO;
import com.fashionhub.dao.WishlistDAO;
import com.fashionhub.model.Product;
import com.fashionhub.model.User;
import com.fashionhub.model.Wishlist;
import com.fashionhub.util.AuthUtil;

@WebServlet("/WishlistController")
public class WishlistController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        User user = AuthUtil.getCurrentUser(request);
        String action = request.getParameter("action");

        if ("add".equals(action)) {
            int productId = Integer.parseInt(request.getParameter("productId"));
            Wishlist w = new Wishlist();
            w.setUserId(user.getUserId());
            w.setProductId(productId);
            WishlistDAO dao = new WishlistDAO();
            dao.addToWishlist(w);
            String back = request.getParameter("redirect");
            if (back != null && AuthUtil.isSafeInternalRedirect(back, request)) {
                response.sendRedirect(back);
            } else {
                response.sendRedirect(request.getContextPath() + "/ProductController?id=" + productId);
            }
            return;
        }

        WishlistDAO dao = new WishlistDAO();
        java.util.ArrayList<Wishlist> items = dao.getWishlistItems(user.getUserId());
        ProductDAO pdao = new ProductDAO();
        java.util.ArrayList<Product> products = new java.util.ArrayList<>();
        for (Wishlist it : items) {
            Product p = pdao.getProductById(it.getProductId());
            if (p != null) {
                products.add(p);
            }
        }
        request.setAttribute("wishlistProducts", products);
        request.getRequestDispatcher("/customer/wishlist.jsp").forward(request, response);
    }
}
