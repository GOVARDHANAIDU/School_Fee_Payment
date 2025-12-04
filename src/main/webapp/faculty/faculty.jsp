<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Student Dashboard - SAS School</title>
  <link rel="icon" href="https://cdn-icons-png.flaticon.com/512/2132/2132732.png" type="image/x-icon">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <!-- Bootstrap Icons -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
  <style>
    
    body {
      font-family: 'Segoe UI', sans-serif;
      background-color: #f8f9fa;
    }
    .card-link {
      text-decoration: none;
      color: inherit;
    }
    .feature-card {
      transition: transform 0.3s ease, box-shadow 0.3s ease;
      border-radius: 15px;
      background-color: #ffffff;
      box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
    }
    .feature-card:hover {
      transform: translateY(-6px);
      box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15);
    }
    .feature-icon {
      font-size: 3rem;
      color: #0d6efd;
    }
    .card-title {
      margin-top: 15px;
      font-weight: 600;
      font-size: 1.25rem;
    }
    .navbar {
      box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
      height: 50px;
      font-size: 0.9rem;
    }
    .modal-80w {
      max-width: 80%;
    }
    .modal-content .feature-card {
      margin-bottom: 1.5rem;
    }
  </style>
  <link href=".././student-profile.css" rel="stylesheet">
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark px-4">
  <div class="container-fluid">
    <a class="navbar-brand" href="#">SAS School</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
      <span class="navbar-toggler-icon"></span>
    </button>
 
    <div class="collapse navbar-collapse" id="navbarNav">
      <!-- Left side nav items -->
      <ul class="navbar-nav me-auto">
        <li class="nav-item"><a class="nav-link active" href="../home.jsp">Home</a></li>
 
<li class="nav-item"><a class="nav-link" href="../about.jsp">About Us</a></li>
 
        <!-- Students Dropdown -->
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">Students</a>
          <ul class="dropdown-menu">
            <li><a class="dropdown-item" href="../studentdetails.jsp">Student Details</a></li>
            <li><a class="dropdown-item" href="../allStudents.jsp">Student Payment Info</a></li>
            <li><a class="dropdown-item" href="../BillingPage.jsp">Student Fee Payment</a></li>
            <li><a class="dropdown-item" href="../studentreg.jsp">Create Student Details</a></li>
            <li><a class="dropdown-item" href="../create-class.jsp">Create Class</a></li>
            <li><a class="dropdown-item" href="../bulkimporting.jsp">Create Bulk</a></li>
            <li><a class="dropdown-item" href="../newupdates.jsp">Update Student Details</a></li>
          </ul>
        </li>
 
        <!-- Payments Dropdown -->
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" id="hideFunction()">Payments</a>
          <ul class="dropdown-menu">
            <li><a class="dropdown-item" href="../allpayments.jsp">All Payment Details</a></li>
            <li><a class="dropdown-item" href="../apbme.jsp">Payment By Admin</a></li>
            <li><a class="dropdown-item" href="../paymentdetails.jsp">All Payment Status</a></li>
          </ul>
        </li>
 
        <!-- Explore Dropdown -->
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">Explore</a>
          <ul class="dropdown-menu">
            <li><a class="dropdown-item" href="#">360° View</a></li>
            <li><a class="dropdown-item" href="#">Videos</a></li>
            <li><a class="dropdown-item" href="../images.jsp">Images</a></li>
          </ul>
        </li>
 
        <!-- Other Links -->
        <li class="nav-item"><a class="nav-link" href="../fee-notifications.jsp" id="hideFunction()">Send Notifications</a></li>
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
    if (displayName == null) {
        // For student or faculty, you might set a "userName" attribute in servlet; adjust as needed
        displayName = "User"; // Fallback
    }
    String userName = "";
    for(int i = 0; i < displayName.length(); i++) {
        char ch = displayName.charAt(i);
        if(ch == ' ') break;
        else userName += ch;
    }
    
    String role = (String)session.getAttribute("Roles");
    
    //System.out.println(role);
	    
%>
      <div class="d-flex align-items-center ms-3">
        <p class="text-white mb-0 me-3">Hello, <%=userName%></p>
 
        <!-- Roles Dropdown -->
        <div class="dropdown me-3">
          <a class="btn btn-sm btn-outline-light dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">
            Roles
          </a>
          <ul class="dropdown-menu dropdown-menu-end">
            <li><a class="dropdown-item" href="home.jsp" id="hideFunction()">Channel Admin</a></li>
            <li><a class="dropdown-item" href="home.jsp" >Student</a></li>
            <li><a class="dropdown-item" href="./faculty/faculty.jsp" id="hideFunction()">Faculty</a></li>
          </ul>
        </div>
 
        <!-- Auth Buttons -->
        <a class="btn btn-outline-light btn-sm me-2" href="AdminLogin.jsp">Logout</a>
        <a class="btn btn-outline-warning btn-sm" href="createaccount.jsp">Signup</a>
      </div>
    </div>
  </div>
