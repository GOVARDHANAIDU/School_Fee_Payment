<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>School Management Home</title>
  <link rel="icon" href="https://cdn-icons-png.flaticon.com/512/2132/2132732.png" type="image/x-icon">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"> 
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

  <style>
    body {
      font-family: 'Segoe UI', sans-serif;
      margin: 0;
      padding-top: 70px;
      background: #f8f9fa;
      font-size: 0.9rem; /* smaller text */
    }
    .navbar {
      position: fixed;
      top: 0;
      width: 100%;
      z-index: 1030;
    }
    .card {
      border-radius: 10px;
      box-shadow: 0px 3px 8px rgba(0,0,0,0.1);
      margin: auto;
      max-width: 850px;
    }
    h2, h4 {
      font-size: 1.0rem;
      font-weight: 600;
    }
    label {
      font-size: 0.85rem;
      font-weight: 500;
    }
    textarea, input, select {
      font-size: 0.85rem !important;
      padding: 0.4rem 0.6rem !important;
    }
    .btn {
      font-size: 0.85rem;
      padding: 0.35rem 1.2rem;
      border-radius: 6px;
    }
    table th, table td {
      font-size: 0.85rem;
      text-align: center;
      vertical-align: middle;
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
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">Payments</a>
          <ul class="dropdown-menu">
            <li><a class="dropdown-item" href="allpayments.jsp">All Payment Details</a></li>
            <li><a class="dropdown-item" href="apbme.jsp">Payment By Admin</a></li>
            <li><a class="dropdown-item" href="paymentdetails.jsp">All Payment Status</a></li>
          </ul>
        </li>
        <li class="nav-item"><a class="nav-link" href="fee-notifications.jsp">Send Notifications</a></li>
        <li class="nav-item"><a class="nav-link" href="#">Contact Us</a></li>
        <li class="nav-item"><a class="nav-link" href="#">About Us</a></li>
      </ul>

      <%
        HttpSession session2 = request.getSession();
        String name = (String) session2.getAttribute("adminName");
        if (name == null) {
            response.sendRedirect("AdminLogin.jsp");
            return;
        }
        String userName = "";
        for(int i=0; i<name.length(); i++) {
          char ch = name.charAt(i);
          if(ch == ' ') break;
          userName += ch;
        }
      %>
      <div class="d-flex align-items-center gap-3">
        <p class="text-white m-0 small">Hello, <%=userName%></p>
        <a class="btn btn-outline-light btn-sm" href="AdminLogin.jsp">Logout</a>
        <a class="btn btn-outline-warning btn-sm" href="createaccount.jsp">Signup</a>
      </div>
    </div>
  </div>
</nav>

<!-- Send Notifications Form -->
<div class="card p-4 mb-4 mt-4">
  <h2 class="mb-3 text-center">Send Bulk Notifications</h2>
  <form action="SendMessagesServlet" method="post" class="row g-2">
    <div class="col-12">
      <label class="form-label">Message</label>
      <textarea name="messageText" rows="2" class="form-control" placeholder="Type your notification..." required></textarea>
    </div>
    <div class="col-md-6">
      <label class="form-label">Min Balance</label>
      <input type="number" name="minBalance" class="form-control" required>
    </div>
    <div class="col-md-6">
      <label class="form-label">Max Balance</label>
      <input type="number" name="maxBalance" class="form-control" required>
    </div>
    <div class="col-md-6">
      <label class="form-label">Send Via</label>
      <select name="messageType" class="form-select">
        <option value="sms">SMS</option>
        <option value="whatsapp">WhatsApp</option>
      </select>
    </div>
    <div class="col-12 text-center mt-2">
      <button type="submit" class="btn btn-primary">Send</button>
    </div>
  </form>
</div>

<!-- Notifications Table -->
<div class="card p-3">
  <h4 class="mb-2">Notifications Sent</h4>
  <table id="notificationTable" class="table table-sm table-striped table-bordered">
    <thead class="table-dark">
      <tr>
        <th>Student Name</th>
        <th>Parent Name</th>
        <th>Phone</th>
        <th>Fee Balance</th>
        <th>Status</th>
      </tr>
    </thead>
    <tbody>
      <% 
        java.util.List<String[]> sentList = (java.util.List<String[]>) request.getAttribute("sentList");
        if(sentList != null) {
          for(String[] row : sentList) {
      %>
        <tr>
          <td><%= row[0] %></td>
          <td><%= row[1] %></td>
          <td><%= row[2] %></td>
          <td><%= row[3] %></td>
          <td><span class="badge bg-success">Sent</span></td>
        </tr>
      <% }} %>
    </tbody>
  </table>
</div>

<!-- Scripts -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datata3bles.net/1.13.6/js/dataTables.bootstrap5.min.js"></script>
<script>
  $(document).ready(function() {
    $('#notificationTable').DataTable({
      pageLength: 5,
      lengthMenu: [5, 10, 20, All],
    });
  });
</script>

</body>
</html>
