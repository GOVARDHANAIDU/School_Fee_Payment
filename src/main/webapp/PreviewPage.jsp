<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Student Fee Receipt</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="icon" href="https://cdn-icons-png.flaticon.com/512/2132/2132732.png" type="image/x-icon">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
  <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <style>
    body {
      font-family: 'Segoe UI', sans-serif;
      background-color: #f9f9f9;
      margin: 0;
      padding-top: 70px;
      padding-bottom: 0;
    }

    /* Navbar */
    .navbar {
      position: fixed;
      top: 0;
      width: 100%;
      z-index: 1030;
      font-size: 0.9rem; /* Smaller font for attractiveness */
      height: 50px;
    }

    .navbar-brand {
      font-size: 0.9rem;
      font-weight: 600;
    }

    .navbar-nav .nav-link {
      padding: 4px 8px; /* Tighter padding for compact look */
    }

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

    @media print {
      body {
        margin: 0;
        padding: 0;
        background: white;
      }

      .print-btn, .btn-back {
        display: none !important; /* Hide buttons */
      }

      .navbar {
        display: none; /* Hide navbar on print */
      }

      @page {
        margin: 0; /* Remove default page margins */
      }
    }

    .receipt {
      max-width: 700px;
      margin: auto;
      background: #fff;
      padding: 25px 35px; /* Slightly tighter padding */
      border: 1px solid #ccc;
      border-radius: 10px;
      box-shadow: 0 0 10px rgba(0,0,0,0.1);
    }

    .header {
      text-align: center;
      margin-bottom: 25px; /* Tighter margin */
    }

    .header h1 {
      margin: 0;
      font-size: 24px; /* Smaller header font */
      color: #2a4365;
      font-weight: 600;
    }

    .header h3 {
      font-size: 18px; /* Smaller subheader */
      color: #2a4365;
      margin-top: 10px;
    }

    .header p {
      margin: 0;
      font-size: 13px; /* Smaller font */
      color: #444;
    }

    .info-section {
      margin-bottom: 18px; /* Tighter spacing */
    }

    .info-section table {
      width: 100%;
      border-collapse: collapse;
    }

    .info-section td {
      padding: 6px; /* Tighter padding */
      font-size: 14px; /* Smaller font */
    }

    .label {
      font-weight: bold;
      color: #333;
      width: 40%;
      border: none;
      font-size: 0.9rem; /* Smaller label font */
    }

    .amount-section {
      background: #f1f5f9;
      padding: 12px 18px; /* Tighter padding */
      border-radius: 8px;
      margin-top: 18px; /* Tighter margin */
    }

    .amount-section table {
      width: 100%;
    }

    .amount-section td {
      padding: 8px; /* Tighter padding */
      font-size: 14px; /* Smaller font */
      vertical-align: top; /* Align tops for better alignment */
    }

    .total {
      font-weight: bold;
      font-size: 16px; /* Slightly smaller */
      color: #2a4365;
    }

    .footer {
      text-align: center;
      margin-top: 25px; /* Tighter margin */
      font-size: 12px; /* Smaller font */
      color: #666;
    }

    input {
      border: 0px;
      background-color: transparent;
      outline: 0px;
      font-size: 14px; /* Consistent smaller font */
      width: 100%;
    }

    /* Button alignment: Back and Proceed side by side, no space */
    .button-group {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-top: 15px;
      gap: 10px; /* Minimal gap */
    }

    .print-btn, .btn-back {
      flex: 1;
      padding: 8px 20px; /* Balanced padding */
      background: #2a4365;
      color: white;
      border: none;
      border-radius: 6px;
      font-size: 14px; /* Smaller font */
      cursor: pointer;
      transition: background-color 0.3s ease;
      text-align: center;
      max-width: 150px; /* Limit width */
    }

    .print-btn:hover:not(:disabled), .btn-back:hover {
      background-color: #4c6795;
      transform: scale(1.02); /* Subtle hover for attractiveness */
    }

    .btn-back {
      background: #2a4365;
    }

    .btn-back:hover {
      background-color: #4c6795;
    }

    /* Beautiful Loading Spinner */
    .loading-overlay {
      position: fixed;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      background: rgba(255, 255, 255, 0.8);
      display: none;
      justify-content: center;
      align-items: center;
      z-index: 1050;
    }

    .spinner-beautiful {
      border: 4px solid #f3f3f3;
      border-top: 4px solid #2a4365;
      border-radius: 50%;
      width: 50px;
      height: 50px;
      animation: spin 1s linear infinite;
    }

    @keyframes spin {
      0% { transform: rotate(0deg); }
      100% { transform: rotate(360deg); }
    }

    .loading-text {
      margin-top: 10px;
      font-size: 16px;
      color: #2a4365;
    }

    #loading {
      display: none;
      text-align: center;
    }
  </style>
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
        <li class="nav-item"><a class="nav-link active" href="home.jsp">Home</a></li>
		
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
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">Payments</a>
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
        <li class="nav-item"><a class="nav-link" href="fee-notifications.jsp">Send Notifications</a></li>
        <li class="nav-item"><a class="nav-link" href="#">Contact Us</a></li>
        
      </ul>

      <!-- Right Side -->
