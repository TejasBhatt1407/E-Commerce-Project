package com.ecommerce.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.ecommerce.model.Product;
import com.ecommerce.util.DBConnection;
import com.ecommerce.model.Category;

public class ProductDAO {

	public Product getProductById(int id) {
		Product product = null;
		try {
			Connection con = DBConnection.getConnection();
			String sql = "select * from products where id=? AND quantity>0";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, id);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				product = new Product();
				product.setId(rs.getInt("id"));
				product.setName(rs.getString("name"));
				product.setPrice(rs.getInt("price"));
				product.setDescription(rs.getString("description"));
				product.setLongDescription(rs.getString("long_description"));
				product.setImage(rs.getString("image"));
				product.setQuantity(rs.getInt("quantity"));
				product.setTypeIcon(rs.getString("type_icon"));
				product.setSubtypeIcon(rs.getString("subtype_icon"));

//				product.setStock(rs.getInt("stock"));
			}
			con.close();
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
		return product;
	}

	public List<Product> getAllProducts() { // for page

		List<Product> products = new ArrayList<>();

		String sql = "SELECT * FROM products WHERE quantity > 0";

		try (Connection con = DBConnection.getConnection();
				PreparedStatement ps = con.prepareStatement(sql);
				ResultSet rs = ps.executeQuery();) {

			while (rs.next()) {

				Product product = new Product();

				product.setId(rs.getInt("id"));
				product.setName(rs.getString("name"));
				product.setType(rs.getString("type"));
				product.setSubType(rs.getString("sub_type"));
				product.setPrice(rs.getInt("price"));
				product.setQuantity(rs.getInt("quantity"));
				product.setDescription(rs.getString("description"));
				product.setImage(rs.getString("image"));
				product.setTypeIcon(rs.getString("type_icon"));
				product.setSubtypeIcon(rs.getString("subtype_icon"));

				products.add(product);
			}

		} catch (Exception e) {
			throw new RuntimeException(e);
		}

		return products;
	}

	public List<Category> getAllTypes() {

		List<Category> types = new ArrayList<>();

		String sql = "SELECT type , MAX(type_icon) AS type_icon FROM products GROUP BY type ORDER BY type";

		try (Connection con = DBConnection.getConnection();
				PreparedStatement ps = con.prepareStatement(sql);
				ResultSet rs = ps.executeQuery();) {

			while (rs.next()) {

				// NEW: Create Category object
				Category category = new Category();

				// NEW: Set category name
				category.setName(rs.getString("type"));

				// NEW: Set icon
				category.setIcon(rs.getString("type_icon"));

				// CHANGED: Add Category instead of String
				types.add(category);
			}

		}
//            catch (Exception e) {
//
//            e.printStackTrace();
//
//        }
		catch (Exception e) {
			throw new RuntimeException(e);
		}

		return types;
	}

	public List<Product> getProducts(int userId, String type, String subType) { // for cart

		List<Product> products = new ArrayList<>();

		String sql = """
				SELECT p.*,
				       COALESCE(c.quantity,0) AS cart_quantity
				FROM products p
				LEFT JOIN cart c
				ON p.id = c.product_id
				AND c.user_id = ?
				WHERE p.type = ?
				AND p.sub_type = ?
				AND p.quantity>0
				""";

		try (Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql);) {

			ps.setInt(1, userId);
			ps.setString(2, type);
			ps.setString(3, subType);

			ResultSet rs = ps.executeQuery();

			while (rs.next()) {

				Product product = new Product();

				product.setId(rs.getInt("id"));
				product.setName(rs.getString("name"));
				product.setType(rs.getString("type"));
				product.setSubType(rs.getString("sub_type"));
				product.setPrice(rs.getInt("price"));
				product.setQuantity(rs.getInt("quantity"));
				product.setDescription(rs.getString("description"));
				product.setImage(rs.getString("image"));
				product.setCartQuantity(rs.getInt("cart_quantity"));

				products.add(product);
			}

		}
//        catch (Exception e) {
//            e.printStackTrace();
//        }
		catch (Exception e) {
			throw new RuntimeException(e);
		}

		return products;
	}

	public List<Category> getSubTypes(String type) {
		List<Category> subTypes = new ArrayList<>();
		String sql = "SELECT sub_type, MAX(subtype_icon) AS subtype_icon "
				+ "FROM products "
				+ "WHERE type = ? "
				+ "GROUP BY sub_type "
				+ "ORDER BY sub_type";
		try (Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql);) {
			ps.setString(1, type);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				Category category = new Category();

				// NEW: Set category name
				category.setName(rs.getString("sub_type"));

				// NEW: Set icon
				category.setIcon(rs.getString("subtype_icon"));

				// CHANGED: Add Category instead of String
				subTypes.add(category);
			}
		}
//    	catch (Exception e) {
//    		e.printStackTrace();
//    	}
		catch (Exception e) {
			throw new RuntimeException(e);
		}
		return subTypes;
	}

	public List<Product> searchProducts(int userId, String search) {

		List<Product> products = new ArrayList<>();

		String sql = """
				SELECT p.*,
				       COALESCE(c.quantity,0) AS cart_quantity
				FROM products p
				LEFT JOIN cart c
				ON p.id = c.product_id
				AND c.user_id = ?
				WHERE p.quantity>0
				AND ( LOWER(p.name) LIKE ?
				   OR LOWER(p.type) LIKE ?
				   OR LOWER(p.sub_type) LIKE ?
				   )
				ORDER BY p.name
				""";

		try (Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql);) {

			String keyword = "%" + search.toLowerCase() + "%";

			ps.setInt(1, userId);
			ps.setString(2, keyword);
			ps.setString(3, keyword);
			ps.setString(4, keyword);

			ResultSet rs = ps.executeQuery();

			while (rs.next()) {

				Product product = new Product();

				product.setId(rs.getInt("id"));
				product.setName(rs.getString("name"));
				product.setType(rs.getString("type"));
				product.setSubType(rs.getString("sub_type"));
				product.setPrice(rs.getInt("price"));
				product.setQuantity(rs.getInt("quantity"));
				product.setDescription(rs.getString("description"));
				product.setImage(rs.getString("image"));
				product.setCartQuantity(rs.getInt("cart_quantity"));

				products.add(product);
			}

		} catch (Exception e) {
			throw new RuntimeException(e);
		}

		return products;
	}
	
	// 1. Method to increase stock
	public void addProductStock(int productId, int additionalStock) {
	    // We use quantity = quantity + ? to safely add to the existing amount
	    String sql = "UPDATE products SET quantity = quantity + ? WHERE id = ?";
	    
	    try (Connection con = DBConnection.getConnection(); 
	         PreparedStatement ps = con.prepareStatement(sql)) {
	         
	        ps.setInt(1, additionalStock);
	        ps.setInt(2, productId);
	        ps.executeUpdate();
	        
	    } catch (Exception e) {
	        throw new RuntimeException(e);
	    }
	}
	
	// 2. Method to remove product (set stock to 0)
	public void removeProduct(int productId) {
	    // Sets quantity to 0 so it disappears from the user store but keeps sales history intact
	    String sql = "UPDATE products SET quantity = 0 WHERE id = ?";
	    
	    try (Connection con = DBConnection.getConnection(); 
	         PreparedStatement ps = con.prepareStatement(sql)) {
	         
	        ps.setInt(1, productId);
	        ps.executeUpdate();
	        
	    } catch (Exception e) {
	        throw new RuntimeException(e);
	    }
	}

}