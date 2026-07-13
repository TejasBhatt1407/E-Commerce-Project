package com.ecommerce.controller;

import java.io.IOException;
import java.util.List;

import com.ecommerce.model.Product;
import com.ecommerce.service.ProductService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/HomeServlet")
public class HomeServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private ProductService productService = new ProductService();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {
    	
    	HttpSession session = request.getSession(false);

    	int userId = (Integer) session.getAttribute("loggedInUserId");

        // Always load all product types
        List<String> types = productService.getAllTypes();
        request.setAttribute("types", types);

        // Get selected type and sub type
        String type = request.getParameter("type");
        String subType = request.getParameter("subType");

        // If a type is selected, load its sub types
        if (type != null && !type.trim().isEmpty()) {

            List<String> subTypes = productService.getSubTypes(type);

            request.setAttribute("selectedType", type);
            request.setAttribute("subTypes", subTypes);
        }

        // If both type and sub type are selected, load products
        if (type != null && !type.trim().isEmpty()
                && subType != null && !subType.trim().isEmpty()) {

            List<Product> products =
                    productService.getProducts(userId,type, subType);
            
            for ( Product product: products) {
            	
            	System.out.println("Values \n" + product.toString() );
				
			}
//            System.out.println("Type      : " + type);
//            System.out.println("Sub Type  : " + subType);
//            System.out.println("Products  : " + products.size());
            

            request.setAttribute("selectedSubType", subType);
            request.setAttribute("products", products);
        }

        request.getRequestDispatcher("home.jsp")
               .forward(request, response);
    }
}