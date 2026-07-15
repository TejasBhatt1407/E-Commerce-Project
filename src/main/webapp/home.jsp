<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.ecommerce.model.Product"%>
<%
String email = (String) session.getAttribute("loggedInUser");
if (email == null) {
	response.sendRedirect("index.jsp");
	return;
}

String userName = (String) session.getAttribute("loggedInUserName");
List<String> types = (List<String>) request.getAttribute("types");
List<String> subTypes = (List<String>) request.getAttribute("subTypes");
List<Product> products = (List<Product>) request.getAttribute("products");
String selectedType = (String) request.getAttribute("selectedType");
String selectedSubType = (String) request.getAttribute("selectedSubType");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Home - E-Commerce Store</title>
<link
	href="https://fonts.googleapis.com/css2?family=Inter:wght=400;500;600;700&display=swap"
	rel="stylesheet">
<style>
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
	font-family: 'Inter', Arial, Helvetica, sans-serif;
}

body {
	background: #f5f5f5;
}

.quantitySelector {
	display: flex;
	align-items: center;
	justify-content: center;
	gap: 10px;
	margin: 15px 0;
}

.quantitySelector form {
	display: inline;
	margin: 0;
}

.qtyBtn {
	width: 35px;
	height: 35px;
	border: none;
	border-radius: 6px;
	background: #2563eb;
	color: white;
	font-size: 20px;
	cursor: pointer;
}

.quantitySelector span {
	font-size: 20px;
	font-weight: bold;
	min-width: 25px;
	text-align: center;
}
/* ================= HEADER ================= */
.header {
	height: 70px;
	background: #1f2937;
	color: white;
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding: 0 30px;
}

.logo {
	font-size: 28px;
	font-weight: bold;
}

.rightHeader {
	display: flex;
	align-items: center;
	gap: 20px;
}

.searchBar {
	width: 350px;
	padding: 10px;
	border-radius: 20px;
	border: none;
	outline: none;
}

.logoutBtn {
	padding: 10px 18px;
	background: #dc2626;
	color: white;
	border: none;
	border-radius: 5px;
	cursor: pointer;
}

.logoutBtn:hover {
	background: #b91c1c;
}
/* ================= MAIN ================= */
.main {
	padding: 25px;
}
/* ================= HORIZONTAL PRODUCT TYPES ================= */
.productTypeSection {
	background: white;
	padding: 20px;
	border-radius: 10px;
	margin-bottom: 25px;
}

.productTypeContainer {
	overflow-x: auto;
	overflow-y: hidden;
	white-space: nowrap;
	padding-bottom: 10px;
}

.productTypeButtons {
	display: flex;
	flex-wrap: nowrap;
	gap: 12px;
	width: max-content;
}

.productTypeButtons form {
	flex-shrink: 0;
}

.typeButton {
	padding: 12px 25px;
	background: #2563eb;
	color: white;
	border: none;
	border-radius: 6px;
	cursor: pointer;
}

.typeButton:hover {
	background: #1d4ed8;
}
/* ================= SUB TYPES ================= */
.subTypeSection {
	background: white;
	padding: 20px;
	border-radius: 10px;
	margin-bottom: 25px;
}

.subTypeSection h2 {
	margin-bottom: 15px;
}

.subTypeButtons {
	display: flex;
	flex-wrap: wrap;
	gap: 12px;
}

.subTypeButton {
	padding: 10px 20px;
	background: #10b981;
	color: white;
	border: none;
	border-radius: 5px;
	cursor: pointer;
}

.subTypeButton:hover {
	background: #059669;
}
/* ================= PRODUCTS ================= */
.productGrid {
	display: flex;
	flex-wrap: wrap;
	gap: 20px; <!--
	margin-top: 20px;
	-->
}

.productGrid {
	display: flex;
	flex-wrap: wrap;
	gap: 20px;
}

.productCard {
	width: 270px;
	background: #fff;
	border-radius: 10px;
	overflow: hidden;
	box-shadow: 0 2px 8px rgba(0, 0, 0, .15);
	display: flex;
	flex-direction: column;
}

.productCard h3 a {
	text-decoration: none;
	color: #1f2937;
}

.productCard h3 a:hover {
	color: #2563eb;
}

.productCard p {
	margin: 5px 0;
}

.product-image {
	width: 100%;
	height: 180px;
	overflow: hidden;
	flex-shrink: 0;
	background: #f5f5f5;
	/* Optional: Center the image vertically and horizontally */
	display: flex;
	justify-content: center;
	align-items: center;
}

.productContent h3 {
	margin: 0;
}

.productContent p {
	margin: 0;
}

.productContent {
	padding: 15px;
	display: flex;
	flex-direction: column;
	gap: 8px;
	flex: 1;
}

.product-image img {
	max-width: 100%;
	max-height: 100%;
	height: auto;
	width: auto;
	object-fit: contain;
}

.description {
	margin: 8px 0;
	color: #444;
	line-height: 1.4;
	min-height: 40px;
}

