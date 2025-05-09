<%@ page contentType="text/html;charset=UTF-8" language="java" %>


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

</style>
<section class="content-card">
  <section class="profile-section">
    <h2 class="profile-title"><i class="fas fa-user"></i> My Profile</h2>

    <div class="profile-container">
      <!-- Profile Picture -->
      <div class="profile-pic">
        <img id="profilePic" src="https://randomuser.me/api/portraits/men/75.jpg" alt="Profile Picture" />
      </div>

      <!-- Profile Info Grid -->
      <div class="profile-info">
        <div class="form-grid">
          <div class="form-group">
            <label>Full Name</label>
            <input type="text" id="name" disabled />
          </div>
          <div class="form-group">
            <label>Email</label>
            <input type="email" id="email" disabled />
          </div>
          <div class="form-group">
            <label>Phone</label>
            <input type="text" id="phone" disabled />
          </div>
          <div class="form-group">
            <label>Joining Date</label>
            <input type="text" id="hireDate" disabled />
          </div>
          <div class="form-group">
            <label>Department</label>
            <input type="text" id="department" disabled />
          </div>
          <div class="form-group">
            <label>Role</label>
            <input type="text" id="role" disabled />
          </div>
          <div class="form-group">
            <label>Basic Salary</label>
            <input type="text" id="salary" disabled />
          </div>
          <div class="form-group">
            <label>Employment Status</label>
            <input type="text" id="isActive" disabled />
          </div>
          <div class="form-group full-width">
            <label>Address</label>
            <input type="text" id="address" value="Kathmandu, Nepal" disabled />
          </div>
        </div>
      </div>
    </div>

    <!-- Change Password Section -->
    <h3 class="profile-title" style="margin-top: 40px;"><i class="fas fa-key"></i> Change Password</h3>
    <form class="profile-container" id="changePasswordForm" style="margin-top: 20px;">
      <div class="form-grid">
        <div class="form-group">
          <label for="currentPassword">Current Password</label>
          <input type="password" id="currentPassword" required />
        </div>
        <div class="form-group">
          <label for="newPassword">New Password</label>
          <input type="password" id="newPassword" required />
        </div>
        <div class="form-group">
          <label for="confirmPassword">Confirm New Password</label>
          <input type="password" id="confirmPassword" required />
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

<script>
// Fetch user profile data
fetch("${pageContext.request.contextPath}/user/profile-data")
  .then(response => response.json())
  .then(user => {
    document.getElementById("name").value = user.name;
    document.getElementById("email").value = user.email;
    document.getElementById("phone").value = user.phone;
    document.getElementById("hireDate").value = user.hireDate;
    document.getElementById("department").value = user.department.name;
    document.getElementById("role").value = user.role.name;
    document.getElementById("salary").value = "Rs. " + user.salary;
    document.getElementById("isActive").value = user.active ? "Active" : "Inactive";
  })
  .catch(error => {
    console.error('Error loading profile:', error);
  });

// Password change logic
document.getElementById("changePasswordForm").addEventListener("submit", function (e) {
  e.preventDefault();
  const current = document.getElementById("currentPassword").value;
  const newPass = document.getElementById("newPassword").value;
  const confirm = document.getElementById("confirmPassword").value;

  if (newPass !== confirm) {
    alert("New passwords do not match.");
    return;
  }

  // TODO: Send password change request
  alert("Password change request submitted!");
  this.reset();
});
</script>
