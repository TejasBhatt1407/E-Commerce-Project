<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.ecommerce.model.User"%>
<%
    User user = (User) request.getAttribute("user");
    if(user == null){
        response.sendRedirect("HomeServlet");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Profile</title>
<style>
    body {
        font-family: Arial;
        background: #f4f4f4;
        margin: 0;
        padding: 40px;
    }
    .container {
        width: 500px;
        margin: auto;
        background: white;
        padding: 30px;
        border-radius: 10px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
    }
    h2 {
        text-align: center;
        margin-bottom: 30px;
    }
    .row {
        display: flex;
        margin-bottom: 18px;
    }
    .label {
        width: 150px;
        font-weight: bold;
    }
    .value {
        flex: 1;
    }
    .btn-container {
        margin-top: 35px;
        display: flex;
        justify-content: space-between;
    }
    .btn {
        display: inline-block;
        padding: 10px 20px;
        background: #2196F3;
        color: white;
        text-decoration: none;
        border-radius: 5px;
    }
    .btn-secondary {
        background: #4CAF50;
    }
</style>
</head>
<body>
<div class="container">
    <h2>My Profile</h2>
    
    
    <div class="row">
        <div class="label">Name</div>
        <div class="value"><%=user.getName()%></div>
    </div>
    <div class="row">
        <div class="label">Email</div>
        <div class="value"><%=user.getEmail()%></div>
    </div>
    <div class="row">
        <div class="label">Mobile</div>
        <div class="value"><%=user.getMobile()%></div>
    </div>
    
    <div class="btn-container">
        <a href="OrderHistoryServlet" class="btn btn-secondary">
            My Orders
        </a>
        <a href="HomeServlet" class="btn">
            Return to Home
        </a>
    </div>
</div>
</body>
</html>
