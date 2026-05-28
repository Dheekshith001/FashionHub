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

@WebServlet("/ProductController")
public class ProductController extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {

            String idParam = request.getParameter("id");

            ProductDAO dao = new ProductDAO();

            // ✅ HOME PAGE
            if (idParam == null) {

                ArrayList<Product> products = dao.getAllProducts();

                request.setAttribute("products", products);

                request.getRequestDispatcher("/customer/home.jsp")
                       .forward(request, response);

            } else {

                // ✅ PRODUCT DETAILS PAGE
                int id = Integer.parseInt(idParam);

                Product product = dao.getProductById(id);

                if (product == null) {
                    response.getWriter().println("<h2>Product not found ❌</h2>");
                    return;
                }

                System.out.println("Brand = " + product.getBrand());

                List<Product> similarProducts =
                        dao.getSimilarProducts(
                                product.getBrand(),
                                product.getCategoryId(),
                                id
                        );

                request.setAttribute("product", product);
                request.setAttribute("similarProducts", similarProducts);

                request.getRequestDispatcher("/customer/productDetails.jsp")
                       .forward(request, response);
            }

        } catch (Exception e) {

            e.printStackTrace();

            response.setContentType("text/html");

            response.getWriter().println("<h2>Error:</h2>");
            response.getWriter().println(e.getMessage());
        }
    }
}