<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.util.List"%>

<%
String type = (String) request.getAttribute("type");
List<String> subTypes = (List<String>) request.getAttribute("subTypes");
%>

<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title><%=type%></title>

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/loader.css">
<script src="${pageContext.request.contextPath}/js/loader.js"></script>

</head>

<body>

<div id="loader">
    <div class="spinner"></div>
</div>

	<h1><%=type%></h1>
	<h2>Select a Category</h2>
	<table border="1" cellpadding="10">
		<tr>
			<th>Sub Type</th>
		</tr>
		<%
		if (subTypes != null && !subTypes.isEmpty()) {
			for (String subType : subTypes) {
		%>
		<tr>
			<td>
				<form action="SubTypeServlet" method="get" onsubmit="showLoader()">
					<input type="hidden" name="type" value="<%=type%>"> <input
						type="hidden" name="subType" value="<%=subType%>">
					<button type="submit">   
						<%=subType%>
					</button>
				</form>
			</td>
		</tr>
		<%
		}
		} else {
		%>
		<tr>
			<td>No Sub Types Found</td>
		</tr>
		<%
}
%>
	</table>
	<br>
	<form action="HomeServlet" method="get" onsubmit="showLoader()">
		<button type="submit">Back</button>
	</form>
</body>
</html>