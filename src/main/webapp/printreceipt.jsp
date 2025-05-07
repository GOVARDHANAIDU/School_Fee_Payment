
<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Print Student Details</title>
     <link rel="icon" href="https://cdn-icons-png.flaticon.com/512/2132/2132732.png" type="image/x-icon">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"> 
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
   
    <style>
    
        body {
    font-family: Arial, sans-serif;
    margin: 0;
    box-sizing: border-box;
}

.maincontainer {
    width: 59%;
    margin: 0 auto;
    transition: width 0.3s ease;
}

@media print {
    .maincontainer {
        width: 80%; /* Expand during printing */
    }
}

.copy {
    padding: 20px;
    margin: 30px 0;
}

.header {
    text-align: center;
    font-size: 0.85rem;
    margin-bottom: 10px;
}

.header h1 {
    font-size: 1.2rem;
    margin: 5px 0;
}

.header p {
    margin: 3px 0;
    font-size: 0.85rem;
}

h2 {
    text-align: center;
    text-transform: uppercase;
    font-size: 1rem;
    margin: 10px 0;
}

.details {
    margin-top: 10px;
    margin-left: 40px;
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 8px 20px;
    font-size: 0.85rem;
}

.details p {
    margin: 0;
}

.print-button {
    margin-top: 30px;
    text-align: center;
    
}

.print-button button {
    padding: 10px 20px;
    font-size: 16px;
    cursor: pointer;
}

@media print {
    .print-button {
        display: none;
    }
}

    </style>
</head>

<%
    // Get student ID from request parameter
    HttpSession session2 = request.getSession();
    
    String studentNo = (String) session2.getAttribute("admissionNo");
    String AdminName = (String) session2.getAttribute("AdminName");
    System.out.println("Admin Name: "+AdminName);
    String payingFee = (String) session2.getAttribute("payingFee");
    // Initialize variables
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    String name = "", class1 = "",admissionNo="", modeofPay = "";
    long phone = 0;
    double totalFee = 0;
    double paidFee = 0;
    double remainingFee = 0;
    try {
        // Load JDBC driver
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Connect to database
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/school_data", "root", "W7301@jqir#");

        // Prepare SQL query
        ps = con.prepareStatement("SELECT * FROM studentfeedetails WHERE Admission_Number = ?");
        ps.setString(1, studentNo);

        // Execute query
        rs = ps.executeQuery();

        if (rs.next()) {
        	admissionNo=rs.getString("Admission_Number");
            name = rs.getString("Student_Name");
            phone = rs.getLong("Phone_Number");
            class1 = rs.getString("Student_Class");
            totalFee = rs.getDouble("Total_Fee");
            paidFee = rs.getDouble("Paid_Fee");         
            remainingFee = rs.getDouble("Remaining_fee");
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
            <li><a class="dropdown-item" href="allStudents.jsp">All Student Info</a></li>
            <li><a class="dropdown-item" href="BillingPage.jsp">Student Fee Payment</a></li>
            <li><a class="dropdown-item" href="studentreg.jsp">Create Student Details</a></li>
            <li><a class="dropdown-item" href="bulkimporting.jsp">Create Bulk</a></li>
            <li><a class="dropdown-item" href="#">Update Student Details</a></li>
          </ul>
        </li>
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">Payments</a>
          <ul class="dropdown-menu">
            <li><a class="dropdown-item" href="allpayments.jsp">All Payment Details</a></li>
            <li><a class="dropdown-item" href="apbme.jsp">Admin Payment</a></li>
          </ul>
        </li>
        <li class="nav-item"><a class="nav-link" href="#">Contact Us</a></li>
        <li class="nav-item"><a class="nav-link" href="#">About Us</a></li>
      </ul>

       <%
        
       String Aname = (String) session2.getAttribute("adminName");
        String userName = "";
        for(int i= 0 ; i<=Aname.length()-1 ; i++)
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




  <div class="maincontainer">
    <div class="copy">
    <div class="header">
      <h1>&#9925; Bright Future High School</h1>
      <p>123 School Lane, Knowledge City, India | Ph: 86456-56789</p>
      <hr style="margin-top: 15px;">
     
    </div>
        <h2>Student Copy</h2>
        <div class="details">
            <p><strong>Admission.no:</strong> <%= admissionNo %></p>
            <p><strong>Name:</strong> <%= name %></p>           
            <p><strong>Phone:</strong> <%= phone %></p>
            <p><strong>Class:</strong> <%= class1 %></p>
        </div>
        <div class="details">
            <p><strong>Mode of Pay:</strong> <%= modeofPay %></p>
            <p><strong>Total Fee:</strong> <%=totalFee %></p>
            <p><strong>Paid Fee :</strong> <%= paidFee %></p>
            <p><strong>Paid Now:</strong> <%= payingFee %></p>           
            <p><strong>Balance Fee:</strong> <%= remainingFee %></p>          
            <p><strong>Billed By:</strong> <%= AdminName %></p>
        </div>
        
    </div>

    <div class="copy">
    <div class="header">
      <h1>&#9925; Bright Future High School</h1>
      <p>123 School Lane, Knowledge City, India | Ph: 86456-56789</p>
      <hr style="margin-top: 15px;">
    </div>
        <h2>School Copy</h2>
        <div class="details">
            <p><strong>Admission.no:</strong> <%= admissionNo %></p>
            <p><strong>Name:</strong> <%= name %></p>           
            <p><strong>Phone:</strong> <%= phone %></p>
            <p><strong>Class:</strong> <%= class1 %></p>
            <p><strong>Mode of Pay:</strong> <%= modeofPay %></p>
        </div>
        <div class="details">
            
            <p><strong>Total Fee:</strong> <%=totalFee %></p>
            <p><strong>Paid Fee :</strong> <%= paidFee %></p>
            <p><strong>Paid Now:</strong> <%= payingFee %></p>   
               
            <p><strong>Balance Fee:</strong> <%= remainingFee %></p>          
            <p><strong>Billed By:</strong> <%=AdminName %></p>

            
        </div>
        
    </div>
  </div>
    <div class="print-button">
        <button onclick="window.print()">Print</button>
    </div>

</body>
</html>