package com.ecommerce.service;

import java.util.List;

import com.ecommerce.dao.ProductDAO;
import com.ecommerce.model.Product;

public class ProductService {

    private ProductDAO productDAO = new ProductDAO();

    public List<Product> getProducts(int userId ,String type, String subType) {

        return productDAO.getProducts(userId,type, subType);

    }
    
    
    
    public List<String> getSubTypes(String type){
    	ProductDAO dao=new ProductDAO();
    	return dao.getSubTypes(type);
    }
    
    public List<String>getAllTypes(){
    	ProductDAO dao=new ProductDAO();
    	return dao.getAllTypes();
    }
}