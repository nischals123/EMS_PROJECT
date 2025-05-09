<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<section class="content-card">
  <section>
    <h2><i class="fas fa-calendar-check"></i> My Attendance</h2>

    <!-- Attendance Action -->
    <div class="mark-attendance-box">
      <p><strong>Date:</strong> <span id="today-date"></span></p>
      <p><strong>Status:</strong> <span id="today-status" class="badge badge-warning">Not Marked</span></p>
      <p><strong>Time In:</strong> <span id="time-in">--:--</span></p>
      <p><strong>Time Out:</strong> <span id="time-out">--:--</span></p>
      <button class="btn" id="markBtn" onclick="markAttendance()">Mark Time In</button>
    </div>

    <!-- History -->
    <h3 style="margin-top: 30px;">Attendance History</h3>
    <input type="month" id="filterMonth" />

    <table>
      <thead>
        <tr>
          <th>Date</th>
          <th>Status</th>
          <th>Time In</th>
          <th>Time Out</th>
        </tr>
      </thead>
      <tbody id="attendance-history">
        <tr>
          <td>2025-04-21</td>
          <td><span class="badge badge-success">Present</span></td>
          <td>09:02 AM</td>
          <td>05:01 PM</td>
        </tr>
      </tbody>
    </table>
  </section>
</section>


<script>
  document.getElementById("today-date").textContent = new Date().toLocaleDateString();

  let markedIn = false;
  let markedOut = false;
  let timeIn = '';
  let timeOut = '';

  function getCurrentTime() {
    const now = new Date();
    return now.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });
  }

  function markAttendance() {
    const statusEl = document.getElementById("today-status");
    const btn = document.getElementById("markBtn");

    if (!markedIn) {
      timeIn = getCurrentTime();
      document.getElementById("time-in").textContent = timeIn;
      statusEl.textContent = "Marked In";
      statusEl.className = "badge badge-info";
      btn.textContent = "Mark Time Out";
      markedIn = true;
    } else if (!markedOut) {
      timeOut = getCurrentTime();
      document.getElementById("time-out").textContent = timeOut;
      statusEl.textContent = "Present";
      statusEl.className = "badge badge-success";
      btn.textContent = "Attendance Completed ✅";
      btn.disabled = true;
      markedOut = true;

      const today = new Date().toLocaleDateString();
      const row = `
        <tr>
          <td>${today}</td>
          <td><span class="badge badge-success">Present</span></td>
          <td>${timeIn}</td>
          <td>${timeOut}</td>
        </tr>
      `;
      document.getElementById("attendance-history").insertAdjacentHTML('afterbegin', row);
    }
  }
</script>
