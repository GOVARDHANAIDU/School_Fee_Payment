<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@page import="com.DAO.DatabaseConnectivity"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*, java.util.*, java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>School Attendance Dashboard - SAS School</title>
    <link rel="icon" href="https://cdn-icons-png.flaticon.com/512/2132/2132732.png" type="image/x-icon">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <!-- DataTables CSS -->
    <link href="https://cdn.datatables.net/1.13.7/css/dataTables.bootstrap5.min.css" rel="stylesheet">
    <!-- DataTables Buttons CSS -->
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/buttons/2.4.2/css/buttons.bootstrap5.min.css">
    <!-- Select2 CSS for searchable dropdown -->
    <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
 
    <!-- Custom CSS for classic, neat UI with borders, segregation, and blue theme -->
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            color: #333;
        }
 
        .lite-card {
            height: 120px;
            background-color: #e3f2fd !important; /* Light blue for total students */
            border: 1px solid #bbdefb;
            color: #1976d2;
            transition: transform 0.2s ease-in-out, box-shadow 0.2s ease-in-out;
        }
        .lite-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }
        .lite-card.present {
            background-color: #e8f5e8 !important; /* Light green for present */
            border: 1px solid #c8e6c9;
            color: #388e3c;
        }
        .lite-card.absent {
            background-color: #fff3e0 !important; /* Light orange for absent */
            border: 1px solid #ffcc80;
            color: #f57c00;
        }
        .lite-card.percentage {
            background-color: #f3e5f5 !important; /* Light purple for percentage */
            border: 1px solid #e1bee7;
            color: #7b1fa2;
        }
        .lite-card i {
            font-size: 1.5rem !important;
        }
        .lite-card h5 {
            font-size: 0.85rem;
            margin-bottom: 0.25rem;
        }
        .lite-card h3 {
            font-size: 1.5rem;
        }
        .lite-card small {
            font-size: 0.75rem;
        }
        /* Table alignment - classic bordered table */
        #attendanceTable th, #attendanceTable td {
            text-align: center;
            vertical-align: middle;
            border: 1px solid #dee2e6 !important;
            padding: 0.75rem;
        }
        #attendanceTable thead th {
            background-color: #0d6efd; /* Blue header */
            color: #fff;
            font-weight: 600;
        }
        #attendanceTable tbody tr:hover {
            background-color: #f8f9fa;
            transition: background-color 0.2s ease-in-out;
        }
        /* Selected filter display */
        .filter-info {
            background-color: #f8f9fa;
            border: 1px solid #dee2e6;
            border-radius: 0.375rem;
            padding: 0.5rem;
            margin-bottom: 1rem;
            font-size: 0.9rem;
        }
        /* Chart container smaller with smooth animations */
        .chart-container {
            height: 200px !important;
            position: relative;
        }
        /* Button alignment and blue colors */
        .dt-buttons {
            margin-bottom: 0.5rem;
        }
        .dt-button {
            background-color: #0d6efd !important; /* Blue buttons */
            border-color: #0d6efd !important;
            color: #fff !important;
            margin-right: 0.5rem !important;
            border-radius: 0.25rem;
            transition: background-color 0.2s ease-in-out;
        }
        .dt-button:hover {
            background-color: #0b5ed7 !important; /* Darker blue */
            border-color: #0b5ed7 !important;
            color: #fff !important;
        }
        .dataTables_wrapper .dataTables_filter input,
        .dataTables_wrapper .dataTables_length select {
            border: 1px solid #0d6efd; /* Blue borders */
            color: #0d6efd;
            border-radius: 0.25rem;
        }
        /* Filters in single row */
        .filter-row .col-md-3 {
            padding: 0.25rem;
        }
        /* Visual segregation - bordered sections */
        .visual-section {
            margin-bottom: 2rem;
            padding: 1rem;
            border: 2px solid #dee2e6;
            border-radius: 0.5rem;
            background-color: #fff;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
            transition: box-shadow 0.2s ease-in-out;
        }
        .visual-section:hover {
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }
        /* Header styles - gray for visuals (charts), blue for table */
        .visual-section .card-header {
            background-color: #6c757d !important; /* Gray like Bootstrap close button for professional look */
            color: #fff;
            font-weight: 600;
        }
        /* Grey table heading */
