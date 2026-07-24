<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, java.util.ArrayList" %>
<%@ page import="com.ecommerce.model.Product, com.ecommerce.model.SellerDashboard, com.ecommerce.model.SellerProductSales" %>



<%
    // Safely retrieve and cast attributes, providing defaults to avoid NullPointerExceptions at runtime
    List<Product> products = (List<Product>) request.getAttribute("products");
    if (products == null) products = new ArrayList<>();

    String sellerName = (String) session.getAttribute("loggedInSellerName");
    if (sellerName == null || sellerName.trim().isEmpty()) sellerName = "Seller";

    SellerDashboard dashboard = (SellerDashboard) request.getAttribute("dashboard");

    List<SellerProductSales> sales = (List<SellerProductSales>) request.getAttribute("sales");
    if (sales == null) sales = new ArrayList<>();

    List<String> types = (List<String>) request.getAttribute("types");
    if (types == null) types = new ArrayList<>();
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Seller Dashboard</title>

<style>
/* CSS remains unchanged for safety, minor formatting applied */
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    font-family: Arial, sans-serif;
}

body {
    background: #f4f6f9;
}

.header {
    background: white;
    padding: 25px;
    text-align: center;
    box-shadow: 0 2px 8px rgba(0,0,0,.1);
}

.header h1 {
    color: #2563eb;
}

.navbar {
    background: #2563eb;
    display: flex;
    justify-content: center;
    gap: 40px;
    padding: 15px;
}

.navbar a {
    color: white;
    text-decoration: none;
    font-weight: bold;
}

.navbar a:hover {
    color: #ffd54f;
}

.container {
    width: 90%;
    margin: 30px auto;
}

.section {
    background: white;
    padding: 25px;
    border-radius: 10px;
    box-shadow: 0 2px 8px rgba(0,0,0,.1);
    margin-bottom: 30px;
}

.section h2 {
    margin-bottom: 20px;
    color: #2563eb;
}

.formGrid {
    display: grid;
    grid-template-columns: repeat(2, 1fr);
    gap: 20px;
}

.formGroup {
    display: flex;
    flex-direction: column;
}

.formGroup label {
    font-weight: bold;
    margin-bottom: 6px;
}

.formGroup input,
.formGroup select,
.formGroup textarea {
    padding: 10px;
    border: 1px solid #ccc;
    border-radius: 6px;
    font-size: 15px;
}

.formGroup textarea {
    resize: vertical;
}

.fullWidth {
    grid-column: 1/3;
}

.addBtn {
    padding: 12px 30px;
    background: #2563eb;
    color: white;
    border: none;
    border-radius: 6px;
    font-size: 16px;
    cursor: pointer;
}

.addBtn:hover {
    background: #1d4ed8;
}

.dashboardCards {
    display: flex;
    gap: 20px;
    margin-bottom: 30px;
    flex-wrap: wrap; /* Allows cards to wrap on smaller screens */
}

.dashboardCard {
    flex: 1;
    min-width: 200px;
    background: white;
    padding: 25px;
    border-radius: 10px;
    box-shadow: 0 2px 8px rgba(0,0,0,.1);
    text-align: center;
}

.dashboardCard h3 {
    color: #666;
    margin-bottom: 10px;
}

.dashboardCard h1 {
    color: #2563eb;
}

.salesTable {
    width: 100%;
    border-collapse: collapse;
}

.salesTable th,
.salesTable td {
    padding: 14px;
    border-bottom: 1px solid #ddd;
    text-align: center;
}

.salesTable th {
    background: #2563eb;
    color: white;
}

.salesTable tr:hover {
    background: #f5f5f5;
}
</style>
</head>

<body>

<div class="header">
    <h1>Welcome, <%= sellerName %></h1>
</div>

<div class="navbar">
    <a href="policy.jsp">Policy</a>
    <a href="T&C.jsp">T&C*</a>
    <a href="#">Platform Fee</a>
    <a href="#addProduct">Add Product</a>
    <a href="#">Profile</a>
    <a href="LogoutServlet">Logout</a>
</div>

