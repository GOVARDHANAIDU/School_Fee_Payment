<%@page import="com.DAO.DatabaseConnectivity"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.sql.*, java.io.*" %>
<%
    // Prevent caching
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
    
    // Get user info
    String role = (String)session.getAttribute("Roles");
    String admissionNo = (String)session.getAttribute("admissionNo");
    String displayName = (String) session.getAttribute("adminName");
    
    if (displayName == null || role == null) {
        response.sendRedirect("AdminLogin.jsp");
        return;
    }
    
    String userName = "";
    for(int i = 0; i < displayName.length(); i++) {
        char ch = displayName.charAt(i);
        if(ch == ' ') break;
        else userName += ch;
    }
    
    // Handle form submission
    String message = "";
    String messageType = "";
    String submittedTitle = "";
    String submittedContent = "";
    String submittedType = "";
    String submittedDate = "";
    
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String title = request.getParameter("title");
        String content = request.getParameter("content");
        String type = request.getParameter("type");
        String datePosted = request.getParameter("date_posted");
        String attachment = request.getParameter("attachment");
        
        // Store submitted values for form reset
        submittedTitle = title != null ? title : "";
        submittedContent = content != null ? content : "";
        submittedType = type != null ? type : "";
        submittedDate = datePosted != null ? datePosted : "";
        
        if (title != null && content != null && type != null && datePosted != null) {
            try {
                Connection conn = DatabaseConnectivity.getConnection();
                PreparedStatement pstmt = conn.prepareStatement("INSERT INTO announcements (title, content, type, date_posted, created_by) VALUES (?, ?, ?, ?, ?)");
                pstmt.setString(1, title);
                pstmt.setString(2, content);
                pstmt.setString(3, type);
                pstmt.setDate(4, java.sql.Date.valueOf(datePosted));
                pstmt.setString(5, displayName);
                int rows = pstmt.executeUpdate();
                if (rows > 0) {
                    message = "Announcement added successfully!";
                    messageType = "success";
                    // Clear form values after successful submission
                    submittedTitle = "";
                    submittedContent = "";
                    submittedType = "";
                    submittedDate = java.time.LocalDate.now().toString();
                } else {
                    message = "Failed to add announcement.";
                    messageType = "danger";
                }
                conn.close();
            } catch (Exception e) {
                message = "Error: " + e.getMessage();
                messageType = "danger";
            }
        } else {
            message = "Please fill all required fields.";
            messageType = "danger";
        }
    } else {
        // Default date for new form
        submittedDate = java.time.LocalDate.now().toString();
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Add Announcement - SAS School</title>
  <link rel="icon" href="https://cdn-icons-png.flaticon.com/512/2132/2132732.png" type="image/x-icon">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
  <style>
    /* Bigger font for body */
body { 
    font-size: 0.95rem !important; /* Increased from 0.85rem */
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
    min-height: 100vh;
    padding-top: 0;
    margin-top: 0;
}

    
    /* Main container - 75% width */
    .main-container {
        width: 75%;
        max-width: 900px;
        margin: 1.5rem auto 0 auto;
        padding: 0 15px;
    }
    
    @media (max-width: 992px) {
        .main-container {
            width: 90%;
        }
    }
    
    @media (max-width: 768px) {
        .main-container {
            width: 95%;
            margin-top: 1rem;
        }
    }
    
    /* Card styling - Compact */
    .announcement-card {
    background: white;
    border-radius: 10px;
    box-shadow: 0 4px 15px rgba(0,0,0,0.08);
    border: none;
    margin-bottom: 1.5rem;
    overflow: visible; /* ✅ allows click */
}

    
    .card-header {
        background: linear-gradient(135deg, #1a237e, #283593);
        border-bottom: none;
        padding: 0.9rem 1.2rem !important;
            position: relative; /* REQUIRED */
        
    }
    
    .card-header h4 {
        font-size: 1.1rem !important;
        font-weight: 600;
        margin: 0;
        color: white;
    }
    
    .card-header p {
        font-size: 0.75rem;
        opacity: 0.9;
        margin: 0.2rem 0 0 0;
    }
    
    .card-body {
        padding: 1.2rem !important;
    }
    
    /* Form elements - Smaller */
    .form-label {
        font-size: 0.8rem !important;
        font-weight: 600;
        color: #37474f;
        margin-bottom: 0.3rem;
        display: flex;
        align-items: center;
        gap: 5px;
    }
    
    .form-label i {
        font-size: 0.75rem;
        width: 14px;
    }
    
    .form-control, .form-select {
        font-size: 0.8rem !important;
        padding: 0.5rem 0.75rem !important;
        border: 1.5px solid #dee2e6;
        border-radius: 6px;
        min-height: 36px;
    }
    
    .form-control:focus, .form-select:focus {
        border-color: #3949ab;
        box-shadow: 0 0 0 0.2rem rgba(57, 73, 171, 0.15);
    }
    
    textarea.form-control {
        min-height: 100px;
        resize: vertical;
    }
    
    /* Buttons - Compact */
    .btn {
        font-size: 0.8rem !important;
        padding: 0.5rem 1rem !important;
        border-radius: 5px;
        font-weight: 500;
    }
    
    .btn-sm {
        padding: 0.35rem 0.75rem !important;
    }
    
    /* Toast notification */
    .toast-container {
        position: fixed;
        top: 70px;
        right: 20px;
        z-index: 1055;
    }
    
    .toast {
        font-size: 0.8rem;
        box-shadow: 0 4px 12px rgba(0,0,0,0.15);
        border: none;
        border-radius: 8px;
        max-width: 350px;
    }
    
    .toast-header {
        font-size: 0.75rem;
        padding: 0.5rem 0.75rem;
    }
    
    .toast-body {
        padding: 0.75rem;
    }
    
    /* Footer - Compact */
    .footer {
        background: linear-gradient(135deg, #212529, #343a40);
        padding: 1.2rem 0 !important;
        margin-top: 2rem;
    }
    
    .footer h6 {
        font-size: 0.85rem !important;
        margin-bottom: 0.5rem;
    }
    
    .footer p, .footer a {
        font-size: 0.75rem !important;
    }
    
    /* Compact form rows */
    .compact-row {
        margin-bottom: 0.8rem;
    }
    
    /* Status indicators */
    .status-indicator {
        display: inline-flex;
        align-items: center;
        padding: 0.2rem 0.6rem;
        border-radius: 4px;
        font-size: 0.7rem;
        font-weight: 500;
    }
    
    .status-pending {
        background: #fff3cd;
        color: #856404;
    }
    
    .status-success {
        background: #d4edda;
        color: #155724;
    }
    
    .status-error {
        background: #f8d7da;
        color: #721c24;
    }
    
    /* Responsive adjustments */
    @media (max-width: 576px) {
        body {
            font-size: 0.8rem !important;
        }
        
        .main-container {
            padding: 0 10px;
        }
        
        .card-body {
            padding: 1rem !important;
        }
        
        .btn-group {
            width: 100%;
        }
        
        .btn-group .btn {
            flex: 1;
        }
    }
    
    /* Loading animation */
    .spinner-small {
        width: 1rem;
        height: 1rem;
        border-width: 0.15rem;
    }
    
    /* Character counter */
    .char-counter {
        font-size: 0.7rem;
        color: #6c757d;
        text-align: right;
        margin-top: 0.25rem;
    }
    
    .char-counter.warning {
        color: #dc3545;
    }
    
    /* Quick Tips Card - Clickable */
.quick-tips-card {
    background: white;
    border-radius: 10px;
    box-shadow: 0 4px 15px rgba(0,0,0,0.08);
    border: none;
    margin-bottom: 1.5rem;
    overflow: hidden;
    cursor: pointer;
    transition: all 0.3s ease;
    border: 2px solid transparent;
}

.quick-tips-card:hover {
    transform: translateY(-3px);
    box-shadow: 0 6px 20px rgba(0,0,0,0.12);
    border-color: #ffc107;
}

.quick-tips-card .card-body {
    padding: 1rem !important;
}

.quick-tips-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 0.5rem;
}

.quick-tips-header h6 {
    margin: 0;
    font-weight: 600;
    color: #333;
}

.quick-tips-toggle {
    color: #ffc107;
    font-size: 0.9rem;
}

/* Quick Tips Modal */
.quick-tips-modal .modal-content {
    border-radius: 12px;
    border: none;
    box-shadow: 0 10px 30px rgba(0,0,0,0.15);
}

.quick-tips-modal .modal-header {
    background: linear-gradient(135deg, #ffc107, #ff9800);
    color: white;
    border-radius: 10px 10px 0 0;
    border-bottom: none;
    padding: 1rem 1.5rem;
}

.quick-tips-modal .modal-title {
    font-weight: 600;
    font-size: 1.2rem;
}

.quick-tips-modal .modal-body {
    padding: 1.5rem;
    font-size: 0.95rem;
}

.tips-list {
    list-style: none;
    padding-left: 0;
}

.tips-list li {
    padding: 0.5rem 0;
    border-bottom: 1px solid #f0f0f0;
    display: flex;
    align-items: flex-start;
}

.tips-list li:last-child {
    border-bottom: none;
}

.tip-icon {
    color: #28a745;
    margin-right: 0.75rem;
    font-size: 0.9rem;
    margin-top: 0.2rem;
}

.tip-text {
    flex: 1;
}

/* Responsive adjustments */
@media (max-width: 576px) {
    body {
        font-size: 0.9rem !important;
    }
    
    .quick-tips-modal .modal-body {
        padding: 1.25rem;
    }
}
	
	.quick-tips-btn {
    position: absolute;
    right: 16px;
    top: 16px;
    z-index: 10;              /* 🔥 THIS IS KEY */
    pointer-events: auto;    /* 🔥 ENSURES CLICK */
    font-size: 0.75rem;
    padding: 0.35rem 0.6rem;
}
	
	.footer {
    width: 100%;
    margin-top: 3rem;
}
	
  </style>
    <link href="./student-profile.css" rel="stylesheet">
  
</head>
<body>
 <nav class="navbar navbar-expand-lg navbar-dark bg-dark px-4">
  <div class="container-fluid">
    <div class="d-flex align-items-center">
      <img src="https://img.pikbest.com/png-images/20241026/simple-useful-bright-sun-and-cloud-logo-a-clear-sky-icon-design-vector_11001223.png!sw800" alt="SAS Logo" 
      style="height: 40px; margin-right: 10px;" href="home.jsp">
      <a class="navbar-brand mb-0" href="home.jsp">SAS School</a>
    </div>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
      <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarNav">
      <!-- Left side nav items -->
      <ul class="navbar-nav me-auto">
        <li class="nav-item"><a class="nav-link active" href="home.jsp"> Home</a></li>

        <li class="nav-item"><a class="nav-link" href="about.jsp">About Us</a></li>

        <!-- Students Dropdown -->
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">Students</a>
          <ul class="dropdown-menu">
            <li><a class="dropdown-item" href="studentdetails.jsp">Student Details</a></li>
            <li><a class="dropdown-item" href="allStudents.jsp">Student Payment Info</a></li>
            <li><a class="dropdown-item" href="BillingPage.jsp">Student Fee Payment</a></li>
            <li><a class="dropdown-item" href="studentreg.jsp">Create Student Details</a></li>
            <li><a class="dropdown-item" href="create-class.jsp">Create Class</a></li>
            <li><a class="dropdown-item" href="bulkimporting.jsp">Create Bulk</a></li>
            <li><a class="dropdown-item" href="newupdates.jsp">Update Student Details</a></li>
          </ul>
        </li>

        <!-- Payments Dropdown -->
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" id="hideFunction()">Payments</a>
          <ul class="dropdown-menu">
            <li><a class="dropdown-item" href="allpayments.jsp">All Payment Details</a></li>
            <li><a class="dropdown-item" href="apbme.jsp">Payment By Admin</a></li>
            <li><a class="dropdown-item" href="paymentdetails.jsp">All Payment Status</a></li>
          </ul>
        </li>

        <!-- Explore Dropdown -->
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">Explore</a>
          <ul class="dropdown-menu">
            <li><a class="dropdown-item" href="#">360° View</a></li>
            <li><a class="dropdown-item" href="#">Videos</a></li>
            <li><a class="dropdown-item" href="images.jsp">Images</a></li>
          </ul>
        </li>

        <!-- Other Links -->
        <li class="nav-item"><a class="nav-link" href="fee-notifications.jsp" id="hideFunction()">Send Notifications</a></li>
        <li class="nav-item"><a class="nav-link" href="#">Contact Us</a></li>
      </ul>

      <!-- Right Side -->
<%
    // Prevent caching to avoid back/forward navigation issues after logout or session expiry
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

   


    //System.out.println(role);
%>
      <div class="ms-lg-auto mt-3 mt-lg-0
            d-flex flex-column flex-lg-row
            align-items-start align-items-lg-center
            gap-2">

    <!-- Hello Admin -->
    <span class="text-white fw-semibold">
        Hello, <%= userName %>
    </span>

    <!-- Roles Dropdown -->
    <div class="dropdown">
        <button class="btn btn-sm btn-outline-light dropdown-toggle"
                data-bs-toggle="dropdown">
            Roles
        </button>
        <ul class="dropdown-menu dropdown-menu-end">
            <li><a class="dropdown-item" href="home.jsp">Channel Admin</a></li>
            <li><a class="dropdown-item" href="home.jsp">Student</a></li>
            <li><a class="dropdown-item" href="./faculty/faculty.jsp">Faculty</a></li>
        </ul>
    </div>

    <!-- Auth Buttons (ALWAYS UNDER Roles in mobile) -->
    <div class="d-flex flex-column flex-lg-row gap-2 mt-2 mt-lg-0">
        <a class="btn btn-outline-light btn-sm" href="AdminLogin.jsp">Logout</a>
        <a class="btn btn-outline-warning btn-sm" href="createaccount.jsp">Signup</a>
    </div>

</div>

    </div>
  </div>
</nav>

  <!-- Toast Notification -->
  <% if (!message.isEmpty()) { %>
  <div class="toast-container">
    <div class="toast align-items-center text-white bg-<%= messageType %> border-0 show" role="alert" aria-live="assertive" aria-atomic="true" data-bs-autohide="true" data-bs-delay="3000">
      <div class="d-flex">
        <div class="toast-body">
          <i class="fas <%= messageType.equals("success") ? "fa-check-circle" : "fa-exclamation-circle" %> me-2"></i>
          <%= message %>
        </div>
        <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
      </div>
    </div>
  </div>
  <% } %>

  <!-- Main Content -->
  <div class="main-container">
    <div class="announcement-card">
      <div class="card-header">
        <h4><i class="fas fa-bullhorn me-2"></i>Add New Announcement</h4>
        <p>Create and publish announcements for the school community</p>
      </div>
      	  <!-- RIGHT CORNER CLICK -->
  <button type="button"
          class="btn btn-warning btn-sm quick-tips-btn"
          data-bs-toggle="modal"
          data-bs-target="#quickTipsModal">
    <i class="fas fa-lightbulb me-1"></i> Tips
    </button>
</div>
      	
      <div class="card-body">
        <form id="announcementForm" action="" method="POST" onsubmit="return validateForm()">
          <div class="compact-row">
            <label for="title" class="form-label">
              <i class="fas fa-heading"></i>Title <span class="text-danger">*</span>
            </label>
            <input type="text" class="form-control" id="title" name="title" 
                   value="<%= submittedTitle %>" 
                   placeholder="e.g., Holiday Notice, Exam Schedule Update" 
                   maxlength="200" required>
            <div class="char-counter" id="titleCounter">0/200</div>
          </div>
          
          <div class="compact-row">
            <label for="content" class="form-label">
              <i class="fas fa-align-left"></i>Content <span class="text-danger">*</span>
            </label>
            <textarea class="form-control" id="content" name="content" rows="4" 
                      placeholder="Enter detailed announcement content..." 
                      maxlength="2000" required><%= submittedContent %></textarea>
            <div class="char-counter" id="contentCounter">0/2000</div>
          </div>
          
          <div class="row g-2 compact-row">
            <div class="col-md-6">
              <label for="type" class="form-label">
                <i class="fas fa-tag"></i>Type <span class="text-danger">*</span>
              </label>
              <select class="form-select" id="type" name="type" required>
                <option value="">Select Type</option>
                <option value="RESULT" <%= "RESULT".equals(submittedType) ? "selected" : "" %>>Result Announcement</option>
                <option value="HOLIDAY" <%= "HOLIDAY".equals(submittedType) ? "selected" : "" %>>Holiday Notice</option>
                <option value="TIMETABLE" <%= "TIMETABLE".equals(submittedType) ? "selected" : "" %>>Timetable Update</option>
                <option value="EVENT" <%= "EVENT".equals(submittedType) ? "selected" : "" %>>Event/Sports</option>
                <option value="EXAM" <%= "EXAM".equals(submittedType) ? "selected" : "" %>>Exam Schedule</option>
                <option value="OTHER" <%= "OTHER".equals(submittedType) ? "selected" : "" %>>Other</option>
              </select>
            </div>
            <div class="col-md-6">
              <label for="date_posted" class="form-label">
                <i class="fas fa-calendar"></i>Date Posted <span class="text-danger">*</span>
              </label>
              <input type="date" class="form-control" id="date_posted" name="date_posted" 
                     value="<%= submittedDate %>" required>
            </div>
          </div>
          
          <div class="compact-row">
            <label for="attachment" class="form-label">
              <i class="fas fa-paperclip"></i>Attachment (Optional)
            </label>
            <input type="file" class="form-control" id="attachment" name="attachment" 
                   accept=".pdf,.jpg,.jpeg,.png,.doc,.docx">
            <div class="form-text small mt-1">
              Supported formats: PDF, JPG, PNG, DOC, DOCX (Max 5MB)
            </div>
          </div>
          
          <div class="mt-3 pt-2 border-top">
            <div class="d-flex justify-content-between align-items-center">
              <div>
                <span class="status-indicator status-<%= message.isEmpty() ? "pending" : messageType %> small">
                  <i class="fas <%= message.isEmpty() ? "fa-clock" : (messageType.equals("success") ? "fa-check" : "fa-exclamation-triangle") %> me-1"></i>
                  <%= message.isEmpty() ? "Ready to submit" : (messageType.equals("success") ? "Submitted successfully" : "Submission failed") %>
                </span>
              </div>
              <div class="d-flex gap-2">
                <a href="home.jsp" class="btn btn-outline-secondary btn-sm">
                  <i class="fas fa-times me-1"></i>Cancel
                </a>
                <button type="reset" class="btn btn-outline-warning btn-sm" onclick="clearForm()">
                  <i class="fas fa-redo me-1"></i>Clear
                </button>
                <button type="submit" class="btn btn-primary btn-sm" id="submitBtn">
                  <i class="fas fa-paper-plane me-1"></i>Publish Announcement
                </button>
              </div>
            </div>
          </div>
        </form>
      </div>
    </div>
    
<!-- Quick Tips Modal -->
<div class="modal fade quick-tips-modal" id="quickTipsModal" tabindex="-1" aria-labelledby="quickTipsModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="quickTipsModalLabel">
          <i class="fas fa-lightbulb me-2"></i>Announcement Best Practices
        </h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <div class="row">
          <div class="col-md-6">
            <h6 class="text-primary mb-3"><i class="fas fa-pencil-alt me-2"></i>Content Guidelines</h6>
            <ul class="tips-list">
              <li>
                <span class="tip-icon"><i class="fas fa-check"></i></span>
                <span class="tip-text"><strong>Clear Titles:</strong> Use descriptive titles that quickly convey the announcement's purpose</span>
              </li>
              <li>
                <span class="tip-icon"><i class="fas fa-check"></i></span>
                <span class="tip-text"><strong>Concise Content:</strong> Keep messages focused and to the point while including all necessary details</span>
              </li>
              <li>
                <span class="tip-icon"><i class="fas fa-check"></i></span>
                <span class="tip-text"><strong>Proper Formatting:</strong> Use paragraphs, bullet points, and emphasis for readability</span>
              </li>
              <li>
                <span class="tip-icon"><i class="fas fa-check"></i></span>
                <span class="tip-text"><strong>Action Items:</strong> Clearly state if any action is required from readers</span>
              </li>
            </ul>
          </div>
          <div class="col-md-6">
            <h6 class="text-primary mb-3"><i class="fas fa-cogs me-2"></i>Technical Tips</h6>
            <ul class="tips-list">
              <li>
                <span class="tip-icon"><i class="fas fa-check"></i></span>
                <span class="tip-text"><strong>Correct Type:</strong> Select the most appropriate announcement type for better organization</span>
              </li>
              <li>
                <span class="tip-icon"><i class="fas fa-check"></i></span>
                <span class="tip-text"><strong>Date Accuracy:</strong> Ensure the posted date reflects when the announcement should be visible</span>
              </li>
              <li>
                <span class="tip-icon"><i class="fas fa-check"></i></span>
                <span class="tip-text"><strong>Attachment Usage:</strong> Attach relevant documents only when they add value to the announcement</span>
              </li>
              <li>
                <span class="tip-icon"><i class="fas fa-check"></i></span>
                <span class="tip-text"><strong>Preview First:</strong> Review your announcement before publishing to catch any errors</span>
              </li>
            </ul>
          </div>
        </div>
        
        <div class="alert alert-info mt-4 mb-0">
          <div class="d-flex">
            <div class="me-3">
              <i class="fas fa-info-circle fa-2x"></i>
            </div>
            <div>
              <h6 class="alert-heading">Pro Tip</h6>
              <p class="mb-0">For urgent announcements, consider sending additional notifications through the Notifications system for maximum reach.</p>
            </div>
          </div>
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
        <a href="fee-notifications.jsp" class="btn btn-warning">
          <i class="fas fa-bell me-2"></i>Go to Notifications
        </a>
      </div>
    </div>
  </div>
</div>

<footer class="footer bg-dark text-white py-4 w-100">
  <div class="container-fluid px-5">
    <div class="row text-center text-md-start">
      <div class="col-md-4 mb-3">
        <h6><strong>Contact</strong></h6>
        <p>Email: contact@sasschool.edu<br>Phone: +1 123 456 7890</p>
      </div>
      <div class="col-md-4 mb-3">
        <h6><strong>About</strong></h6>
        <a href="#" class="d-block text-warning">Our Story</a>
        <a href="#" class="d-block text-warning">Privacy Policy</a>
      </div>
      <div class="col-md-4 mb-3">
        <h6><strong>Address</strong></h6>
        <p>123 Learning Lane<br>Education City, Country</p>
      </div>
    </div>
  </div>
</footer>

  <!-- Bootstrap JS -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  
  <!-- Inline JavaScript -->
  <script>
    // Initialize variables
    window.userRole = "<%= (role != null ? role.replace("\"", "\\\"") : "") %>";
    window.admissionNo = "<%= (admissionNo != null ? admissionNo.replace("\"", "\\\"") : "") %>";
    
    // Character counters
    document.addEventListener('DOMContentLoaded', function() {
        // Initialize character counters
        const titleInput = document.getElementById('title');
        const contentInput = document.getElementById('content');
        const titleCounter = document.getElementById('titleCounter');
        const contentCounter = document.getElementById('contentCounter');
        
        if (titleInput) {
            titleInput.addEventListener('input', function() {
                const length = this.value.length;
                titleCounter.textContent = length + '/200';
                titleCounter.className = 'char-counter' + (length > 190 ? ' warning' : '');
            });
            // Trigger initial count
            titleInput.dispatchEvent(new Event('input'));
        }
        
        if (contentInput) {
            contentInput.addEventListener('input', function() {
                const length = this.value.length;
                contentCounter.textContent = length + '/2000';
                contentCounter.className = 'char-counter' + (length > 1900 ? ' warning' : '');
            });
            // Trigger initial count
            contentInput.dispatchEvent(new Event('input'));
        }
        
        // Auto-hide toast after 5 seconds
        const toastEl = document.querySelector('.toast');
        if (toastEl) {
            setTimeout(() => {
                const toast = bootstrap.Toast.getInstance(toastEl);
                if (toast) toast.hide();
            }, 5000);
        }
        
        // Set max date to today
        const dateInput = document.getElementById('date_posted');
        if (dateInput) {
            const today = new Date().toISOString().split('T')[0];
            dateInput.max = today;
        }
    });
    
    // Form validation
    function validateForm() {
        const title = document.getElementById('title').value.trim();
        const content = document.getElementById('content').value.trim();
        const type = document.getElementById('type').value;
        const date = document.getElementById('date_posted').value;
        const submitBtn = document.getElementById('submitBtn');
        
        if (!title || !content || !type || !date) {
            showAlert('Please fill all required fields', 'danger');
            return false;
        }
        
        if (title.length > 200) {
            showAlert('Title must be 200 characters or less', 'danger');
            return false;
        }
        
        if (content.length > 2000) {
            showAlert('Content must be 2000 characters or less', 'danger');
            return false;
        }
        
        // Disable button and show loading
        submitBtn.disabled = true;
        submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin me-1"></i>Publishing...';
        
        return true;
    }
    
    // Clear form function
    function clearForm() {
        document.getElementById('announcementForm').reset();
        document.getElementById('date_posted').value = new Date().toISOString().split('T')[0];
        
        // Reset character counters
        const titleCounter = document.getElementById('titleCounter');
        const contentCounter = document.getElementById('contentCounter');
        if (titleCounter) titleCounter.textContent = '0/200';
        if (contentCounter) contentCounter.textContent = '0/2000';
        
        showAlert('Form cleared', 'info');
    }
    
    // Show alert function
    function showAlert(message, type) {
        // Remove existing toast
        const existingToast = document.querySelector('.toast-container');
        if (existingToast) existingToast.remove();
        
        // Create new toast
        const toastContainer = document.createElement('div');
        toastContainer.className = 'toast-container';
        
        const toastHtml = `
            <div class="toast align-items-center text-white bg-${type} border-0" role="alert" aria-live="assertive" aria-atomic="true">
                <div class="d-flex">
                    <div class="toast-body">
                        <i class="fas ${type === 'success' ? 'fa-check-circle' : type === 'danger' ? 'fa-exclamation-circle' : 'fa-info-circle'} me-2"></i>
                        ${message}
                    </div>
                    <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
                </div>
            </div>
        `;
        
        toastContainer.innerHTML = toastHtml;
        document.body.appendChild(toastContainer);
        
        // Show and auto-hide
        const toastEl = toastContainer.querySelector('.toast');
        const toast = new bootstrap.Toast(toastEl, { delay: 3000 });
        toast.show();
        
        // Remove after hide
        toastEl.addEventListener('hidden.bs.toast', function() {
            toastContainer.remove();
        });
    }
    
    // Handle form submission to prevent double submission
    let formSubmitted = false;
    const form = document.getElementById('announcementForm');
    if (form) {
        form.addEventListener('submit', function(e) {
            if (formSubmitted) {
                e.preventDefault();
                return false;
            }
            formSubmitted = true;
        });
    }
    
    // Auto-hide success message toast
    <% if (!message.isEmpty() && messageType.equals("success")) { %>
    setTimeout(function() {
        const toastEl = document.querySelector('.toast');
        if (toastEl) {
            const toast = bootstrap.Toast.getInstance(toastEl);
            if (toast) toast.hide();
        }
    }, 4000);
    <% } %>
  </script>
</body>
</html>