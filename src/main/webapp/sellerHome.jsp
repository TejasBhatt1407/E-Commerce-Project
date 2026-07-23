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
            </tr>
            <% if (!sales.isEmpty()) { 
                for (SellerProductSales sale : sales) { %>
                    <tr>
                        <td><%= sale.getProductName() %></td>
                        <td><%= sale.getStockLeft() %></td>
                        <td><%= sale.getSoldQuantity() %></td>
                        <td>₹<%= sale.getTotalSales() %></td>
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
        
        <!-- Note: Because enctype is multipart/form-data, standard request.getParameter("action") in Servlet will return NULL 
             UNLESS your Servlet is annotated with @MultipartConfig -->
        <form action="/SellerHomeServlet" method="post" enctype="multipart/form-data">
            <input type="hidden" name="action" value="addProduct">

            <div class="formGrid">

                <div class="formGroup">
                    <label>Product Name</label>
                    <input type="text" name="name" required>
                </div>

                <div class="formGroup">
                    <label>Product Type</label>
                    <select name="type" id="productType" onchange="updateSubTypes()" required>
                        <option value="">Select Type</option>
                        <% for (String type : types) { %>
                            <option value="<%= type %>"><%= type %></option>
                        <% } %>
                    </select>
                </div>

                <div class="formGroup">
                    <label>Product Sub Type</label>
                    <select name="subType" id="productSubType" required disabled>
                        <option value="">Select Sub Type</option>
                    </select>
                </div>

                <div class="formGroup">
                    <label>Price (Rs)</label>
                    <input type="number" name="price" min="0" step="1" required>
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
                    <textarea rows="3" name="description" required></textarea>
                </div>

                <div class="formGroup fullWidth">
                    <label>Long Description</label>
                    <textarea rows="6" name="longDescription" required></textarea>
                </div>

                <div class="fullWidth">
                    <button class="addBtn" type="submit">Add Product</button>
                </div>

            </div>
        </form>
    </div>
</div>

<script>
  // Ensure this mapping aligns with whatever dynamic "types" the Servlet is passing, 
  // otherwise selecting a dynamic type not in this list will fail to generate sub-types.
  const subTypeMapping = {
    "Electronics": ["Mobiles", "Laptops", "Accessories"],
    "Clothing": ["Men's Wear", "Women's Wear", "Kids"],
    "Home Goods": ["Furniture", "Decor", "Kitchen"]
  };

  function updateSubTypes() {
    const typeSelect = document.getElementById("productType");
    const subTypeSelect = document.getElementById("productSubType");
    const selectedType = typeSelect.value;

    // Reset sub-types
    subTypeSelect.innerHTML = '<option value="">Select Sub Type</option>';

    if (selectedType && subTypeMapping[selectedType]) {
      subTypeSelect.disabled = false;
      subTypeMapping[selectedType].forEach(function(subType) {
        const option = document.createElement("option");
        option.value = subType;
        option.textContent = subType;
        subTypeSelect.appendChild(option);
      });
    } else {
      subTypeSelect.disabled = true;
    }
  }
</script>

</body>
</html>