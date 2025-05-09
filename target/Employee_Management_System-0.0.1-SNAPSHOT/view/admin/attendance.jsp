<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page isELIgnored="false" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Attendance - Employee Management System</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />

    <style>
        /* Attendance-specific styles */
        .attendance-actions { display: flex; gap: 15px; margin-bottom: 20px; }
        .attendance-card {
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            padding: 20px;
            margin-bottom: 20px;
        }
        .attendance-status {
            display: inline-block;
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 500;
        }
        .status-present { background-color: #e3f9e5; color: #2ecc71; }
        .status-absent { background-color: #fde8e8; color: #e74c3c; }
        .status-late { background-color: #fef5e7; color: #f39c12; }
        .status-half-day { background-color: #e7f3fe; color: #3498db; }
        .time-display {
            font-size: 2rem;
            font-weight: bold;
            text-align: center;
            margin: 20px 0;
            color: #2c3e50;
        }
        .date-filter {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 20px;
        }
        .date-filter input[type="date"],
        .date-filter input[type="month"] {
            padding: 8px 12px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }
    </style>
</head>
<body class="dashboard-body">

    <c:if test="${empty sessionScope.user}">
        <c:redirect url="login.jsp"/>
    </c:if>

    <div class="dashboard-container">
        <%@ include file="includes/sidebar.jsp" %>

        <main class="main-content">
            <%@ include file="includes/topnav.jsp" %>

            <!-- Attendance Content -->
            <div class="dashboard-content">
                <div class="attendance-card">
                    <div class="time-display" id="current-time"></div>

                    <div class="attendance-actions">
                        <button class="btn btn-primary" id="check-in-btn">
                            <i class="fas fa-sign-in-alt"></i> Check In
                        </button>
                        <button class="btn btn-secondary" id="check-out-btn" disabled>
                            <i class="fas fa-sign-out-alt"></i> Check Out
                        </button>
                    </div>

                    <div id="attendance-status-message"></div>
                </div>

                <!-- My Attendance History -->
                <div class="content-section">
                    <div class="section-header">
                        <h2>My Attendance History</h2>
                        <div class="date-filter">
                            <label for="month-filter">Filter by Month:</label>
                            <input type="month" id="month-filter" name="month-filter" />
                            <button class="btn btn-sm" id="filter-btn">Apply</button>
                        </div>
                    </div>

                    <div class="table-responsive">
                        <table class="data-table">
                            <thead>
                                <tr>
                                    <th>Date</th>
                                    <th>Check In</th>
                                    <th>Check Out</th>
                                    <th>Working Hours</th>
                                    <th>Status</th>
                                    <th>Notes</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>2023-07-01</td>
                                    <td>09:00 AM</td>
                                    <td>05:30 PM</td>
                                    <td>8.5 hours</td>
                                    <td><span class="attendance-status status-present">Present</span></td>
                                    <td>-</td>
                                </tr>
                                <tr>
                                    <td>2023-07-02</td>
                                    <td>09:15 AM</td>
                                    <td>05:45 PM</td>
                                    <td>8.5 hours</td>
                                    <td><span class="attendance-status status-late">Late</span></td>
                                    <td>Traffic delay</td>
                                </tr>
                                <tr>
                                    <td>2023-07-03</td>
                                    <td>-</td>
                                    <td>-</td>
                                    <td>-</td>
                                    <td><span class="attendance-status status-absent">Absent</span></td>
                                    <td>Sick leave</td>
                                </tr>
                                <tr>
                                    <td>2023-07-04</td>
                                    <td>09:00 AM</td>
                                    <td>01:30 PM</td>
                                    <td>4.5 hours</td>
                                    <td><span class="attendance-status status-half-day">Half Day</span></td>
                                    <td>Doctor's appointment</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>

                <!-- Department Attendance (for Managers/Admin) -->
                <c:if test="${sessionScope.user.role.name eq 'Manager' or sessionScope.user.role.name eq 'Admin'}">
                    <div class="content-section">
                        <div class="section-header">
                            <h2>Department Attendance</h2>
                            <div class="date-filter">
                                <label for="date-filter">Select Date:</label>
                                <input type="date" id="date-filter" name="date-filter" />
                                <button class="btn btn-sm" id="dept-filter-btn">Apply</button>
                            </div>
                        </div>

                        <div class="table-responsive">
                            <table class="data-table">
                                <thead>
                                    <tr>
                                        <th>Employee</th>
                                        <th>Check In</th>
                                        <th>Check Out</th>
                                        <th>Working Hours</th>
                                        <th>Status</th>
                                        <th>Notes</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td><div class="employee-name"><div class="employee-avatar"><img src="https://randomuser.me/api/portraits/men/32.jpg" /></div><span>Kp Oli</span></div></td>
                                        <td>09:00 AM</td>
                                        <td>05:30 PM</td>
                                        <td>8.5 hours</td>
                                        <td><span class="attendance-status status-present">Present</span></td>
                                        <td>-</td>
                                    </tr>
                                    <tr>
                                        <td><div class="employee-name"><div class="employee-avatar"><img src="https://randomuser.me/api/portraits/women/44.jpg" /></div><span>Sher Badhurdeuba</span></div></td>
                                        <td>09:15 AM</td>
                                        <td>05:45 PM</td>
                                        <td>8.5 hours</td>
                                        <td><span class="attendance-status status-late">Late</span></td>
                                        <td>Traffic delay</td>
                                    </tr>
                                    <tr>
                                        <td><div class="employee-name"><div class="employee-avatar"><img src="https://randomuser.me/api/portraits/men/67.jpg" /></div><span>Prachanda</span></div></td>
                                        <td>-</td>
                                        <td>-</td>
                                        <td>-</td>
                                        <td><span class="attendance-status status-absent">Absent</span></td>
                                        <td>Sick leave</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </c:if>
            </div>
        </main>
    </div>

    <!-- JavaScript for Attendance -->
    <script>
        function updateTime() {
            const now = new Date();
            const options = { hour: '2-digit', minute: '2-digit', second: '2-digit', hour12: true };
            document.getElementById('current-time').textContent = now.toLocaleTimeString('en-US', options);
        }
        updateTime();
        setInterval(updateTime, 1000);

        document.getElementById('check-in-btn').addEventListener('click', function () {
            this.disabled = true;
            document.getElementById('check-out-btn').disabled = false;
            const time = new Date().toLocaleTimeString('en-US', { hour: '2-digit', minute: '2-digit', hour12: true });
            document.getElementById('attendance-status-message').innerHTML = `
                <div class="alert alert-success"><i class="fas fa-check-circle"></i> Successfully checked in at ${time}</div>`;
        });

        document.getElementById('check-out-btn').addEventListener('click', function () {
            this.disabled = true;
            document.getElementById('check-in-btn').disabled = true;
            const time = new Date().toLocaleTimeString('en-US', { hour: '2-digit', minute: '2-digit', hour12: true });
            document.getElementById('attendance-status-message').innerHTML = `
                <div class="alert alert-info"><i class="fas fa-check-circle"></i> Successfully checked out at ${time}</div>`;
        });
    </script>
</body>
</html>
