package com.ecommerce.util;

public final class ResponseCode {
	private ResponseCode() {
	}

	public static final String SUCCESS = "SUCCESS";
	public static final String FAILED = "FAILED";
	public static final String LOGIN_SUCCESS = "LOGIN_SUCCESS";
	public static final String REGISTER_SUCCESS = "REGISTER_SUCCESS";
	public static final String INVALID_CREDENTIALS = "INVALID_CREDENTIALS";
	public static final String EMAIL_EXISTS = "EMAIL_EXISTS";
	public static final String MOBILE_EXISTS = "MOBILE_MISMATCH";
	public static final String PASSWORD_MISMATCH = "PASSWORD_MISMATCH";
	public static final String SERVER_ERROR = "SERVER_ERROR";
	public static final String DATABSE_ERROR = "DATABASE_ERROR";
}