.buyButton {
	width: 100%;
	padding: 8px 18px;
	margin-bottom: 8px;
	background: #10b981;
	color: white;
	border: none;
	border-radius: 5px;
	cursor: pointer;
	font-size: 14px;
}

.buyButton:hover {
	background: #059669;
}

.cartButton {
	width: 100%;
	padding: 8px 18px;
	background: #2563eb;
	color: white;
	border: none;
	border-radius: 5px;
	cursor: pointer;
	font-size: 14px;
}

.cartButton:hover {
	background: #1d4ed8;
}

.floatingCart {
	position: fixed;
	right: 30px;
	bottom: 30px;
	width: 70px;
	height: 70px;
	border: none;
	border-radius: 50%;
	background: #2563eb;
	color: white;
	font-size: 30px;
	cursor: pointer;
	box-shadow: 0 4px 12px rgba(0, 0, 0, .3);
	z-index: 1000;
}

.floatingCart:hover {
	background: #1d4ed8;
	transform: scale(1.08);
}

.user-dropdown {
	position: relative;
	display: inline-block;
}

.dropdown-checkbox {
	display: none;
}

/* Style for the main trigger button */
.dropdown-trigger-btn {
	display: inline-block;
	background-color: #2563eb;
	color: white;
	padding: 10px 18px;
	font-size: 14px;
	border: none;
	border-radius: 6px;
	cursor: pointer;
	font-weight: 500;
	user-select: none;
}

/* Dropdown menu container (hidden by default) */
.dropdown-content {
	display: none;
	position: absolute;
	right: 0;
	/* Aligns the dropdown menu to the right side of the button */
	background-color: #ffffff;
	min-width: 160px;
	box-shadow: 0px 8px 16px 0px rgba(0, 0, 0, 0.15);
	border: 1px solid #e5e7eb;
	border-radius: 6px;
	z-index: 100;
	margin-top: 5px;
	overflow: hidden;
}

.dropdown-checkbox:checked ~ .dropdown-trigger-btn {
	background-color: #1d4ed8;
}

