package com.ecommerce.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.List;
import java.util.ArrayList;

import com.ecommerce.model.Order;
import com.ecommerce.util.DBConnection;
import com.ecommerce.model.Cart;

public class OrderDAO {

    public int createOrder(Connection con,
                           int userId,
                           int totalAmount,
                           int totalItems) throws Exception {

        String sql =
                "INSERT INTO orders(user_id,total_amount,total_items) VALUES(?,?,?)";

        PreparedStatement ps =
                con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

        ps.setInt(1, userId);
        ps.setInt(2, totalAmount);
        ps.setInt(3, totalItems);

        ps.executeUpdate();

        ResultSet rs = ps.getGeneratedKeys();

        if (rs.next()) {
            return rs.getInt(1);
        }

        return -1;
    }
    
    public List<Order> getOrdersByUser(int userId) {

        List<Order> orders = new ArrayList<>();

        String sql = """
                SELECT *
                FROM orders
                WHERE user_id = ?
                ORDER BY order_date DESC
                """;

        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql);
        ) {

            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Order order = new Order();

                order.setId(rs.getInt("id"));
                order.setUserId(rs.getInt("user_id"));
                order.setTotalAmount(rs.getInt("total_amount"));
                order.setTotalItems(rs.getInt("total_items"));
                order.setOrderDate(rs.getTimestamp("order_date"));
                order.setStatus(rs.getString("status"));

                orders.add(order);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return orders;
    }
    

    public void saveOrderItems(Connection con,
                               int orderId,
                               List<Cart> cartItems) throws Exception {

        String sql =
                "INSERT INTO order_items(order_id,product_id,quantity,price) VALUES(?,?,?,?)";

        PreparedStatement ps = con.prepareStatement(sql);

        for (Cart cart : cartItems) {

            ps.setInt(1, orderId);
            ps.setInt(2, cart.getProduct().getId());
            ps.setInt(3, cart.getQuantity());
            ps.setInt(4, cart.getProduct().getPrice());

            ps.addBatch();
        }

        ps.executeBatch();
    }

    public void updateProductQuantity(Connection con,
                                      List<Cart> cartItems) throws Exception {

        String sql =
                "UPDATE products SET quantity = quantity - ? WHERE id=?";

        PreparedStatement ps = con.prepareStatement(sql);

        for (Cart cart : cartItems) {

            ps.setInt(1, cart.getQuantity());
            ps.setInt(2, cart.getProduct().getId());

            ps.addBatch();
        }

        ps.executeBatch();
    }

}