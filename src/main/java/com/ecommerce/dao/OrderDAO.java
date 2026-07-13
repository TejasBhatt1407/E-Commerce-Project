package com.ecommerce.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.List;

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