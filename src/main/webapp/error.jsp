<%@ page isErrorPage="true" contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Error</title>
<style>
body{
    font-family: Arial, sans-serif;
    background:#f5f5f5;
    display:flex;
    justify-content:center;
    align-items:center;
    height:100vh;
    margin:0;
}
.container{
    background:white;
    padding:30px;
    border-radius:10px;
    box-shadow:0 0 10px rgba(0,0,0,0.2);
    text-align:center;
    width:450px;
}
h1{
    color:#d9534f;
}
a{
    display:inline-block;
    margin-top:20px;
    text-decoration:none;
    background:#007bff;
    color:white;
    padding:10px 20px;
    border-radius:5px;
}
a:hover{
    background:#0056b3;
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
    <h1>Oops! Something went wrong.</h1>

    <p>
    <%
    if (session == null) {
%>
    Session Timed Out!
<%
    } else if (exception != null) {
%>
    <%= exception.getMessage() %>
<%
    } else {
%>
    An unexpected error occurred.
<%
    }
%>

    </p>

    <a href="index.jsp">New Login</a>
</div>

</body>
</html>