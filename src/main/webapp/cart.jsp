<%@page import="java.util.List"%>
<%@page import="com.ecommerce.model.Cart"%>
<%
List<Cart> cartItems = (List<Cart>) request.getAttribute("cartItems");
double total = (Double) request.getAttribute("total");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Cart | T-Commerce</title>
<style>
    :root {
        --primary: #2563eb;
        --primary-hover: #1d4ed8;
        --danger: #dc2626;
        --danger-hover: #b91c1c;
        --bg: #f8fafc;
        --card-bg: #ffffff;
        --text-main: #1e293b;
        --text-muted: #64748b;
        --border: #e2e8f0;
    }

    body {
        font-family: 'Segoe UI', system-ui, -apple-system, sans-serif;
        background-color: var(--bg);
        color: var(--text-main);
        margin: 0;
        padding: 40px 20px;
    }

    .cart-wrapper {
        max-width: 1200px;
        margin: 0 auto;
        padding: 0 20px;
    }
    
     .cart-header {
    display: flex;
    justify-content: space-between; 
    align-items: flex-end; /* Aligns the bottom of the button with the bottom of the "My Cart" text */
    width: 100%;
    margin-bottom: 25px; /* Space between text and the line */
    border-bottom: 2px solid #e5e7eb; 
    padding-bottom: 12px;
}

.cart-header h1 {
    margin: 0;
    padding: 0;
    border-bottom: none !important; 
}
    
    .back-btn{
    display: inline-block;
    text-decoration: none;
    background-color: #2563eb; 
    color: white;
    padding: 8px 16px;
    border-radius: 6px;
    font-weight: 500;
    
    position: static; 
    transform: none;
    margin: 0;
}

