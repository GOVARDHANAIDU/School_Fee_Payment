<%@page import="com.DAO.StudentDetailsImp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@page import="com.DTO.PaymentTransaction"%>
<%@page import="com.DAO.TransactionPageImp"%>
<%@page import="com.DAO.AllPaymentsByAdmin"%>
<%@page import="com.DTO.StudentDetails"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Student Fee Details</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="icon" href="https://cdn-icons-png.flaticon.com/512/2132/2132732.png" type="image/x-icon">
    <!-- DataTables CSS -->
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/jquery.dataTables.min.css">
    <link rel="stylesheet" href="https://cdn.datatables.net/fixedheader/3.4.0/css/fixedHeader.dataTables.min.css">

    <!-- Chart.js -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.5.1.js"></script>

    <!-- DataTables JS -->
    <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/fixedheader/3.4.0/js/dataTables.fixedHeader.min.js"></script>

    <!-- Bootstrap JS (for dropdowns) -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <!-- jsPDF Library -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
    
    <!-- SheetJS (xlsx) Library -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.17.0/xlsx.full.min.js"></script>

    <style>
        body { font-size: 0.85rem; }
        .navbar { padding: 0.3rem 1rem; }
        .navbar-brand { font-size: 1rem; }
        .nav-link { font-size: 0.85rem; padding: 0.3rem 0.5rem !important; }
        .navbar-nav .dropdown-menu { font-size: 0.9rem; }
        .section-header { margin: 20px 0 10px; font-size: 1.2rem; text-align: center; margin-top: -10px;}
        .card { box-shadow: 0 2px 4px rgba(0,0,0,0.1); margin-bottom: 10px; }
        .card-body { padding: 0.5rem; }
        .card-title { font-size: 0.8rem; margin-bottom: 0.3rem; }
        .card-text { font-size: 0.9rem; font-weight: bold; }
        .table-responsive { max-height: 300px; overflow-y: auto; }
        .table { font-size: 0.8rem; margin-bottom: 0; }
        .table th, .table td { padding: 0.4rem; text-align: center; vertical-align: middle; }
        .table thead th { position: sticky; top: 0; background-color: #f8f9fa; z-index: 10; }
        .btn-group .btn { font-size: 0.8rem; padding: 0.3rem 0.6rem; margin-right: 2px; }
        canvas { max-height: 150px !important; }
        .container { margin-top: 20px; padding-top: 0; } /* Reduced margin to remove empty space */
        table.dataTable thead th { position: sticky; top: 0; background-color: #f8f9fa; }
        nav { position: fixed; top: 0; width: 100%; z-index: 1000; }
        .chart-row .col-md-3 { flex: 0 0 23%; max-width: 23%; }
        #column-list { max-height: 200px; overflow-y: auto; font-size: 0.8rem; }
        #column-list .dropdown-item { padding: 0.3rem 0.75rem; }
        /* Lighter border for analytics sections */
        .analytics-section {
            border: 2px solid #e0e0e0;
            padding: 10px;
            margin-bottom: 20px;
        }
    </style>
    <link href="./student-profile.css" rel="stylesheet">
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
      <div class="d-flex align-items-center ms-3">
        <p class="text-white mb-0 me-3">Hello, <%=userName%></p>
 
        <!-- Roles Dropdown -->
        <div class="dropdown me-3">
          <a class="btn btn-sm btn-outline-light dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">
            Roles
          </a>
          <ul class="dropdown-menu dropdown-menu-end">
            <li><a class="dropdown-item" href="home.jsp" id="hideFunction()">Channel Admin</a></li>
            <li><a class="dropdown-item" href="home.jsp" >Student</a></li>
            <li><a class="dropdown-item" href="./faculty/faculty.jsp" id="hideFunction()">Faculty</a></li>
          </ul>
        </div>
 
        <!-- Auth Buttons -->
        <a class="btn btn-outline-light btn-sm me-2" href="AdminLogin.jsp">Logout</a>
        <a class="btn btn-outline-warning btn-sm" href="createaccount.jsp">Signup</a>
      </div>
    </div>
  </div>
</nav>

<!-- Main Container -->
<div class="container pt-4">
    <h2 class="section-header"><br>All Fee Payments Details</h2>

    <!-- Dashboard Analytics -->
    <h3 class="section-header">Dashboard Analytics</h3>
    <div class="analytics-section">
        <div class="row">
            <div class="col-md-2 col-sm-6 mb-2">
            <br><br><br>
                <div class="card text-center">
                    <div class="card-body">
                        <h5 class="card-title">Total Transactions</h5>
                        <p class="card-text" id="totalTransactions">0</p>
                    </div>
                </div>
            </div>
            <div class="col-md-2 col-sm-6 mb-2">
             <br><br><br>
                <div class="card text-center">
                    <div class="card-body">
                        <h5 class="card-title">Total Collected</h5>
                        <p class="card-text" id="totalCollected">0</p>
                    </div>
                </div>
            </div>
            <div class="col-md-2 col-sm-6 mb-2">
             <br><br><br>
                <div class="card text-center">
                    <div class="card-body">
                        <h5 class="card-title">Average Transaction</h5>
                        <p class="card-text" id="averageTransaction">0</p>
                    </div>
                </div>
            </div>
            <div class="col-md-2 col-sm-6 mb-2">
             <br><br><br>
                <div class="card text-center">
                    <div class="card-body">
                        <h5 class="card-title">Unique Students</h5>
                        <p class="card-text" id="uniqueStudents">0</p>
                    </div>
                </div>
            </div>
            <div class="col-md-3 col-sm-6 mb-2">
                <div class="card text-center">
                    <div class="card-body">
                        <h5 class="card-title">Payment Modes</h5>
                        <canvas id="paymentModesPie" height="150"></canvas>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Class-wise Payment Statistics -->
    <h4 class="section-header">Class-wise Payment Statistics</h4>
    <div class="analytics-section">
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
    <div class="analytics-section">
        <div class="row">
            <div class="col-md-6 col-sm-12 mb-2">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Transactions per Class</h5>
                        <canvas id="transactionsPerClass" height="150"></canvas>
                    </div>
                </div>
            </div>
            <div class="col-md-6 col-sm-12 mb-2">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Collected per Class</h5>
                        <canvas id="collectedPerClass" height="150"></canvas>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-6 col-sm-12 mb-2">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Collected by Billed By</h5>
                        <canvas id="collectedByAdmin" height="150"></canvas>
                    </div>
                </div>
            </div>
            <div class="col-md-6 col-sm-12 mb-2">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Daily Collections</h5>
                        <canvas id="dailyCollections" height="150"></canvas>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Download Buttons -->
    <button id="download-pdf" class="btn btn-primary mb-4">Download as PDF</button>
    <button id="download-xlsx" class="btn btn-success mb-4">Download as Excel</button>

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
                AllPaymentsByAdmin allPaymentsByAdmin = new TransactionPageImp();
                List<PaymentTransaction> list = allPaymentsByAdmin.selectAllPayments();
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
        const table = $('#paymentTable').DataTable({
            fixedHeader: true,
            order: [],
            lengthMenu: [[10, 25, 50, 100, -1], [10, 25, 50, 100, "All"]],
            columnDefs: [{ orderable: true, targets: "_all" }, { targets: -1, orderable: false }]
        });

        // Dashboard calculations
        const allData = table.rows().data().toArray();
        const totalTransactions = allData.length;
        $('#totalTransactions').text(totalTransactions);

        let totalCollected = 0;
        let modeData = {};
        let classData = {};
        let adminData = {};
        let dailyData = {};
        let uniqueStudents = new Set();

        allData.forEach(row => {
            const payingFee = parseFloat(row[4]) || 0;
            const mode = row[9] || 'Unknown';
            const cls = row[6] || 'Unknown';
            const admin = row[10] || 'Unknown';
            const date = row[7] || 'Unknown';
            const student = row[1];

            totalCollected += payingFee;
            uniqueStudents.add(student);

            if (!modeData[mode]) modeData[mode] = { count: 0, total: 0 };
            modeData[mode].count++;
            modeData[mode].total += payingFee;

            if (!classData[cls]) classData[cls] = { transactions: 0, total: 0 };
            classData[cls].transactions++;
            classData[cls].total += payingFee;

            if (!adminData[admin]) adminData[admin] = { total: 0 };
            adminData[admin].total += payingFee;

            if (!dailyData[date]) dailyData[date] = 0;
            dailyData[date] += payingFee;
        });

        const averageTransaction = totalTransactions > 0 ? (totalCollected / totalTransactions).toFixed(2) : 0;
        $('#totalCollected').text(totalCollected.toFixed(2));
        $('#averageTransaction').text(averageTransaction);
        $('#uniqueStudents').text(uniqueStudents.size);

        // Payment Modes Pie Chart (by count)
        const ctxModes = document.getElementById('paymentModesPie').getContext('2d');
        new Chart(ctxModes, {
            type: 'pie',
            data: {
                labels: Object.keys(modeData),
                datasets: [{
                    data: Object.values(modeData).map(d => d.count),
                    backgroundColor: ['rgba(75, 192, 192, 0.8)', 'rgba(255, 99, 132, 0.8)', 'rgba(255, 205, 86, 0.8)', 'rgba(54, 162, 235, 0.8)']
                }]
            },
            options: { responsive: true, maintainAspectRatio: false }
        });

        // Class-wise Stats Table
        const classes = Object.keys(classData);
        classes.forEach(cls => {
            const data = classData[cls];
            const avg = data.transactions > 0 ? (data.total / data.transactions).toFixed(2) : 0;
            $('#classStatsTable tbody').append(`
                <tr>
                    <td>${cls}</td>
                    <td>${data.transactions}</td>
                    <td>${data.total.toFixed(2)}</td>
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
                datasets: [{ label: 'Transactions', data: classes.map(cls => classData[cls].transactions), backgroundColor: 'rgba(153, 102, 255, 0.8)' }]
            },
            options: { scales: { y: { beginAtZero: true } }, responsive: true, maintainAspectRatio: false }
        });

        // Collected per Class Bar
        const ctxCollClass = document.getElementById('collectedPerClass').getContext('2d');
        new Chart(ctxCollClass, {
            type: 'bar',
            data: {
                labels: classes,
                datasets: [{ label: 'Collected', data: classes.map(cls => classData[cls].total), backgroundColor: 'rgba(75, 192, 192, 0.8)' }]
            },
            options: { scales: { y: { beginAtZero: true } }, responsive: true, maintainAspectRatio: false }
        });

        // Collected by Admin Pie
        const ctxAdmin = document.getElementById('collectedByAdmin').getContext('2d');
        new Chart(ctxAdmin, {
            type: 'pie',
            data: {
                labels: Object.keys(adminData),
                datasets: [{ data: Object.values(adminData).map(d => d.total), backgroundColor: ['rgba(255, 99, 132, 0.8)', 'rgba(54, 162, 235, 0.8)', 'rgba(255, 205, 86, 0.8)', 'rgba(75, 192, 192, 0.8)'] }]
            },
            options: { responsive: true, maintainAspectRatio: false }
        });

        // Daily Collections Line
        const dates = Object.keys(dailyData).sort();
        const ctxDaily = document.getElementById('dailyCollections').getContext('2d');
        new Chart(ctxDaily, {
            type: 'line',
            data: {
                labels: dates,
                datasets: [{ label: 'Daily Collected', data: dates.map(date => dailyData[date]), borderColor: 'rgba(75, 192, 192, 1)', fill: false }]
            },
            options: { scales: { y: { beginAtZero: true } }, responsive: true, maintainAspectRatio: false }
        });

        // Download Functions
        function getTodayDate() {
            const today = new Date();
            const year = today.getFullYear();
            const month = String(today.getMonth() + 1).padStart(2, '0');
            const day = String(today.getDate()).padStart(2, '0');
            return `${year}-${month}-${day}`;
        }

        document.getElementById('download-pdf').addEventListener('click', function () {
            const { jsPDF } = window.jspdf;
            const doc = new jsPDF();
            const table = document.getElementById('paymentTable');
            let content = '';

            for (let i = 0; i < table.rows.length; i++) {
                let row = table.rows[i];
                for (let j = 0; j < row.cells.length; j++) {
                    content += row.cells[j].innerText + '\t';
                }
                content += '\n';
            }

            doc.text(content, 10, 10);
            doc.save('all_payments_details_' + getTodayDate() + '.pdf');
        });

        document.getElementById('download-xlsx').addEventListener('click', function () {
            const table = document.getElementById('paymentTable');
            const worksheet = XLSX.utils.table_to_sheet(table);
            const workbook = XLSX.utils.book_new();
            XLSX.utils.book_append_sheet(workbook, worksheet, 'Payments');
            XLSX.writeFile(workbook, 'all_payments_details_' + getTodayDate() + '.xlsx');
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