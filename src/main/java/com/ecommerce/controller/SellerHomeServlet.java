package com.ecommerce.controller;

import java.io.IOException;
import java.nio.file.Paths;
import java.util.List;

import com.ecommerce.dao.ProductDAO;
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
import jakarta.servlet.http.Part;

// REQUIRED: This annotation allows request.getParameter() to work with multipart/form-data
@WebServlet("/SellerHomeServlet")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2, // 2MB
    maxFileSize = 1024 * 1024 * 10,      // 10MB
    maxRequestSize = 1024 * 1024 * 50    // 50MB
)
public class SellerHomeServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private SellerService sellerService = new SellerService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("loggedInSellerId") == null) {
            response.sendRedirect("sellerLogin.jsp");
            return;
        }

        Integer sellerId = (Integer) session.getAttribute("loggedInSellerId");
        String action = request.getParameter("action");

        // Handle default view or explicit history action
        if (action == null || "history".equals(action)) {
            Response<List<Product>> result = sellerService.getSellerProductHistory(sellerId);

            request.setAttribute("products", result.getData());
            request.setAttribute("types", sellerService.getAllTypes());
            request.setAttribute("dashboard", sellerService.getSellerDashboard(sellerId));
            request.setAttribute("sales", sellerService.getSellerProductsSales(sellerId));

            request.getRequestDispatcher("sellerHome.jsp").forward(request, response);
        } else {
            // Fallback for unexpected action parameters
            response.sendRedirect("SellerHomeServlet?action=history");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("loggedInSellerId") == null) {
            response.sendRedirect("sellerLogin.jsp");
            return;
        }

        Integer sellerId = (Integer) session.getAttribute("loggedInSellerId");
        
        // This will now successfully read "addProduct" due to @MultipartConfig
        String action = request.getParameter("action"); 
        ProductDAO productDAO= new ProductDAO();
        

        if ("addStock".equals(action)) {
            try {
                int productId = Integer.parseInt(request.getParameter("productId"));
                int qtyToAdd = Integer.parseInt(request.getParameter("quantityToAdd"));
                
                productDAO.addProductStock(productId, qtyToAdd);
                
                // Redirect back to the history page so the updated stock shows
                response.setContentType("application/json");
                response.getWriter().write("{\"status\":\"success\"}");
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("SellerHomeServlet?action=history");
            }
            return;
            
        } else if ("removeProduct".equals(action)) {
            try {
                int productId = Integer.parseInt(request.getParameter("productId"));
                
                productDAO.removeProduct(productId);
                
                // Redirect back to the history page
                response.setContentType("application/json");
                response.getWriter().write("{\"status\":\"success\"}");
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("SellerHomeServlet?action=history");
            }
            return;
            
        } else if ("addProduct".equals(action)) {
            try {
                Product product = new Product();
                
                // Standard text fields
                product.setName(request.getParameter("name"));
                product.setType(request.getParameter("type"));
                product.setSubType(request.getParameter("subType"));
                
                // Safe parsing to prevent NumberFormatException crashes
                int price = parseIntegerOrDefault(request.getParameter("price"), 0);
                int quantity = parseIntegerOrDefault(request.getParameter("quantity"), 0);
                
                product.setPrice(price);
                product.setQuantity(quantity);
                product.setDescription(request.getParameter("description"));
                product.setLongDescription(request.getParameter("longDescription"));
                product.setTypeIcon(request.getParameter("typeIcon"));
                product.setSubtypeIcon(request.getParameter("subtypeIcon"));

                // FILE UPLOAD HANDLING
                Part filePart = request.getPart("image");
                if (filePart != null && filePart.getSize() > 0) {
                    // Extract the filename safely
                    String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                    
                    // Save just the filename string to the database model
                    product.setImage(fileName); 
                } else {
                    product.setImage("default-product.png"); // Fallback if no image uploaded
                }

                sellerService.addProduct(product, sellerId);

                // Redirect to GET to prevent duplicate form submissions on refresh
                response.sendRedirect("SellerHomeServlet?action=history");

            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("errorMessage", "Failed to add product. Please check your inputs.");
                // Forward back to doGet to reload the page with the error
                doGet(request, response);
            }
        } else {
            // Catch-all for unknown actions
            response.sendRedirect("SellerHomeServlet?action=history");
        }
    }        

    /**
     * Helper method to safely parse integer inputs from forms.
     */
    private int parseIntegerOrDefault(String value, int defaultValue) {
        if (value == null || value.trim().isEmpty()) {
            return defaultValue;
        }
        try {
            return Integer.parseInt(value.trim());
        } catch (NumberFormatException e) {
            return defaultValue;
        }
    }
}