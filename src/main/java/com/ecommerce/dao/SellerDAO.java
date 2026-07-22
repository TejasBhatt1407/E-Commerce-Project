package com.ecommerce.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import com.ecommerce.model.Product;
import com.ecommerce.model.Seller;
import com.ecommerce.util.DBConnection;

public class SellerDAO {
	
	
	public Seller loginSeller(String email, String password) {
	    // Optimized: Fetch only the minimum required fields for session creation
	    String sql = "SELECT id, name, email FROM Seller WHERE email=? AND password=?";

	    try (Connection con = DBConnection.getConnection(); 
	         PreparedStatement ps = con.prepareStatement(sql)) {

	        ps.setString(1, email);
	        ps.setString(2, password);
	        ResultSet rs = ps.executeQuery();

	        if (rs.next()) {
	            Seller seller = new Seller();
	            
	            // Extract ONLY session-critical identification markers
	            seller.setId(rs.getInt("id"));
	            seller.setName(rs.getString("name"));
	            seller.setEmail(rs.getString("email"));
	            
	            // All other heavy fields (address, bankName, etc.) remain untouched/null
	            return seller;
	        }
	    } catch (Exception e) {
	        throw new RuntimeException(e);
	    }
	    return null;
	}
	
	public boolean registerSeller(Seller seller) {
		String sql="INSERT INTO Seller" + "(name,email,mobile,password,companyName,GSTnum,bankName,address)" + "VALUES (?,?,?,?,?,?,?,?)";
		
		try(Connection con=DBConnection.getConnection();
				PreparedStatement ps=con.prepareStatement(sql)){
			ps.setString(1, seller.getName());
			ps.setString(2, seller.getEmail());
			ps.setString(3, seller.getMobile());
			ps.setString(4, seller.getPassword());
			ps.setString(5, seller.getCompanyName());
			ps.setString(6, seller.getGSTNum());
			ps.setString(7, seller.getBankName());
			ps.setString(8, seller.getAddress());
			
			return ps.executeUpdate()>0;
		}catch(Exception e) {
			throw new RuntimeException(e);
		}
	}
	
	public List<String> getAllTypes() {

	    List<String> types = new ArrayList<>();

	    String sql = "SELECT DISTINCT type FROM products ORDER BY type";

	    try (Connection con = DBConnection.getConnection();
	         PreparedStatement ps = con.prepareStatement(sql);
	         ResultSet rs = ps.executeQuery()) {

	        while (rs.next()) {
	            types.add(rs.getString("type"));
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return types;
	}
	
	public List<String> getSubTypes(String type) {

	    List<String> subTypes = new ArrayList<>();

	    String sql = "SELECT DISTINCT sub_type FROM products WHERE type = ? ORDER BY sub_type";

	    try (Connection con = DBConnection.getConnection();
	         PreparedStatement ps = con.prepareStatement(sql)) {

	        ps.setString(1, type);

	        try (ResultSet rs = ps.executeQuery()) {

	            while (rs.next()) {
	                subTypes.add(rs.getString("sub_type"));
	            }
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return subTypes;
	}


    public boolean addProduct(Product product) {
        String sql = "INSERT INTO products (name, type, sub_type, price, quantity, description, long_description, image,seller_id) "
                   + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection con = DBConnection.getConnection(); 
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setString(1, product.getName());
            ps.setString(2, product.getType());
            ps.setString(3, product.getSubType());
            ps.setInt(4, product.getPrice());
            ps.setInt(5, product.getQuantity());
            ps.setString(6, product.getDescription());
            ps.setString(7, product.getLongDescription());
            ps.setString(8, product.getImage());
            ps.setInt(9, product.getSellerId());

            int rows = ps.executeUpdate();
            return rows > 0;
            
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
    
    //return history of products added by seller
    public List<Product> getProductHistory(int sellerId) {
        List<Product> productList = new ArrayList<>();
        String sql = "SELECT * FROM products WHERE seller_id = ? ORDER BY id desc";

        try (Connection con = DBConnection.getConnection(); 
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setInt(1, sellerId);
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
                product.setLongDescription(rs.getString("long_description"));
                product.setImage(rs.getString("image"));
                product.setTypeIcon(rs.getString("type_icon"));
                product.setSubtypeIcon(rs.getString("subtype_icon"));
                product.setSellerId(rs.getInt("seller_id"));

                productList.add(product);
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return productList;
    }
    
}
