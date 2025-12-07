<%@ page language="java" import="java.sql.*, javax.servlet.http.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Class Records</title>
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
    </style>
</head>
<body>
<%
    String tableName = request.getParameter("tableName");
    Connection con = null;
    Statement stmt = null;
    ResultSet rs = null;
    ResultSetMetaData rsmd = null;
    int columnCount = 0;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/academic_details", "root", "W7301@jqir#");
        stmt = con.createStatement();
        rs = stmt.executeQuery("SELECT * FROM " + tableName + ";");
        rsmd = rs.getMetaData();
        columnCount = rsmd.getColumnCount();
    } catch (Exception e) {
        out.println("<div class='alert alert-danger'>Error: " + e.getMessage() + "</div>");
    }
%>
<!-- Navbar -->
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
<!-- Main Container -->
<div class="container">
    <!-- Dashboard Analytics -->
    <h3 class="text-center section-header">Dashboard Analytics</h3>
    <div class="row">
        <div class="col-md-3 col-sm-6 mb-2">
        <br><br>
            <div class="card text-center">
                <div class="card-body">
                    <h5 class="card-title">Total Students</h5>
                    <p class="card-text" id="totalStudents">0</p>
                </div>
            </div>
        </div>
        <div class="col-md-3 col-sm-6 mb-2">
        <br><br>
            <div class="card text-center">
                <div class="card-body">
                    <h5 class="card-title">Overall Pass %</h5>
                    <p class="card-text" id="overallPass">0%</p>
                </div>
            </div>
        </div>
        <div class="col-md-3 col-sm-6 mb-2">
        <br><br>
            <div class="card text-center">
                <div class="card-body">
                    <h5 class="card-title">Overall Avg Marks</h5>
                    <p class="card-text" id="overallAverage">0</p>
                </div>
            </div>
        </div>
        <div class="col-md-3 col-sm-6 mb-2">
            <div class="card text-center">
                <div class="card-body">
                    <h5 class="card-title">Pass/Fail</h5>
                    <canvas id="passFailPieChart" height="100"></canvas>
                </div>
            </div>
        </div>
    </div>

    <!-- Subject Statistics -->
    <h4 class="section-header">Subject Statistics</h4>
    <div class="table-responsive">
        <table class="table table-bordered table-hover" id="statsTable">
            <thead class="table-light">
                <tr>
                    <th>Subject</th>
                    <th>Avg Marks</th>
                    <th>Pass</th>
                    <th>Fail</th>
                    <th>Max</th>
                    <th>Min</th>
                </tr>
            </thead>
            <tbody></tbody>
        </table>
    </div>

    <!-- Class Table -->
    <h3 class="text-center section-header">Class: <%= tableName %></h3>
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
        <table id="classTable" class="display table table-bordered table-hover">
            <thead class="table-light">
                <tr>
                    <% for (int i = 1; i <= columnCount; i++) { %>
                        <th><%= rsmd.getColumnName(i) %></th>
                    <% } %>
                </tr>
            </thead>
            <tbody>
                <% while (rs.next()) { %>
                    <tr>
                        <% for (int i = 1; i <= columnCount; i++) { %>
                            <td><%= rs.getString(i) %></td>
                        <% } %>
                    </tr>
                <% } %>
                <% 
                    if (rs != null) rs.close();
                    if (stmt != null) stmt.close();
                    if (con != null) con.close();
                %>
            </tbody>
        </table>
    </div>

    <!-- Charts -->
    <h4 class="section-header">Additional Analytics</h4>
    <div class="row">
        <div class="col-md-6 col-sm-12 mb-2">
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title">Pass/Fail Counts</h5>
                    <canvas id="passFailChart" height="150"></canvas>
                </div>
            </div>
        </div>
        <div class="col-md-6 col-sm-12 mb-2">
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title">Marks Distribution by Subject</h5>
                    <canvas id="marksDistribution" height="150"></canvas>
                </div>
            </div>
        </div>
        <div class="col-md-6 col-sm-12 mb-2">
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title">Overall Marks Dist.</h5>
                    <canvas id="overallDistribution" height="150"></canvas>
                </div>
            </div>
        </div>
        <div class="col-md-6 col-sm-12 mb-2">
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title">Avg Marks/Subject</h5>
                    <canvas id="averageChart" height="150"></canvas>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    $(document).ready(function () {
        const table = $('#classTable').DataTable({
            fixedHeader: true,
            order: [],
            lengthMenu: [[10, 25, 50, -1], [10, 25, 50, "All"]],
            columnDefs: [{ orderable: true, targets: "_all" }],
            scrollY: '300px',
            scrollCollapse: true,
            paging: true
        });

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

        table.columns().every(function (index) {
            if (Math.random() > 0.7) {
                this.visible(false);
                $(`#column-list input[data-column=${index}]`).prop("checked", false);
            }
        });

        $('#column-list').on('click', '.column-checkbox', function (e) {
            e.stopPropagation();
            const colIndex = $(this).data('column');
            const column = table.column(colIndex);
            column.visible(this.checked);
        });

        const PASS_MARK = 35;
        const headers = table.columns().header().toArray().map(h => $(h).text().trim());
        let subjectIndices = [];
        const possibleSubjects = ['Telugu', 'Hindi', 'English', 'Maths', 'Science', 'Social'];

        headers.forEach((header, index) => {
            if (possibleSubjects.includes(header)) {
                subjectIndices.push({name: header, index: index});
            }
        });

        if (subjectIndices.length === 0) {
            for (let i = 2; i < headers.length; i++) {
                let isNumeric = true;
                table.column(i).data().each(val => {
                    if (isNaN(parseFloat(val))) isNumeric = false;
                });
                if (isNumeric) {
                    subjectIndices.push({name: headers[i], index: i});
                }
            }
        }

        const allData = table.rows().data().toArray();
        const totalStudents = allData.length;
        $('#totalStudents').text(totalStudents);

        let overallPassCount = 0;
        let overallTotalMarks = [];
        allData.forEach(row => {
            let passedAll = true;
            let totalMark = 0;
            subjectIndices.forEach(sub => {
                const mark = parseFloat(row[sub.index]);
                totalMark += mark;
                if (mark < PASS_MARK) passedAll = false;
            });
            if (passedAll) overallPassCount++;
            if (subjectIndices.length > 0) {
                overallTotalMarks.push(totalMark / subjectIndices.length);
            }
        });
        $('#overallPass').text(((overallPassCount / totalStudents) * 100).toFixed(2) + '%');

        let overallAvg = 0;
        if (overallTotalMarks.length > 0) {
            overallAvg = overallTotalMarks.reduce((a, b) => a + b, 0) / totalStudents;
        }
        $('#overallAverage').text(overallAvg.toFixed(2));

        // Pass/Fail Pie Chart
        const ctxPassFail = document.getElementById('passFailPieChart').getContext('2d');
        new Chart(ctxPassFail, {
            type: 'pie',
            data: {
                labels: ['Pass', 'Fail'],
                datasets: [{
                    data: [overallPassCount, totalStudents - overallPassCount],
                    backgroundColor: ['rgba(75, 192, 192, 0.8)', 'rgba(255, 99, 132, 0.8)']
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false
            }
        });

        let passCounts = [];
        let failCounts = [];
        let averageMarks = [];
        let markRanges = {
            '0-25': [], '25-50': [], '50-80': [], '80-100': []
        };
        subjectIndices.forEach(sub => {
            let marks = allData.map(row => parseFloat(row[sub.index])).filter(m => !isNaN(m));
            let avg = marks.reduce((a, b) => a + b, 0) / totalStudents;
            let pass = marks.filter(m => m >= PASS_MARK).length;
            let fail = totalStudents - pass;
            let max = Math.max(...marks);
            let min = Math.min(...marks);

            $('#statsTable tbody').append(`
                <tr>
                    <td>${sub.name}</td>
                    <td>${avg.toFixed(2)}</td>
                    <td>${pass}</td>
                    <td>${fail}</td>
                    <td>${max}</td>
                    <td>${min}</td>
                </tr>
            `);

            passCounts.push(pass);
            failCounts.push(fail);
            averageMarks.push(avg);

            // Calculate mark ranges for each subject
            let ranges = { '0-25': 0, '25-50': 0, '50-80': 0, '80-100': 0 };
            marks.forEach(m => {
                if (m <= 25) ranges['0-25']++;
                else if (m <= 50) ranges['25-50']++;
                else if (m <= 80) ranges['50-80']++;
                else if (m <= 100) ranges['80-100']++;
            });
            markRanges['0-25'].push(ranges['0-25']);
            markRanges['25-50'].push(ranges['25-50']);
            markRanges['50-80'].push(ranges['50-80']);
            markRanges['80-100'].push(ranges['80-100']);
        });

        // Pass/Fail Bar Chart
        const ctx1 = document.getElementById('passFailChart').getContext('2d');
        new Chart(ctx1, {
            type: 'bar',
            data: {
                labels: subjectIndices.map(s => s.name),
                datasets: [
                    { label: 'Pass', data: passCounts, backgroundColor: 'rgba(75, 192, 192, 0.8)' },
                    { label: 'Fail', data: failCounts, backgroundColor: 'rgba(255, 99, 132, 0.8)' }
                ]
            },
            options: {
                scales: { y: { beginAtZero: true } },
                responsive: true,
                maintainAspectRatio: false
            }
        });

        // Marks Distribution by Subject
        const ctx2 = document.getElementById('marksDistribution').getContext('2d');
        new Chart(ctx2, {
            type: 'bar',
            data: {
                labels: subjectIndices.map(s => s.name),
                datasets: [
                    { label: '0-25', data: markRanges['0-25'], backgroundColor: 'rgba(255, 99, 132, 0.8)' },
                    { label: '25-50', data: markRanges['25-50'], backgroundColor: 'rgba(255, 159, 64, 0.8)' },
                    { label: '50-80', data: markRanges['50-80'], backgroundColor: 'rgba(255, 205, 86, 0.8)' },
                    { label: '80-100', data: markRanges['80-100'], backgroundColor: 'rgba(75, 192, 192, 0.8)' }
                ]
            },
            options: {
                scales: { y: { beginAtZero: true } },
                responsive: true,
                maintainAspectRatio: false
            }
        });

        // Overall Marks Distribution
        let overallRanges = { '0-34': 0, '35-59': 0, '60-74': 0, '75-89': 0, '90-100': 0 };
        overallTotalMarks.forEach(avg => {
            if (avg <= 34) overallRanges['0-34']++;
            else if (avg <= 59) overallRanges['35-59']++;
            else if (avg <= 74) overallRanges['60-74']++;
            else if (avg <= 89) overallRanges['75-89']++;
            else if (avg <= 100) overallRanges['90-100']++;
        });
        const ctx3 = document.getElementById('overallDistribution').getContext('2d');
        new Chart(ctx3, {
            type: 'pie',
            data: {
                labels: Object.keys(overallRanges),
                datasets: [{ data: Object.values(overallRanges), backgroundColor: ['rgba(255, 99, 132, 0.8)', 'rgba(255, 159, 64, 0.8)', 'rgba(255, 205, 86, 0.8)', 'rgba(75, 192, 192, 0.8)', 'rgba(54, 162, 235, 0.8)'] }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false
            }
        });

        // Average Marks per Subject
        const ctx4 = document.getElementById('averageChart').getContext('2d');
        new Chart(ctx4, {
            type: 'bar',
            data: {
                labels: subjectIndices.map(s => s.name),
                datasets: [{ label: 'Average Marks', data: averageMarks, backgroundColor: 'rgba(153, 102, 255, 0.8)' }]
            },
            options: {
                scales: { y: { beginAtZero: true, max: 100 } },
                responsive: true,
                maintainAspectRatio: false
            }
        });

        document.getElementById('download-pdf').addEventListener('click', function () {
            const { jsPDF } = window.jspdf;
            const doc = new jsPDF();
            const table = document.getElementById('classTable');
            let content = '';

            for (let i = 0; i < table.rows.length; i++) {
                let row = table.rows[i];
                for (let j = 0; j < row.cells.length; j++) {
                    content += row.cells[j].innerText + '\t';
                }
                content += '\n';
            }

            doc.text(content, 10, 10);
            doc.save('class_records_' + getTodayDate() + '.pdf');
        });

        document.getElementById('download-xlsx').addEventListener('click', function () {
            const table = document.getElementById('classTable');
            const worksheet = XLSX.utils.table_to_sheet(table);
            const workbook = XLSX.utils.book_new();
            XLSX.utils.book_append_sheet(workbook, worksheet, 'ClassRecords');
            XLSX.writeFile(workbook, 'class_records_' + getTodayDate() + '.xlsx');
        });

        function getTodayDate() {
            const today = new Date();
            const year = today.getFullYear();
            const month = String(today.getMonth() + 1).padStart(2, '0');
            const day = String(today.getDate()).padStart(2, '0');
            return `${year}-${month}-${day}`;
        }
    });
</script>
</body>
