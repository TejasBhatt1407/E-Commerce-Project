<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="com.ecommerce.util.Response"%>

<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>Register</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/loader.css">
<script src="${pageContext.request.contextPath}/js/loader.js"></script>

</head>

<body>

<div id="loader">
    <div class="spinner"></div>
</div>

	<div class="register-container">
		<h2>User Registration</h2>

		<%
		
		Response<?> responseObj =
		    (Response<?>) session.getAttribute("response");

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
				<label for="name">Name:</label> <input type="text" id="name"
					name="name" placeholder="Enter Your Name" required>
			</div>

			<div class="form-group">
				<label for="email">Email:</label> <input type="email" id="email"
					name="email" placeholder="xyz@xyz.com" required>
			</div>

			<div class="form-group">
				<label for="mobile">Mobile:</label> <input type="text" id="mobile"
					name="mobile" maxlength="10" placeholder="Enter mobile number"
					required>
			</div>
			
			<div class="form-group">
				<label for="companyName">Business :</label> <input type="text" id="companyName"
					name="companyName"  placeholder="Enter Company/Business name"
					required>
			</div>
			<div class="form-group">
				<label for="GSTnum">GST number:</label> <input type="text" id="GSTnum"
					name="GSTnum"  placeholder="29ABCDE1234F1Z5"
					required>
			</div>
			<div class="form-group">
				<label for="bankName">Bank Name:</label> <input type="text" id="bankName"
					name="bankName"  placeholder="XYZ Bank"
					required>
			</div>
			<div class="form-group">
				<label for="address">Address:</label> <input type="text" id="address"
					name="address"  placeholder="Enter your company address"
					required>
			</div>
			
			

			<div class="form-group">
				<label for="password">Password:</label> <input type="password"
					id="password" name="password" placeholder="Enter Password" required>
			</div>

			<div class="form-group">
				<label for="confirmPassword">Confirm Password:</label> <input
					type="password" id="confirmPassword" name="confirmPassword"
					placeholder="Re-enter password" required>
			</div>

			<button type="submit">Register</button>
		</form>

		<p class="login-text">
			Already have an account? <a href="sellerLogin.jsp">Login here</a>
		</p>
	</div>

</body>
</html>