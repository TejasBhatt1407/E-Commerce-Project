<%@ page import="com.ecommerce.model.Product"%>

<%
Product product = (Product) request.getAttribute("product");

if (product == null) {
	response.sendRedirect("HomeServlet");
	return;
}
%>


<%
Integer selectedQuantity =
(Integer)request.getAttribute("selectedQuantity");

if(selectedQuantity == null){

    selectedQuantity = 1;

}
%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title><%=product.getName()%></title>

<style>
body {
	font-family: Arial;
	margin: 40px;
	background: #f5f5f5;
}

.qty-box{

display:flex;
align-items:center;
gap:10px;
margin-top:15px;

}

.qty-box input{

width:50px;
text-align:center;
font-size:18px;

}

.qty-box button{

width:35px;
height:35px;
font-size:18px;
cursor:pointer;

}

.container {
	display: flex;
	gap: 50px;
	background: white;
	padding: 30px;
	border-radius: 10px;
}

.left {
	width: 40%;
}

.right {
	width: 60%;
}

img {
	width: 100%;
	height: 400px;
	object-fit: contain;
}

.price {
	font-size: 30px;
	font-weight: bold;
	color: #008000;
}

.stock {
	margin: 15px 0;
	font-weight: bold;
}

button {
	padding: 12px 25px;
	margin-top: 20px;
	cursor: pointer;
}

.description {
	margin-top: 30px;
	line-height: 1.7;
}

.quantitySelector{

display:flex;

align-items:center;

gap:15px;

margin:20px 0;

}

.qtyBtn{

width:35px;

height:35px;

font-size:20px;

cursor:pointer;

}

.quantitySelector span{

font-size:18px;

font-weight:bold;

min-width:25px;

text-align:center;

}


.Home a {
    display: inline-block;
    padding: 10px 20px;
    background-color: #007bff;
    color: #ffffff;
    text-decoration: none;
    border-radius: 5px;
    font-weight: bold;
    transition: background 0.2s ease;
}

.Home a:hover {
    background-color: #0056b3;
}

</style>

</head>

<body>
	<div class ="Home">
	<a href="HomeServlet">Continue Shopping</a>
	</div>

	<div class="container">

		<div class="left">

	<!--  		<img src="<%=product.getImage()%>">   -->
	<%
String image = product.getImage();

if (image == null || image.trim().isEmpty()) {
    image = "default-placeholder.png"; // Set the fallback filename string
} else {
    image = product.getImage().trim(); // Use the valid filename string
}
// We close the Java block here cleanly before rendering HTML
%>

<img src="<%= request.getContextPath() %>/images/products/<%= image %>"
     alt="<%= (product.getName() != null) ? product.getName() : "Product Image" %>"
     style="max-width: 90%; height: auto; object-fit: contain;">




		</div>

		<div class="right">

			<h1><%=product.getName()%></h1>

			<h3><%=product.getDescription()%></h3>

			<p class="price">

				Rs
				<%=product.getPrice()%>

			</p>

			<p class="stock">

				<%
if (product.getQuantity() > 0) {
%>
	</p> 

	<% if(product.getCartQuantity() == 0) { %>
		<!-- Case 1: Item is not in the cart yet -->
		<form action="AddToCartServlet" method="post">
			<input type="hidden" name="productId" value="<%=product.getId()%>">
			<button type="submit" class="cartButton">Add To Cart</button>
		</form>
	<% } else { %>
		<!-- Case 2: Item is already in the cart, show plus/minus controls -->
		<div class="quantitySelector">
			<form action="UpdateCartServlet" method="post">
				<input type="hidden" name="source" value="home">
				<input type="hidden" name="productId" value="<%=product.getId()%>">
				<input type="hidden" name="action" value="decrease">
				<button type="submit" class="qtyBtn">-</button>
			</form>
			
			<span><%=product.getCartQuantity()%></span>
			
			<form action="UpdateCartServlet" method="post">
				<input type="hidden" name="productId" value="<%=product.getId()%>">
				<input type="hidden" name="action" value="increase">
				<button type="submit" class="qtyBtn">+</button>
			</form>
		</div>
	<% } %>

<%
} else {
%>
	<!-- Handle Out of Stock scenario here if needed -->
	<p class="outOfStock" style="color:red;">Out of Stock</p>
<%
}
%>


			<div class="description">

				<h2>Description</h2>

				<p>

					<%=product.getLongDescription()%>

				</p>

			</div>

		</div>

	</div>

</body>

</html>