.back-btn:hover{
    background:#1f4fc4;
}
    
    

    h1 {
        font-size: 2rem;
        margin-bottom: 30px;
        color: var(--text-main);
        border-bottom: 2px solid var(--border);
        padding-bottom: 15px;
    }

    /* Main layout grid to prevent empty layout syndrome */
    .cart-layout {
        display: grid;
        grid-template-columns: 1fr;
        gap: 30px;
        align-items: flex-start;
    }

    @media (min-width: 992px) {
        .cart-layout {
            grid-template-columns: 2fr 1fr;
        }
    }

    .cartContainer {
        display: flex;
        flex-direction: column;
        gap: 20px;
    }

    /* Redesigned card structure for a sleek horizontal look */
    .cartCard {
        background: var(--card-bg);
        border-radius: 12px;
        padding: 24px;
        box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05), 0 2px 4px -1px rgba(0, 0, 0, 0.03);
        border: 1px solid var(--border);
        display: flex;
        flex-direction: column;
        gap: 20px;
    }

    @media (min-width: 576px) {
        .cartCard {
            flex-direction: row;
            align-items: center;
            justify-content: space-between;
        }
    }

    .product-details {
        flex: 1;
    }

    .cartCard h2 {
        margin: 0 0 8px 0;
        font-size: 1.25rem;
    }

    .cartCard a {
        text-decoration: none;
        color: var(--primary);
        transition: color 0.2s;
    }

    .cartCard a:hover {
        color: var(--primary-hover);
        text-decoration: underline;
    }

    .price-info {
        display: flex;
        gap: 20px;
        color: var(--text-muted);
        font-size: 0.95rem;
    }

    .price-info b {
        color: var(--text-main);
    }

    /* Controls Grouped Together */
    .cart-actions {
        display: flex;
        align-items: center;
        gap: 20px;
        flex-wrap: wrap;
    }

    .quantitySelector {
        display: flex;
        align-items: center;
        background: var(--bg);
        border: 1px solid var(--border);
        border-radius: 8px;
        padding: 4px;
    }

    .quantitySelector form {
        display: inline;
        margin: 0;
    }

    .qtyBtn {
        width: 32px;
        height: 32px;
        border: none;
        border-radius: 6px;
        background: transparent;
        color: var(--text-main);
        font-size: 18px;
        font-weight: 600;
        cursor: pointer;
        transition: background 0.2s;
    }

    .qtyBtn:hover {
        background: var(--border);
    }

    .quantitySelector span {
        font-size: 16px;
        font-weight: 600;
        min-width: 40px;
        text-align: center;
        display: inline-block;
    }

    .removeButton {
        padding: 10px 16px;
        background: transparent;
        color: var(--danger);
        border: 1px solid var(--border);
        border-radius: 8px;
        cursor: pointer;
        font-weight: 500;
        transition: all 0.2s;
    }

    .removeButton:hover {
        background: #fef2f2;
        border-color: var(--danger);
    }

    /* Sidebar Summary Panel */
    .cartSummary {
        background: var(--card-bg);
        border-radius: 12px;
        padding: 30px;
        box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05);
        border: 1px solid var(--border);
        position: sticky;
        top: 40px;
    }

    .cartSummary h2 {
        margin: 0 0 25px 0;
        font-size: 1.5rem;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .grand-total-amount {
        color: var(--primary);
    }

    .checkoutButton {
        width: 100%;
        padding: 14px;
        background: var(--primary);
        color: white;
        border: none;
        border-radius: 8px;
        cursor: pointer;
        font-size: 16px;
        font-weight: 600;
        transition: background 0.2s;
    }

    .checkoutButton:hover {
        background: var(--primary-hover);
    }

    .empty-state {
        text-align: center;
        padding: 60px 20px;
        background: var(--card-bg);
        border-radius: 12px;
        border: 1px dashed var(--border);
        grid-column: 1 / -1;
    }
    
    .empty-state h2 {
        color: var(--text-muted);
        font-weight: 500;
        margin: 0;
    }
    
   
    
</style>
</head>
<body>

	<div class="cart-wrapper">
		<div class="cart-header">
        <h1>My Cart</h1>
        
        <a href="HomeServlet"
		
		 class="back-btn">
             Return to Products		</a>
    </div>
    
		<div class="cart-layout">
			
			<div class="cartContainer">
				<%
				if (cartItems != null && !cartItems.isEmpty()) {
					for (Cart cart : cartItems) {
				%>
				<div class="cartCard">
					
					<div class="product-details">
						<h2>
							<a href="ProductServlet?id=<%=cart.getProduct().getId()%>"> 
								<%=cart.getProduct().getName()%>
							</a>
						</h2>
						<div class="price-info">
							<p><b>Price:</b> Rs <%=cart.getProduct().getPrice()%></p>
							<p><b>Subtotal:</b> Rs <%=cart.getQuantity() * cart.getProduct().getPrice()%></p>
						</div>
					</div>

					<div class="cart-actions">
						<div class="quantitySelector">
							<form action="UpdateCartServlet" method="post">
								<input type="hidden" name="source" value="cart"> 
								<input type="hidden" name="productId" value="<%=cart.getProduct().getId()%>"> 
								<input type="hidden" name="action" value="decrease">
								<button class="qtyBtn">-</button>
							</form>

							<span><%=cart.getQuantity()%></span>

							<form action="UpdateCartServlet" method="post">
								<input type="hidden" name="source" value="cart"> 
								<input type="hidden" name="productId" value="<%=cart.getProduct().getId()%>"> 
								<input type="hidden" name="action" value="increase">
								<button class="qtyBtn">+</button>
							</form>
						</div>

						<form action="UpdateCartServlet" method="post">
							<input type="hidden" name="source" value="cart"> 
							<input type="hidden" name="productId" value="<%=cart.getProduct().getId()%>"> 
							<input type="hidden" name="action" value="remove">
							<button class="removeButton">Remove</button>
						</form>
					</div>

				</div>
				<%
					}
				} else {
				%>
				<div class="empty-state">
					<h2>Your cart is currently empty.</h2>
				</div>
				<%
				}
				%>
			</div>

			<% if (cartItems != null && !cartItems.isEmpty()) { %>
			<div class="cartSummary">

				<h2>
					<span>Total:</span>
					<span class="grand-total-amount">Rs <%=total%></span>
				</h2>
				<form action="CheckoutServlet" method="post">
					<button class="checkoutButton">Proceed To Checkout</button>
				</form>
			</div>
			<% } %>

		</div>
	</div>

</body>
</html>