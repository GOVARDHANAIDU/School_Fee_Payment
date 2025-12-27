<%@page import="com.DAO.DatabaseConnectivity"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>School Attendance Dashboard - SAS School</title>
    <link rel="icon" href="https://cdn-icons-png.flaticon.com/512/2132/2132732.png" type="image/x-icon">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <!-- DataTables CSS -->
    <link href="https://cdn.datatables.net/1.13.7/css/dataTables.bootstrap5.min.css" rel="stylesheet">
    <link href="https://cdn.datatables.net/buttons/2.4.2/css/buttons.bootstrap5.min.css" rel="stylesheet">
    <!-- Select2 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
    
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            color: #333;
            overflow-x: hidden;
        }
        .lite-card {
            height: 120px;
            background-color: #e3f2fd !important;
            border: 1px solid #bbdefb;
            color: #1976d2;
            transition: transform 0.2s ease-in-out, box-shadow 0.2s ease-in-out;
        }
        .lite-card:hover { transform: translateY(-2px); box-shadow: 0 4px 8px rgba(0,0,0,0.1); }
        .lite-card.present { background-color: #e8f5e8 !important; border: 1px solid #c8e6c9; color: #388e3c; }
        .lite-card.absent { background-color: #fff3e0 !important; border: 1px solid #ffcc80; color: #f57c00; }
        .lite-card.percentage { background-color: #f3e5f5 !important; border: 1px solid #e1bee7; color: #7b1fa2; }
        .lite-card i { font-size: 1.5rem; }
        .lite-card h5 { font-size: 0.85rem; margin-bottom: 0.25rem; }
        .lite-card h3 { font-size: 1.5rem; }
        .lite-card small { font-size: 0.75rem; }

			       /* Table header - grey background */
			#attendanceTable thead th {
			    background-color: #6c757d !important; /* Grey header */
			    color: #fff !important;
			    font-weight: 600;
			    padding: 0.5rem 0.75rem !important; 
			    text-align: center;			    
			}
			
			/* Table body cells - reduced padding for smaller rows */
			#attendanceTable td {
			    text-align: center;
			    vertical-align: middle;
			    border: 1px solid #dee2e6 !important;
			    padding: 0.5rem 0.75rem !important; /* Reduced padding */
			    
			}
			
			/* Hover effect remains */
			#attendanceTable tbody tr:hover {
			    background-color: #f8f9fa;
			}

        .filter-info {
            background-color: #f8f9fa;
            border: 1px solid #dee2e6;
            border-radius: 0.375rem;
            padding: 0.5rem;
            margin-bottom: 1rem;
            font-size: 0.9rem;
        }

        .chart-container { height: 200px !important; position: relative; }

        .dt-buttons .dt-button {
            background-color: #0d6efd !important;
            border-color: #0d6efd !important;
            color: #fff !important;
            margin-right: 0.5rem !important;
            border-radius: 0.25rem;
        }
        .dt-buttons .dt-button:hover {
            background-color: #0b5ed7 !important;
            border-color: #0b5ed7 !important;
        }

        .visual-section {
            margin-bottom: 2rem;
            padding: 1rem;
            border: 2px solid #dee2e6;
            border-radius: 0.5rem;
            background-color: #fff;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
        }
        .visual-section:hover { box-shadow: 0 4px 8px rgba(0,0,0,0.1); }

        .visual-section .card-header {
            background-color: #6c757d !important;
            color: #fff;
            font-weight: 600;
        }

        .period-row {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 1rem;
        }
        .period-row .form-select, .period-row button {
            border: 1px solid #0d6efd;
            color: #0d6efd;
            background-color: #fff;
            border-radius: 0.25rem;
        }
        .period-row button {
            background-color: #0d6efd;
            color: #fff;
        }
        .period-row button:hover {
            background-color: #0b5ed7;
        }

        footer.footer { background-color: #000 !important; color: #fff; }

        .filter-row .col-md-3 { padding: 0.25rem; }

        @media (max-width: 768px) {
            .chart-container { height: 180px !important; }
            .period-row { flex-wrap: wrap; }
            #attendanceTable { font-size: 0.85rem; }
            #attendanceTable th, #attendanceTable td { padding: 0.5rem; white-space: nowrap; }
            .filter-row .col-md-3 { padding: 0.5rem 0; }
        }
    </style>
</head>
<body>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

    String displayName = (String) session.getAttribute("adminName");
    String role = (String) session.getAttribute("Roles");
    if (displayName == null || role == null) {
        response.sendRedirect("AdminLogin.jsp");
        return;
    }
    String userName = displayName.split(" ")[0];

    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;
    List<Map<String, Object>> attendanceData = new ArrayList<>();
    List<String> classes = new ArrayList<>();
    List<Map<String, Object>> classAnalysis = new ArrayList<>();
    List<Map<String, Object>> trendData = new ArrayList<>();

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

    int totalStudents = 0, totalPresent = 0, totalAbsent = 0;
    double overallPercentage = 0.0;
    String overallStatus = "Needs Improvement";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DatabaseConnectivity.getConnection();

        // Fetch classes
        stmt = conn.createStatement();
        rs = stmt.executeQuery("SELECT DISTINCT class FROM students ORDER BY class");
        while (rs.next()) classes.add(rs.getString("class"));
        rs.close();

        // Class-wise analysis
        String classWhere = selectedClassParam.isEmpty() ? "" : "WHERE s.class = '" + selectedClassParam + "'";
        String classQuery = "SELECT s.class, COUNT(DISTINCT s.admin_no) as total_students, " +
                            "COUNT(DISTINCT CASE WHEN COALESCE(a.status, 'A') = 'P' THEN s.admin_no END) as present " +
                            "FROM students s LEFT JOIN attendance a ON s.admin_no = a.admin_no AND a.attendance_date = '" + selectedDateParam + "' " +
                            classWhere + " GROUP BY s.class ORDER BY s.class";
        rs = stmt.executeQuery(classQuery);
        while (rs.next()) {
            Map<String, Object> m = new HashMap<>();
            int total = rs.getInt("total_students");
            int present = rs.getInt("present");
            m.put("class", rs.getString("class"));
            m.put("total_students", total);
            m.put("present", present);
            m.put("percentage", total > 0 ? Math.round((double) present / total * 10000.0) / 100.0 : 0.0);
            classAnalysis.add(m);

            totalStudents += total;
            totalPresent += present;
        }
        rs.close();

        totalAbsent = totalStudents - totalPresent;
        overallPercentage = totalStudents > 0 ? Math.round((double) totalPresent / totalStudents * 10000.0) / 100.0 : 0;

        // Student data
        String studentWhere = "WHERE 1=1";
        if (!selectedClassParam.isEmpty()) studentWhere += " AND s.class = '" + selectedClassParam + "'";
        if (!selectedStatus.isEmpty()) studentWhere += " AND COALESCE(a.status, 'A') = '" + selectedStatus + "'";

        String studentQuery = "SELECT s.admin_no, s.student_name, s.class, COALESCE(a.status, 'A') as status, " +
                              "a.leave_type, a.reason, a.created_at as time, a.document_path " +
                              "FROM students s LEFT JOIN attendance a ON s.admin_no = a.admin_no AND a.attendance_date = '" + selectedDateParam + "' " +
                              studentWhere + " ORDER BY s.class, s.student_name";
        rs = stmt.executeQuery(studentQuery);
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
            row.put("time", rs.getString("time") != null ? rs.getString("time") : "-");
            row.put("document_path", rs.getString("document_path") != null ? rs.getString("document_path") : "-");
            attendanceData.add(row);
        }
        rs.close();

        // Trend data
        int daysBack = "weekly".equals(selectedPeriodParam) ? 28 : "monthly".equals(selectedPeriodParam) ? 90 : "yearly".equals(selectedPeriodParam) ? 365 : 7;
        Calendar cal = Calendar.getInstance();
        cal.add(Calendar.DAY_OF_YEAR, -(daysBack - 1));
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
        String trendWhere = selectedClassParam.isEmpty() ? "" : "AND s.class = '" + selectedClassParam + "'";

        for (int i = 0; i < daysBack; i++) {
            String d = df.format(cal.getTime());
            PreparedStatement ps = conn.prepareStatement(
                "SELECT COUNT(DISTINCT CASE WHEN COALESCE(a.status, 'A') = 'P' THEN s.admin_no END) as present " +
                "FROM students s LEFT JOIN attendance a ON s.admin_no = a.admin_no AND a.attendance_date = ? " + trendWhere
            );
            ps.setString(1, d);
            rs = ps.executeQuery();
            int present = rs.next() ? rs.getInt("present") : 0;
            rs.close(); ps.close();

            Map<String, Object> m = new HashMap<>();
            m.put("date", d);
            m.put("percentage", totalStudents > 0 ? Math.round(present * 10000.0 / totalStudents) / 100.0 : 0);
            trendData.add(m);
            cal.add(Calendar.DAY_OF_YEAR, 1);
        }

    } catch (Exception e) {
        out.println("<div class='alert alert-danger text-center'>Error: " + e.getMessage() + "</div>");
        e.printStackTrace();
    } finally {
        if (rs != null) try { rs.close(); } catch (Exception ignore) {}
        if (stmt != null) try { stmt.close(); } catch (Exception ignore) {}
        if (conn != null) try { conn.close(); } catch (Exception ignore) {}
    }
