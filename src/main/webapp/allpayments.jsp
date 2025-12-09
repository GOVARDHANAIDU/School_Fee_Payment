<%@page import="com.DAO.StudentDetailsImp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@page import="com.DTO.PaymentTransaction"%>
<%@page import="com.DAO.TransactionPageImp"%>
<%@page import="com.DAO.AllPaymentsByAdmin"%>
<%@page import="com.DTO.StudentDetails"%>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Set" %>
<%@ page import="java.util.HashSet" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Fee Details</title>
 
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="icon" href="https://cdn-icons-png.flaticon.com/512/2132/2132732.png" type="image/x-icon">
    <!-- DataTables CSS -->
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/jquery.dataTables.min.css">
    <link rel="stylesheet" href="https://cdn.datatables.net/fixedheader/3.4.0/css/fixedHeader.dataTables.min.css">
    <!-- DataTables Buttons CSS -->
    <link rel="stylesheet" href="https://cdn.datatables.net/buttons/2.4.2/css/buttons.dataTables.min.css">
 
    <!-- Chart.js -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
 
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.5.1.js"></script>
 
    <!-- DataTables JS -->
    <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/fixedheader/3.4.0/js/dataTables.fixedHeader.min.js"></script>
    <!-- DataTables Buttons JS -->
    <script src="https://cdn.datatables.net/buttons/2.4.2/js/dataTables.buttons.min.js"></script>
    <script src="https://cdn.datatables.net/buttons/2.4.2/js/buttons.html5.min.js"></script>
    <!-- JSZip for Excel export -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.10.1/jszip.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/pdfmake.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/vfs_fonts.js"></script>
    <script src="https://cdn.datatables.net/buttons/2.4.2/js/buttons.colVis.min.js"></script>
 
    <!-- Bootstrap JS (for dropdowns) -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
 
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            margin: 0;
            padding-top: 70px;
            padding-bottom: 0;
            background-color: #f8f9fa;
        }
 
        .section-header {
            margin: 15px 0 8px;
            font-size: 1.1rem;
            text-align: center;
            color: #495057;
            border: 1px solid #dee2e6;
            border-top: none;
            padding: 10px;
            background-color: #f8f9fa;
        }
 
        .main-title {
            margin-top: 0 !important;
            padding-top: 0 !important;
        }
 
        .card {
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
            margin-bottom: 10px;
            border: 1px solid #e9ecef;
            border-radius: 8px;
            overflow: hidden;
        }
 
        .card-body {
            padding: 0.75rem;
            text-align: center;
        }
 
        .card-title {
            font-size: 0.8rem;
            margin-bottom: 0.4rem;
            color: #6c757d;
            font-weight: 500;
        }
 
        .card-text {
            font-size: 0.95rem;
            font-weight: bold;
            color: #212529;
        }
 
        .table-responsive {
            max-height: 400px;
            overflow-y: auto;
            border-radius: 8px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
            border: 1px solid #e9ecef;
        }
 
        .table {
            font-size: 0.8rem;
            margin-bottom: 0;
            border: 1px solid #dee2e6;
        }
 
        .table th, .table td {
            padding: 0.5rem 0.3rem;
            text-align: center;
            vertical-align: middle;
            border: 1px solid #dee2e6;
        }
 
        .table thead th {
            position: sticky;
            top: 0;
            background-color: #f8f9fa;
            z-index: 10;
            border-bottom: 1px solid #dee2e6;
        }
 
        .btn-group .btn {
            font-size: 0.75rem;
            padding: 0.25rem 0.5rem;
            margin-right: 1px;
        }
 
        canvas {
            max-height: 160px !important;
            width: 100% !important;
        }
 
        .container {
            margin-top: 0;
            padding: 0 10px;
            max-width: 85%; /* Use 85% of desktop page */
        }
 
        table.dataTable thead th {
            position: sticky;
            top: 0;
            background-color: #f8f9fa;
        }
 
        /* Light borders for all sections */
        .analytics-section {
            border: 1px solid #e9ecef;
            padding: 12px;
            margin-bottom: 15px;
            border-radius: 8px;
            background-color: #fff;
        }
 
        .class-stats-section {
            border: 1px solid #e9ecef;
            padding: 12px;
            margin-bottom: 15px;
            border-radius: 8px;
            background-color: #fff;
        }
 
        .additional-analytics-section {
            border: 1px solid #e9ecef;
            padding: 12px;
            margin-bottom: 15px;
            border-radius: 8px;
            background-color: #fff;
        }
 
        /* Align dropdown to left */
        .period-selector {
            text-align: left;
        }
 
        .billed-scroll {
            max-height: 150px;
            overflow-y: auto;
        }
 
        /* DataTables Buttons Styling with Colors */
        .dt-button.buttons-pdf {
            background: #007bff !important;
            color: white !important;
            border: 1px solid #007bff !important;
        }
 
        .dt-button.buttons-pdf:hover {
            background: #0056b3 !important;
            border: 1px solid #0056b3 !important;
        }
 
        .dt-button.buttons-excel {
            background: #28a745 !important;
            color: white !important;
            border: 1px solid #28a745 !important;
        }
 
        .dt-button.buttons-excel:hover {
            background: #1e7e34 !important;
            border: 1px solid #1e7e34 !important;
        }
 
        .dt-button.buttons-colvis {
            background: #6c757d !important;
            color: white !important;
            border: 1px solid #6c757d !important;
        }
 
        .dt-button.buttons-colvis:hover {
            background: #545b62 !important;
            border: 1px solid #545b62 !important;
        }
 
        /* Desktop: Compact sizing and alignment (85% width enforced) */
        @media (min-width: 993px) {
            .container {
                padding: 0 20px;
                max-width: 85%;
            }
 
            .section-header {
                font-size: 1.2rem;
                margin: 20px 0 10px;
            }
 
            .card-body {
                padding: 0.5rem;
            }
 
            .card-text {
                font-size: 0.9rem;
            }
 
            .card-title {
                font-size: 0.75rem;
            }
 
            .analytics-section, .class-stats-section, .additional-analytics-section {
                padding: 8px;
                margin-bottom: 12px;
            }
 
            canvas {
                max-height: 120px !important;
            }
 
            .table {
                font-size: 0.75rem;
            }
 
            .table th, .table td {
                padding: 0.4rem 0.2rem;
            }
 
            /* Align cards in a single row where possible */
            .dashboard-row .col-md-2 {
                padding: 0 5px;
            }
        }
 
        /* Tablet/Medium: Balanced sizing */
        @media (min-width: 769px) and (max-width: 992px) {
            .container {
                padding: 0 15px;
                max-width: 90%; /* Slightly wider for tablet */
            }
 
            .section-header {
                font-size: 1.15rem;
                margin: 18px 0 9px;
            }
 
            .card-body {
                padding: 0.6rem;
            }
 
            .card-text {
                font-size: 0.95rem;
            }
 
            .card-title {
                font-size: 0.8rem;
            }
 
            .analytics-section, .class-stats-section, .additional-analytics-section {
                padding: 10px;
                margin-bottom: 14px;
            }
 
            canvas {
                max-height: 130px !important;
            }
 
            .table {
                font-size: 0.78rem;
            }
 
            .table th, .table td {
                padding: 0.45rem 0.25rem;
            }
 
            /* Align cards in a single row where possible */
            .dashboard-row .col-md-2 {
                padding: 0 6px;
            }
        }
 
        /* Mobile: Larger elements for readability */
        @media (max-width: 768px) {
            body {
                padding-top: 60px;
            }
 
            .container {
                padding: 0 5px;
                margin-top: 0;
                max-width: 100%; /* Full width on mobile */
            }
 
            .section-header {
                font-size: 1.1rem; /* Bigger on mobile */
                margin: 12px 0 6px;
            }
 
            .main-title {
                font-size: 1.2rem; /* Bigger title */
            }
 
            .card-body {
                padding: 1rem; /* Increased padding */
            }
 
            .card-text {
                font-size: 1.1rem; /* Bigger text */
            }
 
            .card-title {
                font-size: 0.9rem; /* Slightly bigger */
            }
 
            .analytics-section, .class-stats-section, .additional-analytics-section {
                padding: 12px;
                margin-bottom: 15px;
            }
 
            canvas {
                max-height: 160px !important; /* Bigger charts */
            }
 
            .table {
                font-size: 0.8rem; /* Bigger table font */
            }
 
            .table th, .table td {
                padding: 0.4rem 0.2rem;
            }
 
            /* Remove empty spaces by reducing margins */
            .row {
                margin: 0 -5px;
            }
 
            .row > [class*="col-"] {
                padding: 0 5px;
                margin-bottom: 10px; /* Increased spacing */
            }
        }
 
        /* Extra small mobile (e.g., 400px width) - Even bigger for average mobile */
        @media (max-width: 480px) {
            body {
                padding-top: 55px;
            }
 
            .container {
                padding: 0 3px;
            }
 
            .section-header {
                font-size: 1.05rem;
                margin: 10px 0 5px;
            }
 
            .main-title {
                font-size: 1.15rem;
            }
 
            .card-body {
                padding: 0.8rem;
            }
 
            .card-text {
                font-size: 1.05rem;
            }
 
            .card-title {
                font-size: 0.85rem;
            }
 
            .analytics-section, .class-stats-section, .additional-analytics-section {
                padding: 10px;
                margin-bottom: 12px;
            }
 
            canvas {
                max-height: 140px !important;
            }
 
            .table {
                font-size: 0.75rem;
            }
 
            .table th, .table td {
                padding: 0.3rem 0.15rem;
            }
 
            /* Ensure full-width stacking for very small screens */
            .row > [class*="col-"] {
                margin-bottom: 8px;
            }
 
            .dashboard-row .col-6 {
                flex: 0 0 100%;
                max-width: 100%;
            }
        }
 
        /* Navbar mobile tweaks */
        @media (max-width: 991px) {
            .navbar-nav .dropdown-menu {
                position: static;
                float: none;
                width: auto;
                margin-top: 0;
                background-color: transparent;
                border: 0;
                box-shadow: none;
            }
 
            .navbar-nav .dropdown-menu .dropdown-item {
                padding-left: 20px;
            }
        }
    </style>
    <link href="./student-profile.css" rel="stylesheet">
