package com.ecommerce.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;
import java.util.ArrayList;

import com.ecommerce.model.Cart;
import com.ecommerce.model.Product;
import com.ecommerce.util.DBConnection;

public class CartDAO {

	/*
	 * 			public boolean (int userId, int productId) {

    String checkQuery =
            "SELECT quantity FROM cart WHERE user_id=? AND product_id=?";

    String insertQuery =
            "INSERT INTO cart(user_id, product_id, quantity) VALUES(?,?,1)";

    String updateQuantity =
            "UPDATE cart SET quantity=quantity+1 WHERE user_id=? AND product_id=?";

    String updateTrending =
            "UPDATE products SET cart_count=cart_count+1 WHERE id=?";

    try (Connection con = DBConnection.getConnection()) {

        PreparedStatement ps = con.prepareStatement(checkQuery);

        ps.setInt(1, userId);
        ps.setInt(2, productId);

        ResultSet rs = ps.executeQuery();

        if (rs.next()) {

            ps = con.prepareStatement(updateQuantity);

            ps.setInt(1, userId);
            ps.setInt(2, productId);

            ps.executeUpdate();

        } else {

            ps = con.prepareStatement(insertQuery);

            ps.setInt(1, userId);
            ps.setInt(2, productId);

            ps.executeUpdate();

        }

        ps = con.prepareStatement(updateTrending);

        ps.setInt(1, productId);

        ps.executeUpdate();

        return true;

    } catch (Exception e) {

        e.printStackTrace();

    }

    return false;

}
	 * 
	 * */
	
	
	public List<Cart> getCartItems(int userId){
		List<Cart> cartItems=new ArrayList<>();
		String sql=
				"""
				select c.id as cart_id,
				c.quantity,
				
				p.id,		
				p.name,
				p.type,
				p.sub_type,
				p.price,
				p.quantity as stock,
				p. description
				
				from cart c
				join products p
				on c.product_id=p.id
				where c.user_id=?
				""";
		try (Connection con=DBConnection.getConnection();
				PreparedStatement ps =con.prepareStatement(sql)){
			ps.setInt(1, userId);
			ResultSet rs=ps.executeQuery();
			while (rs.next()) {
				Product product=new Product();
				
				product.setId(rs.getInt("id"));
				product.setName(rs.getString("name"));
				product.setType(rs.getString("type"));
				product.setSubType(rs.getString("sub_type"));
				product.setPrice(rs.getInt("price"));
				product.setQuantity(rs.getInt("stock"));
				product.setDescription(rs.getString("description"));
				
				Cart cart = new Cart();

	            cart.setId(rs.getInt("cart_id"));
	            cart.setUserId(userId);
	            cart.setQuantity(rs.getInt("quantity"));
	            cart.setProduct(product);

	            cartItems.add(cart);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return cartItems;
	};

	public boolean increaseQuantity(int userId, int productId) {
		 String sql = "UPDATE cart SET quantity = quantity + 1 WHERE user_id = ? AND product_id = ?";

		    try (Connection con = DBConnection.getConnection();
		         PreparedStatement ps = con.prepareStatement(sql)) {

		        ps.setInt(1, userId);
		        ps.setInt(2, productId);

		        return ps.executeUpdate() > 0;

		    } catch (Exception e) {
		        e.printStackTrace();
		    }

		    return false;
		};
	

	public boolean decreaseQuantity(int userId, int productId) {
		String check = "SELECT quantity FROM cart WHERE user_id=? AND product_id=?";
	    String update = "UPDATE cart SET quantity=quantity-1 WHERE user_id=? AND product_id=?";
	    String delete = "DELETE FROM cart WHERE user_id=? AND product_id=?";

	    try (Connection con = DBConnection.getConnection()) {

	        PreparedStatement ps = con.prepareStatement(check);

	        ps.setInt(1, userId);
	        ps.setInt(2, productId);

	        ResultSet rs = ps.executeQuery();

	        if (rs.next()) {

	            int quantity = rs.getInt("quantity");

	            if (quantity > 1) {

	                ps = con.prepareStatement(update);

	                ps.setInt(1, userId);
	                ps.setInt(2, productId);

	            } else {

	                ps = con.prepareStatement(delete);

	                ps.setInt(1, userId);
	                ps.setInt(2, productId);

	            }

	            return ps.executeUpdate() > 0;
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return false;

	};

	public boolean removeItem(int userId, int productId) {
		String sql = "DELETE FROM cart WHERE user_id=? AND product_id=?";

	    try (Connection con = DBConnection.getConnection();
	         PreparedStatement ps = con.prepareStatement(sql)) {

	        ps.setInt(1, userId);
	        ps.setInt(2, productId);

	        return ps.executeUpdate() > 0;

	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return false;
	};

	public double getCartTotal(int userId) {
		double total = 0;

	    String sql =
	        """
	        SELECT SUM(c.quantity * p.price) AS total
	        FROM cart c
	        JOIN products p
	        ON c.product_id = p.id
	        WHERE c.user_id=?
	        """;

	    try (Connection con = DBConnection.getConnection();
	         PreparedStatement ps = con.prepareStatement(sql)) {

	        ps.setInt(1, userId);

	        ResultSet rs = ps.executeQuery();

	        if (rs.next()) {

	            total = rs.getDouble("total");

	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return total;
	};
	
	public boolean clearCart(Connection con, int userId) throws Exception {

	    String sql = "DELETE FROM cart WHERE user_id=?";

	    PreparedStatement ps = con.prepareStatement(sql);

	    ps.setInt(1, userId);

	    return ps.executeUpdate() > 0;
	}
	

	public boolean clearCart(int userId) {
		String sql = "DELETE FROM cart WHERE user_id=?";

	    try (Connection con = DBConnection.getConnection();
	         PreparedStatement ps = con.prepareStatement(sql)) {

	        ps.setInt(1, userId);

	        return ps.executeUpdate() > 0;

	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return false;		
	};
	
	
	
    public boolean addToCart(int userId, int productId) {

        String check =
                "SELECT quantity FROM cart WHERE user_id=? AND product_id=?";

        String insert =
                "INSERT INTO cart(user_id, product_id) VALUES(?,?)";

        String update =
                "UPDATE cart SET quantity=quantity+1 WHERE user_id=? AND product_id=?";

        try (Connection con = DBConnection.getConnection()) {

            PreparedStatement ps = con.prepareStatement(check);
            ps.setInt(1, userId);
            ps.setInt(2, productId);
            

            ResultSet rs = ps.executeQuery();

            if(rs.next()) {

                PreparedStatement ups = con.prepareStatement(update);
                ups.setInt(1, userId);
                ups.setInt(2, productId);
   //             ps.setInt(3, quantity);

                return ups.executeUpdate() > 0;

            } else {

                PreparedStatement ips = con.prepareStatement(insert);
                ips.setInt(1, userId);
                ips.setInt(2, productId);
      //          ps.setInt(3, quantity);

                return ips.executeUpdate() > 0;
            }

        } catch(Exception e) {
            e.printStackTrace();
        }

        return false;
    }
}