.thead-grey th {
    background-color: #6c757d !important;  /* Bootstrap grey */
    color: white !important;
}
        
        /* Badge styles for status */
        .badge {
            font-size: 0.8rem;
            padding: 0.5em 0.75em;
        }
        /* DataTables controls styling */
        .dataTables_wrapper .dataTables_length,
        .dataTables_wrapper .dataTables_filter {
            margin-bottom: 0 !important;
        }
        .dataTables_wrapper .row:first-child {
            justify-content: space-between;
            align-items: center;
        }
        /* Period filter - left aligned, styled like button */
        .period-row {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 1rem;
        }
        .period-row label {
            margin-bottom: 0;
            font-weight: bold;
        }
        .period-row .form-select {
            width: auto;
            border: 1px solid #0d6efd;
            color: #0d6efd;
            background-color: #fff;
            border-radius: 0.25rem;
            padding: 0.375rem 0.75rem;
        }
        .period-row button {
            background-color: #0d6efd;
            border-color: #0d6efd;
            color: #fff;
            padding: 0.375rem 0.75rem;
            border-radius: 0.25rem;
            transition: background-color 0.2s ease-in-out;
        }
        .period-row button:hover {
            background-color: #0b5ed7;
            border-color: #0b5ed7;
        }
        /* Document link */
        .document-link {
            color: #0d6efd;
            text-decoration: none;
        }
        .document-link:hover {
            text-decoration: underline;
        }
        /* Footer - change to black to match navbar */
        footer.footer {
            background-color: #000 !important; /* Black like navbar */
            color: #fff;
        }
    </style>
</head>
<body>