</head>
<body>
<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark px-4 fixed-top">
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
 
<%
    // Move calculations to top
    StudentDetailsImp sdi = new StudentDetailsImp();
    List<StudentDetails> studentList = sdi.allStudentDetails();
    double totalFee = 0;
    double totalPaid = 0;
    double totalBalance = 0;
    int uniqueStudentsCount = studentList.size();
    Map<String, Double> classPaidSum = new HashMap<>();
    for(StudentDetails sd : studentList){
        totalFee += sd.getTotalFee();
        totalPaid += sd.getPaidFee();
        totalBalance += sd.getRemainingFee();
        String cls = sd.getStudentClass();
        classPaidSum.put(cls, classPaidSum.getOrDefault(cls, 0.0) + sd.getPaidFee());
    }
 
    AllPaymentsByAdmin allPaymentsByAdmin = new TransactionPageImp();
    List<PaymentTransaction> list = allPaymentsByAdmin.selectAllPayments();
    Map<String, Integer> classTransCount = new HashMap<>();
    for(PaymentTransaction pt : list){
        String cls = pt.getStudentClass();
        classTransCount.put(cls, classTransCount.getOrDefault(cls, 0) + 1);
    }
 
    Set<String> classesSet = new HashSet<>();
    classesSet.addAll(classPaidSum.keySet());
    classesSet.addAll(classTransCount.keySet());
