<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
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
<title>Employees - Employee Management System</title>

<!-- External CSS -->
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

			<!-- Employees Content -->
			<div class="dashboard-content">
				<!-- Filters and Search -->
				<form action="${pageContext.request.contextPath}/employee"
					method="get" class="employee-filters">
					<div class="search-box">
						<i class="fas fa-search"></i> <input type="text" name="search"
							placeholder="Search employees..." value="${param.search}" />
					</div>

					<div class="filter-options">
						<select name="department">
							<option value="">All Departments</option>
							<c:forEach var="dept" items="${departments}">
								<option value="${dept.id}"
									${param.department == dept.id ? 'selected' : ''}>${fn:escapeXml(dept.name)}</option>
							</c:forEach>
						</select> <select name="role">
							<option value="">All Roles</option>
							<option value="0" ${param.role == '0' ? 'selected' : ''}>Employee</option>
						</select> <select name="status">
							<option value="">All Status</option>
							<option value="active"
								${param.status == 'active' ? 'selected' : ''}>Active</option>
							<option value="inactive"
								${param.status == 'inactive' ? 'selected' : ''}>Inactive</option>
						</select>
					</div>

					<button type="submit" class="filter-btn">Apply Filters</button>
					<a href="${pageContext.request.contextPath}/employee?action=add"
						class="add-employee-btn"> <i class="fas fa-plus"></i> Add
						Employee
					</a>
				</form>

				<!-- Employees Table -->
				<table class="employees-table">
					<thead>
						<tr>
							<th>Employee</th>
							<th>Department</th>
							<th>Role</th>
							<th>Email</th>
							<th>Phone</th>
							<th>Status</th>
							<th>Actions</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="employee" items="${employeeList}">
							<tr>
								<td data-label="Employee" class="employee-name"><span>${fn:escapeXml(employee.name)}</span></td>
								<td data-label="Department">${fn:escapeXml(employee.department.name)}</td>
								<td data-label="Role">${employee.role == 1 ? 'Admin' : 'Employee'}</td>
								<td data-label="Email">${fn:escapeXml(employee.email)}</td>
								<td data-label="Phone">${fn:escapeXml(employee.phone)}</td>
								<td data-label="Status"><span
									class="${employee.active ? 'status-active' : 'status-inactive'}">
										${employee.active ? 'Active' : 'Inactive'} </span> </ td>
								<td data-label="Actions"><a
									href="${pageContext.request.contextPath}/employee?action=view&id=${employee.id}"
									class="action-btn view"><i class="fas fa-eye"></i></a> <a
									href="${pageContext.request.contextPath}/employee?action=edit&id=${employee.id}"
									class="action-btn edit"><i class="fas fa-edit"></i></a> <a
									href="${pageContext.request.contextPath}/employee?action=delete&id=${employee.id}"
									class="action-btn delete"
									onclick="return confirm('Are you sure you want to delete ${fn:escapeXml(employee.name)}?')"><i
										class="fas fa-trash-alt"></i></a></td>
							</tr>
						</c:forEach>
						<c:if test="${empty employeeList}">
							<tr>
								<td colspan="7">No employees found.</td>
							</tr>
						</c:if>
					</tbody>
				</table>

				<!-- Pagination -->
				<div class="pagination">
					<c:if test="${currentPage > 1}">
						<a
							href="${pageContext.request.contextPath}/employee?page=${currentPage - 1}&search=${param.search}&department=${param.department}&role=${param.role}&status=${param.status}"
							class="pagination-btn"><i class="fas fa-chevron-left"></i></a>
					</c:if>
					<c:if test="${currentPage <= 1}">
						<div class="pagination-btn disabled">
							<i class="fas fa-chevron-left"></i>
						</div>
					</c:if>

					<c:forEach begin="1" end="${totalPages}" var="i">
						<a
							href="${pageContext.request.contextPath}/employee?page=${i}&search=${param.search}&department=${param.department}&role=${param.role}&status=${param.status}"
							class="pagination-btn ${currentPage == i ? 'active' : ''}">${i}</a>
					</c:forEach>

					<c:if test="${currentPage < totalPages}">
						<a
							href="${pageContext.request.contextPath}/employee?page=${currentPage + 1}&search=${param.search}&department=${param.department}&role=${param.role}&status=${param.status}"
							class="pagination-btn"><i class="fas fa-chevron-right"></i></a>
					</c:if>
					<c:if test="${currentPage >= totalPages}">
						<div class="pagination-btn disabled">
							<i class="fas fa-chevron-right"></i>
						</div>
					</c:if>
				</div>
			</div>
		</main>
	</div>

	<script>
		document.addEventListener('DOMContentLoaded', function() {
			const dateElement = document.getElementById('current-date');
			if (dateElement) {
				const options = {
					weekday : 'long',
					year : 'numeric',
					month : 'long',
					day : 'numeric'
				};
				const today = new Date();
				dateElement.textContent = today.toLocaleDateString('en-US',
						options);
			}
		});
	</script>
</body>
</html>