package com.fashionhub.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import com.fashionhub.model.Cart;
import com.fashionhub.util.DBConnection;

public class CartDAO {

    public boolean addToCart(Cart cart) {

        boolean status = false;

        try {
            Connection connection = DBConnection.getConnection();

            String query = "INSERT INTO cart(user_id, product_id, size, quantity) VALUES(?,?,?,?)";

            PreparedStatement ps = connection.prepareStatement(query);

            ps.setInt(1, cart.getUserId());
            ps.setInt(2, cart.getProductId());
            ps.setString(3, cart.getSize());
            ps.setInt(4, cart.getQuantity());

            int rows = ps.executeUpdate();

            if (rows > 0) {
                status = true;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return status;
    }

    public ArrayList<Cart> getCartItems(int userId) {

        ArrayList<Cart> list = new ArrayList<>();

        try {
            Connection con = DBConnection.getConnection();

            String query = "SELECT * FROM cart WHERE user_id=?";

            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Cart c = new Cart();

                c.setCartId(rs.getInt("cart_id"));
                c.setUserId(rs.getInt("user_id"));
                c.setProductId(rs.getInt("product_id"));
                c.setSize(rs.getString("size"));
                c.setQuantity(rs.getInt("quantity"));

                list.add(c);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public boolean removeCartItem(int cartId, int userId) {

        try {
            Connection con = DBConnection.getConnection();

            String query = "DELETE FROM cart WHERE cart_id=? AND user_id=?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, cartId);
            ps.setInt(2, userId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    public boolean updateQuantity(int cartId, int userId, int quantity) {

        if (quantity < 1) {
            return false;
        }

        try {
            Connection con = DBConnection.getConnection();

            String query = "UPDATE cart SET quantity=? WHERE cart_id=? AND user_id=?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, quantity);
            ps.setInt(2, cartId);
            ps.setInt(3, userId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    public boolean clearCartForUser(int userId) {
        if (userId <= 0) {
            return false;
        }
        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement("DELETE FROM cart WHERE user_id=?");
            ps.setInt(1, userId);
            ps.executeUpdate();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
