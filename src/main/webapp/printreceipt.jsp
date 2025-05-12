<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Print Student Details</title>
    <link rel="icon" href="https://cdn-icons-png.flaticon.com/512/2132/2132732.png" type="image/x-icon">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">

    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            background-color: #f8f9fa;
        }

        .maincontainer {
            width: 210mm;
            margin: auto;
            padding: 20px;
            background: white;
            box-shadow: 0 0 10px rgba(0,0,0,0.2);
        }

        .copy {
            margin-bottom: 40px;
            padding: 20px;
            border: 1px dashed #ccc;
        }

        .header {
            text-align: center;
            margin-bottom: 10px;
        }

        .header h1 {
            font-size: 1.5rem;
            margin-bottom: 5px;
        }

        .header p {
            font-size: 0.9rem;
            margin-bottom: 0;
        }

        h2 {
            text-align: center;
            font-size: 1rem;
            text-transform: uppercase;
            margin: 20px 0;
            color: #007bff;
        }

        .details {
            margin-top: 10px;
            margin-left: 60px;
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 10px 30px;
            font-size: 0.9rem;
            padding: 10px 20px;
        }

        .details p {
            margin: 0;
        }

        .footer-note {
            text-align: right;
            font-size: 0.9rem;
            margin-top: 30px;
        }

        .print-button {
            text-align: center;
            margin: 30px 0;
        }

        .print-button button {
            padding: 10px 25px;
            font-size: 16px;
            border-radius: 5px;
        }

        @media print {
            body {
                background: none;
            }

            .print-button {
                display: none;
            }

            .maincontainer {
                box-shadow: none;
                padding: 0;
            }

            body::before {
                content: "";
                position: fixed;
                top: 35%;
                left: 25%;
                width: 50%;
                height: 50%;
                background: url('https://example.com/school-logo.png') no-repeat center center;
                background-size: contain;
                opacity: 0.06;
                z-index: -1;
            }
        }
        
        
        .footer-note{
        text-align: center;
        
        }
        .footer-sign{
        text-align:right;
        right:40%;
        bottom: 45%;
        padding: 0px;
        }
        .footer-sign2{
        text-align:right;
        right:40%;
        bottom: 60%;
        padding: 0px;
        
        }
    </style>
</head>

<%
    HttpSession session2 = request.getSession();
    String studentNo = (String) session2.getAttribute("admissionNumber");
    String AdminName = (String) session2.getAttribute("AdminName");

    String name = "", class1 = "", admissionNo = "", modeofPay = "";
    long phone = 0;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/school_data", "root", "W7301@jqir#");

        PreparedStatement ps = con.prepareStatement("SELECT * FROM studentfeedetails WHERE Admission_Number = ?");
        ps.setString(1, studentNo);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            admissionNo = rs.getString("Admission_Number");
            name = rs.getString("Student_Name");
            phone = rs.getLong("Phone_Number");
            class1 = rs.getString("Student_Class");
            modeofPay = rs.getString("mode_of_payment");
        } else {
            out.println("<p>No student found with ID: " + studentNo + "</p>");
            return;
        }

    } catch (Exception e) {
        e.printStackTrace();
    }
