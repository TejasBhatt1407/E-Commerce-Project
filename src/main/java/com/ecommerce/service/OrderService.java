package com.ecommerce.service;

import java.sql.Connection;
import java.util.List;

import com.ecommerce.dao.AddressDAO;
import com.ecommerce.dao.CartDAO;
import com.ecommerce.dao.OrderDAO;
import com.ecommerce.dao.ProductDAO;
import com.ecommerce.model.Address;
import com.ecommerce.model.Cart;
import com.ecommerce.util.DBConnection;
import com.ecommerce.model.Order;
import com.ecommerce.model.Product;

public class OrderService {

	private CartDAO cartDAO = new CartDAO();
	private OrderDAO orderDAO = new OrderDAO();
	private AddressDAO addressDAO = new AddressDAO();
	private ProductDAO productDAO = new ProductDAO();

	public List<Order> getOrdersByUser(int userId) {
		return orderDAO.getOrdersByUser(userId);
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

			int orderId = orderDAO.createOrder(con, userId, totalAmount, totalItems,"RAZORPAY","PENDING");

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
				ex.printStackTrace();
			}
			e.printStackTrace();
		} finally {
			try {
				if (con != null) {
					con.setAutoCommit(true);
					con.close();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return false;
	}

	/**
	 * Handles single item purchases (Buy Now flow)
	 */
	public boolean placeDirectOrder(int userId, int productId, int quantity, Address address, boolean saveAddress) {

		Connection con = null;

		try {
			con = DBConnection.getConnection();
			con.setAutoCommit(false);

			// 1. Fetch product details
			Product product = productDAO.getProductById(productId);
			if (product == null || product.getQuantity() < quantity) {
				con.rollback();
				return false;
			}

			// 2. Calculate totals
			int totalAmount = (int) (product.getPrice() * quantity);
			int totalItems = quantity;

			// 3. Save address if requested
			if (saveAddress) {
				addressDAO.saveAddress(con, address);
			}

			// 4. Create main order record
			int orderId = orderDAO.createOrder(con, userId, totalAmount, totalItems,"RAZORPAY","PENDING");

			if (orderId != -1) {
				// 5. Insert single item into order_items
				orderDAO.saveOrderItem(con, orderId, productId, quantity, (int) product.getPrice());

				// 6. Reduce stock inventory
				orderDAO.updateSingleProductQuantity(con, productId, quantity);

				con.commit();
				return true;
			}

			con.rollback();

		} catch (Exception e) {
			try {
				if (con != null) {
					con.rollback();
				}
			} catch (Exception ex) {
				ex.printStackTrace();
			}
			e.printStackTrace();
		} finally {
			try {
				if (con != null) {
					con.setAutoCommit(true);
					con.close();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		return false;
	}
}