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
</head>
<body class="dashboard-body">
	<div class="dashboard-container">
		<%@ include file="includes/sidebar.jsp"%>
		<main class="main-content">
			<%@ include file="includes/topnav.jsp"%>
			<div class="dashboard-content">
				<h2>Add New Employee</h2>
				<form action="${pageContext.request.contextPath}/employee"
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
					<a href="${pageContext.request.contextPath}/employee"
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