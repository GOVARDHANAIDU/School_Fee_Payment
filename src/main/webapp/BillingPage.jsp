<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Student Info Lookup</title>
  <link rel="icon" href="https://cdn-icons-png.flaticon.com/512/2132/2132732.png" type="image/x-icon">
  <!-- Select2 CSS -->
  <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
 
  <!-- Fonts and custom CSS -->
  <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <style>
    
    .dropdown-menu {
      font-size: 0.8rem; /* Smaller dropdown font */
    }
 
    .dropdown-item {
      padding: 6px 12px;
    }
 
    /* Footer */
    .footer {
      margin-bottom: 0;
      padding-bottom: 0;
    }
 
    .footer a {
      color: #ffc107;
      text-decoration: none;
    }
 
    .maincontainer {
      background: white;
      padding: 30px 40px;
      border-radius: 12px;
      box-shadow: 0 4px 20px rgba(0, 0, 0, 0.15);
      width: 900px;
      margin: auto;
      margin-bottom: 50px; /* Adjusted for better spacing */
    }
 
    .leftcontainer, .rightcontainer {
      width: 45%;
      display: inline-block;
      vertical-align: top;
      margin: 0 2%;
    }
 
    h2 {
      text-align: center;
      color: #2b6cb0;
      margin-bottom: 30px;
      font-size: 1.5rem; /* Smaller header font */
      font-weight: 600;
    }
 
    label {
      font-weight: bold;
      margin-top: 15px;
      display: block;
      color: #2a4365;
      font-size: 0.9rem; /* Smaller label font */
    }
 
    input, select {
      width: 100%;
      padding: 8px; /* Slightly smaller padding */
      margin-top: 5px;
      margin-bottom: 15px; /* Tighter spacing */
      border: 1px solid #cbd5e0;
      border-radius: 6px;
      font-size: 14px; /* Smaller input font */
    }
 
    input[readonly] {
      background-color: #f1f5f9;
      cursor: not-allowed;
    }
 
    .select2-container .select2-selection--single {
      height: 38px; /* Adjusted height for smaller font */
      padding: 4px 8px;
    }
 
    .select2-container--default .select2-selection--single .select2-selection__rendered {
      font-size: 14px;
    }
 
    .rightcontainer {
      margin-top: -3%;
    }
 
    .preview {
      width: 28%;
      margin-left: 35%;
      height: 40px;
      border-radius: 30px;
      background: linear-gradient(135deg, #dff6ff, #b6e3f9);
      border: none;
      font-size: 0.9rem;
      font-weight: 500;
      transition: transform 0.2s ease; /* Hover effect for attractiveness */
    }
 
    .preview:hover:not(:disabled) {
      transform: scale(1.02);
    }
 
    .preview:disabled {
      opacity: 0.6;
      cursor: not-allowed;
    }
     </style>
      <link href="./student-profile.css" rel="stylesheet">
    
</head>
<body>

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
    String admissionNo = (String)session.getAttribute("admissionNo");
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
 
  <div class="maincontainer">
  <br><br>
<h2>Student Fee Billing</h2>
    <div class="leftcontainer">
      <label for="studentDropdown">Select Student:</label>
      <select id="studentDropdown" name="studentName" style="width: 100%">
        <option></option>
      </select>
      <%
        HttpSession session2 = request.getSession();
        session2.setAttribute("studentName", request.getParameter("studentName"));
        System.out.println(request.getParameter("studentName"));
      %>
      <label for="email">Email:</label>
      <input type="text" id="email" readonly name="email" />
 
      <label for="totalFee">Total Fee:</label>
      <input type="text" id="totalFee" readonly name="totalFee">


      <label for="paidfee">Paid Fee:</label>
      <input type="text" id="paidfee" readonly name="paidfee" />
 
      <label for="class1">Class:</label>
      <input type="text" id="class1" placeholder="Class 1 to 10" name="class1" readonly />
    </div>
 
    <div class="rightcontainer">
      <label for="admissionnumber">Admission.no:</label>
      <input type="text" id="admissionnumber" readonly name="admissionnumber" />
 
      <label for="phone">Phone Number:</label>
      <input type="text" id="phone" readonly name="phone" />
 
      <label for="payingfee">Paying fee:</label>
      <input type="number" id="payingfee" name="payingfee">
 
      <label for="modeOfPayment">Mode of payment:</label>
      <select name="paymentMode" id="paymentMode" required="required">
        <option value="Cash">Cash</option>
        <option value="Online">Online</option>
      </select>
 
      <label>Billed By:</label>
      <input type="text" value="<%=displayName%>" readonly>
    </div>
 
    <button id="proceedBtn" class="preview" disabled>Proceed</button>
 
  </div>
 
<!-- jQuery and JS -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
 
<script>
  window.userRole = "<%= role.replace("\"", "\\\"") %>";
  window.admissionNo = "<%= admissionNo.replace("\"", "\\\"") %>";
  console.log("User role:", window.userRole);
  
  document.addEventListener("DOMContentLoaded", function () {
      const role = window.userRole;
      
      if (role && role.toLowerCase() === "student") {
          const cashOption = document.querySelector('#paymentMode option[value="Cash"]');
          const paymentMode = document.getElementById("paymentMode");

          // Disable and hide Cash option
          if (cashOption) cashOption.hidden = true;

          // Force Online as selected for students
          paymentMode.value = "Online";
      }
  });
  
</script>
<script src="js/billing.js"></script>
 <script src="js/roleControl.js"></script>
 
<!-- Footer (added to match home.jsp structure for consistency) -->
<footer class="footer bg-dark text-white py-3 mt-4">
  <div class="container">
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
 
</body>
</html>