<div class="container">

    <!-- ================= DASHBOARD SUMMARY ================= -->
    <div class="dashboardCards">
        <div class="dashboardCard">
            <h3>Products Added</h3>
            <h1><%= (dashboard != null) ? dashboard.getTotalProducts() : "0" %></h1>
        </div>

        <div class="dashboardCard">
            <h3>Units Sold</h3>
            <h1><%= (dashboard != null) ? dashboard.getTotalUnitsSold() : "0" %></h1>
        </div>

        <div class="dashboardCard">
            <h3>Total Revenue</h3>
            <h1>₹<%= (dashboard != null) ? dashboard.getTotalRevenue() : "0.00" %></h1>
        </div>
    </div>
    
    <!-- ================= PRODUCT SALES ================= -->
    <div class="section">
        <h2>Products Sales</h2>
        <table class="salesTable">
            <tr>
                <th>Product</th>
                <th>Stock Left</th>
                <th>Units Sold</th>
                <th>Total Revenue</th>
                <th>Actions</th>
            </tr>
            <% if (!sales.isEmpty()) { 
                for (SellerProductSales sale : sales) { %>
                    <tr id="row-<%= sale.getProductId() %>">
                        <td><%= sale.getProductName() %></td>
                        <td id="stock-<%= sale.getProductId() %>"><%= sale.getStockLeft() %></td>
                        <td><%= sale.getSoldQuantity() %></td>
                        <td>₹<%= sale.getTotalSales() %></td>
                        
                        <td>
                        
                        
    <!-- Form to Add Stock -->
    <div style="display:inline-block; margin-right: 10px;">
            <input type="number" id="qtyToAdd-<%= sale.getProductId() %>" min="1" style="width: 70px;" placeholder="+ Qty">
            <button type="button" class="btn btn-sm btn-success" onclick="addStockViaAjax(<%= sale.getProductId() %>, this)">Add</button>
        </div>
        
        <button type="button" class="btn btn-sm btn-danger" onclick="removeProductViaAjax(<%= sale.getProductId() %>, this)">Remove</button>
        
</td>
                        
                    </tr>
                <% } 
            } else { %>
                <tr>
                    <td colspan="4">No sales records found.</td>
                </tr>
            <% } %>
        </table>
    </div>

   <!-- ================= ADD PRODUCT FORM ================= -->
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
                <select name="type" id="productType" required>
                    <option value="">Select Type</option>
                    <% for (String type : types) { %>
                        <option value="<%= type %>"><%= type %></option>
                    <% } %>
                </select>
            </div>

            <!-- Changed from disabled <select> to standard <input> -->
            <div class="formGroup">
                <label>Product Sub Type</label>
                <input type="text" name="subType" placeholder="e.g. Mobiles, Laptops..." required>
            </div>

            <div class="formGroup">
                <label>Price (Rs)</label>
                <input type="number" name="price" min="0" step="0.01" required>
            </div>

            <div class="formGroup">
                <label>Quantity</label>
                <input type="number" name="quantity" min="1" required>
            </div>

            <div class="formGroup">
                <label>Image</label>
                <input type="file" name="image" accept="image/*" required>
            </div>

            <div class="formGroup fullWidth">
                <label>Short Description</label>
                <textarea rows="3" name="description" ></textarea>
            </div>

            <div class="formGroup fullWidth">
                <label>Long Description</label>
                <textarea rows="6" name="longDescription" ></textarea>
            </div>

            <div class="fullWidth">
                <button class="addBtn" type="submit">Add Product</button>
            </div>

        </div>
    </form>
</div>
</div>


<script>
    function addStockViaAjax(productId, buttonElement) {
        const qtyInput = document.getElementById('qtyToAdd-' + productId);
        const qtyToAdd = parseInt(qtyInput.value);

        if (!qtyToAdd || qtyToAdd < 1) {
            alert("Please enter a valid quantity.");
            return;
        }

        // Disable button while processing to prevent double-clicks
        buttonElement.disabled = true;
        buttonElement.innerText = "...";

        // Prepare data to send to Servlet
        const params = new URLSearchParams();
        params.append('action', 'addStock');
        params.append('productId', productId);
        params.append('quantityToAdd', qtyToAdd);

        // Send AJAX request
        fetch('SellerHomeServlet', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            body: params.toString()
        })
        .then(response => {
            if (response.ok) {
                // Instantly update the stock number on the screen
                const stockCell = document.getElementById('stock-' + productId);
                const currentStock = parseInt(stockCell.innerText);
                stockCell.innerText = currentStock + qtyToAdd;
                
                // Clear the input field
                qtyInput.value = '';
            } else {
                alert("Failed to update stock. Please try again.");
            }
        })
        .catch(error => console.error('Error:', error))
        .finally(() => {
            // Re-enable button
            buttonElement.disabled = false;
            buttonElement.innerText = "Add";
        });
    }

    function removeProductViaAjax(productId, buttonElement) {
        if (!confirm('Are you sure you want to remove this product? It will be marked as out of stock.')) {
            return;
        }

        buttonElement.disabled = true;
        buttonElement.innerText = "...";

        const params = new URLSearchParams();
        params.append('action', 'removeProduct');
        params.append('productId', productId);

        fetch('SellerHomeServlet', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            body: params.toString()
        })
        .then(response => {
            if (response.ok) {
                // Instantly update the stock to 0 on the screen
                document.getElementById('stock-' + productId).innerText = '0';
            } else {
                alert("Failed to remove product.");
            }
        })
        .catch(error => console.error('Error:', error))
        .finally(() => {
            buttonElement.disabled = false;
            buttonElement.innerText = "Remove";
        });
    }
</script>

</body>
</html>