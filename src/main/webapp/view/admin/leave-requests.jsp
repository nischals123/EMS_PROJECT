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
    <title>Admin Leave Requests - EMS</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css" />
    
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    <style>
        .leave-status {
            display: inline-block;
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 0.75rem;
            font-weight: 600;
        }
        .status-pending { background-color: #fff4e5; color: #e67e22; }
        .status-approved { background-color: #e8f8f5; color: #27ae60; }
        .status-rejected { background-color: #fdecea; color: #c0392b; }
        .leave-type {
            background-color: #eaf2ff;
            color: #2980b9;
            padding: 4px 10px;
            border-radius: 5px;
            font-size: 0.8rem;
        }
        .action-buttons { display: flex; gap: 8px; }
        .btn-approve, .btn-reject {
            border: none;
            padding: 6px 12px;
            border-radius: 5px;
            font-size: 0.8rem;
            cursor: pointer;
        }
        .btn-approve { background-color: #2ecc71; color: #fff; }
        .btn-reject { background-color: #e74c3c; color: #fff; }
        .btn-add-leave {
            background-color: #3498db;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 6px;
            font-weight: 600;
            cursor: pointer;
        }
        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.4);
            justify-content: center;
            align-items: center;
            z-index: 2000;
        }
        .modal.active { display: flex; }
        .modal-content {
            background: #fff;
            padding: 25px;
            border-radius: 10px;
            width: 420px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
        }
        .modal-content h3 { margin-bottom: 20px; }
        .form-group { margin-bottom: 15px; }
        .form-group label { display: block; font-weight: 600; margin-bottom: 5px; }
        .form-group input, .form-group select, .form-group textarea {
            width: 100%;
            padding: 8px 12px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 0.9rem;
        }
        .data-table td, .data-table th {
            vertical-align: middle;
            text-align: center;
        }
    </style>
</head>
<body class="dashboard-body">

<div class="dashboard-container">
    <%@ include file="includes/sidebar.jsp" %>
    <main class="main-content">
        <%@ include file="includes/topnav.jsp" %>
        <header class="content-header">
            <div class="header-left">
                <h1><i class="fas fa-calendar-minus"></i> Leave Requests</h1>
            </div>
            <div class="header-right">
                <button class="btn-add-leave" onclick="openLeaveModal()">
                    <i class="fas fa-plus"></i> Add Leave Manually
                </button>
            </div>
        </header>
        <div class="dashboard-content">
            <div class="content-section">
                <div class="section-header">
                    <h2>Pending Leave Requests</h2>
                </div>
                <div class="table-responsive">
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th>Employee</th>
                                <th>Leave Type</th>
                                <th>Start</th>
                                <th>End</th>
                                <th>Days</th>
                                <th>Reason</th>
                                <th>Status</th>
                                <th>Submitted</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>John Doe</td>
                                <td><span class="leave-type">Annual</span></td>
                                <td>2025-05-01</td>
                                <td>2025-05-05</td>
                                <td>5</td>
                                <td>Family Vacation</td>
                                <td><span class="leave-status status-pending">Pending</span></td>
                                <td>2025-04-20</td>
                                <td class="action-buttons">
                                    <button class="btn-approve" onclick="approveLeave(1)"><i class="fas fa-check"></i></button>
                                    <button class="btn-reject" onclick="rejectLeave(1)"><i class="fas fa-times"></i></button>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </main>
</div>

<!-- Modal: Manual Leave Form -->
<div class="modal" id="leaveModal">
    <div class="modal-content">
        <h3>Add Leave Request</h3>
        <form id="manualLeaveForm">
            <div class="form-group">
                <label>Employee Name</label>
                <input type="text" name="employee" required />
            </div>
            <div class="form-group">
                <label>Leave Type</label>
                <select name="type" required>
                    <option value="Annual">Annual</option>
                    <option value="Sick">Sick</option>
                    <option value="Personal">Personal</option>
                </select>
            </div>
            <div class="form-group">
                <label>Start Date</label>
                <input type="date" name="start" required />
            </div>
            <div class="form-group">
                <label>End Date</label>
                <input type="date" name="end" required />
            </div>
            <div class="form-group">
                <label>Reason</label>
                <textarea name="reason" rows="3" required></textarea>
            </div>
            <div class="form-group" style="display: flex; justify-content: flex-end; gap: 10px;">
                <button type="submit" class="btn btn-primary">Submit</button>
                <button type="button" class="btn btn-secondary" onclick="closeLeaveModal()">Cancel</button>
            </div>
        </form>
    </div>
</div>

<script>
    function openLeaveModal() {
        document.getElementById('leaveModal').classList.add('active');
    }

    function closeLeaveModal() {
        document.getElementById('leaveModal').classList.remove('active');
    }

    function approveLeave(id) {
        alert(`Leave request #${id} approved.`);
        // TODO: Add AJAX call for backend update
    }

    function rejectLeave(id) {
        const reason = prompt("Enter reason for rejection:");
        if (reason !== null && reason.trim() !== '') {
            alert(`Leave request #${id} rejected with reason: ${reason}`);
            // TODO: Add AJAX call for backend update
        }
    }

    document.getElementById('manualLeaveForm').addEventListener('submit', function(e) {
        e.preventDefault();
        alert('Manual leave request submitted successfully!');
        closeLeaveModal();
        this.reset();
        // TODO: Add AJAX submission logic
    });
</script>
</body>
</html>
