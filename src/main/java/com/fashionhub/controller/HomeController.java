package com.fashionhub.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import com.fashionhub.dao.ProductDAO;
import com.fashionhub.model.Product;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/home")
public class HomeController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        ProductDAO productDAO = new ProductDAO();

        String keyword = request.getParameter("keyword");
        String category = request.getParameter("category");
        String priceParam = request.getParameter("price");

        int maxPrice = 0;

        // PRICE CONVERT
        if (priceParam != null && !priceParam.isEmpty()) {
            maxPrice = Integer.parseInt(priceParam);
        }

        List<Product> products;

        // SEARCH
        if (keyword != null && !keyword.trim().isEmpty()) {

            products = productDAO.searchProducts(keyword);

        }
        // FILTER
        else if ((category != null && !category.isEmpty())
                || maxPrice > 0) {

            products = productDAO.filterProducts(category, maxPrice);

        }
        // ALL PRODUCTS
        else {

            products = productDAO.getAllProducts();
        }

        if (products == null) {
            products = new ArrayList<>();
        }

        request.setAttribute("products", products);

        request.getRequestDispatcher("/customer/home.jsp")
               .forward(request, response);
    }
}