%>

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

<div class="container py-4">
    <% if (!selectedDateParam.isEmpty() || !selectedClassParam.isEmpty() || !selectedStatus.isEmpty()) { %>
    <div class="filter-info">
        <strong>Current Filters:</strong>
        <%= !selectedDateParam.isEmpty() ? "Date: " + selectedDateParam : "" %>
        <%= !selectedClassParam.isEmpty() ? (!selectedDateParam.isEmpty() ? ", " : "") + "Class: " + selectedClassParam : "" %>
        <%= !selectedStatus.isEmpty() ? ((!selectedDateParam.isEmpty() || !selectedClassParam.isEmpty()) ? ", " : "") + "Status: " + selectedStatus : "" %>
    </div>
    <% } %>

    <div class="row mb-4 filter-row">
        <div class="col-md-3">
            <label class="form-label">Date:</label>
            <input type="date" id="dateFilter" class="form-control" value="<%= selectedDateParam %>">
        </div>
        <div class="col-md-3">
            <label class="form-label">Class:</label>
            <select id="classFilter" class="form-select">
                <option value="">All Classes</option>
                <% for (String cls : classes) { %>
                <option value="<%= cls %>" <%= selectedClassParam.equals(cls) ? "selected" : "" %>><%= cls %></option>
                <% } %>
            </select>
        </div>
        <div class="col-md-3">
            <label class="form-label">Status:</label>
            <select id="statusFilter" class="form-select">
                <option value="">All</option>
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
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="period-row">
        <label>Trend Period:</label>
        <select id="periodFilter" class="form-select" style="width:auto;">
            <option value="daily" <%= "daily".equals(selectedPeriodParam) ? "selected" : "" %>>Daily</option>
            <option value="weekly" <%= "weekly".equals(selectedPeriodParam) ? "selected" : "" %>>Weekly</option>
            <option value="monthly" <%= "monthly".equals(selectedPeriodParam) ? "selected" : "" %>>Monthly</option>
            <option value="yearly" <%= "yearly".equals(selectedPeriodParam) ? "selected" : "" %>>Yearly</option>
        </select>
        <button id="periodBtn" class="btn btn-primary">Apply</button>
    </div>

    <!-- Charts -->
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

    <!-- Attendance Table -->
    <div class="visual-section">
        <h5 class="mb-3">Attendance Details</h5>
        <div class="card">
            <div class="card-header d-flex justify-content-between align-items-center">
                <h6 class="mb-0">Student Attendance Records</h6>
                <div id="tableButtons"></div>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table id="attendanceTable" class="table table-striped table-bordered" style="width:100%">
                        <thead class="bg-primary text-white">
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
                            <% for (Map<String, Object> row : attendanceData) { %>
                            <tr>
                                <td><%= row.get("sno") %></td>
                                <td><%= row.get("admin_no") %></td>
                                <td><%= row.get("student_name") %></td>
                                <td><%= row.get("class") %></td>
                                <td><span class="badge <%= "P".equals(row.get("status")) ? "bg-success" : "bg-danger" %>"><%= row.get("status") %></span></td>
                                <td><%= row.get("leave_type") %></td>
                                <td><%= row.get("reason") %></td>
                                <td><%= selectedDateParam %></td>
                                <td><%= row.get("time") %></td>
                                <td>
                                    <% String doc = (String) row.get("document_path");
                                       if (!"-".equals(doc) && doc != null && !doc.isEmpty()) { %>
                                    <a href="<%= request.getContextPath() %>/uploads/<%= doc %>" class="text-primary" target="_blank"><i class="bi bi-download"></i></a>
                                    <% } else { %> - <% } %>
                                </td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<footer class="footer text-white py-4 mt-5">
    <div class="container">
        <div class="row text-center">
            <div class="col-md-12">
                <p>&copy; 2025 SAS School. All rights reserved.</p>
            </div>
        </div>
    </div>
</footer>

<!-- Scripts -->
<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.datatables.net/1.13.7/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.13.7/js/dataTables.bootstrap5.min.js"></script>
<script src="https://cdn.datatables.net/buttons/2.4.2/js/dataTables.buttons.min.js"></script>
<script src="https://cdn.datatables.net/buttons/2.4.2/js/buttons.bootstrap5.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.10.1/jszip.min.js"></script>
<script src="https://cdn.datatables.net/buttons/2.4.2/js/buttons.html5.min.js"></script>
<script src="https://cdn.datatables.net/buttons/2.4.2/js/buttons.colVis.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>

<script>
$(document).ready(function() {
    $('#classFilter').select2({ placeholder: "All Classes", allowClear: true });

    const table = $('#attendanceTable').DataTable({
        dom: 'Blfrtip',
        buttons: [
            { extend: 'excel', text: 'Export Excel', className: 'btn btn-success btn-sm', title: 'Attendance_Report_<%= selectedDateParam %>' },
            { extend: 'colvis', text: 'Columns', className: 'btn btn-secondary btn-sm' }
        ],
        columnDefs: [
            { targets: [1,5, 6,8,9], visible: false } // Hide Leave Type (5), Reason (6), Document (9) by default
        ],
        responsive: true,
        pageLength: 10,
        order: [[3, 'asc']],
        lengthMenu: [[10, 25, 50, 100, -1], [10, 25, 50, 100, "All"]]
    });

    // Move buttons to header
    table.buttons().container().appendTo('#tableButtons');

    // Prepare chart data
    const classLabels = [<% for (Map<String, Object> ana : classAnalysis) { %>'<%= ana.get("class") %>',<% } %>].slice(0, -1);
    const classPercentages = [<% for (Map<String, Object> ana : classAnalysis) { %><%= ana.get("percentage") %>,<% } %>].slice(0, -1);
    const trendLabels = [<% for (Map<String, Object> d : trendData) { %>'<%= d.get("date") %>',<% } %>].slice(0, -1);
    const trendPercentages = [<% for (Map<String, Object> d : trendData) { %><%= d.get("percentage") %>,<% } %>].slice(0, -1);

    // Charts
    new Chart(document.getElementById('classChart'), {
        type: 'bar',
        data: {
            labels: classLabels,
            datasets: [{ label: 'Attendance %', data: classPercentages, backgroundColor: 'rgba(13,110,253,0.7)' }]
        },
        options: { responsive: true, maintainAspectRatio: false, scales: { y: { beginAtZero: true, max: 100 } } }
    });

    new Chart(document.getElementById('trendChart'), {
        type: 'line',
        data: {
            labels: trendLabels,
            datasets: [{ label: 'Attendance %', data: trendPercentages, borderColor: '#0d6efd', fill: true }]
        },
        options: { responsive: true, maintainAspectRatio: false, scales: { y: { beginAtZero: true, max: 100 } } }
    });

    new Chart(document.getElementById('pieChart'), {
        type: 'pie',
        data: { labels: ['Present', 'Absent'], datasets: [{ data: [<%= totalPresent %>, <%= totalAbsent %>], backgroundColor: ['#198754', '#dc3545'] }] },
        options: { responsive: true, maintainAspectRatio: false }
    });

    new Chart(document.getElementById('doughnutChart'), {
        type: 'doughnut',
        data: { labels: ['Present', 'Absent'], datasets: [{ data: [<%= overallPercentage %>, <%= 100 - overallPercentage %>], backgroundColor: ['#198754', '#dc3545'] }] },
        options: { responsive: true, maintainAspectRatio: false }
    });

    // Filter apply
    function applyFilters() {
        const params = new URLSearchParams({
            date: $('#dateFilter').val() || '',
            class: $('#classFilter').val() || '',
            status: $('#statusFilter').val() || '',
            period: $('#periodFilter').val() || 'daily'
        });
        window.location.search = params.toString();
    }

    $('#filterBtn, #periodBtn').on('click', applyFilters);
    $('#dateFilter, #classFilter, #statusFilter, #periodFilter').on('change', applyFilters);
});
</script>
</body>
</html>