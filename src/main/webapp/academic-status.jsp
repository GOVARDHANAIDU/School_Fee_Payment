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

  <jsp:include page="includes/navbar.jsp" />

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
 <script src="js/roleControl.js"></script>

</body>
</html>