<%
    // Database connection - Adjust credentials
    Connection conn = null;
    Statement stmt = null;
    Statement stmt2 = null;
    ResultSet rs = null;
    List<Map<String, Object>> attendanceData = new ArrayList<>(); // Student-level data
    List<String> classes = new ArrayList<>();
    String selectedDateParam = request.getParameter("date");
    String selectedClassParam = request.getParameter("class");
    String selectedStatus = request.getParameter("status");
    String selectedPeriodParam = request.getParameter("period");
    if (selectedDateParam == null || selectedDateParam.trim().isEmpty()) {
        selectedDateParam = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
    }
    if (selectedClassParam == null) selectedClassParam = "";
    if (selectedStatus == null) selectedStatus = "";
    if (selectedPeriodParam == null || selectedPeriodParam.trim().isEmpty()) selectedPeriodParam = "daily";
    String selectedDate = selectedDateParam;
    String selectedClass = selectedClassParam;
    String selectedPeriod = selectedPeriodParam;

    int totalStudents = 0;
    int totalPresent = 0;
    int totalAbsent = 0;
    double overallPercentage = 0.0;
    String overallStatus = "Needs Improvement";

    List<Map<String, Object>> trendData = new ArrayList<>();
    List<Map<String, Object>> classAnalysis = new ArrayList<>();

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DatabaseConnectivity.getConnection();

        // Fetch unique classes
        stmt = conn.createStatement();
        rs = stmt.executeQuery("SELECT DISTINCT class FROM students ORDER BY class");
        while (rs.next()) {
            classes.add(rs.getString("class"));
        }
        rs.close();

        // Class-wise analysis for chart and stats
        String classWhere = selectedClassParam.isEmpty() ? "" : "WHERE s.class = '" + selectedClassParam + "'";
        String classQuery = "SELECT s.class, COUNT(DISTINCT s.admin_no) as total_students, " +
                            "COUNT(DISTINCT CASE WHEN COALESCE(a.status, 'A') = 'P' THEN s.admin_no END) as present " +
                            "FROM students s " +
                            "LEFT JOIN attendance a ON s.admin_no = a.admin_no AND a.attendance_date = '" + selectedDateParam + "' " +
                            classWhere +
                            " GROUP BY s.class ORDER BY s.class";
        stmt2 = conn.createStatement();
        rs = stmt2.executeQuery(classQuery);
        while (rs.next()) {
            Map<String, Object> analysis = new HashMap<>();
            analysis.put("class", rs.getString("class"));
            int total = rs.getInt("total_students");
            int present = rs.getInt("present");
            analysis.put("total_students", total);
            analysis.put("present", present);
            analysis.put("percentage", total > 0 ? Math.round((double) present / total * 100 * 100.0) / 100.0 : 0.0);
            classAnalysis.add(analysis);
        }
        rs.close();

        // Overall stats
        totalStudents = 0;
        totalPresent = 0;
        for (Map<String, Object> ana : classAnalysis) {
            totalStudents += (Integer) ana.get("total_students");
            totalPresent += (Integer) ana.get("present");
        }
        totalAbsent = totalStudents - totalPresent;
        overallPercentage = totalStudents > 0 ? (double) totalPresent / totalStudents * 100 : 0;
        overallPercentage = Math.round(overallPercentage * 100.0) / 100.0;
        overallStatus = overallPercentage >= 90 ? "Excellent" : overallPercentage >= 75 ? "Good" : "Needs Improvement";

        // Student-level attendance data for table (filtered by date, class, status) - displays all students with status P/A for the date
        String joinCondition = "LEFT JOIN attendance a ON s.admin_no = a.admin_no AND a.attendance_date = '" + selectedDateParam + "' ";
        String studentWhere = "WHERE 1=1";
        if (!selectedClassParam.isEmpty()) studentWhere += " AND s.class = '" + selectedClassParam + "'";
        if (!selectedStatus.isEmpty()) studentWhere += " AND COALESCE(a.status, 'A') = '" + selectedStatus + "'";
        String studentQuery = "SELECT s.admin_no, s.student_name as student_name, s.class, COALESCE(a.status, 'A') as status, " +
                              "a.leave_type, a.reason, '" + selectedDateParam + "' as date, a.created_at as time, a.document_path " +
                              "FROM students s " +
                              joinCondition +
                              studentWhere +
                              " ORDER BY s.class, s.student_name";
        rs = stmt2.executeQuery(studentQuery);
        int sNo = 1;
        while (rs.next()) {
            Map<String, Object> row = new HashMap<>();
            row.put("sno", sNo++);
            row.put("admin_no", rs.getString("admin_no"));
            row.put("student_name", rs.getString("student_name"));
            row.put("class", rs.getString("class"));
            row.put("status", rs.getString("status"));
            row.put("leave_type", rs.getString("leave_type") != null ? rs.getString("leave_type") : "-");
            row.put("reason", rs.getString("reason") != null ? rs.getString("reason") : "-");
            row.put("date", selectedDate);
            row.put("time", rs.getString("time") != null ? rs.getString("time") : "-");
            row.put("document_path", rs.getString("document_path") != null ? rs.getString("document_path") : "-");
            attendanceData.add(row);
        }
        rs.close();

        // Trend data: based on period - fixed date calculation for current year 2025
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Calendar cal = Calendar.getInstance();
        int daysBack = 7; // default daily
        if ("weekly".equals(selectedPeriod)) {
            daysBack = 28;
        } else if ("monthly".equals(selectedPeriod)) {
            daysBack = 90;
        } else if ("yearly".equals(selectedPeriod)) {
            daysBack = 365;
        }
        cal.add(Calendar.DAY_OF_YEAR, - (daysBack - 1)); // Start from daysBack-1 days ago to today
        int overallTotal = totalStudents;
        String trendClassWhere = selectedClassParam.isEmpty() ? "" : "AND s.class = '" + selectedClassParam + "'";
        for (int i = 0; i < daysBack; i++) {
            String trendDate = dateFormat.format(cal.getTime());
            PreparedStatement pstmt = conn.prepareStatement(
                "SELECT COUNT(DISTINCT CASE WHEN COALESCE(a.status, 'A') = 'P' THEN s.admin_no END) as present " +
                "FROM students s " +
                "LEFT JOIN attendance a ON s.admin_no = a.admin_no AND a.attendance_date = ? " +
                trendClassWhere
            );
            pstmt.setString(1, trendDate);
            rs = pstmt.executeQuery();
            int presentCount = 0;
            if (rs.next()) {
                presentCount = rs.getInt("present");
            }
            rs.close();
            pstmt.close();

            Map<String, Object> daySummary = new HashMap<>();
            daySummary.put("date", trendDate);
            double perc = overallTotal > 0 ? (presentCount * 100.0 / overallTotal) : 0;
            daySummary.put("percentage", Math.round(perc * 100.0) / 100.0);
            trendData.add(daySummary);

            cal.add(Calendar.DAY_OF_YEAR, 1);
        }

    } catch (Exception e) {
        out.println("<div class='alert alert-danger text-center'>Error loading data: " + e.getMessage() + "</div>");
        e.printStackTrace();
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
        if (stmt2 != null) try { stmt2.close(); } catch (SQLException ignore) {}
        if (stmt != null) try { stmt.close(); } catch (SQLException ignore) {}
        if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
    }