%>
 
<script>
var totalFeeVal = <%= totalFee %>;
var totalPaidVal = <%= totalPaid %>;
var totalBalanceVal = <%= totalBalance %>;
var uniqueStudentsCountVal = <%= uniqueStudentsCount %>;
var classTransCounts = {
<%
    boolean first = true;
    for(String cls : classesSet){
        if(!first) out.print(",");
        out.print("\"" + cls + "\":" + classTransCount.getOrDefault(cls, 0));
        first = false;
    }
%>
};
var classPaidSums = {
<%
    first = true;
    for(String cls : classesSet){
        if(!first) out.print(",");
        out.print("\"" + cls + "\":" + classPaidSum.getOrDefault(cls, 0.0));
        first = false;
    }
%>
};
</script>
 
<!-- Main Container -->
<div class="container">
    <h2 class="section-header main-title">All Fee Payments Details</h2>
    <!-- Dashboard Analytics -->
    <h3 class="section-header">Dashboard Analytics</h3>
    <div class="analytics-section">
        <div class="row dashboard-row g-2 justify-content-center">
            <div class="col-6 col-md-2">
                <div class="card text-center h-100">
                    <div class="card-body">
                        <h5 class="card-title">Total Transactions</h5>
                        <p class="card-text" id="totalTransactions"><%= list.size() %></p>
                    </div>
                </div>
            </div>
            <div class="col-6 col-md-2">
                <div class="card text-center h-100">
                    <div class="card-body">
                        <h5 class="card-title">Total Collected</h5>
                        <p class="card-text" id="totalCollected"><%= totalPaid %></p>
                    </div>
                </div>
            </div>
            <div class="col-6 col-md-2">
                <div class="card text-center h-100">
                    <div class="card-body">
                        <h5 class="card-title">Average Transaction</h5>
                        <p class="card-text" id="averageTransaction">0</p>
                    </div>
                </div>
            </div>
            <div class="col-6 col-md-2">
                <div class="card text-center h-100">
                    <div class="card-body">
                        <h5 class="card-title">Unique Students</h5>
                        <p class="card-text" id="uniqueStudents"><%= uniqueStudentsCount %></p>
                    </div>
                </div>
            </div>
            <div class="col-6 col-md-2">
                <div class="card text-center h-100">
                    <div class="card-body">
                        <h5 class="card-title">Total Fee</h5>
                        <p class="card-text" id="totalFee"><%= totalFee %></p>
                    </div>
                </div>
            </div>
            <div class="col-6 col-md-2">
                <div class="card text-center h-100">
                    <div class="card-body">
                        <h5 class="card-title">Total Balance</h5>
                        <p class="card-text" id="totalBalance"><%= totalBalance %></p>
                    </div>
                </div>
            </div>
        </div>
        <div class="row g-2 justify-content-center mt-2">
            <div class="col-12 col-md-6">
                <div class="card text-center h-100">
                    <div class="card-body">
                        <h5 class="card-title">Payment Modes (by Amount)</h5>
                        <canvas id="paymentModesPie" height="150"></canvas>
                    </div>
                </div>
            </div>
            <div class="col-12 col-md-6">
                <div class="card text-center h-100">
                    <div class="card-body">
                        <h5 class="card-title">Fee Status (Collected vs Balance)</h5>
                        <canvas id="feeStatusPie" height="150"></canvas>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Class-wise Payment Statistics -->
    <h4 class="section-header">Class-wise Payment Statistics</h4>
    <div class="class-stats-section">
        <div class="table-responsive">
            <table class="table table-bordered table-hover" id="classStatsTable">
                <thead class="table-light">
                    <tr>
                        <th>Class</th>
                        <th>Transactions</th>
                        <th>Total Collected</th>
                        <th>Avg Transaction</th>
                    </tr>
                </thead>
                <tbody>
                    <!-- Populated dynamically -->
                </tbody>
            </table>
        </div>
    </div>
    <!-- Additional Analytics -->
    <h4 class="section-header">Additional Analytics</h4>
    <div class="additional-analytics-section">
        <div class="row g-2">
            <div class="col-12 col-md-6 mb-2">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Transactions per Class</h5>
                        <canvas id="transactionsPerClass" height="150"></canvas>
                    </div>
                </div>
            </div>
            <div class="col-12 col-md-6 mb-2">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Collections per Class</h5>
                        <canvas id="collectedPerClass" height="150"></canvas>
                    </div>
                </div>
            </div>
        </div>
        <div class="row g-2">
            <div class="col-12 col-md-6 mb-2">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Collected by Billed By</h5>
                        <div class="billed-scroll">
                            <canvas id="billedByPie" height="150"></canvas>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-12 col-md-6 mb-2">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Collections</h5>
                        <div class="period-selector mb-2">
                            <select id="collectionPeriod" class="form-select form-select-sm" style="max-width: 120px;">
                                <option value="daily">Daily</option>
                                <option value="weekly">Weekly</option>
                                <option value="monthly">Monthly</option>
                                <option value="yearly">Yearly</option>
                            </select>
                        </div>
                        <canvas id="dailyCollections" height="150"></canvas>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Custom Download Buttons -->
    <div class="btn-group mb-2" role="group">
        <button id="download-pdf" class="btn btn-primary">PDF</button>
        <button id="download-xlsx" class="btn btn-success">Excel</button>
        <div class="btn-group">
            <button class="btn btn-secondary dropdown-toggle" type="button" id="columnToggleDropdown" data-bs-toggle="dropdown">
                Columns
            </button>
            <ul class="dropdown-menu" id="column-list"></ul>
        </div>
    </div>
    <!-- Table to Display Payment Details -->
    <div class="table-responsive">
        <table id="paymentTable" class="display table table-bordered table-hover">
            <thead class="table-light">
                <tr>
                    <th>S.No</th>
                    <th>Student Name</th>
                    <th>Total Fee</th>
                    <th>Paid Fee</th>
                    <th>Lastly Paid Fee</th>
                    <th>Balance</th>
                    <th>Class</th>
                    <th>Date</th>
                    <th>Time</th>
                    <th>Mode</th>
                    <th>Billed By</th>
                    <th>Print</th>
                </tr>
            </thead>
            <tbody>
            <%
                int count = 1;
                for (int i = list.size() - 1; i >= 0; i--) {
                    PaymentTransaction fee = list.get(i);
            %>
            <tr>
                <td><%= count++ %></td>
                <td><%= fee.getStudentNAme() %></td>
                <td><%= fee.getTotal_fee() %></td>
                <td><%= fee.getPaidFee() %></td>
                <td><%= fee.getPayingFee() %></td>
                <td><%= fee.getRemaingFee() %></td>
                <td><%= fee.getStudentClass() %></td>
                <td><%= fee.getDateOfTransaction() %></td>
                <td><%= fee.getTimeOfTransaction() %></td>
                <td><%= fee.getModeOfPayment() %></td>
                <td><%= fee.getAdminName() %></td>
                <td><button class="btn btn-sm btn-primary" onclick="printReceipt(this)">Print</button></td>
            </tr>
            <%
                }
            %>
            </tbody>
        </table>
    </div>
