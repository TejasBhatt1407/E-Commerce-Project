package com.ecommerce.controller;

import java.io.IOException;

import com.ecommerce.model.User;
import com.ecommerce.service.UserService;
import com.ecommerce.util.Response;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private UserService userService = new UserService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String mobile = request.getParameter("mobile");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        Response<Void> result = new Response<>();

        // Password null
        if (password == null || confirmPassword == null) {

            result.setSuccess(false);
            result.setCode("FAILED");
            result.setMessage("Password cannot be empty.");

            request.getSession().setAttribute("response", result);
            response.sendRedirect("register.jsp");
            return;
        }

        // Password mismatch
        if (!password.equals(confirmPassword)) {

            result.setSuccess(false);
            result.setCode("PASSWORD_MISMATCH");
            result.setMessage("Passwords do not match.");

            request.getSession().setAttribute("response", result);
            response.sendRedirect("register.jsp");
            return;
        }

        User user = new User();

        user.setName(name);
        user.setEmail(email);
        user.setMobile(mobile);
        user.setPassword(password);

        result = userService.registerUser(user);

        request.getSession().setAttribute("response", result);

        response.sendRedirect("register.jsp");
    }
}