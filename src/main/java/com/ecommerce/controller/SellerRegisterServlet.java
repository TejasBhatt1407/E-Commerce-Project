package com.ecommerce.controller;

import java.io.IOException;

import com.ecommerce.model.Seller;
import com.ecommerce.service.SellerService;
import com.ecommerce.util.Response;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/SellerRegisterServlet")
public class SellerRegisterServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private SellerService sellerService = new SellerService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String mobile = request.getParameter("mobile");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String companyName = request.getParameter("companyName");
        String bankName = request.getParameter("bankName");
        String address = request.getParameter("address");
        String GSTnum = request.getParameter("GSTnum");

        


        Response<Void> result = new Response<>();

        // Password null
        if (password == null || confirmPassword == null) {

            result.setSuccess(false);
            result.setCode("FAILED");
            result.setMessage("Password cannot be empty.");

            request.getSession().setAttribute("response", result);
            response.sendRedirect("sellerRegister.jsp");
            return;
        }

        // Password mismatch
        if (!password.equals(confirmPassword)) {

            result.setSuccess(false);
            result.setCode("PASSWORD_MISMATCH");
            result.setMessage("Passwords do not match.");

            request.getSession().setAttribute("response", result);
            response.sendRedirect("sellerRegister.jsp");
            return;
        }

        Seller seller = new Seller();

        seller.setName(name);
        seller.setEmail(email);
        seller.setMobile(mobile);
        seller.setPassword(password);
        seller.setCompanyName(companyName);
        seller.setGSTNum(GSTnum);
        seller.setBankName(bankName);
        seller.setAddress(address);

        result = sellerService.registerSeller(seller);

        request.getSession().setAttribute("response", result);

        response.sendRedirect("sellerRegister.jsp");
    }
}