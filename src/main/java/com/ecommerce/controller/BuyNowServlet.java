package com.ecommerce.controller;

import jakarta.servlet.http.*;
import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;

import com.ecommerce.model.Product;
import com.ecommerce.service.ProductService;

@WebServlet("/BuyNowServlet")
public class BuyNowServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private ProductService productService = new ProductService();

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("loggedInUserId") == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        String productIdParam = request.getParameter("productId");

        if (productIdParam == null || productIdParam.isBlank()) {
            response.sendRedirect("HomeServlet");
            return;
        }

        int productId = Integer.parseInt(productIdParam);

        // Fetch only the selected product
        Product product = productService.getProductById(productId);

        if (product == null) {
            response.sendRedirect("HomeServlet");
            return;
        }

        // Total for Buy Now = only this product
        double total = product.getPrice();
        int totalItems = 1;

        request.setAttribute("product", product);
        request.setAttribute("total", total);
        request.setAttribute("totalItems", totalItems);

        request.getRequestDispatcher("buynow.jsp")
               .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        doGet(request, response);
    }
}