%>

<!-- Navbar - Keep dark green as is -->
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
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">Payments</a>
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
        <li class="nav-item"><a class="nav-link" href="../fee-notifications.jsp">Send Notifications</a></li>
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
            <li><a class="dropdown-item" href="../home.jsp">Channel Admin</a></li>
            <li><a class="dropdown-item" href="../students.jsp">Student</a></li>
            <li><a class="dropdown-item" href="./faculty/faculty.jsp">Faculty</a></li>
        </ul>
    </div>

    <!-- Auth Buttons (ALWAYS UNDER Roles in mobile) -->
    <div class="d-flex flex-column flex-lg-row gap-2 mt-2 mt-lg-0">
        <a class="btn btn-outline-light btn-sm" href="../AdminLogin.jsp">Logout</a>
        <a class="btn btn-outline-warning btn-sm" href="../createaccount.jsp">Signup</a>
    </div>

</div>

    </div>
  </div>
</nav>

<!-- Main Dashboard - Use container for 3-5% margins left/right -->
<div class="container py-4">
    <!-- Filter Info Display -->
<%
    if (!selectedDate.isEmpty() || !selectedClass.isEmpty() || !selectedStatus.isEmpty()) {
%>
    <div class="filter-info">
        <strong>Current Filters:</strong>
<%
        if (!selectedDate.isEmpty()) {
%>
            Date: <%= selectedDate %>
<%
        }
        if (!selectedClass.isEmpty()) {
            if (!selectedDate.isEmpty()) {
%>
                ,
<%
            }
%>
            Class: <%= selectedClass %>
<%
        }
        if (!selectedStatus.isEmpty()) {
            if (!selectedDate.isEmpty() || !selectedClass.isEmpty()) {
%>
                ,
<%
            }
%>
            Status: <%= selectedStatus %>
<%
        }
%>
    </div>
<%
    }
%>

    <!-- Filters in single row -->
    <div class="row mb-4 filter-row">
        <div class="col-md-3">
            <label for="dateFilter" class="form-label">Filter by Date:</label>
            <input type="date" id="dateFilter" class="form-control" value="<%= selectedDate %>">
        </div>
        <div class="col-md-3">
            <label for="classFilter" class="form-label">Filter by Class (Searchable):</label>
            <select id="classFilter" class="form-select">
                <option value="">All Classes</option>
