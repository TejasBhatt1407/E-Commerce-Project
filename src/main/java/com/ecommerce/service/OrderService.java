package com.ecommerce.service;

import java.sql.Connection;
import java.util.List;

import com.ecommerce.dao.AddressDAO;
import com.ecommerce.dao.CartDAO;
import com.ecommerce.dao.OrderDAO;
import com.ecommerce.model.Address;
import com.ecommerce.model.Cart;
import com.ecommerce.util.DBConnection;
import com.ecommerce.model.Order;

public class OrderService {

	private CartDAO cartDAO = new CartDAO();
	private OrderDAO orderDAO = new OrderDAO();
	private AddressDAO addressDAO = new AddressDAO();
	
	
	public List<Order> getOrdersByUser(int userId) {

		OrderDAO dao = new OrderDAO();

		return dao.getOrdersByUser(userId);
	}

	public boolean placeOrder(int userId, Address address, boolean saveAddress) {

		Connection con = null;

		try {

			con = DBConnection.getConnection();

			con.setAutoCommit(false);

			List<Cart> cartItems = cartDAO.getCartItems(userId);
			if (cartItems.isEmpty()) {
				con.rollback();
				return false;
			}

			int totalAmount = 0;
			int totalItems = 0;

			for (Cart cart : cartItems) {
				totalAmount += cart.getQuantity() * cart.getProduct().getPrice();
				totalItems += cart.getQuantity();
			}

			if (saveAddress) {
				addressDAO.saveAddress(con, address);
			}

			int orderId = orderDAO.createOrder(con, userId, totalAmount, totalItems);

			orderDAO.saveOrderItems(con, orderId, cartItems);
			orderDAO.updateProductQuantity(con, cartItems);

			cartDAO.clearCart(con, userId);
			con.commit();
			return true;
		} catch (Exception e) {
			try {
				if (con != null)
					con.rollback();
			} catch (Exception ex) {
			}
			e.printStackTrace();
		} finally {
			try {
				if (con != null) {
					con.setAutoCommit(true);
					con.close();
				}
			} catch (Exception e) {
			}
		}
		return false;
	}

}