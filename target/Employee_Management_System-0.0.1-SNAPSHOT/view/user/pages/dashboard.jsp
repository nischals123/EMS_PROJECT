<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<style>
/* ===== Dashboard Page ===== */

/* Dashboard Header */
.dashboard-header {
  display: flex;
  align-items: center;
  gap: 20px;
  margin-bottom: 30px;
}

.user-avatar {
  width: 90px;
  height: 90px;
  border-radius: 50%;
  object-fit: cover;
  border: 4px solid #004080;
}

.greeting {
  font-size: 26px;
  font-weight: 700;
  color: #004080;
}

.subtext {
  font-size: 15px;
  color: #666;
}

/* Dashboard Stats */
.dashboard-stats {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
  gap: 20px;
  margin-bottom: 30px;
}

.card {
  background: white;
  padding: 24px;
  border-radius: 14px;
  box-shadow: 0 4px 12px rgba(0,0,0,0.08);
  display: flex;
  flex-direction: column;
  align-items: flex-start;
}

.card i {
  color: #004080;
  font-size: 30px;
  margin-bottom: 10px;
}

.card h2 {
  font-size: 20px;
  margin-bottom: 5px;
  color: #222;
}

.card p {
  font-size: 15px;
  color: #555;
}

/* Dashboard Quick Actions - using IDs now */
.dashboard-actions {
  display: flex;
  flex-wrap: wrap;
  gap: 20px;
  margin-top: 20px;
}

#dashboard-attendance,
#dashboard-leave,
#dashboard-tasks,
#dashboard-profile {
  flex: 1;
  min-width: 200px;
  background: #004080;
  color: white;
  padding: 16px;
  border-radius: 10px;
  font-weight: 600;
  display: flex;
  align-items: center;
  gap: 10px;
  justify-content: center;
  transition: background-color 0.3s ease;
}

#dashboard-attendance:hover,
#dashboard-leave:hover,
#dashboard-tasks:hover,
#dashboard-profile:hover {
  background-color: #003366;
}

/* Responsive */
@media (max-width: 768px) {
  .dashboard-header {
    flex-direction: column;
    text-align: center;
  }

  .dashboard-stats,
  .dashboard-actions {
    grid-template-columns: 1fr !important;
    flex-direction: column;
  }
}

</style>
<section class="user-dashboard" aria-label="User Dashboard Overview">
  <!-- User Header -->
  <div class="dashboard-header">
    <img src="https://randomuser.me/api/portraits/men/75.jpg" alt="User Profile Picture" class="user-avatar" />
    <div>
      <h1 class="greeting">Welcome back, <c:out value="${sessionScope.user.name}" default="User" /></h1>
      <p class="subtext">Your performance and activity summary for this month.</p>
    </div>
  </div>

  <!-- Summary Cards -->
  <section class="dashboard-stats" aria-label="User Summary Stats">
    <article class="card" role="group" aria-label="Attendance Summary">
      <i class="fas fa-calendar-check fa-2x"></i>
      <div>
        <h2>Attendance</h2>
        <p>22 / 30 Days</p>
      </div>
    </article>

    <article class="card" role="group" aria-label="Tasks Summary">
      <i class="fas fa-tasks fa-2x"></i>
      <div>
        <h2>Tasks</h2>
        <p>3 Pending</p>
      </div>
    </article>

    <article class="card" role="group" aria-label="Leave Summary">
      <i class="fas fa-envelope-open-text fa-2x"></i>
      <div>
        <h2>Leaves</h2>
        <p>2 Approved</p>
      </div>
    </article>
  </section>

  <!-- Quick Actions -->
  <section class="dashboard-actions" aria-label="Quick Access Actions">
    <a href="#" class="user-link" data-page="attendance.jsp">
      <i class="fas fa-calendar-day"></i> Mark Attendance
    </a>
    <a href="#" class="user-link" data-page="leave-request.jsp">
      <i class="fas fa-paper-plane"></i> Apply Leave
    </a>
    <a href="#" class="user-link" data-page="tasks.jsp">
      <i class="fas fa-clipboard-list"></i> View Tasks
    </a>
    <a href="#" class="user-link" data-page="profile.jsp">
      <i class="fas fa-user-circle"></i> View Profile
    </a>
  </section>
</section>
