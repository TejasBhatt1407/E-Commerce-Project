<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="com.ecommerce.util.Response"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/loader.css">
<script src="${pageContext.request.contextPath}/js/loader.js"></script>

</head>
<style>
/* --- Base Reset & Typography --- */
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
  font-family: 'Inter', -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
}

body {
  background-color: #f3f4f6; /* Clean light gray background */
  display: flex;
  flex-direction: column; /* Stacks the container and forgot password link */
  justify-content: center;
  align-items: center;
  min-height: 100vh;
  color: #111827;
}

/* --- Main Card Container --- */
.login-container {
  background-color: #ffffff;
  width: 100%;
  max-width: 420px;
  padding: 40px 32px;
  border-radius: 12px;
  box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
}

.login-container h2 {
  font-size: 26px;
  font-weight: 700;
  text-align: center;
  margin-bottom: 24px;
  color: #111827;
}

/* --- Alert & Error Messages --- */
.alert-msg, 
.error-msg {
  padding: 12px;
  margin-bottom: 20px;
  border: 1px solid; /* Colors are handled inline for .alert-msg by your JSP */
  border-radius: 8px;
  font-size: 14px;
  text-align: center;
  font-weight: 500;
}

/* Fallback/Specific styles for the query string error */
.error-msg {
  color: #b91c1c;
  background-color: #fef2f2;
  border-color: #f87171;
  margin-top: 20px;
  margin-bottom: 0;
}

/* --- Form Elements --- */
form {
  display: flex;
  flex-direction: column;
  gap: 20px;
}

.form-group {
  display: flex;
  flex-direction: column;
  gap: 6px;
}

.form-group label {
  font-size: 14px;
  font-weight: 500;
  color: #374151;
}

.form-group input {
  width: 100%;
  padding: 12px 16px;
  border: 1px solid #d1d5db;
  border-radius: 8px;
  font-size: 15px;
  transition: all 0.2s ease;
  outline: none;
  background-color: #f9fafb;
}

/* Professional focus state (blue outline) */
.form-group input:focus {
  border-color: #2563eb;
  background-color: #ffffff;
  box-shadow: 0 0 0 4px rgba(37, 99, 235, 0.1);
}

.form-group input::placeholder {
  color: #9ca3af;
}

/* --- Submit Button --- */
button[type="submit"] {
  background-color: #2563eb;
  color: #ffffff;
  border: none;
  border-radius: 8px;
  padding: 12px;
  font-size: 15px;
  font-weight: 600;
  cursor: pointer;
  transition: background-color 0.2s ease, transform 0.1s ease;
  margin-top: 4px;
}

button[type="submit"]:hover {
  background-color: #1d4ed8;
}

button[type="submit"]:active {
  transform: translateY(1px);
}

/* --- Links & Footer Text --- */
.signup-text {
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

/* Specific styling for the standalone forgot password link at the bottom */
body > div[style*="text-align:center"] a {
  font-size: 14px;
  color: #4b5563;
}

body > div[style*="text-align:center"] a:hover {
  color: #111827;
}
</style>
<body>

<div id="loader">
    <div class="spinner"></div>
</div>

	<div class="login-container">
		<h2>Seller Login</h2>

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


		<form action="<%=request.getContextPath() %>/SellerLoginServlet" method="post" onsubmit= "showLoader()">
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
			Don't have an account? <a href="sellerRegister.jsp">Register Here</a>
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