%>
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
            <li><a class="dropdown-item" href="studentdetails.jsp">Student Details</a></li>
            <li><a class="dropdown-item" href="allStudents.jsp">Student Payment Info</a></li>
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
       
        String Aname = (String) session2.getAttribute("adminName");
        String userName = "";

         if (Aname == null) {
             // Redirect if not logged in
             response.sendRedirect("AdminLogin.jsp");
             return;
         }
        
        for(int i= 0 ; i<=Aname.length()-1 ; i++)
        {
        	char ch = Aname.charAt(i);
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








<div class="maincontainer">

    <!-- Student Copy -->
    <div class="copy">
        <div class="header">
            <h1>🌤️ Bright Future High School</h1>
            <p>123 School Lane, Knowledge City, India | Ph: 86456-56789</p>
            <hr>
        </div>
        <h2>Student Copy</h2>
        <div class="details">
            <p><strong>Admission No:</strong> <%= admissionNo %></p>
            <p><strong>Class:</strong> <%= class1 %></p>
            <p><strong>Name:</strong> <%= name %></p>
            <p><strong>Phone:</strong> <%= phone %></p>
        </div>
        <div class="details">
            <p><strong>Mode of Pay:</strong> <%= session2.getAttribute("paymentMode") %></p>
            <p><strong>Total Fee:</strong> <%= session2.getAttribute("totalamount") %></p>
            <p><strong>Paid Fee:</strong> <%= session2.getAttribute("paidfee") %></p>
            <p><strong>Paid Now:</strong> <%= session2.getAttribute("payingfee") %></p>
            <p><strong>Balance Fee:</strong> <%= session2.getAttribute("remainingBalance") %></p>
            <p><strong>Billed By:</strong> <%= session2.getAttribute("adminName") %></p>
        </div>
        <div class="footer-note">
            <p>Generated On: <%= new java.text.SimpleDateFormat("dd-MM-yyyy HH:mm:ss").format(new java.util.Date()) %><br>
            Thank you for your payment</p>
        </div>
        <div class="footer-sign">  
            <p>Signature of Admin.<br><%=session2.getAttribute("adminName")%></p>
        </div>
    </div>

    <!-- School Copy -->
    <div class="copy">
        <div class="header">
            <h1>🌤️ Bright Future High School</h1>
            <p>123 School Lane, Knowledge City, India | Ph: 86456-56789</p>
            <hr>
        </div>
        <h2>School Copy</h2>
        <div class="details">
            <p><strong>Admission No:</strong> <%= admissionNo %></p>
            <p><strong>Class:</strong> <%= class1 %></p>
            <p><strong>Name:</strong> <%= name %></p>
            <p><strong>Phone:</strong> <%= phone %></p>
            
        </div>
        <div class="details">
            <p><strong>Mode of Pay:</strong> <%= session2.getAttribute("paymentMode") %></p>
            <p><strong>Total Fee:</strong> <%= session2.getAttribute("totalamount") %></p>
            <p><strong>Paid Fee:</strong> <%= session2.getAttribute("paidfee") %></p>
            <p><strong>Paid Now:</strong> <%= session2.getAttribute("payingfee") %></p>
            <p><strong>Balance Fee:</strong> <%= session2.getAttribute("remainingBalance") %></p>
            <p><strong>Billed By:</strong> <%= session2.getAttribute("adminName") %></p>
        </div>
        <div class="footer-note">
            <p>Generated On: <%= new java.text.SimpleDateFormat("dd-MM-yyyy HH:mm:ss").format(new java.util.Date()) %><br>
            Thank you for your payment</p>
        </div>
        <div class="footer-sign2">  
            <p>Signature of Admin.<br><%=session2.getAttribute("adminName")%></p>
        </div>
    </div>

    <!-- Print Button -->
    <div class="print-button">
      <button class="btn btn-primary" onclick="printAndNotify()">
		    <i class="bi bi-printer-fill me-2"></i> Print Receipt
		</button>
    </div>
    
       
    
</div>


<div class="position-fixed bottom-0 end-0 p-3" style="z-index: 11">
  <div id="printToast" class="toast align-items-center text-white bg-success border-0" role="alert" aria-live="assertive" aria-atomic="true">
    <div class="d-flex">
      <div class="toast-body">
        ✅ Receipt printed successfully!
      </div>
      <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
    </div>
  </div>
</div>


<script>
    function printAndNotify() {
        window.onafterprint = function () {
            const toastElement = document.getElementById('printToast');
            const toast = new bootstrap.Toast(toastElement);
            toast.show();
        };
        window.print();
    }
    
    // Block F5 and Ctrl+R
    document.addEventListener("keydown", function (e) {
        if ((e.key === "F5") || (e.ctrlKey && e.key.toLowerCase() === "r")) {
            e.preventDefault();
            alert("Page refresh is disabled.");
        }
    });

    // Prevent right-click menu (optional, for extra restriction)
    document.addEventListener("contextmenu", function (e) {
        e.preventDefault();
    });

    // Warn user when trying to close/reload
    window.addEventListener("beforeunload", function (e) {
        e.preventDefault();
        e.returnValue = "Are you sure you want to leave or refresh this page?";
    });

    // Prevent page reload on back/forward navigation
    if (window.history && window.history.pushState) {
        window.history.pushState(null, "", window.location.href);
        window.onpopstate = function () {
            window.history.pushState(null, "", window.location.href);
            alert("Back/forward navigation is disabled on this page.");
        };
    }

    
    
</script>

</body>
</html>
