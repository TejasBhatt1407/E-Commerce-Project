package com.ecommerce.model;

public class OrderItem {

    private int id;
    private int orderId;
    private int productId;
    private int quantity;
    private int price;

    
    public void setId(int id) {
    	this.id=id;
    }
    public int getId() {
    	return id;
    }
    public void setOrderId(int orderId) {
    	this.orderId=orderId;
    }
    public int getOrderId() {
    	return orderId;
    }
    public void setProductId(int productId) {
    	this.productId=productId;
    }
    public int getProductId() {
    	return productId;
    }
    public void setQuantity(int quantity) {
    	this.quantity=quantity;
    }
    public int getQuantity() {
    	return quantity;
    }
    public void setPrice(int price) {
    	this.price=price;
    }
    public int getPrice() {
    	return price;
    }
    
    
    
    
    
    
    
    
    // Generate getters and setters
}