</div>
<!-- Scripts -->
<script>
    $(document).ready(function () {
        function getTodayDate() {
            const today = new Date();
            const year = today.getFullYear();
            const month = String(today.getMonth() + 1).padStart(2, '0');
            const day = String(today.getDate()).padStart(2, '0');
            return `${year}-${month}-${day}`;
        }
 
        const table = $('#paymentTable').DataTable({
            fixedHeader: true,
            order: [],
            lengthMenu: [[10, 25, 50, 100, -1], [10, 25, 50, 100, "All"]],
            columnDefs: [{ orderable: true, targets: "_all" }, { targets: -1, orderable: false }],
            responsive: true,
            dom: 'frtip',
            buttons: [
                {
                    extend: 'excelHtml5',
                    title: 'all_payments_details_' + getTodayDate(),
                    className: 'buttons-excel d-none'
                },
                {
                    extend: 'pdfHtml5',
                    title: 'all_payments_details_' + getTodayDate(),
                    className: 'buttons-pdf d-none'
                },
                {
                    extend: 'colvis',
                    className: 'buttons-colvis d-none'
                }
            ]
        });

        // Custom button handlers
        $('#download-pdf').on('click', function() {
            table.button('.buttons-pdf').trigger();
        });
        $('#download-xlsx').on('click', function() {
            table.button('.buttons-excel').trigger();
        });

        // Custom column visibility dropdown
        table.columns().every(function(index) {
            var column = this;
            var title = $(column.header()).text().trim();
            $('#column-list').append(
                '<li><label class="dropdown-item"><input type="checkbox" value="' + index + '" checked> ' + title + '</label></li>'
            );
        });
        $('#column-list input[type="checkbox"]').on('change', function() {
            var colIdx = parseInt($(this).val());
            table.column(colIdx).visible(this.checked);
        });
 
        // Dashboard calculations
        const allData = table.rows().data().toArray();
        const totalTransactions = allData.length;
        const totalCollected = totalPaidVal;
        const averageTransaction = totalTransactions > 0 ? (totalCollected / totalTransactions).toFixed(2) : 0;
        $('#averageTransaction').text(averageTransaction);
        let modeData = {};
        let adminData = {};
        let dailyData = {};
        allData.forEach(row => {
            const mode = row[9] || 'Unknown';
            const admin = row[10] || 'Unknown';
            const date = row[7] || 'Unknown';
            const payingFee = parseFloat(row[4]) || 0;
            if (!modeData[mode]) modeData[mode] = { count: 0, total: 0 };
            modeData[mode].count++;
            modeData[mode].total += payingFee;
            if (!adminData[admin]) adminData[admin] = { total: 0 };
            adminData[admin].total += payingFee;
            if (!dailyData[date]) dailyData[date] = 0;
            dailyData[date] += payingFee;
        });
        // Payment Modes Pie Chart (by amount)
        const ctxModes = document.getElementById('paymentModesPie').getContext('2d');
        new Chart(ctxModes, {
            type: 'pie',
            data: {
                labels: Object.keys(modeData),
                datasets: [{
                    data: Object.values(modeData).map(d => d.total),
                    backgroundColor: ['rgba(75, 192, 192, 0.8)', 'rgba(255, 99, 132, 0.8)', 'rgba(255, 205, 86, 0.8)', 'rgba(54, 162, 235, 0.8)']
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        position: 'bottom'
                    }
                }
            }
        });
        // Fee Status Pie Chart
        const ctxFeeStatus = document.getElementById('feeStatusPie').getContext('2d');
        new Chart(ctxFeeStatus, {
            type: 'pie',
            data: {
                labels: ['Collected', 'Balance'],
                datasets: [{
                    data: [totalPaidVal, totalBalanceVal],
                    backgroundColor: ['rgba(75, 192, 192, 0.8)', 'rgba(255, 99, 132, 0.8)']
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        position: 'bottom'
                    }
                }
            }
        });
        // Class-wise Stats Table
        let classes = Object.keys(classTransCounts);
        // Sort classes numerically ascending
        classes.sort((a, b) => {
            const numA = parseInt(a.replace(/[^0-9]/g, '')) || 0;
            const numB = parseInt(b.replace(/[^0-9]/g, '')) || 0;
            return numA - numB;
        });
        classes.forEach(cls => {
            const trans = classTransCounts[cls];
            const total = classPaidSums[cls] || 0;
            const avg = trans > 0 ? (total / trans).toFixed(2) : 0;
            $('#classStatsTable tbody').append(`
                <tr>
                    <td>${cls}</td>
                    <td>${trans}</td>
                    <td>${total.toFixed(2)}</td>
                    <td>${avg}</td>
                </tr>
            `);
        });
        // Transactions per Class Bar
        const ctxTransClass = document.getElementById('transactionsPerClass').getContext('2d');
        new Chart(ctxTransClass, {
            type: 'bar',
            data: {
                labels: classes,
                datasets: [{ label: 'Transactions', data: classes.map(cls => classTransCounts[cls]), backgroundColor: 'rgba(153, 102, 255, 0.8)' }]
            },
            options: {
                scales: { y: { beginAtZero: true } },
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        display: false
                    }
                }
            }
        });
        // Collected per Class Bar (changed from pie)
        const ctxCollClass = document.getElementById('collectedPerClass').getContext('2d');
        const collectedData = classes.map(cls => classPaidSums[cls] || 0);
        const colors = classes.map((_, i) => `hsl(${i * 360 / classes.length}, 70%, 50%)`);
        new Chart(ctxCollClass, {
            type: 'bar',
            data: {
                labels: classes,
                datasets: [{ label: 'Collected', data: collectedData, backgroundColor: colors }]
            },
            options: {
                scales: { y: { beginAtZero: true } },
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        display: false
                    }
                }
            }
        });
        // Billed By Pie Chart
        const ctxBilled = document.getElementById('billedByPie').getContext('2d');
        const adminLabels = Object.keys(adminData);
        const adminTotals = Object.values(adminData).map(d => d.total);
        const adminColors = adminLabels.map((_, i) => `hsl(${i * 360 / adminLabels.length}, 70%, 50%)`);
        new Chart(ctxBilled, {
            type: 'pie',
            data: {
                labels: adminLabels,
                datasets: [{ data: adminTotals, backgroundColor: adminColors }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        position: 'right'
                    }
                }
            }
        });
        // Collections Bar Chart - with period selector
        let dailyChart;
        function updateDailyChart(period) {
            if (dailyChart) dailyChart.destroy();
            let groupData = {};
            allData.forEach(row => {
                const dateStr = row[7];
                if (!dateStr || dateStr === 'Unknown') return;
                let key;
                try {
                    const date = new Date(dateStr);
                    if (isNaN(date.getTime())) return;
                    if (period === 'daily') {
                        key = dateStr;
                    } else if (period === 'monthly') {
                        key = dateStr.substring(0, 7);
                    } else if (period === 'yearly') {
                        key = dateStr.substring(0, 4);
                    } else { // weekly
                        let d = new Date(dateStr);
                        let day = d.getDay();
                        let diff = d.getDate() - day + (day === 0 ? -6 : 1); // Monday start
                        d.setDate(diff);
                        key = d.toISOString().slice(0, 10);
                    }
                } catch (e) {
                    return;
                }
                const paying = parseFloat(row[4]) || 0;
                groupData[key] = (groupData[key] || 0) + paying;
            });
            const labels = Object.keys(groupData).sort();
            const dataValues = labels.map(k => groupData[k]);
            const ctxDaily = document.getElementById('dailyCollections').getContext('2d');
            dailyChart = new Chart(ctxDaily, {
                type: 'bar',
                data: {
                    labels,
                    datasets: [{ label: 'Collected', data: dataValues, backgroundColor: 'rgba(75, 192, 192, 0.8)' }]
                },
                options: {
                    scales: { y: { beginAtZero: true } },
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: {
                            display: false
                        }
                    }
                }
            });
        }
        updateDailyChart('daily');
        $('#collectionPeriod').change(function() {
            updateDailyChart($(this).val());
        });
    });
    function printReceipt(button) {
        const row = button.closest('tr');
        const cells = row.cells;
        const data = {
            sno: cells[0].textContent.trim(),
            studentName: cells[1].textContent.trim(),
            totalFee: cells[2].textContent.trim(),
            paidFee: cells[3].textContent.trim(),
            lastPaid: cells[4].textContent.trim(),
            balance: cells[5].textContent.trim(),
            className: cells[6].textContent.trim(),
            date: cells[7].textContent.trim(),
            time: cells[8].textContent.trim(),
            mode: cells[9].textContent.trim(),
            billedBy: cells[10].textContent.trim()
        };
        const printWindow = window.open('', '_blank', 'width=800,height=600');
        printWindow.document.write(`
            <!DOCTYPE html>
            <html>
            <head>
                <title>Payment Receipt - ${data.studentName}</title>
                <style>
                    body { font-family: Arial, sans-serif; margin: 20px; font-size: 12px; }
                    .header { text-align: center; font-size: 18px; font-weight: bold; margin-bottom: 20px; border-bottom: 2px solid #000; padding-bottom: 10px; }
                    .details { margin: 10px 0; display: flex; justify-content: space-between; }
                    .details div { flex: 1; }
                    .label { font-weight: bold; }
                    .copy { page-break-inside: avoid; margin-bottom: 30px; border: 1px dashed #ccc; padding: 15px; }
                    .copy h3 { text-align: center; margin-bottom: 15px; }
                    .footer { text-align: center; margin-top: 10px; font-size: 10px; }
                    @media print { .no-print { display: none !important; } body { margin: 0; } }
                </style>
            </head>
            <body onload="window.print(); window.onafterprint = () => window.close();">
                <button class="no-print btn btn-secondary" onclick="window.close();">Close</button>
                <div class="header">SAS School<br>Payment Receipt</div>
                <div class="details">
                    <div><span class="label">Student Name:</span> ${data.studentName}</div>
                    <div><span class="label">Class:</span> ${data.className}</div>
                </div>
                <div class="details">
                    <div><span class="label">Date:</span> ${data.date}</div>
                    <div><span class="label">Time:</span> ${data.time}</div>
                </div>
                <div class="details">
                    <div><span class="label">Payment Mode:</span> ${data.mode}</div>
                    <div><span class="label">Billed By:</span> ${data.billedBy}</div>
                </div>
                <div class="details">
                    <div><span class="label">Last Payment Amount:</span> ${data.lastPaid}</div>
                    <div><span class="label">Total Fee:</span> ${data.totalFee}</div>
                </div>
                <div class="details">
                    <div><span class="label">Total Paid:</span> ${data.paidFee}</div>
                    <div><span class="label">Balance:</span> ${data.balance}</div>
                </div>
                <div class="copy">
                    <h3>Student Copy</h3>
                    <div class="details">
                        <div><span class="label">Student Name:</span> ${data.studentName}</div>
                        <div><span class="label">Class:</span> ${data.className}</div>
                    </div>
                    <div class="details">
                        <div><span class="label">Date:</span> ${data.date}</div>
                        <div><span class="label">Time:</span> ${data.time}</div>
                    </div>
                    <div class="details">
                        <div><span class="label">Payment Mode:</span> ${data.mode}</div>
                        <div><span class="label">Billed By:</span> ${data.billedBy}</div>
                    </div>
                    <div class="details">
                        <div><span class="label">Last Payment Amount:</span> ${data.lastPaid}</div>
                        <div><span class="label">Total Fee:</span> ${data.totalFee}</div>
                    </div>
                    <div class="details">
                        <div><span class="label">Total Paid:</span> ${data.paidFee}</div>
                        <div><span class="label">Balance:</span> ${data.balance}</div>
                    </div>
                    <p class="footer">Please retain this copy for your records. Thank you!</p>
                </div>
                <div class="copy">
                    <h3>School Copy</h3>
                    <div class="details">
                        <div><span class="label">Student Name:</span> ${data.studentName}</div>
                        <div><span class="label">Class:</span> ${data.className}</div>
                    </div>
                    <div class="details">
                        <div><span class="label">Date:</span> ${data.date}</div>
                        <div><span class="label">Time:</span> ${data.time}</div>
                    </div>
                    <div class="details">
                        <div><span class="label">Payment Mode:</span> ${data.mode}</div>
                        <div><span class="label">Billed By:</span> ${data.billedBy}</div>
                    </div>
                    <div class="details">
                        <div><span class="label">Last Payment Amount:</span> ${data.lastPaid}</div>
                        <div><span class="label">Total Fee:</span> ${data.totalFee}</div>
                    </div>
                    <div class="details">
                        <div><span class="label">Total Paid:</span> ${data.paidFee}</div>
                        <div><span class="label">Balance:</span> ${data.balance}</div>
                    </div>
                    <p class="footer">School receipt copy. For official records.</p>
                </div>
            </body>
            </html>
        `);
        printWindow.document.close();
    }
</script>
<script>
  window.userRole = "<%= role.replace("\"", "\\\"") %>";
  window.admissionNo = "<%= admissionNo.replace("\"", "\\\"") %>";
  console.log("User role:", window.userRole);
</script>
</body>
</html>