<%
    // Session validation: Redirect to login if not authenticated
    // Check for any login indicator (admin, student, or faculty)
    HttpSession sessio = request.getSession(false); // Don't create new session if none exists
    if (sessio == null || 
        (sessio.getAttribute("adminName") == null && 
        sessio.getAttribute("studentId") == null && 
        sessio.getAttribute("facultyId") == null)) {
        response.sendRedirect("AdminLogin.jsp");
        return;
    }

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
%>
      <div class="d-flex align-items-center ms-3">
        <p class="text-white mb-0 me-3">Hello, <%=userName%></p>

        <!-- Roles Dropdown -->
        <div class="dropdown me-3">
          <a class="btn btn-sm btn-outline-light dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">
            Roles
          </a>
          <ul class="dropdown-menu dropdown-menu-end">
            <li><a class="dropdown-item" href="home.jsp">Channel Admin</a></li>
            <li><a class="dropdown-item" href="#">Student</a></li>
            <li><a class="dropdown-item" href="./faculty/faculty.jsp">Faculty</a></li>
          </ul>
        </div>

        <!-- Auth Buttons -->
        <a class="btn btn-outline-light btn-sm me-2" href="AdminLogin.jsp">Logout</a>
        <a class="btn btn-outline-warning btn-sm" href="createaccount.jsp">Signup</a>
      </div>
    </div>
  </div>
