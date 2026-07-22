<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.util.List"%>
<%@ page import="com.ecommerce.model.Product"%>

<%
List<Product> products = (List<Product>) request.getAttribute("products");
String sellerName = (String) session.getAttribute("loggedInSellerName");
%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title>Seller Dashboard</title>

<style>

*{
	margin:0;
	padding:0;
	box-sizing:border-box;
	font-family:Arial,sans-serif;
}

body{
	background:#f4f6f9;
}

/* Header */

.header{

	background:white;
	padding:25px;

	text-align:center;

	box-shadow:0 2px 8px rgba(0,0,0,.1);

}

.header h1{

	color:#2563eb;
}

/* Navigation */

.navbar{

	background:#2563eb;

	display:flex;

	justify-content:center;

	gap:40px;

	padding:15px;

}

.navbar a{

	color:white;

	text-decoration:none;

	font-weight:bold;

}

.navbar a:hover{

	color:#ffd54f;

}

.container{

	width:90%;

	margin:30px auto;

}

.section{

	background:white;

	padding:25px;

	border-radius:10px;

	box-shadow:0 2px 8px rgba(0,0,0,.1);

	margin-bottom:30px;

}

.section h2{

	margin-bottom:20px;

	color:#2563eb;

}
.formGrid{

	display:grid;

	grid-template-columns:repeat(2,1fr);

	gap:20px;

}

.formGroup{

	display:flex;

	flex-direction:column;

}

.formGroup label{

	font-weight:bold;

	margin-bottom:6px;

}

.formGroup input,
.formGroup textarea{

	padding:10px;

	border:1px solid #ccc;

	border-radius:6px;

	font-size:15px;

}

.formGroup textarea{

	resize:vertical;

}

.fullWidth{

	grid-column:1/3;

}

.addBtn{

	padding:12px 30px;

	background:#2563eb;

	color:white;

	border:none;

	border-radius:6px;

	font-size:16px;

	cursor:pointer;

}

.addBtn:hover{

	background:#1d4ed8;

}

</style>

</head>

<body>

<div class="header">

<h1>Welcome <%=sellerName%></h1>

</div>

<div class="navbar">

<a href="#">Policy</a>

<a href="#">T & C</a>

<a href="#">Platform Fee</a>

<a href="#addProduct">Add Product</a>

<a href="#">Profile</a>

<a href="LogoutServlet">Logout</a>

</div>

<div class="container">
<div class="section" id="addProduct">

<h2>Add Product</h2>

<form action="SellerHomeServlet" method="post" enctype="multipart/form-data">

<input type="hidden" name="action" value="addProduct">

<div class="formGrid">

<div class="formGroup">

<label>Product Name</label>

<input type="text" name="name" required>

</div>

<div class="formGroup">

<label>Product Type</label>

<select name="type" required>
    <option value="">Select Type</option>

    <% for(String type : (List<String>)request.getAttribute("types")) { %>
        <option value="<%=type%>"><%=type%></option>
    <% } %>

</select>

</div>

<div class="formGroup">

<label>Product Sub Type</label>

<input type="text" name="subType" required>

</div>

<div class="formGroup">

<label>Price (Rs)</label>

<input type="number" name="price" required>

</div>

<div class="formGroup">

<label>Quantity</label>

<input type="number" name="quantity" required>

</div>

<div class="formGroup">

<label>Image</label>

<input type="file"
       name="image"
       accept="image/*">

</div>


<div class="formGroup fullWidth">

<label>Short Description</label>

<textarea rows="3" name="description"></textarea>

</div>

<div class="formGroup fullWidth">

<label>Long Description</label>

<textarea rows="6" name="longDescription"></textarea>

</div>

<div class="fullWidth">

<button class="addBtn" type="submit">

Add Product

</button>

</div>

</div>

</form>

</div>