<%@page import="com.DAO.DatabaseConnectivity"%>
<%@ page language="java" import="java.sql.*, javax.servlet.http.*, java.util.*, java.text.SimpleDateFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Attendance Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="icon" href="https://cdn-icons-png.flaticon.com/512/2132/2132732.png" type="image/x-icon">
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/jquery.dataTables.min.css">
    <link rel="stylesheet" href="https://cdn.datatables.net/fixedheader/3.4.0/css/fixedHeader.dataTables.min.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script src="https://code.jquery.com/jquery-3.5.1.js"></script>
    <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/fixedheader/3.4.0/js/dataTables.fixedHeader.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.17.0/xlsx.full.min.js"></script>
    <style>
        body { font-size: 0.85rem; }
        .navbar { padding: 0.3rem 1rem; }
        .navbar-brand { font-size: 1rem; }
        .nav-link { font-size: 0.85rem; padding: 0.3rem 0.5rem !important; }
        .navbar-nav .dropdown-menu { font-size: 0.8rem; }
        .section-header { margin: 20px 0 10px; font-size: 1.2rem; }
        .card { box-shadow: 0 2px 4px rgba(0,0,0,0.1); margin-bottom: 10px; }
        .card-body { padding: 0.75rem; }
        .card-title { font-size: 0.9rem; margin-bottom: 0.5rem; }
        .card-text { font-size: 1.1rem; font-weight: bold; }
        .table-responsive { max-height: 300px; overflow-y: auto; }
        .table { font-size: 0.8rem; margin-bottom: 0; }
        .table th, .table td { padding: 0.4rem; text-align: center; vertical-align: middle; }
        .table thead th { position: sticky; top: 0; background-color: #f8f9fa; z-index: 10; }
        .btn-group .btn { font-size: 0.8rem; padding: 0.3rem 0.6rem; margin-right: 2px; }
        #column-list { max-height: 200px; overflow-y: auto; font-size: 0.8rem; }
        #column-list .dropdown-item { padding: 0.3rem 0.75rem; }
        canvas { max-height: 150px !important; }
        .container { margin-top: 20px; }
        /* Color codes for attendance status */
        .status-present { background-color: #d4edda !important; color: #155724; }
        .status-absent { background-color: #f8d7da !important; color: #721c24; }
        .status-general-leave { background-color: #fff3cd !important; color: #856404; }
        .status-festival-leave { background-color: #d1ecf1 !important; color: #0c5460; }
        .status-permission-leave { background-color: #f8d7da !important; color: #721c24; } /* Similar to absent but can differentiate */
        .status-half-day { background-color: #e2e3e5 !important; color: #383d41; font-style: italic; }
    </style>
</head>
<body>
<%
    String selectedClass = request.getParameter("className");
    Connection con = null;
    Statement stmt = null;
    ResultSet rs = null;
    ResultSet studentsRs = null;
    ResultSet attendanceRs = null;
    ResultSet workingRs = null;
    ResultSet classesRs = null;
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    java.util.Date today = new java.util.Date();
    String currentDate = sdf.format(today); // 2025-12-08
    Map<Integer, Map<String, String>> attendanceMap = new HashMap<>();
    int totalWorkingDays = 0;
    int totalStudentsCount = 0;
    List<Map<String, Object>> studentsList = new ArrayList<>(); // To store student data for table

    if (selectedClass == null || selectedClass.isEmpty()) {
        // Separate try for class selection
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DatabaseConnectivity.getConnection();
            stmt = con.createStatement();
            classesRs = stmt.executeQuery("SELECT DISTINCT class FROM students ORDER BY class;");
        } catch (Exception e) {
            out.println("<div class='alert alert-danger'>Error loading classes: " + e.getMessage() + "</div>");
        } finally {
            if (classesRs != null) try { classesRs.close(); } catch (SQLException ignored) {}
            if (stmt != null) try { stmt.close(); } catch (SQLException ignored) {}
            if (con != null) try { con.close(); } catch (SQLException ignored) {}
        }
    } else {
        // Main try for selected class data
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DatabaseConnectivity.getConnection();
            stmt = con.createStatement();

            // Fetch students for selected class (include admin_no and student_id for key)
            studentsRs = stmt.executeQuery("SELECT student_id, admin_no, student_name, class FROM students WHERE class = '" + selectedClass + "' ORDER BY student_name;");
            totalStudentsCount = 0;
            while (studentsRs.next()) {
                totalStudentsCount++;
                Map<String, Object> studentData = new HashMap<>();
                int sid = studentsRs.getInt("student_id");
                String adminNo = studentsRs.getString("admin_no");
                String name = studentsRs.getString("student_name");
                studentData.put("id", sid);
                studentData.put("adminNo", adminNo);
                studentData.put("name", name);
                studentsList.add(studentData);
            }

            // For analytics, fetch attendance data for the class (e.g., last month for summaries)
            String monthStart = "2025-11-08"; // Example: Last month
            attendanceRs = stmt.executeQuery(
                "SELECT a.student_id, a.attendance_date, a.status, a.half_day " +
                "FROM attendance a " +
                "JOIN students s ON a.student_id = s.student_id " +
                "JOIN calendar c ON a.attendance_date = c.date " +
                "WHERE s.class = '" + selectedClass + "' AND c.is_working_day = TRUE " +
                "AND a.attendance_date BETWEEN '" + monthStart + "' AND '" + currentDate + "' " +
                "ORDER BY a.attendance_date, s.student_name;"
            );

            // Process data for attendanceMap
            while (attendanceRs.next()) {
                int sid = attendanceRs.getInt("student_id");
                String date = attendanceRs.getString("attendance_date");
                String status = attendanceRs.getString("status");
                boolean halfDay = attendanceRs.getBoolean("half_day");
                if (halfDay) status += "_half";
                if (!attendanceMap.containsKey(sid)) {
                    attendanceMap.put(sid, new HashMap<>());
                }
                attendanceMap.get(sid).put(date, status);
            }

            // Total working days in period
            workingRs = stmt.executeQuery(
                "SELECT COUNT(*) as total_working FROM calendar WHERE date BETWEEN '" + monthStart + "' AND '" + currentDate + "' AND is_working_day = TRUE;"
            );
            if (workingRs.next()) totalWorkingDays = workingRs.getInt("total_working");

        } catch (Exception e) {
            out.println("<div class='alert alert-danger'>Error: " + e.getMessage() + "</div>");
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException ignored) {}
            if (studentsRs != null) try { studentsRs.close(); } catch (SQLException ignored) {}
            if (attendanceRs != null) try { attendanceRs.close(); } catch (SQLException ignored) {}
            if (workingRs != null) try { workingRs.close(); } catch (SQLException ignored) {}
            if (stmt != null) try { stmt.close(); } catch (SQLException ignored) {}
            if (con != null) try { con.close(); } catch (SQLException ignored) {}
        }

        // Post-process studentsList with attendance stats
        for (Map<String, Object> studentData : studentsList) {
            int sid = (Integer) studentData.get("id");
            String name = (String) studentData.get("name");
            Map<String, String> studentAttendance = attendanceMap.getOrDefault(sid, new HashMap<>());
            int present = 0, absent = 0, leaves = 0;
            for (String date : studentAttendance.keySet()) {
                String status = studentAttendance.get(date);
                if (status.startsWith("Present")) present++;
                else if (status.equals("Absent")) absent++;
                else leaves++;
            }
            double attPct = totalWorkingDays > 0 ? (double) present / totalWorkingDays * 100 : 0;
            studentData.put("present", present);
            studentData.put("absent", absent);
            studentData.put("leaves", leaves);
            studentData.put("attPct", attPct); // Store double for sorting
        }

        // Sort studentsList by attendance % descending for ranking
        studentsList.sort((a, b) -> Double.compare((Double) b.get("attPct"), (Double) a.get("attPct")));

        // Assign ranks (handle ties by same rank)
        int rank = 1;
        double prevPct = -1;
        for (int i = 0; i < studentsList.size(); i++) {
            Map<String, Object> studentData = studentsList.get(i);
            double currentPct = (Double) studentData.get("attPct");
            if (i > 0 && Math.abs(currentPct - prevPct) > 0.001) { // Avoid floating point issues
                rank = i + 1;
            }
            studentData.put("rank", rank);
            prevPct = currentPct;
            // Convert back to String for display
            studentData.put("attPct", String.format("%.2f", currentPct));
        }
    }
%>

<!-- Navbar (same as example) -->
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
            <li><a class="dropdown-item" href="attendanceDashboard.jsp">Attendance Dashboard</a></li> <!-- New link -->
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
      <!-- Right Side (same as example) -->
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
    String displayName = (String) session.getAttribute("adminName");
    if (displayName == null) {
        displayName = "User";
    }
    String userName = "";
    for(int i = 0; i < displayName.length(); i++) {
        char ch = displayName.charAt(i);
        if(ch == ' ') break;
        else userName += ch;
    }
    String role = (String)session.getAttribute("Roles");
    String admissionNo = (String)session.getAttribute("admissionNo");
%>
      <div class="ms-lg-auto mt-3 mt-lg-0
            d-flex flex-column flex-lg-row
            align-items-start align-items-lg-center
            gap-2">
        <span class="text-white fw-semibold">
            Hello, <%= userName %>
        </span>
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
        <div class="d-flex flex-column flex-lg-row gap-2 mt-2 mt-lg-0">
            <a class="btn btn-outline-light btn-sm" href="AdminLogin.jsp">Logout</a>
            <a class="btn btn-outline-warning btn-sm" href="createaccount.jsp">Signup</a>
        </div>
      </div>
    </div>
  </div>
</nav>

<!-- Main Container -->
<div class="container">
    <!-- Class Selection (if no class selected, show dropdown) -->
    <% if (selectedClass == null || selectedClass.isEmpty()) { %>
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="card">
                    <div class="card-body text-center">
                        <h4>Select a Class</h4>
                        <form method="GET" action="attendance.jsp">
                            <select name="className" class="form-select mb-2" required>
                                <option value="">Choose Class...</option>
                                <%
                                    // Re-open connection for classesRs if needed, but since separate try, use a new one or output from earlier
                                    // For simplicity, assume classesRs is available; in practice, store in request or re-query
                                    // Here, re-query for output
                                    Connection conClasses = null;
                                    Statement stmtClasses = null;
                                    ResultSet classesRsLocal = null;
                                    try {
                                        Class.forName("com.mysql.cj.jdbc.Driver");
                                        conClasses = DatabaseConnectivity.getConnection();
                                        stmtClasses = conClasses.createStatement();
                                        classesRsLocal = stmtClasses.executeQuery("SELECT DISTINCT class FROM students ORDER BY class;");
                                        while (classesRsLocal.next()) {
                                %>
                                    <option value="<%= classesRsLocal.getString("class") %>"><%= classesRsLocal.getString("class") %></option>
                                <%
                                        }
                                    } catch (Exception e) {
                                        out.println("<option>Error loading classes</option>");
                                    } finally {
                                        if (classesRsLocal != null) try { classesRsLocal.close(); } catch (SQLException ignored) {}
                                        if (stmtClasses != null) try { stmtClasses.close(); } catch (SQLException ignored) {}
                                        if (conClasses != null) try { conClasses.close(); } catch (SQLException ignored) {}
                                    }
                                %>
                            </select>
                            <button type="submit" class="btn btn-primary">Load Dashboard</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    <% } else { %>
        <!-- Dashboard Analytics (Adapted for Attendance) -->
        <h3 class="text-center section-header">Attendance Dashboard - <%= selectedClass %></h3>
        <div class="row">
            <div class="col-md-3 col-sm-6 mb-2">
                <br><br>
                <div class="card text-center">
                    <div class="card-body">
                        <h5 class="card-title">Total Students</h5>
                        <p class="card-text" id="totalStudents"><%= totalStudentsCount %></p>
                    </div>
                </div>
            </div>
            <div class="col-md-3 col-sm-6 mb-2">
                <br><br>
                <div class="card text-center">
                    <div class="card-body">
                        <h5 class="card-title">Avg Attendance %</h5>
                        <p class="card-text" id="avgAttendance">0%</p>
                    </div>
                </div>
            </div>
            <div class="col-md-3 col-sm-6 mb-2">
                <br><br>
                <div class="card text-center">
                    <div class="card-body">
                        <h5 class="card-title">Total Working Days</h5>
                        <p class="card-text" id="totalWorking"><%= totalWorkingDays %></p>
                    </div>
                </div>
            </div>
            <div class="col-md-3 col-sm-6 mb-2">
                <div class="card text-center">
                    <div class="card-body">
                        <h5 class="card-title">Leave Types Distribution</h5>
                        <canvas id="leavePieChart" height="100"></canvas>
                    </div>
                </div>
            </div>
        </div>

        <!-- Students Table with Attendance Summary -->
        <h4 class="section-header">Students List - <%= selectedClass %></h4>
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
        <div class="table-responsive">
            <table id="studentsTable" class="display table table-bordered table-hover">
                <thead class="table-light">
                    <tr>
                        <th>Rank</th>
                        <th>Admin No</th>
                        <th>Name</th>
                        <th>Present Days</th>
                        <th>Absent Days</th>
                        <th>Total Leaves</th>
                        <th>Attendance %</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (Map<String, Object> studentData : studentsList) {
                        int sid = (Integer) studentData.get("id");
                        String adminNo = (String) studentData.get("adminNo");
                        String name = (String) studentData.get("name");
                        int present = (Integer) studentData.get("present");
                        int absent = (Integer) studentData.get("absent");
                        int leaves = (Integer) studentData.get("leaves");
                        String attPct = (String) studentData.get("attPct");
                        int rank = (Integer) studentData.get("rank");
                    %>
                        <tr>
                            <td><%= rank %></td>
                            <td><%= adminNo %></td>
                            <td><%= name %></td>
                            <td><%= present %></td>
                            <td><%= absent %></td>
                            <td><%= leaves %></td>
                            <td><%= attPct %>%</td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        </div>

        <!-- Tabs for Views: Day-wise, Weekly, Monthly, Comparison -->
        <ul class="nav nav-tabs" id="attendanceTabs" role="tablist">
            <li class="nav-item" role="presentation">
                <button class="nav-link active" id="day-tab" data-bs-toggle="tab" data-bs-target="#day" type="button" role="tab">Day-wise</button>
            </li>
            <li class="nav-item" role="presentation">
                <button class="nav-link" id="weekly-tab" data-bs-toggle="tab" data-bs-target="#weekly" type="button" role="tab">Weekly</button>
            </li>
            <li class="nav-item" role="presentation">
                <button class="nav-link" id="monthly-tab" data-bs-toggle="tab" data-bs-target="#monthly" type="button" role="tab">Monthly</button>
            </li>
            <li class="nav-item" role="presentation">
                <button class="nav-link" id="compare-tab" data-bs-toggle="tab" data-bs-target="#compare" type="button" role="tab">Comparison</button>
            </li>
        </ul>
        <div class="tab-content" id="attendanceTabContent">
            <!-- Day-wise Table -->
            <div class="tab-pane fade show active" id="day" role="tabpanel">
                <h5 class="section-header mt-3">Day-wise Attendance</h5>
                <div class="table-responsive">
                    <table id="dayTable" class="table table-bordered table-hover">
                        <thead class="table-light">
                            <tr><th>Date</th><th>Student</th><th>Status</th></tr>
                        </thead>
                        <tbody>
                            <%-- Sample rows; in real, loop over dates and students --%>
                            <tr><td>2025-12-01</td><td>Alice</td><td class="status-present">Present</td></tr>
                        </tbody>
                    </table>
                </div>
                <canvas id="dayChart" height="150"></canvas>
            </div>
            <!-- Weekly Summary -->
            <div class="tab-pane fade" id="weekly" role="tabpanel">
                <h5 class="section-header mt-3">Weekly Attendance Summary</h5>
                <canvas id="weeklyChart" height="150"></canvas>
            </div>
            <!-- Monthly Summary -->
            <div class="tab-pane fade" id="monthly" role="tabpanel">
                <h5 class="section-header mt-3">Monthly Attendance Trends</h5>
                <canvas id="monthlyChart" height="150"></canvas>
            </div>
            <!-- Comparison with Other Classes -->
            <div class="tab-pane fade" id="compare" role="tabpanel">
                <h5 class="section-header mt-3">Comparison with Other Classes</h5>
                <canvas id="compareChart" height="150"></canvas>
            </div>
        </div>

        <!-- Additional Charts -->
        <h4 class="section-header">Attendance Analytics</h4>
        <div class="row">
            <div class="col-md-6 col-sm-12 mb-2">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Attendance % Distribution</h5>
                        <canvas id="attDistribution" height="150"></canvas>
                    </div>
                </div>
            </div>
            <div class="col-md-6 col-sm-12 mb-2">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Leave Types Breakdown</h5>
                        <canvas id="leaveChart" height="150"></canvas>
                    </div>
                </div>
            </div>
        </div>
    <% } %>
</div>

<script>
    $(document).ready(function () {
        if ('<%= selectedClass %>' === '') return; // Skip if no class

        const table = $('#studentsTable').DataTable({
            fixedHeader: true,
            order: [],
            lengthMenu: [[10, 25, 50, -1], [10, 25, 50, "All"]],
            columnDefs: [{ orderable: true, targets: "_all" }],
            scrollY: '300px',
            scrollCollapse: true,
            paging: true
        });

        // Column toggle (similar to example)
        table.columns().every(function (index) {
            const columnName = $(this.header()).text();
            $('#column-list').append(`
                <li>
                    <label class="dropdown-item">
                        <input type="checkbox" class="form-check-input me-1 column-checkbox" data-column="${index}" checked>
                        ${columnName}
                    </label>
                </li>
            `);
        });
        $('#column-list').on('click', '.column-checkbox', function (e) {
            e.stopPropagation();
            const colIndex = $(this).data('column');
            table.column(colIndex).visible(this.checked);
        });

        // Attendance data from JSP (manual JSON output instead of Gson)
        const attendanceData = <%= generateJson(attendanceMap) %>; // Custom method below
        const totalStudents = <%= totalStudentsCount %>;
        const totalWorking = <%= totalWorkingDays %>;

        // Calculate averages (sample)
        let totalPresent = 0;
        // ... (loop over data to calc totalPresent, etc.)
        let avgAtt = totalStudents > 0 ? (totalPresent / (totalStudents * totalWorking)) * 100 : 0;
        $('#totalStudents').text(totalStudents);
        $('#avgAttendance').text(avgAtt.toFixed(2) + '%');

        // Leave Pie Chart
        const ctxLeavePie = document.getElementById('leavePieChart').getContext('2d');
        new Chart(ctxLeavePie, {
            type: 'pie',
            data: {
                labels: ['General Leave', 'Festival Leave', 'Permission Leave'],
                datasets: [{ data: [5, 3, 2], backgroundColor: ['#fff3cd', '#d1ecf1', '#f8d7da'] }] // Sample
            },
            options: { responsive: true, maintainAspectRatio: false }
        });

        // Day-wise Chart (sample bar for daily attendance)
        const ctxDay = document.getElementById('dayChart').getContext('2d');
        new Chart(ctxDay, {
            type: 'bar',
            data: {
                labels: ['2025-11-08', '2025-11-09'], // Sample dates
                datasets: [{ label: 'Avg Attendance', data: [85, 90], backgroundColor: '#d4edda' }]
            },
            options: { scales: { y: { beginAtZero: true } }, responsive: true, maintainAspectRatio: false }
        });

        // Weekly Chart (line)
        const ctxWeekly = document.getElementById('weeklyChart').getContext('2d');
        new Chart(ctxWeekly, {
            type: 'line',
            data: {
                labels: ['Week 1', 'Week 2', 'Week 3', 'Week 4'],
                datasets: [{ label: 'Attendance %', data: [80, 85, 78, 92], borderColor: '#155724' }]
            },
            options: { responsive: true, maintainAspectRatio: false }
        });

        // Monthly Chart (bar)
        const ctxMonthly = document.getElementById('monthlyChart').getContext('2d');
        new Chart(ctxMonthly, {
            type: 'bar',
            data: {
                labels: ['Nov 2025', 'Dec 2025'],
                datasets: [{ label: 'Total Present', data: [200, 150], backgroundColor: '#d4edda' }]
            },
            options: { responsive: true, maintainAspectRatio: false }
        });

        // Comparison Chart (bar with other classes)
        const ctxCompare = document.getElementById('compareChart').getContext('2d');
        new Chart(ctxCompare, {
            type: 'bar',
            data: {
                labels: ['Class 10A', 'Class 10B', 'Class 11A'],
                datasets: [{ label: 'Avg %', data: [85, 82, 88], backgroundColor: ['#d4edda', '#f8d7da', '#fff3cd'] }]
            },
            options: { responsive: true, maintainAspectRatio: false }
        });

        // Attendance Distribution (pie)
        const ctxAttDist = document.getElementById('attDistribution').getContext('2d');
        new Chart(ctxAttDist, {
            type: 'pie',
            data: {
                labels: ['>90%', '70-90%', '<70%'],
                datasets: [{ data: [10, 15, 5], backgroundColor: ['#d4edda', '#fff3cd', '#f8d7da'] }]
            },
            options: { responsive: true, maintainAspectRatio: false }
        });

        // Leave Breakdown (doughnut)
        const ctxLeave = document.getElementById('leaveChart').getContext('2d');
        new Chart(ctxLeave, {
            type: 'doughnut',
            data: {
                labels: ['Present', 'Absent', 'General', 'Festival', 'Permission'],
                datasets: [{ data: [200, 20, 10, 5, 8], backgroundColor: ['#d4edda', '#f8d7da', '#fff3cd', '#d1ecf1', '#f8d7da'] }]
            },
            options: { responsive: true, maintainAspectRatio: false }
        });

        // Apply colors to day-wise table (sample; extend for real data)
        $('#dayTable td').each(function() {
            const status = $(this).text().toLowerCase(); // Assume status in cell
            if (status.includes('present')) $(this).addClass('status-present');
            else if (status.includes('absent')) $(this).addClass('status-absent');
            else if (status.includes('general')) $(this).addClass('status-general-leave');
            else if (status.includes('festival')) $(this).addClass('status-festival-leave');
            else if (status.includes('permission')) $(this).addClass('status-permission-leave');
            else if (status.includes('half')) $(this).addClass('status-half-day');
        });

        // Download functions (same as example)
        document.getElementById('download-pdf').addEventListener('click', function () {
            const { jsPDF } = window.jspdf;
            const doc = new jsPDF();
            const table = document.getElementById('studentsTable');
            let content = '';
            for (let i = 0; i < table.rows.length; i++) {
                let row = table.rows[i];
                for (let j = 0; j < row.cells.length; j++) {
                    content += row.cells[j].innerText + '\t';
                }
                content += '\n';
            }
            doc.text(content, 10, 10);
            doc.save('attendance_' + getTodayDate() + '.pdf');
        });
        document.getElementById('download-xlsx').addEventListener('click', function () {
            const table = document.getElementById('studentsTable');
            const worksheet = XLSX.utils.table_to_sheet(table);
            const workbook = XLSX.utils.book_new();
            XLSX.utils.book_append_sheet(workbook, worksheet, 'Attendance');
            XLSX.writeFile(workbook, 'attendance_' + getTodayDate() + '.xlsx');
        });
        function getTodayDate() {
            const today = new Date();
            const year = today.getFullYear();
            const month = String(today.getMonth() + 1).padStart(2, '0');
            const day = String(today.getDate()).padStart(2, '0');
            return `${year}-${month}-${day}`;
        }
    });

    <%!
    // Custom JSP method to generate JSON for Map (simple implementation)
    private String generateJson(Map<Integer, Map<String, String>> map) {
        StringBuilder sb = new StringBuilder("{");
        for (Map.Entry<Integer, Map<String, String>> entry : map.entrySet()) {
            sb.append(entry.getKey()).append(":{");
            for (Map.Entry<String, String> inner : entry.getValue().entrySet()) {
                sb.append("\"").append(inner.getKey()).append("\":\"").append(inner.getValue()).append("\",");
            }
            if (sb.charAt(sb.length() - 1) == ',') sb.deleteCharAt(sb.length() - 1);
            sb.append("},");
        }
        if (sb.charAt(sb.length() - 1) == ',') sb.deleteCharAt(sb.length() - 1);
        sb.append("}");
        return sb.toString();
    }
    %>
</script>
</body>
</html>