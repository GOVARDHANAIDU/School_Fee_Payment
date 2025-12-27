<%@page import="com.DAO.DatabaseConnectivity"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.sql.*, java.io.*" %>
<%
    // Handle form submission (simple insertion in JSP - NOT production-ready, use servlet for real apps)
    String message = "";
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String title = request.getParameter("title");
        String content = request.getParameter("content");
        String type = request.getParameter("type");
        String datePosted = request.getParameter("date_posted");
        String attachment = request.getParameter("attachment"); // Handle file separately if needed

        if (title != null && content != null && type != null && datePosted != null) {
            try {
                Connection conn = DatabaseConnectivity.getConnection();
                PreparedStatement pstmt = conn.prepareStatement("INSERT INTO announcements (title, content, type, date_posted) VALUES (?, ?, ?, ?)");
                pstmt.setString(1, title);
                pstmt.setString(2, content);
                pstmt.setString(3, type);
                pstmt.setDate(4, java.sql.Date.valueOf(datePosted)); // Fixed: Explicitly use java.sql.Date to resolve ambiguity
                int rows = pstmt.executeUpdate();
                if (rows > 0) {
                    message = "<div class='alert alert-success text-center'>Announcement added successfully!</div>";
                } else {
                    message = "<div class='alert alert-danger text-center'>Failed to add announcement.</div>";
                }
                conn.close();
            } catch (Exception e) {
                message = "<div class='alert alert-danger text-center'>Error: " + e.getMessage() + "</div>";
            }
        }
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
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <style>
    body { font-size: 0.9rem; font-family: 'Segoe UI', sans-serif; }
    .form-label { font-size: 0.85rem; font-weight: 600; color: #495057; }
    .form-control, .form-select { font-size: 0.85rem; }
    .card { box-shadow: 0 0.5rem 1rem rgba(0,0,0,0.15) !important; border-radius: 0.75rem; }
    .card-header { background: linear-gradient(135deg, #0d47a1, #1976d2); border-radius: 0.75rem 0.75rem 0 0 !important; }
    .btn { font-size: 0.85rem; border-radius: 0.5rem; }
    .grid-form { display: grid; grid-template-columns: 1fr 1fr; gap: 1rem; }
    @media (max-width: 768px) { .grid-form { grid-template-columns: 1fr; } }
  </style>
</head>
<body class="bg-light">
  <!-- Navbar -->
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
          <li class="nav-item"><a class="nav-link" href="home.jsp">Home</a></li>

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
              <li><a class="dropdown-item" href="addAnnouncement.jsp">Announcements</a></li>
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

    // Get user name for display (prioritize adminName, fallback to others if needed)
    String displayName = (String) session.getAttribute("adminName");
    String role = (String)session.getAttribute("Roles");
    String admissionNo = (String)session.getAttribute("admissionNo");

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
%>
        <div class="ms-lg-auto mt-3 mt-lg-0 d-flex flex-column flex-lg-row align-items-start align-items-lg-center gap-2">

          <!-- Hello Admin -->
          <span class="text-white fw-semibold">
            Hello, <%= userName %>
          </span>

          <!-- Roles Dropdown -->
          <div class="dropdown">
            <button class="btn btn-sm btn-outline-light dropdown-toggle" data-bs-toggle="dropdown">
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

  <!-- Main Content: Input Fields for Announcement -->
  <div class="container my-5 pt-5">
    <%= message %> <!-- Success/Error Message -->
    <div class="row justify-content-center">
      <div class="col-md-10 col-lg-8">
        <div class="card shadow-lg border-0 rounded-4">
          <div class="card-header bg-primary text-white text-center py-3">
            <h3 class="mb-1"><i class="fas fa-bullhorn me-2"></i>Add New Announcement</h3>
            <p class="mb-0 small opacity-75">Share updates with the school community</p>
          </div>
          <div class="card-body p-4">
            <form action="" method="POST" enctype="multipart/form-data">
              <input type="hidden" name="action" value="add">

              <div class="row g-3 mb-3">
                <div class="col-md-12">
                  <label for="title" class="form-label"><i class="fas fa-heading me-1 text-primary"></i>Title</label>
                  <input type="text" class="form-control form-control-sm" id="title" name="title" placeholder="Enter announcement title (e.g., Holiday Notice)" required>
                </div>
              </div>

              <div class="row g-3 mb-3">
                <div class="col-md-12">
                  <label for="content" class="form-label"><i class="fas fa-align-left me-1 text-primary"></i>Content</label>
                  <textarea class="form-control form-control-sm" id="content" name="content" rows="4" placeholder="Enter detailed content..." required></textarea>
                </div>
              </div>

              <div class="row g-3 mb-3">
                <div class="col-md-6">
                  <label for="type" class="form-label"><i class="fas fa-tags me-1 text-primary"></i>Type</label>
                  <select class="form-select form-select-sm" id="type" name="type" required>
                    <option value="">Select Type</option>
                    <option value="RESULT">Result Announcement</option>
                    <option value="HOLIDAY">Holiday Notice</option>
                    <option value="TIMETABLE">Timetable Update</option>
                    <option value="EVENT">Event/Sports</option>
                    <option value="OTHER">Other</option>
                  </select>
                </div>
                <div class="col-md-6">
                  <label for="date_posted" class="form-label"><i class="fas fa-calendar me-1 text-primary"></i>Date Posted</label>
                  <input type="date" class="form-control form-control-sm" id="date_posted" name="date_posted" value="<%= java.time.LocalDate.now() %>" required>
                </div>
              </div>

              <div class="row g-3 mb-4">
                <div class="col-md-12">
                  <label for="attachment" class="form-label"><i class="fas fa-paperclip me-1 text-primary"></i>Attachment (Optional)</label>
                  <input type="file" class="form-control form-control-sm" id="attachment" name="attachment" accept=".pdf,.jpg,.jpeg,.png,.docx">
                  <div class="form-text small">Upload PDF, images, or documents (max 5MB)</div>
                </div>
              </div>

              <div class="d-flex justify-content-end gap-2">
                <a href="home.jsp" class="btn btn-secondary btn-sm"><i class="fas fa-arrow-left me-1"></i>Back to Dashboard</a>
                <button type="submit" class="btn btn-primary btn-sm"><i class="fas fa-save me-1"></i>Save Announcement</button>
              </div>
            </form>
          </div>
        </div>
      </div>
    </div>
  </div>

  <!-- Footer -->
  <footer class="footer bg-dark text-white py-3 mt-5">
    <div class="container">
      <div class="row text-center text-md-start g-3">
        <div class="col-md-4">
          <h6 class="small"><strong><i class="fas fa-envelope me-1"></i>Contact</strong></h6>
          <p class="small mb-0">Email: contact@sasschool.edu<br>Phone: +1 123 456 7890</p>
        </div>
        <div class="col-md-4">
          <h6 class="small"><strong><i class="fas fa-info-circle me-1"></i>About</strong></h6>
          <a href="#" class="d-block small text-warning">Our Story</a>
          <a href="#" class="d-block small text-warning">Privacy Policy</a>
        </div>
        <div class="col-md-4">
          <h6 class="small"><strong><i class="fas fa-map-marker-alt me-1"></i>Address</strong></h6>
          <p class="small mb-0">123 Learning Lane<br>Education City, Country</p>
        </div>
      </div>
      <hr class="my-2 opacity-50">
      <div class="text-center">
        <p class="small mb-0">&copy; 2025 SAS School. All Rights Reserved.</p>
      </div>
    </div>
  </footer>

  <!-- Inline Script for Session Variables -->
  <script>
    // Set session variables from JSP
    window.userRole = "<%= (role != null ? role.replace("\"", "\\\"") : "") %>";
    window.admissionNo = "<%= (admissionNo != null ? admissionNo.replace("\"", "\\\"") : "") %>";
    console.log("User role:", window.userRole);
    console.log("Admission No:", window.admissionNo);

    // Preloader handling (if element exists)
    window.addEventListener("load", function () {
      setTimeout(() => {
        const loader = document.getElementById("sun-loader");
        if (loader) loader.style.display = "none";
      }, 1200);
    });
  </script>

  <script src="addAnnouncement.js"></script>
  <script src="js/roleControl.js"></script>
</body>
</html>