<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<section class="content-card">
  <section>
    <h2><i class="fas fa-tasks"></i> My Tasks</h2>

    <table>
      <thead>
        <tr>
          <th>Task</th>
          <th>Assigned By</th>
          <th>Deadline</th>
          <th>Attachment</th>
          <th>Status</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td>
            <a href="#" class="task-link"
              data-title="Update EMS UI"
              data-assigned-by="Admin"
              data-deadline="2025-04-25"
              data-file="media/ui-guide.pdf"
              data-status="In Progress"
              data-desc="Update UI components for EMS user panel.">
              Update EMS UI
            </a>
          </td>
          <td>Admin</td>
          <td>2025-04-25</td>
          <td>
            <a href="media/ui-guide.pdf" target="_blank">
              <i class="fas fa-file-pdf fa-lg" style="color: #d9534f;"></i>
            </a>
          </td>
          <td><span class="badge badge-info">In Progress</span></td>
        </tr>
      </tbody>
    </table>
  </section>
</section>

<!-- Modal HTML -->
<div id="taskDetailModal" class="modal" style="display: none;">
  <div class="modal-content">
    <h3><i class="fas fa-info-circle"></i> Task Detail</h3>

    <div class="task-details">
      <p><strong>Task:</strong> <span id="taskTitleText"></span></p>
      <p><strong>Assigned By:</strong> <span id="taskAssignedBy"></span></p>
      <p><strong>Deadline:</strong> <span id="taskDeadline"></span></p>
      <p><strong>Status:</strong> <span id="taskStatus"></span></p>

      <div class="attachment-display">
        <p><strong>Attachment:</strong></p>
        <div id="attachmentPreview"></div>
      </div>

      <p><strong>Admin Description:</strong><br><span id="taskAdminDesc"></span></p>
    </div>

    <hr>

    <form id="taskSubmitForm" enctype="multipart/form-data" class="task-form">
      <h4><i class="fas fa-upload"></i> Submit Your Work</h4>
      <label for="taskFile">Upload File</label>
      <input type="file" id="taskFile" required />

      <label for="taskNote">Your Notes</label>
      <textarea id="taskNote" placeholder="Add your notes or explanation..." rows="4"></textarea>

      <div class="submit-actions">
        <button type="submit" class="btn">Submit</button>
        <button type="button" class="btn reject" onclick="closeTaskDetailModal()">Cancel</button>
      </div>
    </form>
  </div>
</div>
