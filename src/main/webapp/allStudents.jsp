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

    <!-- Bootstrap JS (for dropdowns) -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <!-- jsPDF Library -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
    
    <!-- SheetJS (xlsx) Library -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.17.0/xlsx.full.min.js"></script>

    <style>
        body { font-size: 0.85rem; }
        .navbar { padding: 0.3rem 1rem;
        font-size: 0.9rem;
        heigth: 50px; }
        .navbar-brand { font-size: 1rem; }
        .nav-link { font-size: 0.85rem; padding: 0.3rem 0.5rem !important; }
        .navbar-nav .dropdown-menu { font-size: 0.8rem; }
        .section-header { margin: 20px 0 10px; font-size: 1.2rem; text-align: center; }
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
        .container { margin-top: 20px; padding-top: 0; }
        table.dataTable thead th { position: sticky; top: 0; background-color: #f8f9fa; }
        nav { position: fixed; top: 0; width: 100%; z-index: 1000; }
        .chart-row .col-md-6 { flex: 0 0 48%; max-width: 48%; margin-right: 4%; }
        #column-list { max-height: 200px; overflow-y: auto; font-size: 0.8rem; }
        #column-list .dropdown-item { padding: 0.3rem 0.75rem; }
        /* Updated style for lighter border for all analytics */
        .analytics-section {
            border: 2px solid #e0e0e0; /* Light gray border */
            padding: 10px;
            margin-bottom: 20px;
        }
        .print-btn {
            font-size: 0.7rem;
            padding: 0.2rem 0.4rem;
        }
    </style>
</head>
<body>

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
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">Students</a>
            <ul class="dropdown-menu">
            <li><a class="dropdown-item" href="allStudents.jsp">All Student Info</a></li>
            <li><a class="dropdown-item" href="BillingPage.jsp">Student Fee Payment</a></li>
            <li><a class="dropdown-item" href="studentreg.jsp">Create Student Details</a></li>
            <li><a class="dropdown-item" href="bulkimporting.jsp">Create Bulk</a></li>
            <li><a class="dropdown-item" href="newupdates.jsp">Update Student Details</a></li>
          </ul>
        </li>
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">Payments</a>
          <ul class="dropdown-menu">
            <li><a class="dropdown-item" href="allpayments.jsp">All Payment Details</a></li>
            <li><a class="dropdown-item" href="apbme.jsp">Payment By Admin </a></li>
            <li><a class="dropdown-item" href="paymentdetails.jsp">All Payment Status</a></li>
          </ul>
        </li>
        <li class="nav-item"><a class="nav-link" href="#">Contact Us</a></li>
        <li class="nav-item"><a class="nav-link" href="#">About Us</a></li>
      </ul>

       <%
        HttpSession session2 = request.getSession();
        String name = (String) session2.getAttribute("adminName");
        String userName = "";
        
        if (name == null) {
            // Redirect if not logged in
            response.sendRedirect("AdminLogin.jsp");
            return;
        }
        
        for(int i= 0 ; i<=name.length()-1 ; i++)
        {
        	char ch = name.charAt(i);
        	if(ch == ' ' )
        	{
        		break;
        	}
        	else
        	{
        		userName = userName+ch;
        	}
        }
        %>
        <div style="display: flex; align-items: center; margin-left: 20px; gap: 10px;">
    <p style="color: white; margin-right: 40px; padding-top: 10px;">Hello, <%=userName%></p>
    
</div>
         
      <!-- Right side nav items -->
      <div class="d-flex">
        <a class="btn btn-outline-light me-2" href="AdminLogin.jsp">Logout</a>
        <a class="btn btn-outline-warning" href="createaccount.jsp">Signup</a>
      </div>
    </div>
  </div>
</nav>


<!-- Main Container -->
<div class="container">
    <h2 class="section-header">Student Fee Details</h2>

    <!-- Dashboard Analytics -->
    <h3 class="section-header">Dashboard Analytics</h3>
    <div class="analytics-section">
        <div class="row">
            <div class="col-md-2 col-sm-6 mb-2">
            <br><br><br>
                <div class="card text-center">
                    <div class="card-body">
                        <h5 class="card-title">Total Students</h5>
                        <p class="card-text" id="totalStudents">0</p>
                    </div>
                </div>
            </div>
            <div class="col-md-2 col-sm-6 mb-2">
                    <br><br><br>
                <div class="card text-center">
                    <div class="card-body">
                        <h5 class="card-title">Total Fee</h5>
                        <p class="card-text" id="totalFee">0</p>
                    </div>
                </div>
            </div>
            <div class="col-md-2 col-sm-6 mb-2">
                               <br><br><br>
                <div class="card text-center">
                    <div class="card-body">
                        <h5 class="card-title">Total Paid</h5>
                        <p class="card-text" id="totalPaid">0</p>
                    </div>
                </div>
            </div>
            <div class="col-md-2 col-sm-6 mb-2">
                    <br><br><br>
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
                        <h5 class="card-title">Paid/Balance</h5>
                        <canvas id="paidBalancePie" height="150"></canvas>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Class-wise Statistics -->
    <h4 class="section-header">Class-wise Fee Statistics</h4>
    <div class="analytics-section">
        <div class="table-responsive">
            <table class="table table-bordered table-hover" id="classStatsTable">
                <thead class="table-light">
                    <tr>
                        <th>Class</th>
                        <th>Students</th>
                        <th>Total Fee</th>
                        <th>Paid Fee</th>
                        <th>Balance</th>
                        <th>Avg Paid</th>
                    </tr>
                </thead>
                <tbody>
                    <!-- Populated dynamically -->
                </tbody>
            </table>
        </div>
    </div>

    <!-- Additional Analytics in 2x2 matrix -->
    <h4 class="section-header">Additional Analytics</h4>
    <div class="analytics-section">
        <div class="row">
            <div class="col-md-6 col-sm-12 mb-2">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Class-wise Students</h5>
                        <canvas id="studentsPerClass" height="150"></canvas>
                    </div>
                </div>
            </div>
            <div class="col-md-6 col-sm-12 mb-2">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Class-wise Fee Breakdown</h5>
                        <canvas id="classFeeBar" height="150"></canvas>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-6 col-sm-12 mb-2">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Balance Distribution</h5>
                        <canvas id="balanceDistribution" height="150"></canvas>
                    </div>
                </div>
            </div>
            <div class="col-md-6 col-sm-12 mb-2">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Payment Completion %</h5>
                        <canvas id="paymentCompletion" height="150"></canvas>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Download Buttons and Column Toggle -->
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
                    <th>S.no</th>
                    <th>Admission No</th>
                    <th>Student Name</th>
                    <th>Phone Number</th>
                    <th>Total Fee</th>
                    <th>Paid Fee</th>
                    <th>Balance</th>
                    <th>Class</th>
                    <th>Print</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    StudentDetailsImp studentDetailsImp = new StudentDetailsImp();
                    List<StudentDetails> list = studentDetailsImp.allStudentDetails();
                    int count = 1;
                    for (StudentDetails p : list) {
                %>           
                <tr>
                    <td><%= count %></td>
                    <td><%= p.getAdmissionNumber() %></td>
                    <td><%= p.getStudentName() %></td>
                    <td><%= p.getPhoneNumber() %></td>
                    <td><%= p.getTotalFee() %></td>
                    <td><%= p.getPaidFee()%></td>
                    <td><%= p.getRemainingFee() %></td>
                    <td><%= p.getStudentClass() %></td>
                    <td><button class="btn btn-sm btn-info print-btn" data-admission="<%= p.getAdmissionNumber() %>" data-name="<%= p.getStudentName() %>" data-phone="<%= p.getPhoneNumber() %>" data-total="<%= p.getTotalFee() %>" data-paid="<%= p.getPaidFee() %>" data-balance="<%= p.getRemainingFee() %>" data-class="<%= p.getStudentClass() %>">Print</button></td>
                </tr>
                <% count++; } %>
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
            columnDefs: [{ orderable: true, targets: "_all" }]
        });

        // Column hiding feature
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

        // Dashboard calculations
        const allData = table.rows().data().toArray();
        const totalStudents = allData.length;
        $('#totalStudents').text(totalStudents);

        let totalFee = 0, totalPaid = 0, totalBalance = 0;
        let classData = {};
        let balanceRanges = { '0-5000': 0, '5001-10000': 0, '10001-20000': 0, '20001+': 0 };

        allData.forEach(row => {
            const tFee = parseFloat(row[4]) || 0;
            const pFee = parseFloat(row[5]) || 0;
            const bal = parseFloat(row[6]) || 0;
            const cls = row[7] || 'Unknown';

            totalFee += tFee;
            totalPaid += pFee;
            totalBalance += bal;

            if (!classData[cls]) {
                classData[cls] = { students: 0, totalFee: 0, paid: 0, balance: 0 };
            }
            classData[cls].students++;
            classData[cls].totalFee += tFee;
            classData[cls].paid += pFee;
            classData[cls].balance += bal;

            if (bal <= 5000) balanceRanges['0-5000']++;
            else if (bal <= 10000) balanceRanges['5001-10000']++;
            else if (bal <= 20000) balanceRanges['10001-20000']++;
            else balanceRanges['20001+']++;
        });

        $('#totalFee').text(totalFee.toFixed(2));
        $('#totalPaid').text(totalPaid.toFixed(2));
        $('#totalBalance').text(totalBalance.toFixed(2));

        // Paid/Balance Pie Chart
        const ctxPie = document.getElementById('paidBalancePie').getContext('2d');
        new Chart(ctxPie, {
            type: 'pie',
            data: {
                labels: ['Paid', 'Balance'],
                datasets: [{
                    data: [totalPaid, totalBalance],
                    backgroundColor: ['rgba(75, 192, 192, 0.8)', 'rgba(255, 99, 132, 0.8)']
                }]
            },
            options: { responsive: true, maintainAspectRatio: false }
        });

        // Class-wise Stats Table and Charts
        const classes = Object.keys(classData);
        let studentsPerClass = [];
        let classTotalFee = [], classPaid = [], classBalance = [], classAvgPaid = [], classCompletion = [];

        classes.forEach(cls => {
            const data = classData[cls];
            const avgPaid = (data.paid / data.students).toFixed(2);
            const completion = ((data.paid / data.totalFee) * 100).toFixed(2) || 0;
            $('#classStatsTable tbody').append(`
                <tr>
                    <td>${cls}</td>
                    <td>${data.students}</td>
                    <td>${data.totalFee.toFixed(2)}</td>
                    <td>${data.paid.toFixed(2)}</td>
                    <td>${data.balance.toFixed(2)}</td>
                    <td>${avgPaid}</td>
                </tr>
            `);

            studentsPerClass.push(data.students);
            classTotalFee.push(data.totalFee);
            classPaid.push(data.paid);
            classBalance.push(data.balance);
            classCompletion.push(completion);
        });

        // Students per Class Bar Chart
        const ctxStudents = document.getElementById('studentsPerClass').getContext('2d');
        new Chart(ctxStudents, {
            type: 'bar',
            data: {
                labels: classes,
                datasets: [{ label: 'Students', data: studentsPerClass, backgroundColor: 'rgba(153, 102, 255, 0.8)' }]
            },
            options: { scales: { y: { beginAtZero: true } }, responsive: true, maintainAspectRatio: false }
        });

        // Class-wise Fee Breakdown Stacked Bar
        const ctxFeeBar = document.getElementById('classFeeBar').getContext('2d');
        new Chart(ctxFeeBar, {
            type: 'bar',
            data: {
                labels: classes,
                datasets: [
                    { label: 'Paid', data: classPaid, backgroundColor: 'rgba(75, 192, 192, 0.8)' },
                    { label: 'Balance', data: classBalance, backgroundColor: 'rgba(255, 99, 132, 0.8)' }
                ]
            },
            options: { scales: { y: { beginAtZero: true, stacked: true }, x: { stacked: true } }, responsive: true, maintainAspectRatio: false }
        });

        // Balance Distribution Pie
        const ctxBalanceDist = document.getElementById('balanceDistribution').getContext('2d');
        new Chart(ctxBalanceDist, {
            type: 'pie',
            data: {
                labels: Object.keys(balanceRanges),
                datasets: [{ data: Object.values(balanceRanges), backgroundColor: ['rgba(255, 205, 86, 0.8)', 'rgba(255, 159, 64, 0.8)', 'rgba(255, 99, 132, 0.8)', 'rgba(220, 53, 69, 0.8)'] }]
            },
            options: { responsive: true, maintainAspectRatio: false }
        });

        // Payment Completion % per Class Bar
        const ctxCompletion = document.getElementById('paymentCompletion').getContext('2d');
        new Chart(ctxCompletion, {
            type: 'bar',
            data: {
                labels: classes,
                datasets: [{ label: 'Completion %', data: classCompletion, backgroundColor: 'rgba(54, 162, 235, 0.8)' }]
            },
            options: { scales: { y: { beginAtZero: true, max: 100 } }, responsive: true, maintainAspectRatio: false }
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
                for (let j = 0; j < row.cells.length - 1; j++) { // Exclude print button
                    content += row.cells[j].innerText + '\t';
                }
                content += '\n';
            }

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

        // Print Receipt Popup
        $('.print-btn').on('click', function() {
            const admission = $(this).data('admission');
            const name = $(this).data('name');
            const phone = $(this).data('phone');
            const total = $(this).data('total');
            const paid = $(this).data('paid');
            const balance = $(this).data('balance');
            const cls = $(this).data('class');
            const adminName = '<%= name %>'; // From JSP session
            const paymentMode = 'Cash'; // Default for print from list
            const dateOfPayment = new Date().toLocaleString('en-IN', { 
                day: '2-digit', 
                month: '2-digit', 
                year: 'numeric', 
                hour: '2-digit', 
                minute: '2-digit', 
                second: '2-digit' 
            });

            // Create popup window
            const printWindow = window.open('', '_blank', 'width=800,height=600,scrollbars=yes');
            printWindow.document.write(`
                <!DOCTYPE html>
                <html>
                <head>
                    <title>Fee Receipt - ${name}</title>
                    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
                    <style>
                        body { font-family: 'Segoe UI', sans-serif; margin: 0; padding: 10px; background: white; font-size: 0.9rem; }
                        .maincontainer { width: 100%; max-width: 210mm; margin: auto; padding: 10px; background: white; }
                        .copy { margin-bottom: 15px; padding: 10px; border: 1px dashed #ccc; page-break-inside: avoid; }
                        .header { text-align: center; margin-bottom: 5px; }
                        .header h1 { font-size: 1.2rem; margin-bottom: 2px; color: #2a4365; }
                        .header p { font-size: 0.8rem; margin-bottom: 0; color: #666; }
                        h2 { text-align: center; font-size: 0.85rem; text-transform: uppercase; margin: 10px 0; color: #007bff; }
                        .details { margin-top: 5px; margin-left: 30px; display: grid; grid-template-columns: repeat(2, 1fr); gap: 5px 15px; font-size: 0.8rem; padding: 5px 10px; }
                        .details p { margin: 0; line-height: 1.3; }
                        .footer-note { text-align: center; font-size: 0.75rem; margin-top: 10px; }
                        .footer-sign, .footer-sign2 { text-align: right; font-size: 0.75rem; margin-top: 5px; }
                        .button-group { display: flex; justify-content: space-between; align-items: center; margin-top: 10px; gap: 10px; }
                        .button-group button { flex: 1; padding: 6px 12px; font-size: 0.85rem; border-radius: 4px; cursor: pointer; }
                        .print-btn-popup { background: #2a4365; color: white; border: none; }
                        .close-btn { background: #6c757d; color: white; border: none; }
                        @media print { 
                            body { background: none; padding: 0; } 
                            .maincontainer { box-shadow: none; padding: 5px; width: 100%; margin: 0; }
                            .copy { border: 1px solid #000; margin-bottom: 10px; page-break-inside: avoid; }
                            .copy:first-of-type { page-break-after: avoid; }
                            .copy:last-of-type { page-break-before: avoid; }
                            .button-group { display: none; }
                            body::before { content: ""; position: fixed; top: 20%; left: 10%; width: 80%; height: 80%; background: url('https://cdn-icons-png.flaticon.com/512/2132/2132732.png') no-repeat center center; background-size: contain; opacity: 0.05; z-index: -1; transform: rotate(-45deg); }
                        }
                    </style>
                </head>
                <body>
                    <div class="maincontainer">
                        <!-- Student Copy -->
                        <div class="copy">
                            <div class="header">
                                <h1>SAS School</h1>
                                <p>123 Learning Lane, Education City, Country | Ph: +1 123 456 7890</p>
                                <hr>
                            </div>
                            <h2>Student Copy</h2>
                            <div class="details">
                                <p><strong>Admission No:</strong> ${admission}</p>
                                <p><strong>Class:</strong> ${cls}</p>
                                <p><strong>Name:</strong> ${name}</p>
                                <p><strong>Phone:</strong> ${phone}</p>
                            </div>
                            <div class="details">
                                <p><strong>Mode of Pay:</strong> ${paymentMode}</p>
                                <p><strong>Total Fee:</strong> ₹${total}</p>
                                <p><strong>Paid Fee:</strong> ₹${paid}</p>
                                <p><strong>Paid Now:</strong> ₹0.00</p>
                                <p><strong>Balance Fee:</strong> ₹${balance}</p>
                                <p><strong>Billed By:</strong> ${adminName}</p>
                            </div>
                            <div class="footer-note">
                                <p>Generated On: ${dateOfPayment}<br>Thank you for your payment</p>
                            </div>
                            <div class="footer-sign">  
                                <p>Signature of Admin.<br>${adminName}</p>
                            </div>
                        </div>

                        <!-- School Copy -->
                        <div class="copy">
                            <div class="header">
                                <h1>SAS School</h1>
                                <p>123 Learning Lane, Education City, Country | Ph: +1 123 456 7890</p>
                                <hr>
                            </div>
                            <h2>School Copy</h2>
                            <div class="details">
                                <p><strong>Admission No:</strong> ${admission}</p>
                                <p><strong>Class:</strong> ${cls}</p>
                                <p><strong>Name:</strong> ${name}</p>
                                <p><strong>Phone:</strong> ${phone}</p>
                            </div>
                            <div class="details">
                                <p><strong>Mode of Pay:</strong> ${paymentMode}</p>
                                <p><strong>Total Fee:</strong> ₹${total}</p>
                                <p><strong>Paid Fee:</strong> ₹${paid}</p>
                                <p><strong>Paid Now:</strong> ₹0.00</p>
                                <p><strong>Balance Fee:</strong> ₹${balance}</p>
                                <p><strong>Billed By:</strong> ${adminName}</p>
                            </div>
                            <div class="footer-note">
                                <p>Generated On: ${dateOfPayment}<br>Thank you for your payment</p>
                            </div>
                            <div class="footer-sign2">  
                                <p>Signature of Admin.<br>${adminName}</p>
                            </div>
                        </div>
                    </div>
                    <div class="button-group">
                        <button onclick="window.print()" class="print-btn-popup">Print Receipt</button>
                        <button onclick="window.close()" class="close-btn">Close</button>
                    </div>
                </body>
                </html>
            `);
            printWindow.document.close();
        });
    });
</script>
</body>
</html>