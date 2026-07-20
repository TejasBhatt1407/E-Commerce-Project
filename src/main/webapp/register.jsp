<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="com.ecommerce.util.Response"%>

<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>Register</title>
<style>
/* Reset and base styles */
* {
	box-sizing: border-box;
	margin: 0;
	padding: 0;
	font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}

body {
	background-color: #f4f6f9;
	display: flex;
	justify-content: center;
	align-items: center;
	min-height: 100vh;
	color: #333;
	padding: 20px 0;
}

/* Card container */
.register-container {
	background: #ffffff;
	padding: 2.5rem;
	border-radius: 8px;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
	width: 100%;
	max-width: 450px;
}

h2 {
	margin-bottom: 1.5rem;
	font-size: 1.8rem;
	color: #1a1a1a;
	text-align: center;
}

/* Form layout */
.form-group {
	margin-bottom: 1.25rem;
}

label {
	display: block;
	margin-bottom: 0.5rem;
	font-weight: 500;
	font-size: 0.9rem;
	color: #555;
}

input[type="text"], input[type="email"], input[type="password"] {
	width: 100%;
	padding: 0.75rem;
	border: 1px solid #ccc;
	border-radius: 4px;
	font-size: 0.95rem;
	transition: border-color 0.2s, box-shadow 0.2s;
}

input[type="text"]:focus, input[type="email"]:focus, input[type="password"]:focus
	{
	outline: none;
	border-color: #4a90e2;
	box-shadow: 0 0 0 3px rgba(74, 144, 226, 0.15);
}

/* Button styling */
button[type="submit"] {
	width: 100%;
	padding: 0.75rem;
	background-color: #4a90e2;
	color: white;
	border: none;
	border-radius: 4px;
	font-size: 1rem;
	font-weight: 600;
	cursor: pointer;
	transition: background-color 0.2s;
	margin-top: 0.5rem;
}

button[type="submit"]:hover {
	background-color: #357abd;
}

/* Footer link */
.login-text {
	text-align: center;
	margin-top: 1.5rem;
	font-size: 0.9rem;
	color: #666;
}

.login-text a {
	color: #4a90e2;
	text-decoration: none;
	font-weight: 500;
}

.login-text a:hover {
	text-decoration: underline;
}

/* Alert Dynamic Message Box */
.alert-msg {
	padding: 0.75rem;
	border-left: 4px solid;
	border-radius: 4px;
	margin-bottom: 1.5rem;
	font-size: 0.9rem;
	text-align: center;
	background-color: #f9f9f9; /* Default fallback */
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

		<form id="registerForm" action="RegisterServlet" method="post" onsubmit="showLoader()">
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
			Already have an account? <a href="index.jsp">Login here</a>
		</p>
	</div>

</body>
</html>