<%
                for (String cls : classes) {
%>
                    <option value="<%= cls %>" <%= selectedClass.equals(cls) ? "selected=\"selected\"" : "" %>><%= cls %></option>
<%
                }
%>
            </select>
        </div>
        <div class="col-md-3">
            <label for="statusFilter" class="form-label">Filter by Status:</label>
            <select id="statusFilter" class="form-select">
                <option value="">All Status</option>
                <option value="P" <%= "P".equals(selectedStatus) ? "selected" : "" %>>Present</option>
                <option value="A" <%= "A".equals(selectedStatus) ? "selected" : "" %>>Absent</option>
            </select>
        </div>
        <div class="col-md-3 d-flex align-items-end">
            <button id="filterBtn" class="btn btn-primary w-100">Apply Filter</button>
        </div>
    </div>

    <!-- Summary Cards -->
    <div class="visual-section">
        <h5 class="mb-3">Attendance Summary</h5>
        <div class="row justify-content-center">
            <div class="col-md-3">
                <div class="card text-center lite-card">
                    <div class="card-body d-flex flex-column justify-content-center">
                        <i class="bi bi-people-fill"></i>
                        <h5>Total Students</h5>
                        <h3><%= totalStudents %></h3>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card text-center lite-card present">
                    <div class="card-body d-flex flex-column justify-content-center">
                        <i class="bi bi-check-circle-fill"></i>
                        <h5>Present</h5>
                        <h3><%= totalPresent %></h3>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card text-center lite-card absent">
                    <div class="card-body d-flex flex-column justify-content-center">
                        <i class="bi bi-x-circle-fill"></i>
                        <h5>Absent</h5>
                        <h3><%= totalAbsent %></h3>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card text-center lite-card percentage">
                    <div class="card-body d-flex flex-column justify-content-center">
                        <i class="bi bi-graph-up"></i>
                        <h5>Attendance %</h5>
                        <h3><%= overallPercentage %>%</h3>
                        <small><%= overallStatus %></small>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Period Filter for Trends - Only for visuals, left aligned, styled like button -->
    <div class="period-row">
        <label for="periodFilter" class="form-label">Trend Period:</label>
        <select id="periodFilter" class="form-select">
            <option value="daily" <%= "daily".equals(selectedPeriod) ? "selected" : "" %>>Daily</option>
            <option value="weekly" <%= "weekly".equals(selectedPeriod) ? "selected" : "" %>>Weekly</option>
            <option value="monthly" <%= "monthly".equals(selectedPeriod) ? "selected" : "" %>>Monthly</option>
            <option value="yearly" <%= "yearly".equals(selectedPeriod) ? "selected" : "" %>>Yearly</option>
        </select>
        <button id="periodBtn" class="btn btn-primary">Apply</button>
    </div>

    <!-- Visuals Section - 4 Charts -->
    <div class="visual-section">
        <h5 class="mb-3">Attendance Visuals</h5>
        <div class="row">
            <div class="col-md-6 mb-3">
                <div class="card">
                    <div class="card-header">Class Analysis (Bar Chart)</div>
                    <div class="card-body chart-container">
                        <canvas id="classChart"></canvas>
                    </div>
                </div>
            </div>
            <div class="col-md-6 mb-3">
                <div class="card">
                    <div class="card-header">Trends (Line Chart)</div>
                    <div class="card-body chart-container">
                        <canvas id="trendChart"></canvas>
                    </div>
                </div>
            </div>
            <div class="col-md-6 mb-3">
                <div class="card">
                    <div class="card-header">Present vs Absent (Pie Chart)</div>
                    <div class="card-body chart-container">
                        <canvas id="pieChart"></canvas>
                    </div>
                </div>
            </div>
            <div class="col-md-6 mb-3">
                <div class="card">
                    <div class="card-header">Status Distribution (Doughnut Chart)</div>
                    <div class="card-body chart-container">
                        <canvas id="doughnutChart"></canvas>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Attendance Table - DataTables handles single entries dropdown, search; buttons: Excel (download) and Columns (show/hide) only -->
    <div class="visual-section">
        <h5 class="mb-3">Attendance Details</h5>
        <div class="card">
            <div class="card-header d-flex justify-content-between align-items-center">
                <h6>Student Attendance Records</h6>
                <div class="dt-buttons"></div>
            </div>
            <div class="card-body">
                <table id="attendanceTable" class="table table-striped table-bordered" style="width:100%">
                     <thead class="thead-grey">
                        <tr>
                            <th>S.No</th>
                            <th>Admin No</th>
                            <th>Student Name</th>
                            <th>Class</th>
                            <th>Status</th>
                            <th>Leave Type</th>
                            <th>Reason</th>
                            <th>Date</th>
                            <th>Time</th>
                            <th>Document</th>
                        </tr>
                    </thead>
                    <tbody>
