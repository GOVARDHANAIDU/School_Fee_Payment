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
  HttpSession session2 = request.getSession();
  String name = (String) session2.getAttribute("adminName");

  if (name == null) {
      response.sendRedirect("AdminLogin.jsp");
      return;
  }

  String userName = "";
  for (int i = 0; i < name.length(); i++) {
      if (name.charAt(i) == ' ') break;
      userName += name.charAt(i);
  }

  // Fetching table names
  List<String> tableNames = new ArrayList<>();
  try {
      Class.forName("com.mysql.cj.jdbc.Driver");
      Connection con = DriverManager.getConnection(
          "jdbc:mysql://localhost:3306/academic_details", 
          "root", 
          "W7301@jqir#"
      );
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
    <a class="navbar-brand" href="#">SAS School</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
      <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarNav">
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
        <li class="nav-item"><a class="nav-link" href="#">Contact Us</a></li>
        <li class="nav-item"><a class="nav-link" href="#">About Us</a></li>
      </ul>

      <div class="d-flex align-items-center ms-auto">
        <span class="text-white me-3">Hello, <%= userName %></span>
        <a class="btn btn-outline-light me-2" href="AdminLogin.jsp">Logout</a>
        <a class="btn btn-outline-warning" href="createaccount.jsp">Signup</a>
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
