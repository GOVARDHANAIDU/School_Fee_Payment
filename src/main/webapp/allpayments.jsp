<%@page import="com.DTO.PaymentTransaction"%>
<%@page import="com.DAO.TransactionPageImp"%>
<%@page import="com.DAO.AllPaymentsByAdmin"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Student Fee Details</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- DataTables CSS -->
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/jquery.dataTables.min.css">
    <link rel="stylesheet" href="https://cdn.datatables.net/fixedheader/3.4.0/css/fixedHeader.dataTables.min.css">

    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.5.1.js"></script>

    <!-- DataTables JS -->
    <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/fixedheader/3.4.0/js/dataTables.fixedHeader.min.js"></script>

    <!-- Bootstrap JS (for dropdowns) -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <style>
        table.dataTable thead th {
            position: sticky;
            top: 0;
            background-color: #f8f9fa;
        }
        body {
	  padding-top: 75px; /* Adjust to match actual navbar height */
	}
    </style>
</head>
<body>

<!-- Navigation Bar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top px-4">
  <div class="container-fluid">
    <a class="navbar-brand" href="#">SAS School</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
      <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarNav">
      <!-- Left Side -->
      <ul class="navbar-nav me-auto">
        <li class="nav-item"><a class="nav-link active" href="home.jsp">Home</a></li>
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">Students</a>
          <ul class="dropdown-menu">
            <li><a class="dropdown-item" href="allStudents.jsp">All Student Info</a></li>
            <li><a class="dropdown-item" href="BillingPage.jsp">Student Fee Payment</a></li>
            <li><a class="dropdown-item" href="studentreg.jsp">Create Student Details</a></li>
            <li><a class="dropdown-item" href="bulkimporting.jsp">Create Bulk</a></li>
            <li><a class="dropdown-item" href="#">Update Student Details</a></li>
          </ul>
        </li>
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">Payments</a>
          <ul class="dropdown-menu">
            <li><a class="dropdown-item" href="allpayments.jsp">All Payment Details</a></li>
            <li><a class="dropdown-item" href="apbme.jsp">Admin Payment</a></li>
          </ul>
        </li>
        <li class="nav-item"><a class="nav-link" href="#">Contact Us</a></li>
        <li class="nav-item"><a class="nav-link" href="#">About Us</a></li>
      </ul>

      <!-- Right Side -->
      <%
        HttpSession session2 = request.getSession();
        String name = (String) session2.getAttribute("adminName");
        String userName = "";
        if (name != null) {
            for (int i = 0; i < name.length(); i++) {
                char ch = name.charAt(i);
                if (ch == ' ') break;
                userName += ch;
            }
        }
      %>
      <div class="d-flex align-items-center text-white me-3">
        <span>Hello, <%= userName %></span>
      </div>
      <div class="d-flex">
        <a class="btn btn-outline-light me-2" href="AdminLogin.jsp">Login</a>
        <a class="btn btn-outline-warning" href="createaccount.jsp">Signup</a>
      </div>
    </div>
  </div>
</nav>

<!-- Main Container -->
<div class="container pt-4">
    <center> <h2 class="mb-4">Student Fee Details</h2> </center>

    <div class="table-responsive">
        <table id="paymentTable" class="display table table-bordered table-hover">
            <thead class="table-light">
                <tr>
                    <th>S.No</th>
                    <th>Student Name</th>
                    <th>Total Fee</th>
                    <th>Paid Fee</th>
                    <th>Balance</th>
                    <th>Class</th>
                    <th>Date</th>
                    <th>Time</th>
                    <th>Mode</th>
                    <th>Billed By</th>
                </tr>
            </thead>
            <tbody>
                <%
                AllPaymentsByAdmin allPaymentsByAdmin = new TransactionPageImp();
                List<PaymentTransaction> list = allPaymentsByAdmin.selectAllPayments();
                int count = 1;
                for (PaymentTransaction fee : list) {
                %>
                <tr>
                    <td><%= count++ %></td>
                    <td><%= fee.getStudentNAme() %></td>
                    <td><%= fee.getTotal_fee() %></td>
                    <td><%= fee.getPaidFee() %></td>
                    <td><%= fee.getRemaingFee() %></td>
                    <td><%= fee.getStudentClass() %></td>
                    <td><%= fee.getDateOfTransaction() %></td>
                    <td><%= fee.getTimeOfTransaction() %></td>
                    <td><%= fee.getModeOfPayment() %></td>
                    <td><%= fee.getAdminName() %></td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>
    </div>
</div>

<!-- DataTable Init -->
<script>
    $(document).ready(function () {
        $('#paymentTable').DataTable({
            fixedHeader: true,
            order: [],
            columnDefs: [
                { orderable: true, targets: "_all" }
            ]
        });
    });
</script>

</body>
</html>
