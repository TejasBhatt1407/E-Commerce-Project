package com.ecommerce.controller;

import java.io.IOException;
import java.util.List;

import com.ecommerce.model.Category;
import com.ecommerce.model.Product;
import com.ecommerce.service.ProductService;
import com.ecommerce.service.CartService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/HomeServlet")
public class HomeServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	private ProductService productService = new ProductService();

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession(false);

		if (session == null || session.getAttribute("loggedInUserId") == null) {
			response.sendRedirect("index.jsp");
		}

		int userId = (Integer) session.getAttribute("loggedInUserId");

		// Load all product types
		List<Category> types = productService.getAllTypes();
		request.setAttribute("types", types);

		// Selected values from URL
		String type = request.getParameter("type");
		String subType = request.getParameter("subType");
		String search = request.getParameter("search");
		
		boolean isSearch=search!=null && !search.trim().isEmpty();
		
		request.setAttribute("isSearch", isSearch);
		request.setAttribute("search", search);

		// If no type selected, use first type
		if ((type == null || type.trim().isEmpty()) && !types.isEmpty()) {
			type = types.get(0).getName();
		}

		// Load subtypes of selected/default type
		List<Category> subTypes = productService.getSubTypes(type);

		// If no subtype selected, use first subtype
		if ((subType == null || subType.trim().isEmpty()) && !subTypes.isEmpty()) {
			subType = subTypes.get(0).getName();
		}

		// Send selected values to JSP
		request.setAttribute("selectedType", type);
		request.setAttribute("subTypes", subTypes);
		request.setAttribute("selectedSubType", subType);

		// Load products
		if (search != null && !search.trim().isEmpty()) {

			List<Product> products = productService.searchProducts(userId, search.trim());

			for (Product product : products) {
				System.out.println(product);
			}

			request.setAttribute("products", products);

		} else if (type != null && subType != null) {

			List<Product> products = productService.getProducts(userId, type, subType);

			for (Product product : products) {
				System.out.println(product);
			}

			request.setAttribute("products", products);
		}

		CartService cartService = new CartService();

		int cartCount = cartService.getCartCount(userId);

		request.setAttribute("cartCount", cartCount);

		request.getRequestDispatcher("home.jsp").forward(request, response);
	}

}