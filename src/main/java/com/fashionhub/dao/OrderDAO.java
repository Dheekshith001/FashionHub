package com.fashionhub.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.time.LocalDate;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.fashionhub.model.CartLineItem;
import com.fashionhub.model.Order;
import com.fashionhub.model.OrderHistoryRow;
import com.fashionhub.util.DBConnection;
import com.fashionhub.util.OrderStatusUtil;

public class OrderDAO {

    private static final DateTimeFormatter DISPLAY = DateTimeFormatter.ofPattern("dd MMM yyyy");

    public boolean placeOrder(Order order) {

        boolean status = false;

        try {
            Connection connection = DBConnection.getConnection();

            String query = "INSERT INTO orders(user_id, total_amount, status) VALUES(?,?,?)";

            PreparedStatement preparedStatement = connection.prepareStatement(query);

            preparedStatement.setInt(1, order.getUserId());
            preparedStatement.setDouble(2, order.getTotalAmount());
            preparedStatement.setString(3, order.getStatus());

            int rows = preparedStatement.executeUpdate();

            if (rows > 0) {
                status = true;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return status;
    }

    public ArrayList<Order> getOrdersByUser(int userId) {

        ArrayList<Order> orders = new ArrayList<>();

        try {
            Connection connection = DBConnection.getConnection();

            String query = "SELECT * FROM orders WHERE user_id=?";

            PreparedStatement preparedStatement = connection.prepareStatement(query);

            preparedStatement.setInt(1, userId);

            ResultSet resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {

                Order order = new Order();

                order.setOrderId(resultSet.getInt("order_id"));
                order.setUserId(resultSet.getInt("user_id"));
                order.setTotalAmount(resultSet.getDouble("total_amount"));
                order.setOrderDate(resultSet.getString("order_date"));
                order.setStatus(resultSet.getString("status"));

                orders.add(order);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return orders;
    }

    /**
     * Places an order from the current bag: header row + line items + clears cart (caller clears cart on success).
     */
    public boolean placeOrderFromCart(int userId, List<CartLineItem> lines) {
        if (userId <= 0 || lines == null || lines.isEmpty()) {
            return false;
        }

        Connection con = DBConnection.getConnection();
        boolean prevAuto = true;
        try {
            prevAuto = con.getAutoCommit();
            con.setAutoCommit(false);

            double total = 0.0;
            for (CartLineItem line : lines) {
                if (line == null || line.getCart() == null || line.getProduct() == null) {
                    continue;
                }
                total += line.getProduct().getPrice() * line.getCart().getQuantity();
            }
            if (total <= 0) {
                con.rollback();
                return false;
            }

            // Match FashionHub `orders` table: user_id, total_amount, order_date (default CURRENT_TIMESTAMP), status — no delivery_date column.
            String insertOrder = "INSERT INTO orders (user_id, total_amount, status) VALUES (?,?,?)";
            PreparedStatement psOrder = con.prepareStatement(insertOrder, Statement.RETURN_GENERATED_KEYS);
            psOrder.setInt(1, userId);
            psOrder.setDouble(2, total);
            psOrder.setString(3, "PLACED");
            psOrder.executeUpdate();

            int orderId = -1;
            try (ResultSet keys = psOrder.getGeneratedKeys()) {
                if (keys.next()) {
                    orderId = keys.getInt(1);
                }
            }
            if (orderId <= 0) {
                con.rollback();
                return false;
            }

            // FashionHub `order_items` uses column name `price` (not unit_price).
            String insertItem = "INSERT INTO order_items (order_id, product_id, quantity, price) VALUES (?,?,?,?)";
            PreparedStatement psItem = con.prepareStatement(insertItem);
            for (CartLineItem line : lines) {
                if (line == null || line.getCart() == null || line.getProduct() == null) {
                    continue;
                }
                psItem.setInt(1, orderId);
                psItem.setInt(2, line.getCart().getProductId());
                psItem.setInt(3, line.getCart().getQuantity());
                psItem.setDouble(4, line.getProduct().getPrice());
                psItem.addBatch();
            }
            psItem.executeBatch();

            con.commit();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            try {
                con.rollback();
            } catch (Exception ex) {
                ex.printStackTrace();
            }
            return false;
        } finally {
            try {
                con.setAutoCommit(prevAuto);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    public ArrayList<OrderHistoryRow> listOrderHistoryRows(int userId) {
        ArrayList<OrderHistoryRow> rows = new ArrayList<>();
        if (userId <= 0) {
            return rows;
        }
        try {
            Connection con = DBConnection.getConnection();
            String sql = "SELECT o.order_id, o.order_date, p.name AS product_name, p.image AS product_image, "
                    + "oi.quantity, oi.price AS unit_price "
                    + "FROM orders o "
                    + "INNER JOIN order_items oi ON o.order_id = oi.order_id "
                    + "INNER JOIN products p ON oi.product_id = p.product_id "
                    + "WHERE o.user_id=? "
                    + "ORDER BY o.order_date DESC, o.order_id DESC, oi.order_item_id ASC";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                OrderHistoryRow row = new OrderHistoryRow();
                row.setOrderId(rs.getInt("order_id"));

                LocalDate orderLocal = LocalDate.now();
                Timestamp ots = rs.getTimestamp("order_date");
                if (ots != null) {
                    orderLocal = ots.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
                }

                row.setOrderDate(DISPLAY.format(orderLocal));
                // No delivery_date column in DB: show promised date as order date + 7 days.
                row.setDeliveryDate(DISPLAY.format(orderLocal.plusDays(7)));
                row.setStatusLabel(OrderStatusUtil.computePhase(orderLocal, LocalDate.now()));

                row.setProductName(rs.getString("product_name"));
                row.setProductImage(rs.getString("product_image"));
                row.setQuantity(rs.getInt("quantity"));
                row.setUnitPrice(rs.getDouble("unit_price"));

                rows.add(row);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return rows;
    }
}
