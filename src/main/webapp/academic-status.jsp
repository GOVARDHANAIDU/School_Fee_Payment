<%@page import="com.DAO.DatabaseConnectivity"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*, javax.servlet.http.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>Select Class</title>
  <link rel="icon" href="https://cdn-icons-png.flaticon.com/512/2132/2132732.png" type="image/x-icon">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
  <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
  <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <style>
    body {
      font-family: 'Segoe UI', sans-serif;
      background-color: #f8f9fa;
      padding-top: 70px;
    }

    .navbar {
      position: fixed;
      top: 0;
      width: 100%;
      z-index: 1030;
    }

    h2 {
      text-align: center;
      margin-bottom: 30px;
    }

    .select2-container {
      width: 100% !important;
    }

    .container-box {
      padding-top: 50px;
    }
  </style>
</head>
<body>

<%
  // Session check
  HttpSession sessionObj = request.getSession();
  String name = (String) sessionObj.getAttribute("adminName");

  if (name == null) {
      response.sendRedirect("AdminLogin.jsp");
      return;
  }

  String userName = "";
  for (int i = 0; i < name.length(); i++) {
      if (name.charAt(i) == ' ') break;
      userName += name.charAt(i);
  }

  // Prevent caching to avoid back/forward navigation issues after logout or session expiry
  response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
  response.setHeader("Pragma", "no-cache");
  response.setDateHeader("Expires", 0);

  String role = (String)sessionObj.getAttribute("Roles");
  String admissionNo = (String)sessionObj.getAttribute("admissionNo");
  //System.out.println(role);

  // Fetching table names
  List<String> tableNames = new ArrayList<>();
  try {
      Class.forName("com.mysql.cj.jdbc.Driver");
      Connection con = 
    		  DriverManager.getConnection("jdbc:mysql://trolley.proxy.rlwy.net:49592/academic_details?useSSL=false&allowPublicKeyRetrieval=true" ,"root", "IIoeacGMfpglDLjgmSkwWIQoajFikXvz");
      DatabaseMetaData dbm = con.getMetaData();
      ResultSet rs = dbm.getTables("academic_details", "academic_details", "%", new String[]{"TABLE"});

      while (rs.next()) {
          tableNames.add(rs.getString("TABLE_NAME"));
      }

      con.close();
  } catch (Exception e) {
      out.println("DB Error: " + e.getMessage());
  }
%>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark px-4">
  <div class="container-fluid">
    <div class="d-flex align-items-center">
      <img src="https://img.pikbest.com/png-images/20241026/simple-useful-bright-sun-and-cloud-logo-a-clear-sky-icon-design-vector_11001223.png!sw800" alt="SAS Logo"
      style="height: 40px; margin-right: 10px;">
      <a class="navbar-brand mb-0" href="home.jsp">SAS School</a>
    </div>
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

<!-- Main Container -->
<div class="container container-box">
  <h2>Select a Class</h2>
  <form method="get" action="showdata.jsp">
    <div class="row justify-content-center">
      <div class="col-md-6 mb-3">
        <label class="form-label">Class List</label>
        <select class="form-select js-example-basic-single" name="tableName" required>
          <option value="">-- Select Class --</option>
          <% for (String table : tableNames) { %>
            <option value="<%= table %>"><%= table %></option>
          <% } %>
        </select>
      </div>
      <div class="col-md-2 mb-3 d-flex align-items-end">
        <button class="btn btn-primary w-100" type="submit">Show Class</button>
      </div>
    </div>
  </form>
</div>

<!-- Select2 Init -->
<script>
  $(document).ready(function () {
    $('.js-example-basic-single').select2({
      placeholder: "Search class...",
      allowClear: true
    });
  });
</script>

</body>
</html>