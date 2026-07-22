package com.ecommerce.service;

import java.util.List;

import jakarta.servlet.http.HttpSession;

import com.ecommerce.dao.SellerDAO;
import com.ecommerce.model.Product;
import com.ecommerce.model.Seller;
import com.ecommerce.util.Response;
import com.ecommerce.util.ResponseCode;

public class SellerService {

    private SellerDAO sellerDAO = new SellerDAO();

    public Response<Seller> loginSeller(String email, String password) {

        if (email == null || email.trim().isEmpty()
                || password == null || password.trim().isEmpty()) {

            return new Response<>(
                    false,
                    ResponseCode.INVALID_CREDENTIALS,
                    "Email and Password cannot be empty.",
                    null);
        }

        Seller seller = sellerDAO.loginSeller(email.trim(), password);

        if (seller == null) {
            return new Response<>(
                    false,
                    ResponseCode.INVALID_CREDENTIALS,
                    "Invalid Email or Password.",
                    null);
        }

        return new Response<>(
                true,
                ResponseCode.LOGIN_SUCCESS,
                "Login Successful.",
                seller);
    }
    
    
    public Response<Void> registerSeller(Seller seller){
    	if (seller==null) {
    		return new Response<>(
    				false,
    				ResponseCode.FAILED,
    				"Seller details missing.",
    				null);
    	}
    	boolean registered =sellerDAO.registerSeller(seller);
    	if (registered) {
    		return new Response<>(
    				true,
    				ResponseCode.SUCCESS,
    				"Seller Registered Successfully",
    				null);
    	}
    	return new Response<>(
    			false,
    			ResponseCode.FAILED,
    			"Unable to register seller",
    			null);
    }
    
    public List<String> getAllTypes() {
        return sellerDAO.getAllTypes();
    }
    public List<String> getSubTypes(String type) {
        return sellerDAO.getSubTypes(type);
    }
    

    public Response<Void> addProduct(Product product, int sellerId) {

    	product.setSellerId(sellerId);

    	boolean added = sellerDAO.addProduct(product);

    	if (!added) {
    	    return new Response<>(
    	            false,
    	            ResponseCode.FAILED,
    	            "Unable to add product.",
    	            null);
    	}

    	return new Response<>(
    	        true,
    	        ResponseCode.SUCCESS,
    	        "Product added successfully.",
    	        null);
    }

    public Response<List<Product>> getSellerProductHistory(int sellerId) {

    	List<Product> products = sellerDAO.getProductHistory(sellerId);

    	return new Response<>(
    	        true,
    	        ResponseCode.SUCCESS,
    	        "Products loaded successfully.",
    	        products);
    }
    

    /**
     * Returns the logged-in seller id.
     * Returns null if the seller is not logged in.
     */
}