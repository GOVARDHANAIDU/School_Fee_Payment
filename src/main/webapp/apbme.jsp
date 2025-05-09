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

    <!-- jsPDF Library -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
    
    <!-- SheetJS (xlsx) Library -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.17.0/xlsx.full.min.js"></script>

    <style>
    
    table.dataTable thead th {
        position: sticky;
        top: 0;
        background-color: #f8f9fa;
    }
    nav {
        position: fixed;
        top: 0;
        width: 100%;
        z-index: 1000; /* Keeps it on top of other elements */
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
        int tempid = (int) session2.getAttribute("adminId");      
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
         
      <!-- Right side Login and Signup buttons -->
      <div class="d-flex">
        <a class="btn btn-outline-light me-2" href="AdminLogin.jsp">Login</a>
        <a class="btn btn-outline-warning" href="createaccount.jsp">Signup</a>
      </div>
    </div>
  </div>
</nav>


<!-- Main Container -->
<div class="container pt-4">
    <center> <h2 class="mb-4">Fee Payment By Admin</h2> </center>

    <!-- Download Buttons -->
    <button id="download-pdf" class="btn btn-primary mb-4">Download as PDF</button>
    <button id="download-xlsx" class="btn btn-success mb-4">Download as Excel</button>

    <!-- Table to Display Payment Details -->
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
                        for (PaymentTransaction p : list) {
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

<!-- DataTable Init -->
<script>
	$('#paymentTable').DataTable({
	    fixedHeader: true,
	    order: [],
	    lengthMenu: [[10, 25, 50, 100, -1], [10, 25, 50, 100, "All"]],
	    columnDefs: [
	        { orderable: true, targets: "_all" }
	    ]
	});

    // Function to get today's date in YYYY-MM-DD format
    function getTodayDate() {
        const today = new Date();
        const year = today.getFullYear();
        const month = String(today.getMonth() + 1).padStart(2, '0');
        const day = String(today.getDate()).padStart(2, '0');
        return `${year}-${month}-${day}`;
    }

    // PDF Download Functionality
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
        const fileName = 'student_fee_details_' + getTodayDate() + '.pdf';
        doc.save(fileName);
    });

    // Excel Download Functionality
    document.getElementById('download-xlsx').addEventListener('click', function () {
        const table = document.getElementById('paymentTable');
        const worksheet = XLSX.utils.table_to_sheet(table);
        const workbook = XLSX.utils.book_new();
        XLSX.utils.book_append_sheet(workbook, worksheet, 'FeeDetails');

        const fileName = 'student_fee_details_' + getTodayDate() + '.xlsx';
        XLSX.writeFile(workbook, fileName);
    });
</script>
</body>
</html>