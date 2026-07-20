package com.ecommerce.controller;

import java.io.IOException;

import com.ecommerce.service.CartService;
import com.ecommerce.dao.CartDAO;
import com.ecommerce.model.Cart;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;


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

        
        
//        String source = request.getParameter("source");
//
//        if ("home".equals(source)) {
//            response.sendRedirect("HomeServlet");
//        } else {
//            response.sendRedirect("CartServlet");
//        }
        

        int updatedQuantity = cartService.getProductQuantity(userId, productId);

        int cartCount = cartService.getCartCount(userId);

        double subtotal = 0;

        List<Cart> cartItems = cartService.getCartItems(userId);

        double grandTotal = 0;

        for (Cart cart : cartItems) {

            grandTotal += cart.getQuantity() * cart.getProduct().getPrice();

            if (cart.getProduct().getId() == productId) {

                subtotal = cart.getQuantity() * cart.getProduct().getPrice();

            }

        }

        response.setContentType("text/plain");

        response.getWriter().print(
                updatedQuantity + "," +
                cartCount + "," +
                subtotal + "," +
                grandTotal
        );
    }
	
	
	

	}





