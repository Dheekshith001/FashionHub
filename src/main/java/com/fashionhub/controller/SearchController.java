package com.fashionhub.controller;

import java.io.IOException;
import java.util.List;

import com.fashionhub.dao.ProductDAO;
import com.fashionhub.model.Product;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/SearchController")
public class SearchController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    ProductDAO productDAO = new ProductDAO();

    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        String keyword = request.getParameter("keyword");

        List<Product> products =
                productDAO.searchProducts(keyword);

        request.getSession().setAttribute("products", products);

        response.sendRedirect(request.getContextPath() + "/home");
    }
}