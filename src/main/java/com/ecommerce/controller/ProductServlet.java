package com.ecommerce.controller;

import java.io.IOException;
import java.util.List;

import com.ecommerce.model.Product;
import com.ecommerce.service.ProductService;
import com.ecommerce.dao.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/ProductServlet")
public class ProductServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private ProductService productService = new ProductService();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

    	int id =Integer.parseInt(request.getParameter("id"));
    	ProductDAO dao=new ProductDAO();
    	Product product=dao.getProductById(id);
    	
    	if (product ==null) {
    		response.sendRedirect("HomeServlet");
    		return;
    	}

    	int selectedQuantity = 1;

    	String qty = request.getParameter("quantity");

    	if (qty != null) {
    	    selectedQuantity = Integer.parseInt(qty);
    	}

    	String action = request.getParameter("action");

    	if ("increase".equals(action) && selectedQuantity < product.getQuantity()) {
    	    selectedQuantity++;
    	}

    	if ("decrease".equals(action) && selectedQuantity > 1) {
    	    selectedQuantity--;
    	}

    	request.setAttribute("selectedQuantity", selectedQuantity);
    	
    	System.out.println("Action = " + request.getParameter("action"));
    	System.out.println("Quantity = " + request.getParameter("quantity"));
    	System.out.println("Product Id = " + request.getParameter("id"));
    	
    	request.setAttribute("product", product);
    	request.setAttribute("selectedQuantity", selectedQuantity);
    	request.getRequestDispatcher("product.jsp").forward(request,response);
    	
    	
    	
    	
     //   List<Product> products = productService.getAllProducts();

    //    request.setAttribute("products", products);

//        request.getRequestDispatcher("HomeServlet")//homeServlet soon
//               .forward(request, response);

    
    }
}