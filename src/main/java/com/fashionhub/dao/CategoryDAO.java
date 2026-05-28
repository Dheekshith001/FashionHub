package com.fashionhub.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import com.fashionhub.model.Category;
import com.fashionhub.util.DBConnection;

public class CategoryDAO {

    public ArrayList<Category> getAllCategories() {

        ArrayList<Category> categories = new ArrayList<>();

        try {
            Connection connection = DBConnection.getConnection();

            String query = "SELECT * FROM categories";

            PreparedStatement preparedStatement = connection.prepareStatement(query);

            ResultSet resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {

                Category category = new Category();

                category.setCategoryId(resultSet.getInt("category_id"));
                category.setCategoryName(resultSet.getString("category_name"));

                categories.add(category);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return categories;
    }

    /**
     * Single category by id (for catalog / filters).
     */
    public Category getCategoryById(int categoryId) {

        if (categoryId <= 0) {
            return null;
        }

        try {
            Connection connection = DBConnection.getConnection();

            String query = "SELECT * FROM categories WHERE category_id = ? LIMIT 1";

            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setInt(1, categoryId);

            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                Category category = new Category();
                category.setCategoryId(resultSet.getInt("category_id"));
                category.setCategoryName(resultSet.getString("category_name"));
                return category;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }
}