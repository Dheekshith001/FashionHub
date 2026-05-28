package com.fashionhub.filter;

import java.io.IOException;

import com.fashionhub.util.AuthUtil;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Requires a logged-in user for protected ecommerce actions.
 * Public browsing (home, ProductController, categories, etc.) is not mapped here.
 */
@WebFilter(filterName = "AuthFilter", urlPatterns = {
        "/CartController",
        "/ViewCartController",
        "/RemoveCartController",
        "/UpdateCartController",
        "/WishlistController",
        "/CheckoutController",
        "/ProfileController",
        "/OrderController",
        "/OrdersController"
})
public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute(AuthUtil.SESSION_USER) == null) {
            StringBuilder returnUrl = new StringBuilder(req.getRequestURI());
            String qs = req.getQueryString();
            if (qs != null && !qs.isEmpty()) {
                returnUrl.append('?').append(qs);
            }
            AuthUtil.redirectToAuthLogin(req, resp, returnUrl.toString());
            return;
        }

        chain.doFilter(request, response);
    }
}
