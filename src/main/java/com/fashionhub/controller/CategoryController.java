package com.fashionhub.controller;

import java.io.IOException;
import java.util.ArrayList;

import com.fashionhub.dao.CategoryDAO;
import com.fashionhub.dao.ProductDAO;
import com.fashionhub.dao.SubCategoryDAO;
import com.fashionhub.model.Category;
import com.fashionhub.model.Product;
import com.fashionhub.model.SubCategory;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Catalog listing with optional filters (GET).
 * Forwards to {@code /customer/products.jsp}.
 * <p>
 * Place file: {@code src/main/java/com/fashionhub/controller/CategoryController.java}
 */
@WebServlet("/CategoryController")
public class CategoryController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        ProductDAO productDAO = new ProductDAO();
        CategoryDAO categoryDAO = new CategoryDAO();
        SubCategoryDAO subCategoryDAO = new SubCategoryDAO();

        int categoryId = 0;
        String categoryParam = request.getParameter("category");
        if (categoryParam != null && !categoryParam.isBlank()) {
            try {
                categoryId = Integer.parseInt(categoryParam.trim());
            } catch (NumberFormatException ignored) {
                categoryId = 0;
            }
        }

        String subcategory = request.getParameter("subcategory");
        if (subcategory != null) {
            subcategory = subcategory.trim();
            if (subcategory.isEmpty()) {
                subcategory = null;
            }
        }

        String brand = request.getParameter("brand");
        if (brand != null) {
            brand = brand.trim();
            if (brand.isEmpty()) {
                brand = null;
            }
        }

        double minPrice = parseDoubleOr(request.getParameter("minPrice"), -1);
        double maxPrice = parseDoubleOr(request.getParameter("maxPrice"), -1);
        double rating = parseDoubleOr(request.getParameter("rating"), 0);

        ArrayList<Product> products = productDAO.getFilteredProducts(
                categoryId,
                subcategory,
                brand,
                minPrice,
                maxPrice,
                rating
        );

        Category selectedCategory = null;
        if (categoryId > 0) {
            selectedCategory = categoryDAO.getCategoryById(categoryId);
        }

        ArrayList<SubCategory> subcategories = subCategoryDAO.getSubCategories(categoryId);
        ArrayList<String> brands = productDAO.getDistinctBrands(categoryId);

        request.setAttribute("products", products);
        request.setAttribute("selectedCategory", selectedCategory);
        request.setAttribute("selectedSubCategory", subcategory);
        request.setAttribute("subcategories", subcategories);
        request.setAttribute("brands", brands);
        request.setAttribute("filterBrand", brand != null ? brand : "");
        request.setAttribute("filterMinPrice", minPrice >= 0 ? Double.valueOf(minPrice) : null);
        request.setAttribute("filterMaxPrice", maxPrice >= 0 ? Double.valueOf(maxPrice) : null);
        request.setAttribute("filterRating", rating > 0 ? Double.valueOf(rating) : null);

        request.getRequestDispatcher("/customer/products.jsp").forward(request, response);
    }

    private static double parseDoubleOr(String raw, double defaultValue) {
        if (raw == null || raw.isBlank()) {
            return defaultValue;
        }
        try {
            return Double.parseDouble(raw.trim());
        } catch (NumberFormatException e) {
            return defaultValue;
        }
    }
}
