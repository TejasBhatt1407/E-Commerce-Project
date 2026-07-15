package com.ecommerce.controller;

import java.io.IOException;
import java.util.List;

import com.ecommerce.model.Order;
import com.ecommerce.service.OrderService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/OrderHistoryServlet")
public class OrderHistoryServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private OrderService orderService = new OrderService();

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null ||
                session.getAttribute("loggedInUserId") == null) {

            response.sendRedirect("index.jsp");
            return;
        }

        int userId =
                (Integer) session.getAttribute("loggedInUserId");

        List<Order> orders =
                orderService.getOrdersByUser(userId);

        request.setAttribute("orders", orders);

        request.getRequestDispatcher("orderHistory.jsp")
               .forward(request, response);
    }
}