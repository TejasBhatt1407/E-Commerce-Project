<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
String message = (String) request.getAttribute("message");
%>

<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>Forgot Password</title>

<style>

*{
    margin:0;
    padding:0;
    box-sizing:border-box;
    font-family:Arial, Helvetica, sans-serif;
}

body{

    background:#f5f5f5;

    display:flex;

    justify-content:center;

    align-items:center;

    height:100vh;

}

.container{

    width:400px;

    background:white;

    padding:35px;

    border-radius:10px;

    box-shadow:0 0 15px rgba(0,0,0,0.15);

}

h2{

    text-align:center;

    margin-bottom:25px;

}

label{

    display:block;

    margin-bottom:8px;

    font-weight:bold;

}

input{

    width:100%;

    padding:10px;

    border:1px solid #ccc;

    border-radius:5px;

    margin-bottom:20px;

}

button{

    width:100%;

    padding:12px;

    background:#007bff;

    color:white;

    border:none;

    border-radius:5px;

    cursor:pointer;

    font-size:16px;

}

button:hover{

    background:#0056b3;

}

.message{

    text-align:center;

    color:red;

    margin-bottom:15px;

}

.back{

    text-align:center;

    margin-top:20px;

}

.back a{

    text-decoration:none;

    color:#007bff;

}

.back a:hover{

    text-decoration:underline;

}

</style>

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/loader.css">
<script src="${pageContext.request.contextPath}/js/loader.js"></script>

</head>

<body>

<div id="loader">
    <div class="spinner"></div>
</div>

<div class="container">

    <h2>Forgot Password</h2>

    <% if(message != null){ %>

        <div class="message">
            <%= message %>
        </div>

    <% } %>

    <form action="ForgotPasswordServlet" method="post" onsubmit ="showLoader()">

        <label for="email">
            Registered Email
        </label>

        <input
            type="email"
            id="email"
            name="email"
            placeholder="Enter your registered email"
            required>

        <button type="submit">
            Send OTP
        </button>

    </form>

    <div class="back">

        <a href="index.jsp">
            Back to Login
        </a>

    </div>

</div>

</body>
</html>
