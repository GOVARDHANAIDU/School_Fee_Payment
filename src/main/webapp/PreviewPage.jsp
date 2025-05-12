<!DOCTYPE html>

<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Student Fee Receipt</title>
  
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="icon" href="https://cdn-icons-png.flaticon.com/512/2132/2132732.png" type="image/x-icon">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
  <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
 
  <style>
    
    body {
      font-family: 'Arial', sans-serif;
      background-color: #f9f9f9;
      
    }
     @media print {
    body {
      margin: 0;
      padding: 0;
      background: white;
    }

    .print-btn {
      display: none !important; /* Hide print button */
    }

    @page {
      margin: 0; /* Remove default page margins */
    }
  }
    .receipt {
      max-width: 700px;
      margin: auto;
      background: #fff;
      padding: 30px 40px;
      border: 1px solid #ccc;
      border-radius: 10px;
      box-shadow: 0 0 10px rgba(0,0,0,0.1);
    }

    .header {
      text-align: center;
      margin-bottom: 30px;
    }

    .header h1 {
      margin: 0;
      font-size: 26px;
      color: #2a4365;
    }

    .header p {
      margin: 0;
      font-size: 14px;
      color: #444;
    }

    .info-section {
      margin-bottom: 20px;
    }

    .info-section table {
      width: 100%;
      border-collapse: collapse;
    }

    .info-section td {
      padding: 8px;
      font-size: 16px;
    }

    .label {
      font-weight: bold;
      color: #333;
      width: 40%;
      border: none;
    }

    .amount-section {
      background: #f1f5f9;
      padding: 15px 20px;
      border-radius: 8px;
      margin-top: 20px;
    }

    .amount-section table {
      width: 100%;
    }

    .amount-section td {
      padding: 10px;
      font-size: 16px;
    }

    .total {
      font-weight: bold;
      font-size: 18px;
      color: #2a4365;
    }

    .footer {
      text-align: center;
      margin-top: 30px;
      font-size: 14px;
      color: #666;
    }

    .print-btn {
      display: block;
      position: bottom;
      margin: 20px auto;
      padding: 10px 30px;
      background: #2a4365;
      color: white;
      border: none;
      border-radius: 6px;
      font-size: 16px;
      cursor: pointer;
      margin-top: -5%;
      margin-left: 80%;
    }
     .btn-back {
      position: bottom;
      bottom: 30px;
      left: 20px;
      background-color:#2a4365 ;
      color: white;
      padding: 8px 20px;
      font-size: 14px;
      border: none;
      border-radius: 6px;
      cursor: pointer;
      transition: background-color 0.5s ease;
      width: 150px;
    }

    .btn-back:hover {
      background: white;
      color: black;
      transition: background-color 0.3s ease;
    }
    input{
    border: 0px;
    background-color: transparent;
    outline: 0px;
    }
    .print-btn:hover {
      background-color: #4c6795;
    }
    .spinner {
      border: 5px solid #f3f3f3;
      border-top: 5px solid teal;
      border-radius: 50%;
      width: 60px;
      height: 60px;
      animation: spin 1s linear infinite;
      margin-top:-35%;
      margin-left:42%;
      float: left;
    }

    @keyframes spin {
      0% { transform: rotate(0deg); }
      100% { transform: rotate(360deg); }
    }

    #loading {
      display: none;
      text-align: center;
    }
  </style>
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
       HttpSession session2 = request.getSession();
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
        <a class="btn btn-outline-light me-2" href="#">Login</a>
        <a class="btn btn-outline-warning" href="#">Signup</a>
      </div>
    </div>
  </div>
