package com.ecommerce.service;

import com.ecommerce.util.Response;
import com.ecommerce.util.ResponseCode;
import com.ecommerce.dao.UserDAO;
import com.ecommerce.model.User;

// creates logic
public class UserService { // acts as a mediator btw UI and Database

	private UserDAO userDAO = new UserDAO();

	public Response<User> loginUser(String email, String password) {

		User user = userDAO.loginUser(email, password);

		if (user != null) {

			return new Response<>(true, ResponseCode.LOGIN_SUCCESS, "Login Successful", user);
		}

		return new Response<>(false, ResponseCode.INVALID_CREDENTIALS, "Invalid Email or Password", null);
	}

	public Response<Void> registerUser(User user) {
		if (userDAO.emailExists(user.getEmail())) {
			return new Response<>(false, ResponseCode.EMAIL_EXISTS, "Email already exists", null);
		}
		if (userDAO.mobileExists(user.getMobile())) {
			return new Response<>(false, ResponseCode.MOBILE_EXISTS, "Mobile number already exists", null);
		}
		boolean status = userDAO.registerUser(user);

		if (status) {
			return new Response<>(true, ResponseCode.REGISTER_SUCCESS, "Registration Successful", null);
		}
		return new Response<>(false, ResponseCode.FAILED, "Registration Failed", null);
	}

}