<%
                        for (Map<String, Object> row : attendanceData) {
%>
                        <tr>
                            <td><%= row.get("sno") %></td>
                            <td><%= row.get("admin_no") %></td>
                            <td><%= row.get("student_name") %></td>
                            <td><%= row.get("class") %></td>
                            <td>
                                <span class="badge <%= "P".equals(row.get("status")) ? "bg-success" : "bg-danger" %>">
                                    <%= row.get("status") %>
                                </span>
                            </td>
                            <td><%= row.get("leave_type") %></td>
                            <td><%= row.get("reason") %></td>
                            <td><%= row.get("date") %></td>
                            <td><%= row.get("time") %></td>
                            <td>
<%
                            String docPath = (String) row.get("document_path");
                            if (!"-".equals(docPath) && docPath != null && !docPath.isEmpty()) {
                                // Assume base path for documents, adjust as needed (e.g., full URL)
                                String fullPath = request.getContextPath() + "/uploads/" + docPath; // Example: adjust to your upload path
%>
                                <a href="<%= fullPath %>" class="document-link" target="_blank" download>Download</a>
<%
                            } else {
%>
                                -
<%
                            }
%>
                            </td>
                        </tr>
<%
                        }
%>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<!-- Footer - Changed to black to match navbar -->
<footer class="footer text-white py-4 mt-5">
  <div class="container">
    <div class="row text-center">
      <div class="col-md-12">
        <p>&copy; 2025 SAS School. All rights reserved.</p>
      </div>
    </div>
  </div>
</footer>

