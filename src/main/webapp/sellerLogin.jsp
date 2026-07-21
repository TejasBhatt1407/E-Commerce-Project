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