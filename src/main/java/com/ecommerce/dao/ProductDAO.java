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
		Product product =null;
		try {
			Connection con=DBConnection.getConnection();
			String sql="select * from products where id=?";
			PreparedStatement ps=con.prepareStatement(sql);
			ps.setInt(1, id);
			ResultSet rs=ps.executeQuery();
			if(rs.next()) {
				product =new Product();
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
		}catch(Exception e){
		    throw new RuntimeException(e);
		}
		return product;
	}

	
	
    public List<Product> getAllProducts() {   // for page

        List<Product> products = new ArrayList<>();

        String sql = "SELECT * FROM products";

        try (
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
        ) {

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

        } catch(Exception e){
            throw new RuntimeException(e);
        }

        return products;
    }
    
    public List<Category> getAllTypes() {

        List<Category> types = new ArrayList<>();

        String sql = "SELECT DISTINCT type , type_icon FROM products ORDER BY type";

        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql);
                ResultSet rs = ps.executeQuery();
        ) {

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
        catch(Exception e){
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
            """;

        try (
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
        ) {

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
        catch(Exception e){
            throw new RuntimeException(e);
        }

        return products;
    }
    
    
    
    public List<Category> getSubTypes(String type){
    	List<Category> subTypes= new ArrayList<>();
    	String sql="select distinct sub_type , subtype_icon from products where type =? order by sub_type";
    	try (
    			Connection con=DBConnection.getConnection();
    			PreparedStatement ps =con.prepareStatement(sql);
    			){
    		ps.setString(1, type);
    		ResultSet rs= ps.executeQuery();
    		while(rs.next()) {
    			Category category = new Category();

                // NEW: Set category name
                category.setName(rs.getString("sub_type"));

                // NEW: Set icon
                category.setIcon(rs.getString("subtype_icon"));

                // CHANGED: Add Category instead of String
                subTypes.add(category);    		}
    	}
//    	catch (Exception e) {
//    		e.printStackTrace();
//    	}
    	catch(Exception e){
    	    throw new RuntimeException(e);
    	}
    	return subTypes;
    }
    
}