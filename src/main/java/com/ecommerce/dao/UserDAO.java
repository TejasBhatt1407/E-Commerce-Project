package com.ecommerce.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.ecommerce.model.User;
import com.ecommerce.util.DBConnection;
import com.ecommerce.service.UserService;

public class UserDAO {

	public boolean emailExists(String email) {
		String sql = "SELECT COUNT(*) FROM users WHERE email=?";
		try (Connection con = DBConnection.getConnection(); // object created to access database
				PreparedStatement ps = con.prepareStatement(sql); // sends sql query to database engine
		) {
			ps.setString(1, email);
			ResultSet rs = ps.executeQuery();// execute prepared query ( ps ) against database and store the response in
												// memory buffer

			if (rs.next()) { // internal reading cursor,checks if next row exists
				return rs.getInt(1) > 0; // gets the data and compares it value
			}
		} catch (SQLException e) {
			e.printStackTrace();

		}
		return false;
	}

	public boolean mobileExists(String mobile) {
		String sql = "SELECT COUNT(*) FROM users WHERE mobile =?";
		try (Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql);) {
			ps.setString(1, mobile);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				return rs.getInt(1) > 0;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	public boolean registerUser(User user) {
		String sql = "INSERT INTO users(name,email,mobile,password) VALUES (?,?,?,?)";
		try (Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql);) {
			ps.setString(1, user.getName());
			ps.setString(2, user.getEmail());
			ps.setString(3, user.getMobile());
			ps.setString(4, user.getPassword());

			int rows = ps.executeUpdate(); // UpdateTheDataAndReturnNothing
			return rows > 0;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	public User loginUser(String email, String password) {

		String sql = "SELECT * FROM users WHERE email=? AND password=?";

		try (Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

			ps.setString(1, email);
			ps.setString(2, password);

			ResultSet rs = ps.executeQuery(); //ReturnTheDataAndUpdateNothing

			if (rs.next()) {

				User user = new User();

				user.setId(rs.getInt("id"));
				user.setName(rs.getString("name"));
				user.setEmail(rs.getString("email"));
				user.setMobile(rs.getString("mobile"));
				user.setPassword(rs.getString("password"));

				return user;
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return null;
	}
	
	public User getUserByEmail(String email) {

	    User user = null;

	    String query = "SELECT * FROM users WHERE email = ?";

	    try (
	        Connection con = DBConnection.getConnection();
	        PreparedStatement ps = con.prepareStatement(query);
	    ) {

	        ps.setString(1, email);

	        ResultSet rs = ps.executeQuery();

	        if (rs.next()) {

	            user = new User();
	            user.setName(rs.getString("name"));
	            user.setEmail(rs.getString("email"));
	            user.setMobile(rs.getString("mobile"));
	            

	            // Don't set password
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return user;
	}
	
	public boolean updatePassword(String email,String password)
	{
	    String sql="UPDATE users SET password=? WHERE email=?";

	    try(Connection con=DBConnection.getConnection();
	        PreparedStatement ps=con.prepareStatement(sql))
	    {
	        ps.setString(1,password);

	        ps.setString(2,email);

	        return ps.executeUpdate()>0;
	    }
	    catch(Exception e)
	    {
	        e.printStackTrace();
	    }

	    return false;
	}
	
	

}
