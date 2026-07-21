package com.ecommerce.controller;

import java.io.IOException;

import com.ecommerce.util.Response;
import com.ecommerce.model.Seller;
import com.ecommerce.service.SellerService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/SellerLoginServlet")
public class SellerLoginServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	private SellerService sellerService = new SellerService();

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String email = request.getParameter("email");
		String password = request.getParameter("password");

		Response<Seller> result = sellerService.loginSeller(email, password);

		HttpSession session = request.getSession();
		
		if (result.isSuccess()) {

			

			session.setAttribute("loggedInSeller", result.getData().getEmail());
			session.setAttribute("loggedInSellerName", result.getData().getName());
			session.setAttribute("loggedInSellerId",result.getData().getId());
			session.setMaxInactiveInterval(10 * 60 * 60);

			response.sendRedirect("SellerHomeServlet"); 
		} else {

			session.setAttribute("response", result);

	        // Redirect back to login page
	        response.sendRedirect("sellerLogin.jsp");
		}

	}
}