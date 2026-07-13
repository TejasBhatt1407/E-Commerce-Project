package com.ecommerce.model;

import java.sql.Timestamp;

public class Order {

    private int id;
    private int userId;
    private int totalAmount;
    private int totalItems;
    private Timestamp orderDate;
    private String status;

    
    public int getId() {
    	return id;
    }
    public void setId(int id) {
    	this.id=id;
    }
    public int getUserId() {
    	return userId;
    }
    public void setUserId(int userId) {
    	this.userId=userId;
    }
    public int getTotalAmount() {
    	return totalAmount;
    }
    public int getTotalItems() {
    	return totalItems;
    }
    public void setTotalItems(int totalItems) {
    	this.totalItems=totalItems;
    }
    public Timestamp getOrderDate() {
    	return orderDate;
    }
    public void setOrderDate(Timestamp orderDate) {
    	this.orderDate=orderDate;
    }
    public String getStatus() {
    	return status;
    }
    public void setStatus(String status) {
    	this.status=status;
    }
    // Generate getters and setters
}