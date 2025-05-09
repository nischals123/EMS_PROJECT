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
<meta name="viewport" content="width=device-width, initial-scale =1.0" />
<title>View Employee - Employee Management System</title>
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
				<h2>Employee Details</h2>
				<div class="employee-details">
					<p>
						<strong>Name:</strong> ${fn:escapeXml(employee.name)}
					</p>
					<p>
						<strong>Email:</strong> ${fn:escapeXml(employee.email)}
					</p>
					<p>
						<strong>Phone:</strong> ${fn:escapeXml(employee.phone)}
					</p>
					<p>
						<strong>Picture Path:</strong>
						${fn:escapeXml(employee.picturePath)}
					</p>
					<p>
						<strong>Role:</strong> ${employee.role == 1 ? 'Admin' : 'Employee'}
					</p>
					<p>
						<strong>Status:</strong> ${employee.active ? 'Active' : 'Inactive'}
					</p>
					<p>
						<strong>Department:</strong>
						${fn:escapeXml(employee.department.name)}
					</p>
					<p>
						<strong>Hire Date:</strong> ${employee.hireDate}
					</p>
					<p>
						<strong>Created At:</strong> ${employee.createdAt}
					</p>
				</div>
				<a href="${pageContext.request.contextPath}/employee"
					class="back-btn">Back to List</a>
			</div>
		</main>
	</div>
</body>
</html>
