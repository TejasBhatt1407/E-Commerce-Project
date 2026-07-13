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

		HttpSession session = request.getSession(false);

		if (session != null) {

			String sessionId = session.getId();

			try (Connection con = DBConnection.getConnection();
					PreparedStatement ps = con.prepareStatement("DELETE FROM cart WHERE session_id = ?")) {

				ps.setString(1, sessionId);
				ps.executeUpdate();

			} catch (Exception e) {
				e.printStackTrace();
			}

			session.setAttribute("loggedInUser", null);
			session.setAttribute("loggedInUserName", null);
			session.setAttribute("loggedInUserId",null);
			
			// Destroy the session
			session.invalidate();
		}

		// Redirect to login page after logout
		response.sendRedirect("index.jsp");
	}
}