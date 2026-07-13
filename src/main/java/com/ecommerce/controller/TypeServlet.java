package com.ecommerce.controller;

import java.io.IOException;
import java.util.List;

import com.ecommerce.service.ProductService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/TypeServlet")
public class TypeServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private ProductService productService = new ProductService();

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String type = request.getParameter("type");

        System.out.println("Type received = " + type); 
        
        List<String> subTypes =
                productService.getSubTypes(type);

        request.setAttribute("type", type);
        request.setAttribute("subTypes", subTypes);

        request.getRequestDispatcher("/subtype.jsp")
               .forward(request, response);
    }
}