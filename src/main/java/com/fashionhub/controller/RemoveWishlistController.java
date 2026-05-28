package com.fashionhub.controller;

import java.io.IOException;

import com.fashionhub.dao.WishlistDAO;
import com.fashionhub.model.User;
import com.fashionhub.util.AuthUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/RemoveWishlistController")
public class RemoveWishlistController extends HttpServlet {

    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        User user = AuthUtil.getCurrentUser(request);

        int productId =
            Integer.parseInt(request.getParameter("productId"));

        WishlistDAO dao = new WishlistDAO();

        dao.removeWishlistItem(
            user.getUserId(),
            productId
        );

        response.setStatus(HttpServletResponse.SC_OK);
    }
}