</nav>

  <div class="receipt">
    <div class="header">
      <h1>&#9925; Bright Future High School</h1>
      <p>123 School Lane, Knowledge City, India | Ph: 86456-56789</p>
      <hr style="margin-top: 15px;">
      <h3>Student Fee Receipt</h3>
    </div>

  <form action="addPayment" method="POST" id="paymentForm"> 
    <div class="info-section">
      <table>
      
       <tr>
          <td class="label">Admission Number:</td>
           <%  
           HttpSession session2 = request.getSession();
           String studentName = (String)session2.getAttribute("studentName");
           String email = (String)session2.getAttribute("email");
           String phone = (String)session2.getAttribute("phone");
           String  class1 = (String)session2.getAttribute("class1");
           double payingfee = (double)session2.getAttribute("payingfee");
           String admissionNumber = (String)session2.getAttribute("admissionNumber");
           double totalfee = (double)session2.getAttribute("totalamount");
           double paidfee = (double) session2.getAttribute("paidfee");
           String paymentMode = (String) session2.getAttribute("paymentMode");
           %>
           
          <td><input value="<%=admissionNumber%>" name="AdmissionNumber" readOnly></td>
        
        </tr>
        <tr>
          <td class="label">Student Name:</td>
          <td><input value="<%=studentName%>" name="studentName" readOnly></td>
        </tr>
        
        <tr>
          <td class="label">Email ID:</td>
          <td><input value="<%= email %>" name="emailId" readOnly></td>
        </tr>
        <tr>
          <td class="label">Phone Number:</td>
          <td><input value="<%= phone %>" name="phoneNumber" readOnly></td>
        </tr>
      </table>
    </div>

    <div class="amount-section">
      <table>
        <tr>
          <td class="label">Mode of Payment:</td>
          <td><input value="<%= paymentMode %>" name="modeOfPayment" readOnly></td>
            <%
          session2.setAttribute("paymentMode", paymentMode);
          %>
        </tr>
        <tr>
          <td class="label">Total Fee:</td>
          <td>₹ <input value="<%=totalfee%>" name="totalFee" readOnly style="display: inline; width: auto;"></td>
          <%
          session2.setAttribute("totalfee", totalfee);
          %>
        </tr>
        <tr>
          <td class="label">Fee Already Paid:</td>
          <td>₹ <input value="<%= paidfee %>" name="paidFee" readOnly style="display: inline; width: auto;"></td>
            <%
           session2.setAttribute("paidFee", paidfee);
          %>
        </tr>
        <tr>
          <td class="label">Fee Paid Now:</td>
          <td>₹ <input value="<%= payingfee %>" name="payingFee" readOnly style="display: inline; width: auto;"></td>
           <%
          session2.setAttribute("payingfee", payingfee);
          %>
        </tr>
        <tr>
          <td class="label total">Remaining Balance:</td>
          <td class="total">
            ₹ 
            <%
              try {
                double total = totalfee;
                double paid = paidfee;
                double now = payingfee;
                double balance = paid + now;
                double remainingBalance = total - balance;
                session2.setAttribute("remainingBalance", remainingBalance);
                out.print(remainingBalance);
              } catch (Exception e) {
                out.print("N/A");
              }
            %>
            
          </td>
        </tr>
        <tr>
          <td class="label">Class&Section:</td>
          <td><input value="<%= class1 %>" name="class" readOnly></td>
        </tr>
      </table>
    </div>

    <div class="footer">
      <p>Generated on: <%= new java.util.Date() %></p>
     
    </div>
    
    <!-- Button Group: Back and Proceed aligned straight with minimal space -->
    <div class="button-group">
      <button type="button" class="btn-back" onclick="history.back()">← Back</button>
      <button type="button" class="print-btn" data-bs-toggle="modal" data-bs-target="#confirmationModal">Proceed</button>
    </div>
      </form>
  </div>

 <!-- Loading Overlay -->
 <div class="loading-overlay" id="loadingOverlay">
   <div style="text-align: center;">
     <div class="spinner-beautiful"></div>
     <div class="loading-text">Processing your payment...</div>
   </div>
 </div>

 <!-- Bootstrap Modal -->
<div class="modal fade" id="confirmationModal" tabindex="-1" aria-labelledby="confirmationModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="confirmationModalLabel">Confirm Submission</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        Are you sure you want to proceed with the fee payment?
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
        <button type="button" class="btn btn-primary" id="confirmBtn">I Confirm</button>
      </div>
    </div>
  </div>
</div>
        
<!-- Script to submit the form with loading -->
<script>
  document.getElementById('confirmBtn').addEventListener('click', function() {
    // Hide modal
    const modal = bootstrap.Modal.getInstance(document.getElementById('confirmationModal'));
    modal.hide();
    
    // Show loading overlay
    document.getElementById('loadingOverlay').style.display = 'flex';
    
    // Submit form after a short delay for visual effect
    setTimeout(function() {
      document.getElementById('paymentForm').submit();
    }, 500);
  });
</script>

<!-- Footer (added for consistency, but hidden on print) -->
<footer class="footer bg-dark text-white py-4 mt-5">
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