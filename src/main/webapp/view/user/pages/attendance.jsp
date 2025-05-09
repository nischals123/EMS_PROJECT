<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
    if (session.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Attendance</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            padding: 30px;
            background-color: #f9f9f9;
        }
        .card {
            max-width: 400px;
            margin: auto;
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px #ccc;
        }
        button {
            padding: 10px 20px;
            background: #28a745;
            border: none;
            color: white;
            border-radius: 5px;
            cursor: pointer;
        }
        input[type="date"] {
            padding: 8px;
            width: 100%;
            margin: 10px 0;
        }
    </style>
</head>
<body>

<div class="card">
    <h2>Check In Attendance</h2>
    <form action="${pageContext.request.contextPath}/attendance" method="post">
        <input type="hidden" name="action" value="markCheckedIn" />
        <label for="date">Date</label>
        <input type="date" name="attendanceDate" id="date" required value="<%= java.time.LocalDate.now() %>"/>

        <button type="submit">✅ Check In</button>
    </form>
</div>

<!-- SweetAlert2 -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<c:if test="${not empty sessionScope.message}">
    <script>
        Swal.fire({
            icon: 'info',
            title: 'Attendance',
            text: '${sessionScope.message}'
        });
    </script>
    <c:remove var="message" scope="session" />
</c:if>

</body>
</html>
