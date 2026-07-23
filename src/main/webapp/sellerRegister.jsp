<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.ecommerce.util.Response"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Seller Register</title>

<style>
	/* --- Base Reset & Typography --- */
	* {
		margin: 0;
		padding: 0;
		box-sizing: border-box;
		font-family: 'Inter', -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
	}

	body {
		background-color: #f3f4f6;
		display: flex;
		justify-content: center;
		align-items: center;
		min-height: 100vh;
		color: #111827;
		padding: 40px 20px; /* Added padding for scrolling on smaller screens */
	}

	/* --- Main Card Container --- */
	.register-container {
		background-color: #ffffff;
		width: 100%;
		max-width: 650px; /* Made wider to accommodate 2 columns */
		padding: 40px 32px;
		border-radius: 12px;
		box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
	}

	h2 {
		font-size: 26px;
		font-weight: 700;
		text-align: center;
		margin-bottom: 24px;
		color: #111827;
	}

	/* --- Alert & Error Messages --- */
	.alert-msg {
		padding: 12px;
		margin-bottom: 24px;
		border: 1px solid;
		border-radius: 8px;
		font-size: 14px;
		text-align: center;
		font-weight: 500;
	}

	/* --- Form Grid Layout --- */
	form {
		display: grid;
		grid-template-columns: 1fr 1fr;
		gap: 20px;
	}

	/* Class to make an element span both columns */
	.full-width {
		grid-column: 1 / -1;
	}

	.form-group {
		display: flex;
		flex-direction: column;
		gap: 6px;
	}

	label {
		font-size: 14px;
		font-weight: 500;
		color: #374151;
	}

	input[type="text"],
	input[type="email"],
	input[type="password"] {
		width: 100%;
		padding: 12px 16px;
		border: 1px solid #d1d5db;
		border-radius: 8px;
		font-size: 15px;
		transition: all 0.2s ease;
		outline: none;
		background-color: #f9fafb;
	}

	/* Professional focus state */
	input:focus {
		border-color: #2563eb;
		background-color: #ffffff;
		box-shadow: 0 0 0 4px rgba(37, 99, 235, 0.1);
	}

	input::placeholder {
		color: #9ca3af;
	}

	/* --- Submit Button --- */
	button[type="submit"] {
		width: 100%;
		background-color: #2563eb;
		color: #ffffff;
		border: none;
		border-radius: 8px;
		padding: 12px;
		font-size: 15px;
		font-weight: 600;
		cursor: pointer;
		transition: background-color 0.2s ease, transform 0.1s ease;
		margin-top: 8px;
	}

	button[type="submit"]:hover {
		background-color: #1d4ed8;
	}

	button[type="submit"]:active {
		transform: translateY(1px);
	}

	/* --- Links & Footer Text --- */
	.login-text {
		text-align: center;
		margin-top: 24px;
		font-size: 14px;
		color: #6b7280;
	}

	a {
		color: #2563eb;
		text-decoration: none;
		font-weight: 500;
		transition: color 0.2s ease;
	}

	a:hover {
		color: #1d4ed8;
		text-decoration: underline;
	}

	/* --- Responsive adjustments for mobile --- */
	@media (max-width: 600px) {
		form {
			grid-template-columns: 1fr; /* Stacks everything on small screens */
		}
		.register-container {
			padding: 32px 24px;
		}
	}
</style>

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/loader.css">
<script src="${pageContext.request.contextPath}/js/loader.js"></script>
</head>

<body>

<div id="loader">
    <div class="spinner"></div>
</div>

<div class="register-container">
	<h2>Seller Registration</h2>

	<%
	Response<?> responseObj = (Response<?>) session.getAttribute("response");
	if(responseObj != null){
		session.removeAttribute("response");   // show only once
	}
	
	if (responseObj != null) {
	%>
	<div class="alert-msg"
		style="color:<%=responseObj.isSuccess() ? "green" : "red"%>; border-color:<%=responseObj.isSuccess() ? "green" : "red"%>; background-color:<%=responseObj.isSuccess() ? "#f0fff4" : "#fff0f0"%>; ">
		<%=responseObj.getMessage()%>
	</div>
	<%
	}
	%>

	<form id="sellerRegisterForm" action="SellerRegisterServlet" method="post" onsubmit="showLoader()">
		
		<div class="form-group">
			<label for="name">Name:</label> 
			<input type="text" id="name" name="name" placeholder="Enter Your Name" required>
		</div>

		<div class="form-group">
			<label for="email">Email:</label> 
			<input type="email" id="email" name="email" placeholder="xyz@xyz.com" required>
		</div>

		<div class="form-group">
			<label for="mobile">Mobile:</label> 
			<input type="text" id="mobile" name="mobile" maxlength="10" placeholder="Enter mobile number" required>
		</div>
		
		<div class="form-group">
			<label for="companyName">Business Name:</label> 
			<input type="text" id="companyName" name="companyName" placeholder="Enter Company/Business name" required>
		</div>

		<div class="form-group">
			<label for="GSTnum">GST Number:</label> 
			<input type="text" id="GSTnum" name="GSTnum" placeholder="29ABCDE1234F1Z5" maxlength="15" required>
		</div>

		<div class="form-group">
			<label for="bankName">Bank Name:</label> 
			<input type="text" id="bankName" name="bankName" placeholder="XYZ Bank" required>
		</div>

		<!-- Address spans both columns because it usually requires more typing space -->
		<div class="form-group full-width">
			<label for="address">Address:</label> 
			<input type="text" id="address" name="address" placeholder="Enter your company address" required>
		</div>
		
		<div class="form-group">
			<label for="password">Password:</label> 
			<input type="password" id="password" name="password" placeholder="Enter Password" required>
		</div>

		<div class="form-group">
			<label for="confirmPassword">Confirm Password:</label> 
			<input type="password" id="confirmPassword" name="confirmPassword" placeholder="Re-enter password" required>
		</div>

		<!-- Button spans both columns -->
		<div class="form-group full-width">
			<button type="submit">Register</button>
		</div>
	</form>

	<p class="login-text">
		Already have an account? <a href="sellerLogin.jsp">Login here</a>
	</p>
</div>

</body>
</html>