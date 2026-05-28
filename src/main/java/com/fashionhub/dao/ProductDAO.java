package com.fashionhub.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.fashionhub.model.Product;
import com.fashionhub.util.DBConnection;

public class ProductDAO {

    // GET ALL PRODUCTS
    public ArrayList<Product> getAllProducts() {

        ArrayList<Product> products = new ArrayList<>();

        try (Connection con = DBConnection.getConnection()) {

            String query = "SELECT * FROM products";

            PreparedStatement ps = con.prepareStatement(query);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                products.add(mapProduct(rs));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return products;
    }

    // GET PRODUCT BY ID
    public Product getProductById(int id) {

        Product p = null;

        try (Connection con = DBConnection.getConnection()) {

            String query =
                    "SELECT * FROM products WHERE product_id = ?";

            PreparedStatement ps =
                    con.prepareStatement(query);

            ps.setInt(1, id);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                p = mapProduct(rs);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return p;
    }

    // SEARCH PRODUCTS
    public List<Product> searchProducts(String keyword) {

        List<Product> list = new ArrayList<>();

        try {

            Connection con = DBConnection.getConnection();

            String sql =
                    "SELECT * FROM products WHERE name LIKE ?";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ps.setString(1, "%" + keyword + "%");

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                list.add(mapProduct(rs));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // HOME FILTER PRODUCTS
    public List<Product> filterProducts(String category, int maxPrice) {

        List<Product> list = new ArrayList<>();

        try {

            Connection con = DBConnection.getConnection();

            String sql =
                "SELECT p.* FROM products p " +
                "JOIN categories c ON p.category_id = c.category_id " +
                "WHERE 1=1";

            // CATEGORY FILTER
            if (category != null && !category.isEmpty()) {

                sql += " AND c.category_name = ?";
            }

            // PRICE FILTER
            if (maxPrice > 0) {

                sql += " AND p.price <= ?";
            }

            PreparedStatement ps =
                    con.prepareStatement(sql);

            int index = 1;

            if (category != null && !category.isEmpty()) {

                ps.setString(index++, category);
            }

            if (maxPrice > 0) {

                ps.setInt(index++, maxPrice);
            }

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                list.add(mapProduct(rs));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // CATEGORY PAGE FILTER
    public ArrayList<Product> getFilteredProducts(
            int categoryId,
            String subcategory,
            String brand,
            double minPrice,
            double maxPrice,
            double rating) {

        ArrayList<Product> products = new ArrayList<>();

        try (Connection con = DBConnection.getConnection()) {

            StringBuilder query =
                    new StringBuilder(
                            "SELECT * FROM products WHERE 1=1");

            ArrayList<Object> params =
                    new ArrayList<>();

            if (categoryId > 0) {

                query.append(" AND category_id = ?");

                params.add(categoryId);
            }

            if (subcategory != null &&
                    !subcategory.isBlank()) {

                query.append(" AND subcategory = ?");

                params.add(subcategory);
            }

            if (brand != null &&
                    !brand.isBlank()) {

                query.append(" AND brand LIKE ?");

                params.add("%" + brand + "%");
            }

            if (minPrice >= 0) {

                query.append(" AND price >= ?");

                params.add(minPrice);
            }

            if (maxPrice >= 0) {

                query.append(" AND price <= ?");

                params.add(maxPrice);
            }

            if (rating > 0) {

                query.append(" AND rating >= ?");

                params.add(rating);
            }

            PreparedStatement ps =
                    con.prepareStatement(query.toString());

            for (int i = 0; i < params.size(); i++) {

                Object obj = params.get(i);

                if (obj instanceof Integer) {

                    ps.setInt(i + 1, (Integer) obj);

                } else if (obj instanceof Double) {

                    ps.setDouble(i + 1, (Double) obj);

                } else {

                    ps.setString(i + 1, obj.toString());
                }
            }

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                products.add(mapProduct(rs));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return products;
    }

    // DISTINCT BRANDS
    public ArrayList<String> getDistinctBrands(
            int categoryId) {

        ArrayList<String> brands =
                new ArrayList<>();

        try (Connection con =
                     DBConnection.getConnection()) {

            String query =
                    "SELECT DISTINCT brand " +
                    "FROM products " +
                    "WHERE category_id=?";

            PreparedStatement ps =
                    con.prepareStatement(query);

            ps.setInt(1, categoryId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                brands.add(rs.getString("brand"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return brands;
    }

    
 // SIMILAR PRODUCTS
    public List<Product> getSimilarProducts(String brand,
                                            int categoryId,
                                            int currentId) {

        List<Product> list = new ArrayList<>();

        try {

            Connection con = DBConnection.getConnection();

            String sql =
                "SELECT * FROM products " +
                "WHERE brand = ? " +
                "AND category_id = ? " +
                "AND product_id != ? " +
                "LIMIT 8";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ps.setString(1, brand);
            ps.setInt(2, categoryId);
            ps.setInt(3, currentId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                list.add(mapProduct(rs));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
    
    // MAP PRODUCT
    private Product mapProduct(ResultSet rs)
            throws SQLException {

        Product p = new Product();

        p.setProductId(rs.getInt("product_id"));

        p.setCategoryId(rs.getInt("category_id"));

        p.setName(rs.getString("name"));

        p.setBrand(rs.getString("brand"));

        p.setPrice(rs.getDouble("price"));

        p.setImage(rs.getString("image"));

        p.setRating(rs.getDouble("rating"));

        p.setSubcategory(rs.getString("subcategory"));

        p.setDescription(rs.getString("description"));

        p.setStock(rs.getInt("stock"));

        return p;
    }
}