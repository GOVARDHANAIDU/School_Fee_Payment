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
    <title>Fee Payment By Admin</title>
 
    <link rel="icon" href="https://cdn-icons-png.flaticon.com/512/2132/2132732.png" type="image/x-icon">
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
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
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <!-- jsPDF Library -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
    <!-- SheetJS (xlsx) Library -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.17.0/xlsx.full.min.js"></script>
 
    <style>

       .section-header {
            margin: 10px 0;
            font-size: 1.2rem;
            font-weight: 600;
            text-align: center;
            color: #343a40;
        }
        .card {
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            margin-bottom: 10px;
            border: 1px solid #e0e0e0;
            border-radius: 10px;
            transition: transform 0.2s;
        }
        .card:hover {
            transform: translateY(-3px);
        }
        .card-body {
            padding: 0.5rem;
        }
        .card-title {
            font-size: 0.8rem;
            font-weight: 500;
            margin-bottom: 0.3rem;
            color: #495057;
        }
        .card-text {
            font-size: 0.9rem;
            font-weight: bold;
            color: #212529;
        }
        .table-responsive {
            max-height: 300px;
            overflow-y: auto;
            border: 1px solid #dee2e6;
            border-radius: 8px;
            margin-bottom: 20px;
        }
        .table {
            font-size: 0.75rem;
            margin-bottom: 0;
            border-collapse: separate;
            border-spacing: 0;
        }
        .table th, .table td {
            padding: 0.4rem;
            text-align: center;
            vertical-align: middle;
            border: 1px solid #dee2e6;
        }
        .table thead th {
            position: sticky;
            top: 0;
            background-color: #f8f9fa;
            z-index: 10;
            font-weight: 600;
            color: #343a40;
        }
        .table tbody tr:hover {
            background-color: #f1f3f5;
        }
        .btn-group .btn {
            font-size: 0.75rem;
            padding: 0.3rem 0.6rem;
            margin-right: 2px;
            border-radius: 6px;
        }
        canvas {
            max-height: 150px !important;
            width: 100% !important;
        }
        .container {
            margin-top: 70px;
            padding: 20px;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.05);
            max-width: 95%; /* Slightly wider container */
            width: 100%;
        }
        table.dataTable thead th {
            position: sticky;
            top: 0;
            background-color: #f8f9fa;
        }
        .chart-row .col-md-3 {
            flex: 0 0 23%;
            max-width: 23%;
            margin-right: 2%;
            margin-bottom: 20px;
        }
        .chart-row .col-md-3:last-child {
            margin-right: 0;
        }
        #column-list {
            max-height: 200px;
            overflow-y: auto;
            font-size: 0.75rem;
            border: 1px solid #dee2e6;
            border-radius: 6px;
        }
        #column-list .dropdown-item {
            padding: 0.3rem 0.75rem;
        }
        .analytics-section {
            border: 2px solid #e0e0e0;
            padding: 10px;
            margin-bottom: 20px;
            border-radius: 10px;
            background-color: #fafafa;
        }
        .btn-primary {
            background-color: #007bff;
            border-color: #007bff;
        }
        .btn-primary:hover {
            background-color: #0056b3;
            border-color: #0056b3;
        }
        .btn-success {
            background-color: #28a745;
            border-color: #28a745;
        }
        .btn-success:hover {
            background-color: #218838;
            border-color: #218838;
        }
        .btn-secondary {
            background-color: #6c757d;
            border-color: #6c757d;
        }
        .btn-secondary:hover {
            background-color: #5a6268;
            border-color: #5a6268;
        }
    </style>
      <link href="./student-profile.css" rel="stylesheet">
    
