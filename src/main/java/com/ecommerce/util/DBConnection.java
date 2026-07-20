package com.ecommerce.util;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
	private static final String URL="jdbc:mysql://localhost:3306/E_commerce";
	private static final String USERNAME="root";
	private static final String PASSWORD="asdf@1234";

public static Connection getConnection() {
	Connection connection =null;
	try {
		Class.forName("com.mysql.cj.jdbc.Driver"); // load MYsQL driver
		connection=DriverManager.getConnection(URL,USERNAME,PASSWORD);  //establishing connection
		System.out.println("Connection successful");
	} catch (ClassNotFoundException e) {
		System.out.println("JDBC Driver Not Found!");
		throw new RuntimeException(e);
	} catch (SQLException e){
		System.out.println("Unable to Connect to Database!");
		throw new RuntimeException(e);
	}
	
	return connection;
}


}
