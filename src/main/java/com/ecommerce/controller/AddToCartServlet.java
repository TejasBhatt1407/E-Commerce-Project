package com.ecommerce.controller;

import java.io.IOException;

import com.ecommerce.dao.CartDAO;
import com.ecommerce.model.Product;
import com.ecommerce.service.CartService;
import com.ecommerce.service.ProductService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/AddToCartServlet")
public class AddToCartServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        
        System.out.println("Session = " + session);

        if (session != null) {
            System.out.println("loggedInUserId = " + session.getAttribute("loggedInUserId"));
        }

        System.out.println("productId = " + request.getParameter("productId"));
        
        
        
        if(session == null){
            response.sendRedirect("HomeServlet");
            return;
        }
       
        Integer userId = (Integer) session.getAttribute("loggedInUserId");

        if(userId == null){
            response.sendRedirect("HomeServlet");
            return;
        }
        String pid = request.getParameter("productId");
        System.out.println("pid = " + pid);

        if (pid == null) {
            response.getWriter().print("productId missing");
            return;
        }

        int productId = Integer.parseInt(pid);
        CartService cartService = new CartService();
        ProductService productService=new ProductService();
        
        Product product = productService.getProductById(productId);

        if (product.getQuantity() <= 0) {
            // Don't add to cart
            return;
        }

        cartService.addToCart(userId, productId);

        int cartCount = cartService.getCartCount(userId);

        response.setContentType("text/plain");
        response.getWriter().print(cartCount);
        
        
        //response.sendRedirect("CartServlet");// CartServlet soon , home servlet before
    }
}
	
