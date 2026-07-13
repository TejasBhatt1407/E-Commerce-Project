package com.ecommerce.controller;

import java.io.IOException;

import com.ecommerce.util.Response;
import com.ecommerce.model.User;
import com.ecommerce.service.UserService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	private UserService userService = new UserService();

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String email = request.getParameter("email");
		String password = request.getParameter("password");

		Response<User> result = userService.loginUser(email, password);

		HttpSession session = request.getSession();
		
		if (result.isSuccess()) {

			

			session.setAttribute("loggedInUser", result.getData().getEmail());
			session.setAttribute("loggedInUserName", result.getData().getName());
			session.setAttribute("loggedInUserId",result.getData().getId());
			session.setMaxInactiveInterval(10 * 60 * 60);

			response.sendRedirect("HomeServlet"); // to homeServlet for a better home page
		} else {

			session.setAttribute("response", result);

	        // Redirect back to login page
	        response.sendRedirect("index.jsp");
		}

	}
}