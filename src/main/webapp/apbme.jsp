<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@page import="com.DTO.PaymentTransaction"%>
<%@page import="com.DAO.TransactionPageImp"%>
<%@page import="com.DAO.AllPaymentsByAdmin"%>
<%@page import="com.DTO.StudentDetails"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment History</title>
    <link rel="stylesheet" href="HomePage.css">
    <link rel="icon" href="https://i.pinimg.com/736x/2a/31/61/2a3161135f001e58c563ef3103221dcd.jpg" type="image/x-icon">
     <link rel="icon" href="https://cdn-icons-png.flaticon.com/512/2132/2132732.png" type="image/x-icon">
     <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<style>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/css/bootstrap.min.css" rel="stylesheet" 
integrity="sha384-SgOJa3DmI69IUzQ2PVdRZhwQ+dy64/BUtbMJw1MZ8t5HZApcHrRKUc4W0kG879m7" crossorigin="anonymous">

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/js/bootstrap.bundle.min.js" 
integrity="sha384-k6d4wzSIapyDyv1kpU366/PK5hCdSbCRGRCMv+eplOQJWyd1fbcAu9OCUj5zNLiq" crossorigin="anonymous"></script>

     .wrapper {
	    min-height: 85%;
	    display: flex;
	    flex-direction: column;
		}
  	   .footer-buttons {
	    position: fixed;
	    bottom: 0;
	    left: 0;
	    width: 100%;
	    background-color: #f8f8f8;
	    padding: 15px 50px;
	    display: flex;
	    justify-content: space-between;
	    box-shadow: 0 -2px 5px rgba(0,0,0,0.1);
	    z-index: 1000;
		}

     #medium{
       width:150px;
       margin-top: 5px;
       text-align: center;
       border:0px;
       color: black ;
       margin-bottom: 5px;
       background: transparent;
       outline: 0px;
     }
     #small{
       width:80px;
       margin-top: 5px;
       margin-bottom: 5px;
       text-align: center;
       border: 0px;
       background-color: none;
       color:black;
       background: transparent;
       outline: 0px;
     }
     th {
         text-align: center;
        }
     #tableContents{
     margin-bottom: -25px;
     }
     .home-btn {
            position: absolute;
            bottom: 20px;
            right: 20px;
            padding: 10px 20px;
            font-size: 18px;
            background: #8e44ad;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
            transition: 0.3s;
        }
        .check-btn {
        position:absolute;
            bottom: 20px;
            left: 20px;
            padding: 10px 20px;
            font-size: 18px;
            background: #8e44ad;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
            transition: 0.3s;
        }
        .home-btn :hover {
            background: #357ae8;
        }
        .check-btn:hover {
            background: #357ae8;
        }
       
    </style>
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
            <li><a class="dropdown-item" href="#">Create Student Details</a></li>
            <li><a class="dropdown-item" href="#">Update Student Details</a></li>
          </ul>
        </li>
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">Payments</a>
          <ul class="dropdown-menu">
            <li><a class="dropdown-item" href="">All Payment Details</a></li>
            <li><a class="dropdown-item" href="apbme.jsp">Admin Payment</a></li>
          </ul>
        </li>
        <li class="nav-item"><a class="nav-link" href="#">Contact Us</a></li>
        <li class="nav-item"><a class="nav-link" href="#">About Us</a></li>
      </ul>

      <!-- Right side Login and Signup buttons -->
      <div class="d-flex">
        <a class="btn btn-outline-light me-2" href="AdminLogin.jsp">Login</a>
        <a class="btn btn-outline-warning" href="#">Signup</a>
      </div>
    </div>
  </div>
</nav>
    
     <div class="wrapper">
    <center>
	<div style="max-height: 600px; overflow-y: auto; width: 80%; margin-bottom: 20px; ">
	<table class="table-info table table-bordered" id="tablewidth">	
	            <tr >
                <th >S.no</td>
                <th >Student Name</th>
                <th >Total Fee</th>
                <th >Paid Fee</th>
                <th >Balance</th>
                <th >Class</th>
                <th >Date</th>
                <th >time</th>
                <th >Mode</th>
                <th >Billed By</th>
            </tr>
            <br><br>
            <%
            
              
            AllPaymentsByAdmin allPaymentsByAdmin = new TransactionPageImp();
            List<PaymentTransaction> list = allPaymentsByAdmin.selectAllPayments();
                // Iterate over the product list
                int count = 1;
                for (PaymentTransaction p : list) {
                	
                %>           
                    <tr>
                        
                        <th ><input value="<%= count%>" id="small" name="prod_name" readonly="readonly"></th>
                        <th ><input value="<%= p.getStudentNAme() %>" id="medium" name="prod_name" readonly="readonly"></th>
                        <th ><input value="<%= p.getTotal_fee() %>" id="small" name="prod_name" readonly="readonly"></th>
                        <td ><input value="<%= p.getPaidFee() %>"  id="small"  name="prod_price" readonly="readonly"></td>
                        <td ><input value="<%= p.getRemaingFee() %>"  id="small" name="prod_brand"readonly="readonly"></td>
                        <td ><input value="<%= p.getStudentClass() %>"  name="prod_discount" id="small"readonly="readonly"></td>
                        <td ><input value="<%= p.getDateOfTransaction() %>"  name="prod_discount" id="medium"readonly="readonly"></td>
                        <td ><input value="<%= p.getTimeOfTransaction() %>"  name="prod_discount" id="small"readonly="readonly"></td>
                        <td ><input value="<%= p.getModeOfPayment() %>"  name="prod_discount" id="small"readonly="readonly"></td>
                        <td ><input value="<%= p.getAdminName() %>"  name="prod_discount" id="medium"readonly="readonly"></td>
                        
                        
                    </tr>
         
     <% 
        count++;        
     }
     %>
        </table>
        </div>
	      </center>  
	       <div class="footer-buttons">
		      <a href="home.jsp" class="home-btn">🏠 Home</a>
		   </div>
	      
	     </div>
	    
	    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
