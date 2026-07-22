package com.ecommerce.controller;

import java.io.IOException;
import java.util.List;

import com.ecommerce.model.Product;
import com.ecommerce.service.SellerService;
import com.ecommerce.util.Response;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
@MultipartConfig
@WebServlet("/SellerHomeServlet")
public class SellerHomeServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private SellerService sellerService = new SellerService();

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("loggedInSellerId") == null) {
            response.sendRedirect("sellerLogin.jsp");
            return;
        }

        int sellerId = (Integer) session.getAttribute("loggedInSellerId");

        String action = request.getParameter("action");

        if (action == null || action.equals("history")) {

            Response<List<Product>> result =
                    sellerService.getSellerProductHistory(sellerId);

            request.setAttribute("products", result.getData());
            request.setAttribute("types", sellerService.getAllTypes());

            request.getRequestDispatcher("sellerHome.jsp")
                   .forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("loggedInSellerId") == null) {
            response.sendRedirect("sellerLogin.jsp");
            return;
        }

        int sellerId = (Integer) session.getAttribute("loggedInSellerId");

        String action = request.getParameter("action");

        if ("addProduct".equals(action)) {

            Product product = new Product();

            product.setName(request.getParameter("name"));
            product.setType(request.getParameter("type"));
            product.setSubType(request.getParameter("subType"));
            product.setPrice(Integer.parseInt(request.getParameter("price")));
            product.setQuantity(Integer.parseInt(request.getParameter("quantity")));
            product.setDescription(request.getParameter("description"));
            product.setLongDescription(request.getParameter("longDescription"));
            product.setImage(request.getParameter("image"));
            product.setTypeIcon(request.getParameter("typeIcon"));
            product.setSubtypeIcon(request.getParameter("subtypeIcon"));

            sellerService.addProduct(product, sellerId);

            response.sendRedirect("SellerHomeServlet?action=history");
        }
    }
}