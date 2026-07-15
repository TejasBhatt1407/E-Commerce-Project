package com.ecommerce.controller;

import java.io.IOException;

import com.ecommerce.dao.CartDAO;
import com.ecommerce.service.CartService;

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

        if(session == null){
            response.sendRedirect("HomeServlet");
            return;
        }

        Integer userId = (Integer) session.getAttribute("loggedInUserId");

        if(userId == null){
            response.sendRedirect("HomeServlet");
            return;
        }
        int productId = Integer.parseInt(request.getParameter("productId"));

        CartService cartService = new CartService();

        cartService.addToCart(userId, productId);

        int cartCount = cartService.getCartCount(userId);

        response.setContentType("text/plain");
        response.getWriter().print(cartCount);
        
        
        //response.sendRedirect("CartServlet");// CartServlet soon , home servlet before
    }
}
	
