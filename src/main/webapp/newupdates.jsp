<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Feature Under Progress</title>
  <link rel="stylesheet" href="HomePage.css">
 
  <link rel="icon" href="https://cdn-icons-png.flaticon.com/512/2132/2132732.png" type="image/x-icon">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"> 
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  </head>
  <style>
    .message-box {
     margin-top: 30px;
     margin-left:400px;
      width: 800px;
      text-align: center;
      background: #ffffff;
      padding: 30px 40px;
      border-radius: 15px;
      box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
      animation: comboEffect 2s ease-in-out;
    }

    .message-box h2 {
      margin-bottom: 20px;
      color: #333;
    }

    .btn-home {
            position: absolute;
            bottom: 300px;
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
            width:150px;
        }
        .btn-home:hover {
            background: white;
            color: black;
        }

    .btn-back {
      position: absolute;
      bottom: 300px;
      left: 20px;
      background-color: #8e44ad;
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
    @keyframes comboEffect {
      0% {
        opacity: 0;
        background-color: white;
        color: #999;
        transform: scale(0.9);
      }
      50% {
        background-color: white;
        color: #007BFF;
      }
      100% {
        opacity: 1;
        background-color: white;
        color: #333;
        transform: scale(1);
      }
    }
  </style>

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
          <a class="nav-link dropdown-toggle" href="home.jsp" role="button" data-bs-toggle="dropdown">Students</a>
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
            <li><a class="dropdown-item" href="apbme.jsp">Admin Payment</a></li>
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
        <a class="btn btn-outline-light me-2" href="AdminLogin.jsp">Login</a>
        <a class="btn btn-outline-warning" href="createaccount.jsp">Signup</a>
      </div>
    </div>
  </div>
</nav>
  <div class="message-box">
   <span style='font-size:100px;'>&#128679;</span>
    <h2>This feature is under progress.<br>It will be available shortly.</h2>
   
  </div>
  <button class="btn-home" onclick="location.href='home.jsp'">🏡 Home</button>
  <button class="btn-back" onclick="history.back()">← Back</button>

</body>
</html>
