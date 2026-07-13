package com.ecommerce.controller;

import jakarta.servlet.http.*;
import java.io.IOException;
import jakarta.servlet.ServletException;
import java.util.List;
import com.ecommerce.dao.CartDAO;
import com.ecommerce.model.Cart;
import com.ecommerce.service.CartService;
import jakarta.servlet.annotation.WebServlet;

@WebServlet("/CheckoutServlet")
public class CheckoutServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private CartService cartService = new CartService();


    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if(session == null || session.getAttribute("loggedInUserId") == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        //String email = (String) session.getAttribute("userEmail");

     //   CartDAO cartDAO = new CartDAO();

        int userId = (Integer) session.getAttribute("loggedInUserId");
 
        
        List<Cart> cartItems = cartService.getCartItems(userId);

        if(cartItems == null || cartItems.isEmpty()) {
            response.sendRedirect("CartServlet");
            return;
        }

        double total = 0;
        int totalItems = 0;

        for(Cart item : cartItems) {
            total += item.getQuantity() * item.getProduct().getPrice();
            totalItems += item.getQuantity();
        }

        request.setAttribute("cartItems", cartItems);
        request.setAttribute("total", total);
        request.setAttribute("totalItems", totalItems);

        // Later you'll load saved address here
        // request.setAttribute("savedAddress", address);

        request.getRequestDispatcher("checkout.jsp")
               .forward(request, response);

    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // This passes the post request directly to your existing doGet logic
        doGet(request, response);
    }
    
}