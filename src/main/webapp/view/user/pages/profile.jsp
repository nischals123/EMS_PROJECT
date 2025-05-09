<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
    <title>My Profile</title>
    <style>
        .profile-section {
            background: #fff;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.08);
        }

        .profile-title {
            margin-bottom: 20px;
            color: #333;
            font-size: 24px;
        }

        .profile-container {
            display: flex;
            gap: 30px;
            flex-wrap: wrap;
            margin-top: 20px;
        }

        .profile-pic {
            flex: 0 0 200px;
            text-align: center;
        }

        .profile-pic img {
            width: 150px;
            height: 150px;
            object-fit: cover;
            border-radius: 50%;
            border: 3px solid #ccc;
        }

        .profile-info {
            flex: 1;
        }

        .form-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
        }

        .form-group {
            display: flex;
            flex-direction: column;
        }

        .form-group label {
            font-weight: 500;
            margin-bottom: 5px;
        }

        .form-group input {
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 8px;
        }

        .full-width {
            grid-column: 1 / -1;
        }

        .btn {
            padding: 10px 20px;
            background: #007bff;
            color: #fff;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            cursor: pointer;
            transition: background 0.3s ease;
        }

        .btn:hover {
            background: #0056b3;
        }

        .message {
            margin: 10px 0;
            padding: 10px;
            border-radius: 8px;
        }

        .success {
            background: #d4edda;
            color: #155724;
        }

        .error {
            background: #f8d7da;
            color: #721c24;
        }
    </style>
</head>
<body>
<section class="content-card">
    <section class="profile-section">
        <h2 class="profile-title"><i class="fas fa-user"></i> My Profile</h2>

        <!-- Display success or error messages -->
        <c:if test="${not empty successMessage}">
            <div class="message success">${fn:escapeXml(successMessage)}</div>
        </c:if>
        <c:if test="${not empty errorMessage}">
            <div class="message error">${fn:escapeXml(errorMessage)}</div>
        </c:if>

        <div class="profile-container">
            <!-- Profile Picture -->
            <div class="profile-pic">
                <img id="profilePic" 
                     src="${empty employee.picturePath ? 'https://randomuser.me/api/portraits/men/75.jpg' : fn:escapeXml(employee.picturePath)}" 
                     alt="Profile Picture" />
            </div>

            <!-- Profile Info Grid -->
            <div class="profile-info">
                <div class="form-grid">
                    <div class="form-group">
                        <label>Name</label>
                        <input type="text" id="name" value="${sessionScope.user.name}" required disabled />
                    </div>
                    <div class="form-group">
                        <label>Email</label>
                        <input type="email" id="email" value="${sessionScope.user.email}" disabled />
                    </div>
                    <div class="form-group">
                        <label>Phone</label>
                        <input type="text" id="phone" value="${sessionScope.user.phone}" disabled />
                    </div>
                    <div class="form-group">
                        <label>Joining Date</label>
                        <input type="text" id="hireDate" value="<fmt:formatDate value='${sessionScope.user.hireDate}' pattern='yyyy-MM-dd'/>" disabled />
                    </div>
                    <div class="form-group">
                        <label>Department</label>
                        <input type="text" id="department" value="${sessionScope.user.department.name}" disabled />
                    </div>
                    <div class="form-group">
                        <label>Role</label>
                        <input type="text" id="role" value="${fn:escapeXml(employee.roleName != null ? employee.roleName : (employee.role == 1 ? 'Admin' : 'User'))}" disabled />
                    </div>
                    <div class="form-group">
                        <label>Basic Salary</label>
                        <input type="text" id="salary" value="Rs. ${employee.salary != null ? employee.salary : '0.00'}" disabled />
                    </div>
                    <div class="form-group">
                        <label>Employment Status</label>
                        <input type="text" id="isActive" value="${sessionScope.user.active ? 'Active' : 'Inactive'}" disabled />
                    </div>
                </div>
            </div>
        </div>

        <!-- Change Password Section -->
        <h3 class="profile-title" style="margin-top: 40px;"><i class="fas fa-key"></i> Change Password</h3>
        <form class="profile-container" action="${pageContext.request.contextPath}/user/profile" method="post" style="margin-top: 20px;">
            <div class="form-grid">
                <div class="form-group">
                    <label for="currentPassword">Current Password</label>
                    <input type="password" id="currentPassword" name="currentPassword" required />
                </div>
                <div class="form-group">
                    <label for="newPassword">New Password</label>
                    <input type="password" id="newPassword" name="newPassword" required />
                </div>
                <div class="form-group">
                    <label for="confirmPassword">Confirm New Password</label>
                    <input type="password" id="confirmPassword" name="confirmPassword" required />
                </div>
            </div>
            <div style="margin-top: 20px;">
                <button type="submit" class="btn">
                    <i class="fas fa-save"></i> Update Password
                </button>
            </div>
        </form>
    </section>
</section>
</body>
</html>
