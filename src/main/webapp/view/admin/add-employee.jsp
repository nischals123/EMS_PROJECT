<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page isELIgnored="false"%>

<%-- Server-side Session Check --%>
<%
if (session.getAttribute("user") == null) {
	response.sendRedirect(request.getContextPath() + "/view/login.jsp");
	return;
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Add Employee - Employee Management System</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/style.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/dashboard.css" />
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" />


<style>
.dashboard-content {
	background: #f8f9fc;
	padding: 40px;
	border-radius: 12px;
	margin-top: 20px;
}

h2 {
	font-size: 26px;
	font-weight: 600;
	margin-bottom: 30px;
	color: #333;
	text-align: center;
}

.employee-form {
	display: flex;
	flex-wrap: wrap;
	gap: 40px;
	justify-content: space-between;
}

.left-form-section, .right-form-section {
	flex: 1 1 45%;
}

.form-group {
	margin-bottom: 20px;
}

label {
	display: block;
	font-weight: 500;
	margin-bottom: 6px;
	font-size: 15px;
	color: #333;
}

input[type="text"], input[type="email"], input[type="password"], input[type="date"],
	select {
	width: 100%;
	padding: 10px 14px;
	font-size: 14px;
	border: 1px solid #ddd;
	border-radius: 6px;
	background-color: #f5f6fa;
	transition: border-color 0.3s ease;
}

input[type="text"]:focus, input[type="email"]:focus, input[type="password"]:focus,
	input[type="date"]:focus, select:focus {
	border-color: #5b9bd5;
	background-color: #fff;
	outline: none;
}

.file-upload label {
	display: flex;
	align-items: center;
	gap: 8px;
}

.file-upload input[type="file"] {
	width: 100%;
	padding: 8px;
	margin-top: 6px;
	background: #fff;
	border: 1px solid #ccc;
	border-radius: 6px;
}

.file-upload-info {
	font-size: 12px;
	color: #888;
	margin-top: 4px;
}

.button-group {
	margin-top: 30px;
	display: flex;
	gap: 12px;
	justify-content: flex-start;
}

.submit-btn, .cancel-btn {
	padding: 10px 18px;
	font-size: 14px;
	border-radius: 8px;
	font-weight: 500;
	border: none;
	cursor: pointer;
	transition: background-color 0.3s ease;
}

.submit-btn {
	background-color: #28a745;
	color: white;
}

.submit-btn:hover {
	background-color: #218838;
}

.cancel-btn {
	background-color: #dc3545;
	color: white;
	text-decoration: none;
	line-height: 28px;
}

.cancel-btn:hover {
	background-color: #c82333;
}

.error-message {
	background-color: #ffe0e0;
	padding: 12px;
	border-radius: 6px;
	color: #c0392b;
	font-weight: 500;
	margin-top: 20px;
}
</style>
</head>
<body class="dashboard-body">
	<div class="dashboard-container">
		<%@ include file="includes/sidebar.jsp"%>
		<main class="main-content">
			<%@ include file="includes/topnav.jsp"%>
			<div class="dashboard-content">
				<h2>Add New Employee</h2>
				<form action="${pageContext.request.contextPath}/employees"
					method="post" class="employee-form">
					<input type="hidden" name="action" value="add" />
					<div class="form-group">
						<label for="name">Name :</label> <input type="text" id="name"
							name="name" required />
					</div>
					<div class="form-group">
						<label for="email">Email:</label> <input type="email" id="email"
							name="email" required />
					</div>
					<div class="form-group">
						<label for="password">Password:</label> <input type="password"
							id="password" name="password" required />
					</div>
					<div class="form-group">
						<label for="phone">Phone:</label> <input type="text" id="phone"
							name="phone" />
					</div>
					<div class="form-group">
						<label for="picturePath">Picture Path:</label> <input type="text"
							id="picturePath" name="picturePath" />
					</div>
					<div class="form-group">
						<label for="role">Role:</label> <select id="role" name="role"
							required>
							<option value="0">Employee</option>
							<option value="1">Admin</option>
						</select>
					</div>
					<div class="form-group">
						<label for="isActive">Status:</label> <select id="isActive"
							name="isActive" required>
							<option value="true">Active</option>
							<option value="false">Inactive</option>
						</select>
					</div>
					<div class="form-group">
						<label for="departmentId">Department:</label> <select
							id="departmentId" name="departmentId" required>
							<c:forEach var="dept" items="${departments}">
								<option value="${dept.id}">${fn:escapeXml(dept.name)}</option>
							</c:forEach>
						</select>
					</div>
					<div class="form-group">
						<label for="hireDate">Hire Date:</label> <input type="date"
							id="hireDate" name="hireDate" required />
					</div>
					<button type="submit" class="submit-btn">Add Employee</button>
					<a href="${pageContext.request.contextPath}/employees"
						class="cancel-btn">Cancel</a>
				</form>
				<c:if test="${param.error == 'failed'}">
					<p class="error-message">Failed to add employee. Please try
						again.</p>
				</c:if>
			</div>
		</main>
	</div>
</body>
</html>