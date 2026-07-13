package com.ecommerce.controller;

import java.io.IOException;

import com.ecommerce.service.CartService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


@WebServlet("/UpdateCartServlet") 
public class UpdateCartServlet  extends HttpServlet{
		
	private static final long serialVersionUID=1L;
	private CartService cartService=new CartService();

	@Override
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response)
	throws ServletException , IOException{
		HttpSession session=request.getSession(false);
		if (session==null || session.getAttribute("loggedInUserId")==null) {
			response.sendRedirect("index.jsp");
			return;
		}
		int userId = (Integer) session.getAttribute("loggedInUserId");

        int productId = Integer.parseInt(request.getParameter("productId"));

        String action = request.getParameter("action");

        switch (action) {

        case "increase":

            cartService.increaseQuantity(userId, productId);
            break;

        case "decrease":

            cartService.decreaseQuantity(userId, productId);
            break;

        case "remove":

            cartService.removeItem(userId, productId);
            break;

        }

//        response.sendRedirect("CartServlet");

        
        
        String source = request.getParameter("source");

        if ("home".equals(source)) {
            response.sendRedirect("HomeServlet");
        } else {
            response.sendRedirect("CartServlet");
        }
    }
	
	
	

	}