</nav>

<!-- Student Feature Cards -->
<div class="container py-5">
  <h2 class="text-center mb-4 fw-bold">Faculty Features</h2>
  <div class="row g-4">
    <!-- Student Profile -->
    <div class="col-md-4">
      <a href="faculty-profile.jsp" class="card-link">
        <div class="p-4 text-center feature-card h-100">
          <i class="bi bi-person-badge feature-icon"></i>
          <div class="card-body">
            <h5 class="card-title">Faculty Profile</h5>
            <p class="card-text">View and edit personal and academic information.</p>
          </div>
        </div>
      </a>
    </div>

    <!-- Manage Fees -->
    <div class="col-md-4">
      <a href="#" class="card-link" data-bs-toggle="modal" data-bs-target="#paymentModal">
        <div class="p-4 text-center feature-card h-100">
          <i class="bi bi-currency-rupee feature-icon"></i>
          <div class="card-body">
            <h5 class="card-title">Manage Salary</h5>
            <p class="card-text">Check Salary history and Hikes</p>
          </div>
        </div>
      </a>
    </div>

    <!-- Academic Status -->
    <div class="col-md-4">
      <a href="#" class="card-link">
        <div class="p-4 text-center feature-card h-100">
          <i class="bi bi-journal-check feature-icon"></i>
          <div class="card-body">
            <h5 class="card-title">Question Papers<h5>
            <p class="card-text">Visualize academic growth through interactive reports.</p>
          </div>
        </div>
      </a>
    </div>

    <!-- Track Progress -->
    <div class="col-md-4">
      <a href="questions.jsp" class="card-link">
        <div class="p-4 text-center feature-card h-100">
          <i class="bi bi-bar-chart-line feature-icon"></i>
          <div class="card-body">
            <h5 class="card-title">Attendance Progress</h5>
            <p class="card-text">Visualize academic growth through interactive reports.</p>
          </div>
        </div>
      </a>
    </div>

    <!-- Test Results -->
    <div class="col-md-4">
      <a href="/SchoolData/questions.jsp" class="card-link">
        <div class="p-4 text-center feature-card h-100">
          <i class="bi bi-file-earmark-text feature-icon"></i>
          <div class="card-body">
            <h5 class="card-title">Test Results</h5>
            <p class="card-text">Access term-wise, unit test, and exam results easily.</p>
          </div>
        </div>
      </a>
    </div>


  </div>
</div>


<!-- Payment Modal 
<div class="modal fade" id="paymentModal" tabindex="-1" aria-labelledby="paymentModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-80w">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="paymentModalLabel">Payment Options</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <div class="row g-4">
          <!-- Fee Payment Card 
          <div class="col-md-4">
            <div class="p-4 text-center feature-card h-100">
              <i class="bi bi-wallet2 feature-icon"></i>
              <div class="card-body">
                <h5 class="card-title">Fee Payment</h5>
                <p class="card-text">Manage your fee payment details.</p>
                <a href="BillingPage.jsp" class="btn btn-primary mt-3">Manage</a>
              </div>
            </div>
          </div>
          <!-- Payment Info Card 
          <div class="col-md-4">
            <div class="p-4 text-center feature-card h-100">
              <i class="bi bi-credit-card feature-icon"></i>
              <div class="card-body">
                <h5 class="card-title">Payment Info</h5>
                <p class="card-text">Update your payment information.</p>
                <a href="allStudents.jsp" class="btn btn-primary mt-3">Manage</a>
              </div>
            </div>
          </div>
          <!-- Placeholder Card 1 
          <div class="col-md-4">
            <div class="p-4 text-center feature-card h-100">
              <i class="bi bi-receipt feature-icon"></i>
              <div class="card-body">
                <h5 class="card-title">Payment History</h5>
                <p class="card-text">View your payment history and receipts.</p>
                <a href="allpayments.jsp" class="btn btn-primary mt-3">Manage</a>
              </div>
            </div>
          </div>
          <!-- Placeholder Card 2 (Add more as needed) 
          <div class="col-md-4">
            <div class="p-4 text-center feature-card h-100">
              <i class="bi bi-bank feature-icon"></i>
              <div class="card-body">
                <h5 class="card-title">Bank Details</h5>
                <p class="card-text">Manage bank account details for payments.</p>
                <a href="#" class="btn btn-primary mt-3">Manage</a>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>
-->
<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<script>
  window.userRole = "<%= role.replace("\"", "\\\"") %>";
  console.log("User role:", window.userRole);
</script>

 <script src="js/roleControl.js"></script>
 
</body>
</html>