.dropdown-checkbox:checked ~ .dropdown-content {
	display: block;
	/* Individual links/buttons inside the dropdown */ . dropdown-item {
	color : #374151;
	padding: 12px 16px;
	text-decoration: none;
	display: block;
	font-size: 14px;
	text-align: left;
	width: 100%;
	background: none;
	border: none;
	cursor: pointer;
	box-sizing: border-box;
}

/* Hover effects for individual items */
.dropdown-item:hover {
	background-color: #f3f4f6;
	color: #111827;
}

/* Custom design for the inside logout option */
.dropdown-item.logout-btn {
	color: #dc2626; /* Making the logout option stand out in red */
}

.dropdown-item.logout-btn:hover {
	background-color: #fee2e2;
}

/* Simple divider rule styling */
.dropdown-divider {
	border: 0;
	border-top: 1px solid #e5e7eb;
	margin: 4px 0;
}

/* CRITICAL: Shows the dropdown menu when hovering over the parent wrapper */
.user-dropdown:hover .dropdown-content {
	display: block;
}
</style>
</head>

<body> 

<body>

	<a href="CartServlet" class="floatingCart">
		🛒 <span id="cartCount">${cartCount}</span>
	</a>

	<div class="header">

		<div class="logo">
			<a href="HomeServlet" style="text-decoration: none; color: inherit;">
				GalaXy 8uy
			</a>
		</div>

		<div class="rightHeader">

			<form action="HomeServlet" method="get">
				<input class="searchBar"
					   type="text"
					   name="search"
					   placeholder="Search Products...">
			</form>

			<span>Welcome, <%=userName%></span>

			<div class="user-dropdown">

				<input
					type="checkbox"
					id="dropdown-toggle"
					class="dropdown-checkbox">

				<label
					for="dropdown-toggle"
					class="dropdown-trigger-btn">

					Account Menu

				</label>

				<div class="dropdown-content">

					<a href="${pageContext.request.contextPath}/ProfileServlet"
					   class="dropdown-item">

						Profile

					</a>

					<a href="OrderHistoryServlet"
					   class="dropdown-item">

						Order History

					</a>

					<hr class="dropdown-divider">

					<form action="LogoutServlet"
						  method="get"
						  class="dropdown-logout-form">

						<button
							type="submit"
							class="dropdown-item logout-btn">

							Logout

						</button>

					</form>

				</div>

			</div>

		</div>

	</div>

	<div class="main">

		<!-- Product Types -->

		<div class="productTypeSection">

			<h2>Product Types</h2>

			<div class="productTypeContainer">

				<div class="productTypeButtons">

					<%
					if(types != null){
						for(String type : types){
					%>

						<form action="HomeServlet" method="get">

							<input
								type="hidden"
								name="type"
								value="<%=type%>">

							<button class="typeButton">

								<%=type%>

							</button>

						</form>

					<%
						}
					}
					%>

				</div>

			</div>

		</div>

		<!-- Default Screen -->

		<%
		if(selectedType == null){
		%>

			<div class="products">

				<h2>Featured Products</h2>

				<p style="margin-top:15px;color:#666;">

					Please select a product type above to explore categories.

				</p>

			</div>

		<%
		}
		%>

		<!-- Sub Types -->

		<%
		if(selectedType != null){
		%>

			<div class="subTypeSection">

				<h2>Sub Types</h2>

				<%
				if(subTypes != null){
				%>

					<div class="subTypeButtons">

						<%
						for(String subType : subTypes){
						%>

							<form action="HomeServlet" method="get">

								<input
									type="hidden"
									name="type"
									value="<%=selectedType%>">

								<input
									type="hidden"
									name="subType"
									value="<%=subType%>">

								<button class="subTypeButton">

									<%=subType%>

								</button>

							</form>

						<%
						}
						%>

					</div>

				<%
				}
				else{
				%>

					<p>Select a Product Type</p>

				<%
				}
				%>

			</div>

		<%
		}
		%>

		<!-- Products -->

		<%
		if(selectedSubType != null){
		%>

			<div class="products">

				<h2>Products</h2>

				<%
				if(products != null && !products.isEmpty()){
				%>

					<div class="productGrid">

						<%
						for(Product product : products){
						%>
						
						
												<div class="productCard" id="productCard<%=product.getId()%>">

							<!-- Product Image -->
							<div class="product-image">

								<a href="ProductServlet?id=<%=product.getId()%>">

									<img
										src="<%=request.getContextPath()%>/images/products/<%= (product.getImage() != null && !product.getImage().trim().isEmpty()) ? product.getImage() : "default-placeholder.png" %>"
										alt="<%=product.getName()%>"
										style="max-width:90%; height:auto; object-fit:contain;">

								</a>

							</div>

							<!-- Product Content -->
							<div class="productContent">

								<h3>
									<a href="ProductServlet?id=<%=product.getId()%>">
										<%=product.getName()%>
									</a>
								</h3>

								<p>
									<b>Price :</b> ₹<%=product.getPrice()%>
								</p>

								<p>
									<b>Available :</b>
									<%=product.getQuantity()%>
								</p>

								<%
									String description = product.getDescription();
									String shortDescription = description;

									if(description != null && description.length() > 60){
										shortDescription = description.substring(0,60) + "...";
									}
								%>

								<p class="description">
									<%=shortDescription%>
								</p>

								<form action="CheckoutServlet" method="get">

									<input
										type="hidden"
										name="id"
										value="<%=product.getId()%>">

									<button
										type="submit"
										class="buyButton">

										Buy Now

									</button>

								</form>

								<!-- Cart Area -->

								<div id="cartArea<%=product.getId()%>">

									<%
									if(product.getCartQuantity() == 0){
									%>

										<button
											type="button"
											class="cartButton"
											onclick="addToCart(<%=product.getId()%>)">

											Add To Cart

										</button>

									<%
									}else{
									%>

										<div class="quantitySelector">

											<button
												type="button"
												class="qtyBtn"
												onclick="updateQuantity(<%=product.getId()%>, 'decrease')">

												-

											</button>

											<span id="qty<%=product.getId()%>">
												<%=product.getCartQuantity()%>
											</span>

											<button
												type="button"
												class="qtyBtn"
												onclick="updateQuantity(<%=product.getId()%>, 'increase')">

												+

											</button>

										</div>

									<%
									}
									%>

								</div>

							</div>

						</div>

					<%
					}
					%>

				</div>

			<%
			}else{
			%>

				<h3>No Products Found</h3>

			<%
			}
			%>

		</div>

	<%
	}
	%>
	
	<script>

function addToCart(productId){

    fetch("AddToCartServlet",{

        method:"POST",

        headers:{
            "Content-Type":"application/x-www-form-urlencoded"
        },

        body:"productId="+productId

    })

    .then(response=>response.text())

    .then(cartCount=>{

        cartCount = cartCount.trim();

        // Update floating cart count
        document.getElementById("cartCount").innerText = cartCount;

        // Replace Add To Cart button with quantity selector
        document.getElementById("cartArea"+productId).innerHTML =

        `
        <div class="quantitySelector">

            <button
                type="button"
                class="qtyBtn"
                onclick="updateQuantity(${productId},'decrease')">

                -

            </button>

            <span id="qty${productId}">1</span>

            <button
                type="button"
                class="qtyBtn"
                onclick="updateQuantity(${productId},'increase')">

                +

            </button>

        </div>
        `;

    })

    .catch(error=>{

        console.error(error);

    });

}



function updateQuantity(productId,action){

    fetch("UpdateCartServlet",{

        method:"POST",

        headers:{
            "Content-Type":"application/x-www-form-urlencoded"
        },

        body:
        "productId="+productId+
        "&action="+action

    })

    .then(response=>response.text())

    .then(quantity=>{

        quantity = quantity.trim();

        if(quantity==="0"){

            document.getElementById("cartArea"+productId).innerHTML =

            `
            <button
                type="button"
                class="cartButton"
                onclick="addToCart(${productId})">

                Add To Cart

            </button>
            `;

        }
        else{

            document.getElementById("qty"+productId).innerText = quantity;

        }

    })

    .catch(error=>{

        console.error(error);

    });

}

</script>

</body>

</html>



</body>
</html>