</head>
<body>

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
    int tempid = (int) session.getAttribute("adminId");

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
<div class="container">
    <h2 class="section-header">Fee Payment By Admin</h2>

    <h3 class="section-header">Dashboard Analytics</h3>
    <div class="analytics-section">
        <div class="row">
            <div class="col-md-2 col-sm-6 mb-2">
                <div class="card text-center">
                    <div class="card-body">
                        <h5 class="card-title">Total Transactions</h5>
                        <p class="card-text" id="totalTransactions">0</p>
                    </div>
                </div>
            </div>
            <div class="col-md-2 col-sm-6 mb-2">
                <div class="card text-center">
                    <div class="card-body">
                        <h5 class="card-title">Total Fee</h5>
                        <p class="card-text" id="totalFee">0</p>
                    </div>
                </div>
            </div>
            <div class="col-md-2 col-sm-6 mb-2">
                <div class="card text-center">
                    <div class="card-body">
                        <h5 class="card-title">Total Paid</h5>
                        <p class="card-text" id="totalPaid">0</p>
                    </div>
                </div>
            </div>
            <div class="col-md-2 col-sm-6 mb-2">
                <div class="card text-center">
                    <div class="card-body">
                        <h5 class="card-title">Total Balance</h5>
                        <p class="card-text" id="totalBalance">0</p>
                    </div>
                </div>
            </div>
            <div class="col-md-3 col-sm-6 mb-2">
                <div class="card text-center">
                    <div class="card-body">
                        <h5 class="card-title">Payment Modes</h5>
                        <canvas id="paymentModePie" height="150"></canvas>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <h4 class="section-header">Class-wise Payment Statistics</h4>
    <div class="analytics-section">
        <div class="table-responsive">
            <table class="table table-bordered table-hover" id="classStatsTable">
                <thead class="table-light">
                    <tr>
                        <th>Class</th>
                        <th>Transactions</th>
                        <th>Total Fee</th>
                        <th>Paid Fee</th>
                        <th>Balance</th>
                        <th>Avg Paid</th>
                    </tr>
                </thead>
                <tbody></tbody>
            </table>
        </div>
    </div>

    <h4 class="section-header">Additional Analytics</h4>
    <div class="analytics-section">
        <div class="row chart-row">
            <div class="col-md-3 col-sm-6 mb-2">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Class-wise Transactions</h5>
                        <canvas id="transactionsPerClass" height="150"></canvas>
                    </div>
                </div>
            </div>
            <div class="col-md-3 col-sm-6 mb-2">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Class-wise Fee Breakdown</h5>
                        <canvas id="classFeeBar" height="150"></canvas>
                    </div>
                </div>
            </div>
            <div class="col-md-3 col-sm-6 mb-2">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Balance Distribution</h5>
                        <canvas id="balanceDistribution" height="150"></canvas>
                    </div>
                </div>
            </div>
            <div class="col-md-3 col-sm-6 mb-2">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Payment Completion %</h5>
                        <canvas id="paymentCompletion" height="150"></canvas>
                    </div>
                </div>
            </div>
        </div>
    </div>

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
        <table id="paymentTable" class="display table table-bordered table-hover">
            <thead class="table-light">
                <tr>
                    <th>S.no</th>
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
                </tr>
            </thead>
            <tbody>
                <%
                    AllPaymentsByAdmin allPaymentsByAdmin = new TransactionPageImp();
                    List<PaymentTransaction> list = allPaymentsByAdmin.selectAllPaymentsByAdmin(tempid);
                    int count = 1;
                    for (int i = list.size() - 1; i >= 0; i--) {
                        PaymentTransaction p = list.get(i);
                %>
                <tr>
                    <td><%= count++ %></td>
                    <td><%= p.getStudentNAme() %></td>
                    <td><%= p.getTotal_fee() %></td>
                    <td><%= p.getPaidFee() %></td>
                    <td><%= p.getPayingFee()%></td>
                    <td><%= p.getRemaingFee() %></td>
                    <td><%= p.getStudentClass() %></td>
                    <td><%= p.getDateOfTransaction() %></td>
                    <td><%= p.getTimeOfTransaction() %></td>
                    <td><%= p.getModeOfPayment() %></td>
                    <td><%= p.getAdminName() %></td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>
</div>

<script>
$(document).ready(function () {
    const table = $('#paymentTable').DataTable({
        fixedHeader: true,
        order: [],
        lengthMenu: [[10, 25, 50, 100, -1], [10, 25, 50, 100, "All"]],
        columnDefs: [{ orderable: true, targets: "_all" }],
        dom: 'lfrtip',
        language: {
            lengthMenu: "Show _MENU_ entries",
            info: "Showing _START_ to _END_ of _TOTAL_ entries"
        }
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

    const allData = table.rows().data().toArray();
    const totalTransactions = allData.length;
    $('#totalTransactions').text(totalTransactions);

    let totalFee = 0, totalPaid = 0, totalBalance = 0;
    let classData = {};
    let paymentModes = {};
    let balanceRanges = { '0-5000': 0, '5001-10000': 0, '10001-20000': 0, '20001+': 0 };

    allData.forEach(row => {
        const tFee = parseFloat(row[2]) || 0;
        const pFee = parseFloat(row[3]) || 0;
        const bal = parseFloat(row[5]) || 0;
        const cls = row[6] || 'Unknown';
        const mode = row[9] || 'Unknown';

        totalFee += tFee;
        totalPaid += pFee;
        totalBalance += bal;

        if (!classData[cls]) {
            classData[cls] = { transactions: 0, totalFee: 0, paid: 0, balance: 0 };
        }
        classData[cls].transactions++;
        classData[cls].totalFee += tFee;
        classData[cls].paid += pFee;
        classData[cls].balance += bal;

        if (!paymentModes[mode]) {
            paymentModes[mode] = 0;
        }
        paymentModes[mode]++;

        if (bal <= 5000) balanceRanges['0-5000']++;
        else if (bal <= 10000) balanceRanges['5001-10000']++;
        else if (bal <= 20000) balanceRanges['10001-20000']++;
        else balanceRanges['20001+']++;
    });

    $('#totalFee').text(totalFee.toFixed(2));
    $('#totalPaid').text(totalPaid.toFixed(2));
    $('#totalBalance').text(totalBalance.toFixed(2));

    const ctxPie = document.getElementById('paymentModePie').getContext('2d');
    new Chart(ctxPie, {
        type: 'pie',
        data: {
            labels: Object.keys(paymentModes),
            datasets: [{
                data: Object.values(paymentModes),
                backgroundColor: ['rgba(75, 192, 192, 0.8)', 'rgba(255, 99, 132, 0.8)', 'rgba(255, 205, 86, 0.8)', 'rgba(54, 162, 235, 0.8)'],
                borderColor: ['#fff', '#fff', '#fff', '#fff'],
                borderWidth: 1
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: { position: 'top' },
                tooltip: { backgroundColor: '#333', borderRadius: 5 }
            }
        }
    });

    const classes = Object.keys(classData);
    let transactionsPerClass = [];
    let classTotalFee = [], classPaid = [], classBalance = [], classAvgPaid = [], classCompletion = [];

    classes.forEach(cls => {
        const data = classData[cls];
        const avgPaid = (data.paid / data.transactions).toFixed(2);
        const completion = ((data.paid / data.totalFee) * 100).toFixed(2) || 0;
        $('#classStatsTable tbody').append(`
            <tr>
                <td>${cls}</td>
                <td>${data.transactions}</td>
                <td>${data.totalFee.toFixed(2)}</td>
                <td>${data.paid.toFixed(2)}</td>
                <td>${data.balance.toFixed(2)}</td>
                <td>${avgPaid}</td>
            </tr>
        `);

        transactionsPerClass.push(data.transactions);
        classTotalFee.push(data.totalFee);
        classPaid.push(data.paid);
        classBalance.push(data.balance);
        classCompletion.push(completion);
    });

    const ctxTransactions = document.getElementById('transactionsPerClass').getContext('2d');
    new Chart(ctxTransactions, {
        type: 'bar',
        data: {
            labels: classes,
            datasets: [{
                label: 'Transactions',
                data: transactionsPerClass,
                backgroundColor: 'rgba(153, 102, 255, 0.8)',
                borderColor: '#fff',
                borderWidth: 1
            }]
        },
        options: {
            scales: { y: { beginAtZero: true, grid: { color: '#e0e0e0' } } },
            responsive: true,
            maintainAspectRatio: false,
            plugins: { legend: { position: 'top' } }
        }
    });

    const ctxFeeBar = document.getElementById('classFeeBar').getContext('2d');
    new Chart(ctxFeeBar, {
        type: 'bar',
        data: {
            labels: classes,
            datasets: [
                {
                    label: 'Paid',
                    data: classPaid,
                    backgroundColor: 'rgba(75, 192, 192, 0.8)',
                    borderColor: '#fff',
                    borderWidth: 1
                },
                {
                    label: 'Balance',
                    data: classBalance,
                    backgroundColor: 'rgba(255, 99, 132, 0.8)',
                    borderColor: '#fff',
                    borderWidth: 1
                }
            ]
        },
        options: {
            scales: {
                y: { beginAtZero: true, stacked: true, grid: { color: '#e0e0e0' } },
                x: { stacked: true }
            },
            responsive: true,
            maintainAspectRatio: false,
            plugins: { legend: { position: 'top' } }
        }
    });

    const ctxBalanceDist = document.getElementById('balanceDistribution').getContext('2d');
    new Chart(ctxBalanceDist, {
        type: 'pie',
        data: {
            labels: Object.keys(balanceRanges),
            datasets: [{
                data: Object.values(balanceRanges),
                backgroundColor: [
                    'rgba(255, 205, 86, 0.8)',
                    'rgba(255, 159, 64, 0.8)',
                    'rgba(255, 99, 132, 0.8)',
                    'rgba(220, 53, 69, 0.8)'
                ],
                borderColor: '#fff',
                borderWidth: 1
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: { legend: { position: 'top' } }
        }
    });

    const ctxCompletion = document.getElementById('paymentCompletion').getContext('2d');
    new Chart(ctxCompletion, {
        type: 'bar',
        data: {
            labels: classes,
            datasets: [{
                label: 'Completion %',
                data: classCompletion,
                backgroundColor: 'rgba(54, 162, 235, 0.8)',
                borderColor: '#fff',
                borderWidth: 1
            }]
        },
        options: {
            scales: {
                y: { beginAtZero: true, max: 100, grid: { color: '#e0e0e0' } }
            },
            responsive: true,
            maintainAspectRatio: false,
            plugins: { legend: { position: 'top' } }
        }
    });

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

        doc.setFontSize(10);
        doc.text(content, 10, 10);
        doc.save('student_fee_details_' + getTodayDate() + '.pdf');
    });

    document.getElementById('download-xlsx').addEventListener('click', function () {
        const table = document.getElementById('paymentTable');
        const worksheet = XLSX.utils.table_to_sheet(table);
        const workbook = XLSX.utils.book_new();
        XLSX.utils.book_append_sheet(workbook, worksheet, 'FeeDetails');
        XLSX.writeFile(workbook, 'student_fee_details_' + getTodayDate() + '.xlsx');
    });
});
</script>
</body>
</html>