<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<style>
/* ===== Leave Request Page CSS ===== */

/* Container */
.leave-section {
  display: flex;
  flex-direction: column;
  gap: 30px;
}

/* Form Styles */
#leaveForm {
  background: #f9fbfd;
  padding: 24px;
  border: 1px solid #ddd;
  border-radius: 12px;
}

.leave-form .form-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
  gap: 20px;
}

.leave-form label {
  font-weight: 600;
  color: #333;
  margin-bottom: 6px;
  display: block;
}

.leave-form input,
.leave-form select,
.leave-form textarea {
  width: 100%;
  padding: 12px 14px;
  border: 1px solid #ccc;
  border-radius: 8px;
  font-size: 14px;
  background-color: #f9f9f9;
}

/* Submit Button (ID Based) */
#submitLeaveRequest {
  background-color: #004080;
  color: white;
  padding: 12px 24px;
  font-size: 16px;
  font-weight: 600;
  border: none;
  border-radius: 8px;
  margin-top: 20px;
  cursor: pointer;
  transition: background-color 0.3s ease;
}

#submitLeaveRequest:hover {
  background-color: #003366;
}

/* Leave History Table */
.leave-section table {
  width: 100%;
  border-collapse: collapse;
  background: white;
  border-radius: 8px;
  overflow: hidden;
  box-shadow: 0 2px 8px rgba(0,0,0,0.05);
}

.leave-section th,
.leave-section td {
  padding: 14px 18px;
  border-bottom: 1px solid #eee;
}

.leave-section th {
  background-color: #004080;
  color: white;
  font-weight: 600;
  text-align: left;
}

.leave-section td:last-child {
  text-align: center;
}

/* Badge Styling */
.badge {
  display: inline-block;
  padding: 5px 12px;
  border-radius: 50px;
  font-size: 13px;
  font-weight: 500;
}

.badge-success {
  background-color: #28a745;
  color: white;
}

.badge-warning {
  background-color: #ffc107;
  color: #222;
}
</style>

<section class="content-card">
  <section class="leave-section">
    <h2><i class="fas fa-envelope"></i> Leave Request</h2>

    <!-- Leave Form -->
    <form class="leave-form" id="leaveForm">
      <div class="form-grid">
        <div>
          <label for="fromDate">From Date</label>
          <input type="date" id="fromDate" required />
        </div>
        <div>
          <label for="tillDate">Till Date</label>
          <input type="date" id="tillDate" required />
        </div>
        <div>
          <label for="leaveType">Leave Type</label>
          <select id="leaveType" required>
            <option value="">Select Type</option>
            <option value="Sick">Sick Leave</option>
            <option value="Casual">Casual Leave</option>
            <option value="Emergency">Emergency</option>
            <option value="Other">Other</option>
          </select>
        </div>
        <div style="grid-column: 1 / -1;">
          <label for="leaveReason">Reason</label>
          <textarea id="leaveReason" rows="4" placeholder="Write your reason..." required></textarea>
        </div>
      </div>
      <button type="submit" id="submitLeaveRequest">
        <i class="fas fa-paper-plane"></i> Submit Request
      </button>
    </form>

    <!-- Leave History -->
    <h3>My Leave History</h3>
    <table>
      <thead>
        <tr>
          <th>From</th>
          <th>Till</th>
          <th>Type</th>
          <th>Reason</th>
          <th>Status</th>
          <th>Admin Remarks</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td>2025-04-19</td>
          <td>2025-04-19</td>
          <td>Casual</td>
          <td>Family Function</td>
          <td><span class="badge badge-warning">Pending</span></td>
          <td>—</td>
        </tr>
        <tr>
          <td>2025-04-10</td>
          <td>2025-04-12</td>
          <td>Sick</td>
          <td>Fever</td>
          <td><span class="badge badge-success">Approved</span></td>
          <td>Take care and rest well</td>
        </tr>
      </tbody>
    </table>
  </section>
</section>

<script>
  document.getElementById("leaveForm").addEventListener("submit", function (e) {
    e.preventDefault();
    const from = document.getElementById("fromDate").value;
    const till = document.getElementById("tillDate").value;

    if (new Date(till) < new Date(from)) {
      alert("❌ 'Till Date' must be after 'From Date'");
      return;
    }

    alert("✅ Leave request submitted!");
    this.reset();
  });
</script>
