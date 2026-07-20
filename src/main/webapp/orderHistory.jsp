<%@page import="java.util.List"%>
<%@page import="com.ecommerce.model.Order"%>

<%
List<Order> orders = (List<Order>) request.getAttribute("orders");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Order History</title>

<style>
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
	font-family: Arial, Helvetica, sans-serif;
}

body {
	background: #f4f6f9;
	padding: 40px;
}

.container {
	width: 90%;
	max-width: 1000px;
	margin: auto;
}

h1 {
	text-align: center;
	margin-bottom: 35px;
	color: #333;
}

.empty {
	text-align: center;
	background: white;
	padding: 40px;
	border-radius: 10px;
	font-size: 20px;
	box-shadow: 0 2px 8px rgba(0, 0, 0, .1);
}

.order-card {
	background: white;
	border-radius: 10px;
	margin-bottom: 20px;
	padding: 20px;
	box-shadow: 0 2px 8px rgba(0, 0, 0, .1);
}

.order-header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 15px;
	border-bottom: 1px solid #ddd;
	padding-bottom: 10px;
}

.order-id {
	font-size: 20px;
	font-weight: bold;
	color: #333;
}

.status {
	padding: 6px 15px;
	border-radius: 20px;
	background: #28a745;
	color: white;
	font-weight: bold;
}

.order-details {
	display: grid;
	grid-template-columns: repeat(3, 1fr);
	gap: 20px;
}

.detail {
	display: flex;
	flex-direction: column;
}

.label {
	font-size: 14px;
	color: #777;
	margin-bottom: 5px;
}

.value {
	font-size: 17px;
	font-weight: bold;
	color: #222;
}

.back-btn {
	display: inline-block;
	margin-top: 30px;
	padding: 12px 25px;
	text-decoration: none;
	background: #007bff;
	color: white;
	border-radius: 6px;
}

.back-btn:hover {
	background: #0056b3;
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

		<h1>My Orders</h1>

		<%
if(orders == null || orders.isEmpty()){
%>

		<div class="empty">

			No orders placed yet. <br> <br> <a href="HomeServlet"
				class="back-btn"> Continue Shopping </a>

		</div>

		<%
}else{

for(Order order : orders){
%>

		<div class="order-card">

			<div class="order-header">

				<div class="order-id">
					Order #<%=order.getId()%>
				</div>

				<div class="status">
					<%=order.getStatus()%>
				</div>

			</div>

			<div class="order-details">

				<div class="detail">

					<div class="label">Order Date</div>

					<div class="value">
						<%=order.getOrderDate()%>
					</div>

				</div>

				<div class="detail">

					<div class="label">Items</div>

					<div class="value">
						<%=order.getTotalItems()%>
					</div>

				</div>

				<div class="detail">

					<div class="label">Total Amount</div>

					<div class="value">
						Rs
						<%=order.getTotalAmount()%>
					</div>

				</div>

			</div>

		</div>

		<%
}
%>

		<a href="HomeServlet" class="back-btn"> Return to Home </a>

		<%
}
%>

	</div>

</body>
</html>