package com.fashionhub.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import com.fashionhub.model.SubCategory;
import com.fashionhub.util.DBConnection;

/**
 * JDBC access for {@code subcategories}.
 * Place file: {@code src/main/java/com/fashionhub/dao/SubCategoryDAO.java}
 */
public class SubCategoryDAO {

    public ArrayList<SubCategory> getSubCategories(int categoryId) {

        ArrayList<SubCategory> list = new ArrayList<>();

        if (categoryId <= 0) {
            return list;
        }

        try (Connection con = DBConnection.getConnection()) {

            String query = "SELECT subcategory_id, category_id, subcategory_name "
                    + "FROM subcategories WHERE category_id = ? ORDER BY subcategory_name";

            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, categoryId);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                SubCategory s = new SubCategory();
                s.setSubcategoryId(rs.getInt("subcategory_id"));
                s.setCategoryId(rs.getInt("category_id"));
                s.setSubcategoryName(rs.getString("subcategory_name"));
                list.add(s);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
}
