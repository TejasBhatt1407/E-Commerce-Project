package com.ecommerce.service;

import java.util.List;

import com.ecommerce.dao.CartDAO;
import com.ecommerce.model.Cart;

public class CartService {

    private CartDAO cartDAO = new CartDAO();

    public boolean addToCart(int userId, int productId) {

        return cartDAO.addToCart(userId, productId);
    }
    
    public double getCartTotal(int userId) {
    	       return cartDAO.getCartTotal(userId);
    }
    
    public List<Cart> getCartItems(int userId){
    	return cartDAO.getCartItems(userId);
    }
    public boolean increaseQuantity(int userId,int ProductId) {
    	return cartDAO.increaseQuantity(userId, ProductId);
    }
    public boolean decreaseQuantity(int userId,int ProductId) {
    	return cartDAO.decreaseQuantity(userId, ProductId);
    }
    public boolean removeItem(int userId,int productId) {
    	return cartDAO.removeItem(userId, productId);
    }
    public boolean clearCart(int userId) {
    	return cartDAO.clearCart(userId);
    }
    public int getCartCount(int userId) {
        return cartDAO.getCartCount(userId);
    }
    public int getProductQuantity(int userId, int productId) {
        return cartDAO.getProductQuantity(userId, productId);
    }

}