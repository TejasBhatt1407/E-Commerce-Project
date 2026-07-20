<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="com.ecommerce.util.Response"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
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
	}

	/* Card container */
	.login-container {
		background: #ffffff;
		padding: 2.5rem;
		border-radius: 8px;
		box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
		width: 100%;
		max-width: 400px;
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

	input[type="email"],
	input[type="password"] {
		width: 100%;
		padding: 0.75rem;
		border: 1px solid #ccc;
		border-radius: 4px;
		font-size: 0.95rem;
		transition: border-color 0.2s, box-shadow 0.2s;
	}

	input[type="email"]:focus,
	input[type="password"]:focus {
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
	.signup-text {
		text-align: center;
		margin-top: 1.5rem;
		font-size: 0.9rem;
		color: #666;
	}

	.signup-text a {
		color: #4a90e2;
		text-decoration: none;
		font-weight: 500;
	}

	.signup-text a:hover {
		text-decoration: underline;
	}

	/* Error Message Styling */
	.error-msg {
		background-color: #fff0f0;
		color: #d9534f;
		padding: 0.75rem;
		border-left: 4px solid #d9534f;
		border-radius: 4px;
		margin-top: 1rem;
		font-size: 0.9rem;
		text-align: center;
	}
</style>

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/loader.css">
<script src="${pageContext.request.contextPath}/js/loader.js"></script>

</head>

<body>

<div id="loader">
    <div class="spinner"></div>
</div>

	<div class="login-container">
		<h2>Login</h2>

	<%
     Response<?> responseObj =
    (Response<?>) session.getAttribute("response");

if(responseObj != null){
    session.removeAttribute("response"); // Display only once
}
%>


<% if(responseObj != null){ %>

<div class="alert-msg"
			style="color:<%=responseObj.isSuccess() ? "green" : "red"%>; border-color:<%=responseObj.isSuccess() ? "green" : "red"%>; background-color:<%=responseObj.isSuccess() ? "#f0fff4" : "#fff0f0"%>; ">
    <%= responseObj.getMessage() %>
</div>

<% } %>


		<form action="<%=request.getContextPath() %>/LoginServlet" method="post" onsubmit= "showLoader()">
			<div class="form-group">
				<label for="email">Email</label>
				<input type="email" id="email" name="email" placeholder="Enter your email" required>
			</div>

			<div class="form-group">
				<label for="password">Password</label>
				<input type="password" id="password" name="password" placeholder="Enter your password" required>
			</div>

			<button type="submit">Login</button>
		</form>

		<p class="signup-text">
			Don't have an account? <a href="register.jsp">Register Here</a>
		</p>

		<%
		String error = request.getParameter("error");
		if ("1".equals(error)) {
		%>
			<div class="error-msg">
				Invalid email or password. Please try again.
			</div>
		<%
		}
		%>
	</div>
	
	<div style="text-align:center;margin-top:15px;">
    <a href="forgotPassword.jsp">
        Forgot Password?
    </a>
</div>

</body>
</html>