package com.ecommerce.controller;

import java.io.IOException;
import java.security.SecureRandom;

import com.ecommerce.service.UserService;
import com.ecommerce.util.EmailUtility;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/ForgotPasswordServlet")
public class ForgotPasswordServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private UserService userService = new UserService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");

        // Check if email exists
        if (!userService.emailExists(email)) {

            request.setAttribute("message", "No account found with this email.");

            request.getRequestDispatcher("forgotPassword.jsp")
                    .forward(request, response);

            return;
        }

        // Generate secure 6-digit OTP
        SecureRandom random = new SecureRandom();

        String otp = String.valueOf(100000 + random.nextInt(900000));

        HttpSession session = request.getSession();

        session.setAttribute("resetEmail", email);
        session.setAttribute("otp", otp);
        session.setAttribute("otpExpiry",
                System.currentTimeMillis() + (5 * 60 * 1000));

        boolean sent = EmailUtility.sendOTP(email, otp);

        if (sent) {

            request.getRequestDispatcher("verifyOtp.jsp")
                    .forward(request, response);

        } else {

            request.setAttribute("message",
                    "Unable to send OTP. Please try again.");

            request.getRequestDispatcher("forgotPassword.jsp")
                    .forward(request, response);

        }

    }

}