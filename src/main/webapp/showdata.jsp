<%@ page language="java" import="java.sql.*, javax.servlet.http.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Class Records</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="icon" href="https://cdn-icons-png.flaticon.com/512/2132/2132732.png" type="image/x-icon">

    <!-- DataTables CSS -->
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/jquery.dataTables.min.css">
    <link rel="stylesheet" href="https://cdn.datatables.net/fixedheader/3.4.0/css/fixedHeader.dataTables.min.css">

    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.5.1.js"></script>

    <!-- DataTables JS -->
    <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/fixedheader/3.4.0/js/dataTables.fixedHeader.min.js"></script>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

    <!-- jsPDF Library -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>

    <!-- SheetJS (xlsx) Library -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.17.0/xlsx.full.min.js"></script>

    <style>
        nav {
            position: fixed;
            top: 0;
            width: 100%;
            z-index: 1000;
        }

        table.dataTable thead th {
            position: sticky;
            top: 0;
            background-color: #f8f9fa;
        }

        
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
            <li><a class="dropdown-item" href="studentdetails.jsp">Student Details</a></li>
            <li><a class="dropdown-item" href="allStudents.jsp">Student Payment Info</a></li>
            <li><a class="dropdown-item" href="BillingPage.jsp">Student Fee Payment</a></li>
            <li><a class="dropdown-item" href="studentreg.jsp">Create Student Details</a></li>
            <li><a class="dropdown-item" href="create-class.jsp">Create Class</a></li>
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
        
        if (name == null) {
            // Redirect if not logged in
            response.sendRedirect("AdminLogin.jsp");
            return;
        }
        
        String userName = "";
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
        <a class="btn btn-outline-light me-2" href="AdminLogin.jsp">Logout</a>
        <a class="btn btn-outline-warning" href="createaccount.jsp">Signup</a>
      </div>
    </div>
  </div>
</nav>

<!-- Main Container -->
<div class="container pt-4">
    <center><h2 class="mb-4">Class: <%= tableName %></h2></center>

    <!-- Download Buttons -->
    <button id="download-pdf" class="btn btn-primary mb-3">Download as PDF</button>
    <button id="download-xlsx" class="btn btn-success mb-3">Download as Excel</button>

    <div class="table-responsive">
        <table id="classTable" class="display table table-bordered table-hover">
            <thead class="table-light">
                <tr>
                    <%
                        for (int i = 1; i <= columnCount; i++) {
                            out.println("<th>" + rsmd.getColumnName(i) + "</th>");
                        }
                    %>
                </tr>
            </thead>
            <tbody>
                <%
                    while (rs.next()) {
                        out.println("<tr>");
                        for (int i = 1; i <= columnCount; i++) {
                            out.println("<td>" + rs.getString(i) + "</td>");
                        }
                        out.println("</tr>");
                    }
                    if (rs != null) rs.close();
                    if (stmt != null) stmt.close();
                    if (con != null) con.close();
                %>
            </tbody>
        </table>
    </div>
</div>

<!-- DataTable Init + Export Scripts -->
<script>
    $(document).ready(function () {
        $('#classTable').DataTable({
            fixedHeader: true,
            order: [],
            lengthMenu: [[10, 25, 50, -1], [10, 25, 50, "All"]],
            columnDefs: [{ orderable: true, targets: "_all" }]
        });
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
</script>
</body>
</html>
