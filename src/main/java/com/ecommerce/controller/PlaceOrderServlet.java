package com.ecommerce.controller;

import java.io.IOException;
import com.ecommerce.model.Address;
import com.ecommerce.service.OrderService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/PlaceOrderServlet")
public class PlaceOrderServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private OrderService orderService = new OrderService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("loggedInUserId") == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        int userId = (Integer) session.getAttribute("loggedInUserId");

        // Check if this is a "Buy Now" order or a normal Cart order
        String productIdParam = request.getParameter("productId");

        // Read form address data
        String fullName = request.getParameter("fullName");
        String mobile = request.getParameter("mobile");
        String addressText = request.getParameter("address");
        String city = request.getParameter("city");
        String state = request.getParameter("state");
        String pincode = request.getParameter("pincode");

        boolean saveAddress = request.getParameter("saveAddress") != null;

        // Populate Address object
        Address address = new Address();
        address.setUserId(userId);
        address.setFullName(fullName);
        address.setMobile(mobile);
        address.setAddress(addressText);
        address.setCity(city);
        address.setState(state);
        address.setPincode(pincode);

        boolean success = false;

        if (productIdParam != null && !productIdParam.isBlank()) {
            // --- BUY NOW FLOW ---
            int productId = Integer.parseInt(productIdParam);
            // Default quantity is 1 for Buy Now (or get from request if user can change quantity)
            int quantity = 1; 

            // Call OrderService method to place order for a single product
            success = orderService.placeDirectOrder(userId, productId, quantity, address, saveAddress);
        } else {
            // --- CART FLOW ---
            success = orderService.placeOrder(userId, address, saveAddress);
        }

        if (success) {
            session.setAttribute("message", "Order placed successfully!");
            response.sendRedirect("OrderHistoryServlet");
        } else {
            session.setAttribute("message", "Unable to place order.");
            response.sendRedirect("buynow.jsp");
        }
    }
}