package com.ecommerce.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import com.ecommerce.util.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/LogoutServlet")
public class LogoutServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Fetch session without creating a new one if it doesn't exist
        HttpSession session = request.getSession(false);

        if (session != null) {
            Integer userId = (Integer) session.getAttribute("loggedInUserId");

            // Only attempt database operation if userId is actually present
            if (userId != null) {
                try (Connection con = DBConnection.getConnection();
                     PreparedStatement ps = con.prepareStatement("DELETE FROM cart WHERE user_id = ?")) {

                    ps.setInt(1, userId);
                    ps.executeUpdate();

                } catch (Exception e) {
                    // Log error on server side instead of forwarding to JSP with a broken session
                    e.printStackTrace();
                }
            }

            // Invalidate destroys all attributes automatically; no need to set them to null manually
            session.invalidate();
        }

        // Always safely redirect back to index/login
        response.sendRedirect("index.jsp");
    }
}