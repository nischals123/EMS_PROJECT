<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>My Profile - EMS</title>

  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css" />
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />

  <style>
    .profile-page {
      padding: 20px;
      display: flex;
      flex-wrap: wrap;
      gap: 20px;
    }
    .profile-card {
      background: white;
      padding: 20px;
      border-radius: 10px;
      flex: 1 1 300px;
      box-shadow: 0 2px 10px rgba(0,0,0,0.05);
    }
    .profile-card h2 {
      margin-bottom: 20px;
      font-size: 22px;
      color: #333;
    }
    .profile-info {
      display: grid;
      grid-template-columns: 1fr 1fr;
      gap: 15px;
    }
    .profile-info label {
      font-weight: bold;
      font-size: 14px;
      color: #555;
    }
    .profile-info input {
      width: 100%;
      padding: 8px 12px;
      margin-top: 5px;
      border-radius: 5px;
      border: 1px solid #ddd;
      background: #f9f9f9;
      font-size: 14px;
    }
    .profile-info input:disabled {
      color: #555;
      background: #f0f0f0;
    }
    .change-password {
      margin-top: 40px;
    }
    .btn-save {
      background: #3498db;
      color: white;
      padding: 10px 20px;
      border: none;
      margin-top: 20px;
      border-radius: 5px;
      cursor: pointer;
      font-weight: bold;
      transition: 0.3s;
    }
    .btn-save:hover {
      background: #2980b9;
    }
    @media (max-width: 768px) {
      .profile-info {
        grid-template-columns: 1fr;
      }
    }
  </style>
</head>

<body class="dashboard-body">

<div class="dashboard-container">

  <%-- Sidebar (Optional, if you have) --%>
  <%-- Example: --%>
  <%@ include file="includes/sidebar.jsp" %> 

  <main class="main-content">

    <%-- Top Navigation (Optional, if you have) --%>
    <%@ include file="includes/topnav.jsp" %>

    <div class="dashboard-content">

      <div class="profile-page">
        <div class="profile-card">
          <h2><i class="fas fa-user"></i> My Profile</h2>

          <div class="profile-info">
            <div>
              <label>Full Name</label>
              <input type="text" value="John Doe" disabled />
            </div>

            <div>
              <label>Email</label>
              <input type="email" value="john.doe@example.com" disabled />
            </div>

            <div>
              <label>Phone</label>
              <input type="text" value="+977-9800000000" disabled />
            </div>

            <div>
              <label>Department</label>
              <input type="text" value="Computer Science" disabled />
            </div>

            <div>
              <label>Role</label>
              <input type="text" value="Admin" disabled />
            </div>

            <div>
              <label>Status</label>
              <input type="text" value="Active" disabled />
            </div>

            <div style="grid-column: 1 / -1;">
              <label>Hire Date</label>
              <input type="text" value="2023-01-15" disabled />
            </div>
          </div>

          <div class="change-password">
            <h2><i class="fas fa-key"></i> Change Password</h2>

            <form id="changePasswordForm">
              <div class="profile-info">
                <div>
                  <label>Current Password</label>
                  <input type="password" id="currentPassword" required />
                </div>
                <div>
                  <label>New Password</label>
                  <input type="password" id="newPassword" required />
                </div>
                <div style="grid-column: 1 / -1;">
                  <label>Confirm New Password</label>
                  <input type="password" id="confirmPassword" required />
                </div>
              </div>
              <button type="submit" class="btn-save">Update Password</button>
            </form>
          </div>

        </div>
      </div>

    </div>

  </main>

</div>

<script>
  document.getElementById("changePasswordForm").addEventListener("submit", function(e) {
    e.preventDefault();
    const newPassword = document.getElementById("newPassword").value;
    const confirmPassword = document.getElementById("confirmPassword").value;

    if (newPassword !== confirmPassword) {
      alert("New passwords do not match!");
      return;
    }

    alert("Password updated successfully!");
    this.reset();
  });
</script>

</body>
</html>
