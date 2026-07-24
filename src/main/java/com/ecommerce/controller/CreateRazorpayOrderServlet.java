package com.ecommerce.controller;

import java.io.IOException;
import java.util.List;

import org.json.JSONObject;

import com.ecommerce.model.Cart;
import com.ecommerce.service.CartService;
import com.ecommerce.util.RazorpayUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/*
 * This servlet only creates a Razorpay Order.
 *
 * Responsibilities:
 * 1. Check whether the user is logged in.
 * 2. Read the latest cart from the database.
 * 3. Calculate the amount on the server.
 * 4. Ask Razorpay to create an Order.
 * 5. Return the JSON response to checkout.jsp.
 *
 * It DOES NOT:
 * - create a local order
 * - reduce stock
 * - clear the cart
 */

@WebServlet("/CreateRazorpayOrderServlet")
public class CreateRazorpayOrderServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private CartService cartService = new CartService();

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        try {

            // -----------------------------
            // Check Login
            // -----------------------------
            HttpSession session = request.getSession(false);

            if (session == null || session.getAttribute("loggedInUserId") == null) {
                response.sendError(HttpServletResponse.SC_UNAUTHORIZED,
                        "Please login first.");
                return;
            }

            int userId = (Integer) session.getAttribute("loggedInUserId");

            // -----------------------------
            // Read Cart
            // -----------------------------
            List<Cart> cartItems = cartService.getCartItems(userId);

            if (cartItems == null || cartItems.isEmpty()) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST,
                        "Cart is empty.");
                return;
            }

            // -----------------------------
            // Calculate Total Amount
            // -----------------------------
            int totalAmount = 0;

            for (Cart cart : cartItems) {
                totalAmount += cart.getQuantity()
                        * cart.getProduct().getPrice();
            }

            /*
             * Razorpay accepts amount in paise.
             *
             * Example:
             * Rs. 100
             * becomes
             * 10000
             */
            int amountInPaise = totalAmount * 100;

            /*
             * Unique receipt for Razorpay.
             */
            String receipt =
                    "USER_" + userId + "_" + System.currentTimeMillis();

            // -----------------------------
            // Create Razorpay Order
            // -----------------------------
            JSONObject razorpayOrder =
                    RazorpayUtil.createOrder(amountInPaise, receipt);

            // -----------------------------
            // Return JSON to Browser
            // -----------------------------
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().print(razorpayOrder.toString());

        }
        catch (Exception e) {

            e.printStackTrace();

            response.sendError(
                    HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Unable to create Razorpay Order");
        }
    }
}