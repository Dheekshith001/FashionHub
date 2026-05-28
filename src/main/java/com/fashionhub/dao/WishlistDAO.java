package com.fashionhub.dao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import com.fashionhub.model.Wishlist;
import com.fashionhub.util.DBConnection;

public class WishlistDAO {

    public boolean addToWishlist(Wishlist wishlist) {

        boolean status = false;

        try {
            Connection connection = DBConnection.getConnection();

            String query = "INSERT INTO wishlist(user_id, product_id) VALUES(?,?)";

            PreparedStatement preparedStatement = connection.prepareStatement(query);

            preparedStatement.setInt(1, wishlist.getUserId());
            preparedStatement.setInt(2, wishlist.getProductId());

            int rows = preparedStatement.executeUpdate();

            if (rows > 0) {
                status = true;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return status;
    }

    public ArrayList<Wishlist> getWishlistItems(int userId) {

        ArrayList<Wishlist> wishlistItems = new ArrayList<>();

        try {
            Connection connection = DBConnection.getConnection();

            String query = "SELECT * FROM wishlist WHERE user_id=?";

            PreparedStatement preparedStatement = connection.prepareStatement(query);

            preparedStatement.setInt(1, userId);

            ResultSet resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {

                Wishlist wishlist = new Wishlist();

                wishlist.setWishlistId(resultSet.getInt("wishlist_id"));
                wishlist.setUserId(resultSet.getInt("user_id"));
                wishlist.setProductId(resultSet.getInt("product_id"));

                wishlistItems.add(wishlist);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return wishlistItems;
    }
    
    
    public void removeWishlistItem(int userId, int productId) {

        String sql =
            "DELETE FROM wishlist WHERE user_id=? AND product_id=?";

        try {

            Connection con = DBConnection.getConnection();

            PreparedStatement ps =
                con.prepareStatement(sql);

            ps.setInt(1, userId);
            ps.setInt(2, productId);

            ps.executeUpdate();

        } catch (Exception e) {

            e.printStackTrace();
        }
    }
}