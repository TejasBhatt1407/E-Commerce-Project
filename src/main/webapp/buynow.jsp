<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.ecommerce.model.Cart"%>

<%
    List<Cart> cartItems = (List<Cart>) request.getAttribute("cartItems");
    Double totalObj = (Double) request.getAttribute("total");
    Integer totalItemsObj = (Integer) request.getAttribute("totalItems");
    
    double total = (totalObj != null) ? totalObj : 0.0;
    int totalItems = (totalItemsObj != null) ? totalItemsObj : 0;
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Checkout | BuyNow</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/loader.css">
    <script src="${pageContext.request.contextPath}/js/loader.js"></script>

<style>
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    font-family: Arial, Helvetica, sans-serif;
}

body {
    background: #f0f0f0;
    padding: 20px;
}

.container {
    max-width: 1100px;
    margin: 0 auto;
}

h1 {
    text-align: center;
    margin-bottom: 20px;
    font-size: 28px;
    font-weight: bold;
}

.checkout-layout {
    display: flex;
    gap: 25px;
    align-items: flex-start;
}

.address-box {
    flex: 1.8;
    background: #ffffff;
    padding: 30px;
    border-radius: 8px;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
}

.summary-box {
    flex: 1;
    background: #ffffff;
    padding: 25px;
    border-radius: 8px;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
}

h2 {
    font-size: 22px;
    font-weight: bold;
    margin-bottom: 20px;
}

label {
    display: block;
    margin-top: 15px;
    margin-bottom: 6px;
    font-size: 14px;
    font-weight: bold;
    color: #000;
}

input[type=text], 
input[type=number] {
    width: 100%;
    padding: 10px;
    border: 1px solid #ccc;
    border-radius: 4px;
    font-size: 14px;
    outline: none;
}

textarea {
    width: 100%;
    height: 120px;
    padding: 10px;
    border: 1px solid #ccc;
    border-radius: 4px;
    font-size: 14px;
    resize: none;
    outline: none;
}

.checkbox {
    margin-top: 25px;
    display: flex;
    align-items: center;
    gap: 8px;
    font-size: 14px;
}

.checkbox input {
    width: 14px;
    height: 14px;
    cursor: pointer;
}

.item {
    padding-bottom: 12px;
    margin-bottom: 15px;
    border-bottom: 1px solid #e0e0e0;
    font-size: 14px;
    line-height: 1.5;
}

.item-name {
    font-weight: bold;
    margin-bottom: 3px;
}

.total {
    margin-top: 15px;
    font-size: 16px;
    font-weight: bold;
    line-height: 1.8;
}

.place-btn {
    width: 100%;
    margin-top: 20px;
    padding: 12px;
    background: #28a745;
    color: white;
    border: none;
    border-radius: 5px;
    font-size: 15px;
    cursor: pointer;
}

.place-btn:hover {
    background: #218838;
}

.back-btn {
    display: inline-block;
    margin-top: 15px;
    padding: 10px 20px;
    font-size: 15px;
    text-decoration: none;
    color: #ffffff;
    background-color: #007bff;
    border-radius: 5px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    transition: background-color 0.2s ease;
}

.back-btn:hover {
    background-color: #0056b3;
}
</style>
</head>

<body>

    <div id="loader" style="display:none;">
        <div class="spinner"></div>
    </div>

    <div class="container">
        <div class="header-section">
        
            <h1>Checkout</h1>
            <div style="width: 100px;"></div> <!-- Spacer balance -->
                    <a href="HomeServlet" class="back-btn">Home</a>
            
        </div>

        <form action="PlaceOrderServlet" method="post" onsubmit="return showLoader();">
            <div class="checkout-layout">
                <input type="hidden" name="productId" value="${product.id}">
                <!-- Left Column: Shipping Address -->
                <div class="address-box">
                    <h2>Shipping Address</h2>

                    <div class="form-group">
                        <label for="fullName">Full Name</label>
                        <input type="text" id="fullName" name="fullName" maxlength="30" placeholder="John Doe" required>
                    </div>

                    <div class="form-group">
                        <label for="mobile">Mobile Number</label>
                        <input type="text" id="mobile" name="mobile" pattern="[0-9]{10}" maxlength="10" placeholder="10-digit number" required>
                    </div>

                    <div class="form-group">
                        <label for="address">Street Address</label>
                        <textarea id="address" name="address" maxlength="100" placeholder="House no., street name, area" required></textarea>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label for="city">City</label>
                            <input type="text" id="city" name="city" maxlength="15" required>
                        </div>
                        <div class="form-group">
                            <label for="state">State</label>
                            <input type="text" id="state" name="state" maxlength="15" required>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="pincode">Pincode</label>
                        <input type="number" id="pincode" name="pincode" maxlength="6" required>
                    </div>

                    <div class="checkbox-group">
                        <input type="checkbox" id="saveAddress" name="saveAddress" value="true">
                        <label for="saveAddress" style="display:inline; font-weight:normal; margin:0;">Save this address for future orders</label>
                    </div>
                    
                    
                </div>

                <!-- Right Column: Order Summary -->
                <div class="summary-box">
                    <h2>Order Summary</h2>

                    <div class="summary-details">
                        <div class="summary-row">
                            <span>Total Items</span>
                            <span><%= totalItems %></span>
                        </div>
                        <div class="summary-row">
                            <span>Subtotal</span>
                            <span>Rs <%= total %></span>
                        </div>
                        <div class="summary-row">
                            <span>Shipping</span>
                            <span style="color: #28a745;">FREE</span>
                        </div>
                        <div class="summary-row total">
                            <span>Grand Total</span>
                            <span>Rs <%= total %></span>
                        </div>
                    </div>

                    <button type="submit" class="place-btn">Place Order</button>
                </div>

            </div>
        </form>
    </div>

</body>
</html>