</nav>


  <div class="receipt">
    <div class="header">
      <h1>&#9925; Bright Future High School</h1>
      <p>123 School Lane, Knowledge City, India | Ph: 86456-56789</p>
      <hr style="margin-top: 15px;">
      <h3>Student Fee Receipt</h3>
    </div>

  <form action="addPayment" method="POST"> 
    <div class="info-section">
      <table>
      
       <tr>
          <td class="label">Admission Number:</td>
           <%  
           String studentName = (String)session2.getAttribute("studentName");
           String email = (String)session2.getAttribute("email");
           String phone = (String)session2.getAttribute("phone");
           String  class1 = (String)session2.getAttribute("class1");
           double payingfee = (double)session2.getAttribute("payingfee");
           String admissionNumber = (String)session2.getAttribute("admissionNumber");
           double totalfee = (double)session2.getAttribute("totalamount");
           double paidfee = (double) session2.getAttribute("paidfee");
           String paymentMode = (String) session2.getAttribute("paymentMode");
           %>
           
          <td><input value="<%=admissionNumber%>" name="AdmissionNumber" readOnly></td>
        
        </tr>
        <tr>
          <td class="label">Student Name:</td>
          <td><input value="<%=studentName%>" name="studentName" readOnly></td>
        </tr>
        
        <tr>
          <td class="label">Email ID:</td>
          <td><input value="<%= email %>" name="emailId" readOnly></td>
        </tr>
        <tr>
          <td class="label">Phone Number:</td>
          <td><input value="<%= phone %>" name="phoneNumber" readOnly></td>
        </tr>
      </table>
    </div>

    <div class="amount-section">
      <table>
        <tr>
          <td class="label">Mode of Payment:</td>
          <td> <input value="<%= paymentMode %>" name="modeOfPayment" readOnly></td>
            <%
          session2.setAttribute("paymentMode", paymentMode);
          %>
        </tr>
        <tr>
          <td class="label">Total Fee:</td>
          <td>&#8377; <input value="<%=totalfee%>" name="totalFee" readOnly></td>
          <%
          session2.setAttribute("totalfee", totalfee);
          %>
        </tr>
        <tr>
          <td class="label">Fee Already Paid:</td>
          <td>&#8377; <input value="<%= paidfee %>"name="paidFee" readOnly></td>
            <%
           session2.setAttribute("paidFee", paidfee);
          %>
        </tr>
        <tr>
          <td class="label">Fee Paid Now:</td>
          <td>&#8377; <input value="<%= payingfee %>"name="payingFee" readOnly></td>
           <%
          session2.setAttribute("payingfee", payingfee);
          %>
        </tr>
        <tr>
          <td class="label total">Remaining Balance:</td>
          <td class="total">
            &#8377;
            <%
              try {
                double total = totalfee;
                double paid = paidfee;
                double now = payingfee;
                double balance = paid + now;
                double remainingBalance = total - balance;
                session2.setAttribute("remainingBalance", remainingBalance);
                out.print(remainingBalance);
              } catch (Exception e) {
                out.print("N/A");
              }
            %>
            
          </td>
        </tr>
        <tr>
          <td class="label">Class&Section:</td>
          <td><input value="<%= class1 %>" name="class" readOnly></td>
        </tr>
      </table>
    </div>

    <div class="footer">
      <p>Generated on: <%= new java.util.Date() %></p>
     
    </div>
     <button class="btn-back" onclick="history.back()">← Back</button>
    <button type="button" class="print-btn" data-bs-toggle="modal" data-bs-target="#confirmationModal" >
	  Proceed
	</button>   
      </form>
  </div>
 
 <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
 <!-- Bootstrap Modal (add this just before the closing </body> tag) -->
<div class="modal fade" id="confirmationModal" tabindex="-1" aria-labelledby="confirmationModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered"> <!-- Centers the modal -->
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="confirmationModalLabel">Confirm Submission</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        Are you sure you want to proceed with the fee payment?
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
        <button type="button" class="btn btn-primary" onclick="submitForm()">I Confirm</button>
      </div>
    </div>
  </div>
</div>
        
<!-- Script to submit the form -->
<script>
  function submitForm() {
	 
     document.querySelector("form").submit();
     
  }
</script>

 
</body>
</html>
