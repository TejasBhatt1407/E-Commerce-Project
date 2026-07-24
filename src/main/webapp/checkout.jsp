<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.util.List"%>
<%@ page import="com.ecommerce.model.Cart"%>

<%
List<Cart> cartItems = (List<Cart>) request.getAttribute("cartItems");

double total = (Double) request.getAttribute("total");
int totalItems = (Integer) request.getAttribute("totalItems");
%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title>Checkout</title>

<style>
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
	font-family: Arial, Helvetica, sans-serif;
}

body {
	background: #f4f4f4;
	padding: 30px;
}

.container {
	max-width: 1200px;
	margin: auto;
}

h1 {
	margin-bottom: 25px;
	text-align: center;
}

.checkout-layout {
	display: flex;
	gap: 30px;
	align-items: flex-start;
}

.address-box {
	flex: 2;
	background: white;
	padding: 25px;
	border-radius: 10px;
	box-shadow: 0 2px 8px rgba(0, 0, 0, .1);
}

.summary-box {
	flex: 1;
	background: white;
	padding: 25px;
	border-radius: 10px;
	box-shadow: 0 2px 8px rgba(0, 0, 0, .1);
	position: sticky;
	top: 20px;
}

label {
	display: block;
	margin-top: 15px;
	font-weight: bold;
}

input[type=text], input[type=number] {
	width: 100%;
	padding: 10px;
	margin-top: 5px;
	border: 1px solid #ccc;
	border-radius: 5px;
}

textarea {
	width: 100%;
	height: 90px;
	padding: 10px;
	margin-top: 5px;
	resize: none;
	border-radius: 5px;
}

.item {
	padding: 10px 0;
	border-bottom: 1px solid #ddd;
}

.total {
	margin-top: 20px;
	font-size: 18px;
	font-weight: bold;
}

.place-btn {
	width: 100%;
	margin-top: 25px;
	padding: 14px;
	background: #28a745;
	color: white;
	border: none;
	border-radius: 5px;
	font-size: 16px;
	cursor: pointer;
}

.place-btn:hover {
	background: #218838;
}

.checkbox {
	margin-top: 20px;
}


.back-btn {
  display: inline-block;
  padding: 12px 24px;
  font-size: 16px;
  font-family: sans-serif;
  text-decoration: none;
  color: #ffffff;
  background-color: #007bff;
  border-radius: 6px;
  box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
  transition: background-color 0.2s ease, transform 0.1s ease;
}

/* Hover effect */
.back-btn:hover {
  background-color: #0056b3;
}

/* Click effect */
.back-btn:active {
  transform: scale(0.98);
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

<a href=CartServlet class="back-btn">Previous</a>

		<h1>Checkout</h1>

		<form action="PlaceOrderServlet" method="post" onsubmit="showLoader">

			<div class="checkout-layout">

				<div class="address-box">

					<h2>Shipping Address</h2>

					<label>Full Name</label> <input type="text" name="fullName"
						required> <label>Mobile Number</label> <input type="text"
						name="mobile" required> <label>Address</label>
					<textarea name="address" required></textarea>

					<label>City</label> <input type="text" name="city" required>

					<label>State</label> <input type="text" name="state" required>

					<label>Pincode</label> <input type="number" name="pincode" required>

					<div class="checkbox">

						<input type="checkbox" name="saveAddress" value="true">

						Save this address for future orders

					</div>

				</div>

				<div class="summary-box">

					<h2>Order Summary</h2>

					<br>

					<%
					for (Cart cart : cartItems) {
					%>

					<div class="item">

						<b><%=cart.getProduct().getName()%></b> <br> Quantity :
						<%=cart.getQuantity()%>

						<br> Subtotal : Rs
						<%=cart.getQuantity() * cart.getProduct().getPrice()%>

					</div>

					<%
}
%>

					<div class="total">

						Total Items :
						<%=totalItems%>

						<br> <br> Grand Total : Rs
						<%=total%>

					</div>

					<button class="place-btn">Place Order</button>

				</div>

			</div>

		</form>




	</div>

</body>

</html>