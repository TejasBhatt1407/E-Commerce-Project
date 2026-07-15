package com.ecommerce.controller;

import java.io.IOException;
import java.util.List;

import com.ecommerce.model.Cart;
import com.ecommerce.dao.CartDAO;
import com.ecommerce.service.CartService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/CartServlet")
public class CartServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private CartService cartService = new CartService();

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("loggedInUserId") == null) {

            response.sendRedirect("index.jsp");
            return;
        }

        int userId = (Integer) session.getAttribute("loggedInUserId");

        List<Cart> cartItems = cartService.getCartItems(userId);

        double total = cartService.getCartTotal(userId);

        request.setAttribute("cartItems", cartItems);
        request.setAttribute("total", total);

        request.getRequestDispatcher("cart.jsp")
               .forward(request, response);

    }
    private CartDAO cartDAO = new CartDAO();
    public int getProductQuantity(int userId, int productId) {
        return cartDAO.getProductQuantity(userId, productId);
    }

}