<!-- Scripts - jQuery first to fix TypeError and DataTables issues -->
<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.datatables.net/1.13.7/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.13.7/js/dataTables.bootstrap5.min.js"></script>
<script src="https://cdn.datatables.net/buttons/2.4.2/js/dataTables.buttons.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.10.1/jszip.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/pdfmake.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/vfs_fonts.js"></script>
<script src="https://cdn.datatables.net/buttons/2.4.2/js/buttons.html5.min.js"></script>
<script src="https://cdn.datatables.net/buttons/2.4.2/js/buttons.print.min.js"></script>
<script src="https://cdn.datatables.net/buttons/2.4.2/js/buttons.colVis.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<!-- Select2 JS -->
<script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
    // Initialize Select2
    $('#classFilter').select2({
        placeholder: "Search for a class...",
        allowClear: true,
        width: '100%'
    });

    // DataTable - single entries dropdown, search; buttons: Excel (download) and Columns (show/hide) only
    const table = $('#attendanceTable').DataTable({
        responsive: true,
        pageLength: 10,
        lengthMenu: [[10, 25, 50, 100, -1], [10, 25, 50, 100, "All"]],
        order: [[2, 'asc']],
        dom: 'lfrtip',
        buttons: [
            { extend: 'excelHtml5', text: 'Download Excel File', title: 'Attendance Details' }, // Download button
            { extend: 'colvis', text: 'Shown Columns' } // Show/hide columns
        ],
        language: {
            search: "Search:",
            lengthMenu: "Show _MENU_ entries per page"
        },
        drawCallback: function(settings) {
            // Move buttons to header
            if (this.buttons && this.buttons().container) {
                this.buttons().container().appendTo('.dt-buttons');
            }
        }
    });

    // 4 Charts with animations
    // 1. Bar Chart - Class Analysis
    const classLabels = [<% for (Map<String, Object> ana : classAnalysis) { %>'<%= ana.get("class") %>',<% } %>];
    const classData = [<% for (Map<String, Object> ana : classAnalysis) { %><%= ana.get("percentage") %>,<% } %>];
    new Chart(document.getElementById('classChart'), {
        type: 'bar',
        data: { labels: classLabels, datasets: [{ label: 'Percentage', data: classData, backgroundColor: 'rgba(13, 110, 253, 0.6)' }] }, // Blue
        options: { 
            responsive: true, 
            maintainAspectRatio: false, 
            scales: { y: { beginAtZero: true, max: 100 } },
            animation: { duration: 1000 }
        }
    });

    // 2. Line Chart - Trends
    const trendLabels = [<% for (Map<String, Object> d : trendData) { %>'<%= d.get("date") %>',<% } %>];
    const trendDataVals = [<% for (Map<String, Object> d : trendData) { %><%= d.get("percentage") %>,<% } %>];
    new Chart(document.getElementById('trendChart'), {
        type: 'line',
        data: { labels: trendLabels, datasets: [{ label: 'Trends', data: trendDataVals, borderColor: 'rgba(13, 110, 253, 1)', fill: true }] }, // Blue
        options: { 
            responsive: true, 
            maintainAspectRatio: false, 
            scales: { y: { beginAtZero: true, max: 100 } },
            animation: { duration: 1000 }
        }
    });

    // 3. Pie Chart - Present vs Absent
    new Chart(document.getElementById('pieChart'), {
        type: 'pie',
        data: { labels: ['Present', 'Absent'], datasets: [{ data: [<%= totalPresent %>, <%= totalAbsent %>], backgroundColor: ['#198754', '#dc3545'] }] },
        options: { 
            responsive: true, 
            maintainAspectRatio: false,
            animation: { duration: 1000 }
        }
    });

    // 4. Doughnut Chart - Status Distribution (based on present/absent percentages)
    new Chart(document.getElementById('doughnutChart'), {
        type: 'doughnut',
        data: { 
            labels: ['Present', 'Absent'], 
            datasets: [{ 
                data: [<%= overallPercentage %>, <%= 100 - overallPercentage %>], 
                backgroundColor: ['#198754', '#dc3545'] 
            }] 
        },
        options: { 
            responsive: true, 
            maintainAspectRatio: false,
            animation: { duration: 1000 }
        }
    });

    // Filters functionality - reloads page with params for full data refresh
    function applyFilters() {
        const date = $('#dateFilter').val();
        const cls = $('#classFilter').val();
        const status = $('#statusFilter').val();
        const period = $('#periodFilter').val();
        let url = '?date=' + (date || '') + '&class=' + (cls || '') + '&status=' + (status || '') + '&period=' + (period || '');
        window.location.href = url;
    }

    $('#dateFilter, #classFilter, #statusFilter, #periodFilter').on('change', applyFilters);
    $('#filterBtn, #periodBtn').on('click', applyFilters);

    // Role-based hiding (if needed)
    const userRole = window.userRole || '';
    if (userRole !== 'admin') {
        table.buttons().container().hide();
    }

    // Auto-refresh every 5 minutes
    setInterval(function() {
        location.reload();
    }, 300000);
});

// Global variables
window.userRole = "<%= session.getAttribute("role") != null ? session.getAttribute("role").toString().replace("\"", "\\\"") : "" %>";
</script>

</body>
</html>