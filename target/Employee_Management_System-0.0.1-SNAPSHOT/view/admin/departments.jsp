<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page isELIgnored="false" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Departments - Employee Management System</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css" />

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    
    <style>
        /* your long department styles stay unchanged here */
        /* ... */
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

            <!-- Departments Content -->
            <div class="dashboard-content">
                <div class="department-header">
                    <div class="department-info">
                        <h2>All Departments</h2>
                        <p>Manage your organization's departments</p>
                    </div>
                    <button class="add-department-btn" id="add-department-btn">
                        <i class="fas fa-plus"></i> Add Department
                    </button>
                </div>

                <div class="departments-grid">
                    <!-- all your department cards here -->
                    <!-- Computer Science, Electrical, Mechanical, Civil, HR, etc. -->
                    <!-- unchanged from your original code -->
                </div>
            </div>
        </main>
    </div>

    <!-- Add Department Modal -->
    <div class="modal" id="department-modal">
        <div class="modal-content">
            <div class="modal-header">
                <h3>Add New Department</h3>
                <button class="modal-close">&times;</button>
            </div>
            <div class="modal-body">
                <form id="department-form">
                    <div class="form-group">
                        <label for="department-name">Department Name</label>
                        <input type="text" id="department-name" name="name" required />
                    </div>
                    <div class="form-group">
                        <label for="department-description">Description</label>
                        <textarea id="department-description" name="description" required></textarea>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button class="btn-cancel" id="cancel-btn">Cancel</button>
                <button class="btn-save" id="save-btn">Save Department</button>
            </div>
        </div>
    </div>

    <script>
        // Date & modal logic
        document.addEventListener('DOMContentLoaded', function () {
            const dateElement = document.getElementById('current-date');
            const options = { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' };
            const today = new Date();
            dateElement.textContent = today.toLocaleDateString('en-US', options);

            const modal = document.getElementById('department-modal');
            const addBtn = document.getElementById('add-department-btn');
            const closeBtn = document.querySelector('.modal-close');
            const cancelBtn = document.getElementById('cancel-btn');
            const saveBtn = document.getElementById('save-btn');

            addBtn.addEventListener('click', () => modal.classList.add('active'));
            closeBtn.addEventListener('click', () => modal.classList.remove('active'));
            cancelBtn.addEventListener('click', () => modal.classList.remove('active'));

            saveBtn.addEventListener('click', function () {
                const name = document.getElementById('department-name').value;
                const desc = document.getElementById('department-description').value;
                if (name && desc) {
                    alert(`Department "${name}" added successfully!`);
                    modal.classList.remove('active');
                    document.getElementById('department-form').reset();
                } else {
                    alert("Please fill in all fields");
                }
            });

            window.addEventListener('click', function (event) {
                if (event.target === modal) {
                    modal.classList.remove('active');
                }
            });

            document.querySelectorAll('.action-btn').forEach(btn => {
                btn.addEventListener('click', function () {
                    const action = this.classList.contains('view') ? 'view' : 'edit';
                    const deptName = this.closest('.department-body').querySelector('.department-name').textContent;
                    if (action === 'view') {
                        alert(`View details for ${deptName} department`);
                    } else {
                        alert(`Edit ${deptName} department`);
                    }
                });
            });
        });
    </script>
</body>
</html>
