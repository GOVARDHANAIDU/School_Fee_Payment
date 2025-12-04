<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Admin Registration</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600&display=swap" rel="stylesheet" />
  <link rel="icon" href="https://cdn-icons-png.flaticon.com/512/2132/2132732.png" type="image/x-icon">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"> 
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <style>
	body {
	  font-family: 'Segoe UI', sans-serif;
	  margin: 0;
	  padding-top: 70px;
	  padding-bottom: 0;
	}
    /* Fixed navbar */
    .navbar {
      position: fixed;
      top: 0;
      width: 100%;
      z-index: 1030;
      height:50px;
    }

    .form-container {
      max-width: 900px;
      margin: 2rem auto;
      padding: 2rem;
      background: white;
      border-radius: 1rem;
      box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
      animation: fadeIn 1s ease-in-out;
    }

    .form-title {
      text-align: center;
      font-size: 2rem;
      font-weight: 600;
      color: #1f2937;
      margin-bottom: 1.5rem;
    }

    .error-message {
      font-size: 0.875rem;
      color: #dc2626;
      margin-top: 0.25rem;
    }

    .floating-input {
      position: relative;
      margin-bottom: 1.5rem;
    }

    .floating-input input,
    .floating-input textarea {
      width: 100%;
      padding: 1rem 1rem 0.5rem;
      font-size: 1rem;
      border: 1px solid #d1d5db;
      border-radius: 0.5rem;
      outline: none;
      background: transparent;
      transition: all 0.3s ease;
    }

    .floating-input label {
      position: absolute;
      top: 1rem;
      left: 1rem;
      font-size: 1rem;
      color: #6b7280;
      background: white;
      padding: 0 0.25rem;
      pointer-events: none;
      transition: 0.3s ease;
    }

    .floating-input input:focus + label,
    .floating-input input:not(:placeholder-shown) + label,
    .floating-input textarea:focus + label,
    .floating-input textarea:not(:placeholder-shown) + label {
      top: -0.6rem;
      left: 0.8rem;
      font-size: 0.8rem;
      color: #2563eb;
    }

    .register{
      border: 1px solid black;
      width: 20%;
      background: #3b82f6;
      color: black;
      padding: 0.75rem 1.5rem;
      font-weight: 600;
      border-radius: 0.5rem; 
      height: 25px; 
      text-align: center;  
      padding-bottom: 30px;  
    }

    

    @media (min-width: 768px) {
      .form-grid {
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 1.5rem;
      }
    }

    @keyframes slideDown {
      from { transform: translate(-50%, -100%); opacity: 0; }
      to { transform: translate(-50%, 0); opacity: 1; }
    }

    @keyframes slideUp {
      from { transform: translate(-50%, 0); opacity: 1; }
      to { transform: translate(-50%, -100%); opacity: 0; }
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

<%
    if(request.getParameter("name") != null) {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String aadhar = request.getParameter("aadhar");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String dob = request.getParameter("dob");
        String address = request.getParameter("address");
        String pincode = request.getParameter("pincode");

        if (!password.equals(confirmPassword)) {
            out.println("<script>alert('Passwords do not match. Please try again.');</script>");
        } else {
            Connection con = null;
            PreparedStatement ps = null;
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/school_data", "root", "W7301@jqir#");

                String sql = "INSERT INTO admin_registration(name, email, phone_number, aadhar_number, password, confirm_password, dob, address, pincode) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
                ps = con.prepareStatement(sql);
                ps.setString(1, name);
                ps.setString(2, email);
                ps.setString(3, phone);
                ps.setString(4, aadhar);
                ps.setString(5, password);
                ps.setString(6, confirmPassword);
                ps.setString(7, dob);
                ps.setString(8, address);
                ps.setString(9, pincode);

                int i = ps.executeUpdate();
                if (i > 0) {
                    out.println("<script>" +
                        "function showPopup(message, isSuccess) {" +
                        "    const popup = document.createElement('div');" +
                        "    popup.style.position = 'fixed';" +
                        "    popup.style.top = '20px';" +
                        "    popup.style.left = '50%';" +
                        "    popup.style.transform = 'translateX(-50%)';" +
                        "    popup.style.padding = '15px 30px';" +
                        "    popup.style.borderRadius = '5px';" +
                        "    popup.style.color = 'white';" +
                        "    popup.style.fontWeight = 'bold';" +
                        "    popup.style.zIndex = '1000';" +
                        "    popup.style.boxShadow = '0 4px 6px rgba(0, 0, 0, 0.1)';" +
                        "    popup.style.animation = 'slideDown 0.5s ease-out';" +
                        "    popup.style.backgroundColor = isSuccess ? '#4CAF50' : '#f44336';" +
                        "    popup.textContent = message;" +
                        "    document.body.appendChild(popup);" +
                        "    setTimeout(() => {" +
                        "        popup.style.animation = 'slideUp 0.5s ease-out';" +
                        "        setTimeout(() => {" +
                        "            document.body.removeChild(popup);" +
                        "            if(isSuccess) window.location.href='AdminLogin.jsp';" +
                        "        }, 500);" +
                        "    }, 2000);" +
                        "}" +
                        "showPopup('Admin Registered Successfully!', true);" +
                        "</script>");
                } else {
                    out.println("<script>alert('Registration Failed!')</script>");
                }
            } catch(Exception e) {
                if (e.getMessage().contains("Duplicate entry")) {
                    out.println("<script>alert('Error: Email or Aadhar number already exists!')</script>");
                } else {
                    out.println("<script>alert('Database error: " + e.getMessage().replace("'", "\\'") + "')</script>");
                }
            } finally {
                try { if(ps != null) ps.close(); } catch(Exception e) {}
                try { if(con != null) con.close(); } catch(Exception e) {}
            }
        }
    }
%>



<div class="form-container">
  <h1 class="form-title">Admin Registration</h1>

  <form method="post" id="adminForm" onsubmit="return validateAdminForm(event)">
    <div class="form-grid">
      <div class="floating-input">
        <input type="text" id="name" name="name" required placeholder=" " />
        <label for="name">Name <span class="text-red-500">*</span></label>
      </div>

      <div class="floating-input">
        <input type="email" id="email" name="email" required placeholder=" " />
        <label for="email">Email <span class="text-red-500">*</span></label>
        <p id="email-error" class="error-message hidden"></p>
      </div>

      <div class="floating-input">
        <input type="text" id="phone" name="phone" required placeholder=" " />
        <label for="phone">Phone Number <span class="text-red-500">*</span></label>
      </div>

      <div class="floating-input">
        <input type="text" id="aadhar" name="aadhar" required placeholder=" " />
        <label for="aadhar">Aadhar Number <span class="text-red-500">*</span></label>
        <p id="aadhar-error" class="error-message hidden"></p>
      </div>

      <div class="floating-input">
        <input type="password" id="password" name="password" required placeholder=" " />
        <label for="password">Password <span class="text-red-500">*</span></label>
        <p id="password-error" class="error-message hidden"></p>
      </div>

      <div class="floating-input">
        <input type="password" id="confirmPassword" name="confirmPassword" required placeholder=" " />
        <label for="confirmPassword">Confirm Password <span class="text-red-500">*</span></label>
        <p id="confirm-password-error" class="error-message hidden"></p>
      </div>

      <div class="floating-input">
        <input type="date" id="dob" name="dob" required placeholder=" " />
        <label for="dob">Date of Birth <span class="text-red-500">*</span></label>
      </div>

      <div class="floating-input">
        <input type="text" id="pincode" name="pincode" required placeholder=" " />
        <label for="pincode">Pincode <span class="text-red-500">*</span></label>
        <p id="pincode-error" class="error-message hidden"></p>
      </div>
    </div>

    <div class="floating-input">
      <textarea id="address" name="address" required placeholder=" " rows="3"></textarea>
      <label for="address">Address <span class="text-red-500">*</span></label>
    </div>

    <div class="text-center">
      <button type="submit" class="register">Register</button>
    </div>
  </form>
</div>

<script>
  function showPopup(message, isSuccess) {
    const popup = document.createElement('div');
    popup.style.position = 'fixed';
    popup.style.top = '20px';
    popup.style.left = '50%';
    popup.style.transform = 'translateX(-50%)';
    popup.style.padding = '15px 30px';
    popup.style.borderRadius = '5px';
    popup.style.color = 'white';
    popup.style.fontWeight = 'bold';
    popup.style.zIndex = '1000';
    popup.style.boxShadow = '0 4px 6px rgba(0, 0, 0, 0.1)';
    popup.style.animation = 'slideDown 0.5s ease-out';
    
    if (isSuccess) {
      popup.style.backgroundColor = '#4CAF50';
    } else {
      popup.style.backgroundColor = '#f44336';
    }
    
    popup.textContent = message;
    document.body.appendChild(popup);
    
    setTimeout(() => {
      popup.style.animation = 'slideUp 0.5s ease-out';
      setTimeout(() => {
        document.body.removeChild(popup);
      }, 500);
    }, 3000);
  }

  function validateAdminForm(event) {
    event.preventDefault();
    let valid = true;

    const email = document.getElementById("email");
    const emailError = document.getElementById("email-error");
    const aadhar = document.getElementById("aadhar");
    const aadharError = document.getElementById("aadhar-error");
    const password = document.getElementById("password");
    const confirmPassword = document.getElementById("confirmPassword");
    const passwordError = document.getElementById("password-error");
    const confirmPasswordError = document.getElementById("confirm-password-error");
    const pincode = document.getElementById("pincode");
    const pincodeError = document.getElementById("pincode-error");

    emailError.textContent = aadharError.textContent = passwordError.textContent =
    confirmPasswordError.textContent = pincodeError.textContent = "";

    emailError.classList.add("hidden");
    aadharError.classList.add("hidden");
    passwordError.classList.add("hidden");
    confirmPasswordError.classList.add("hidden");
    pincodeError.classList.add("hidden");

    if (!email.value.match(/^[^ ]+@[^ ]+\.[a-z]{2,3}$/)) {
      emailError.textContent = "❌ Invalid email format.";
      emailError.classList.remove("hidden");
      valid = false;
    }

    if (!aadhar.value.match(/^\d{12}$/)) {
      aadharError.textContent = "❌ Aadhar number must be 12 digits.";
      aadharError.classList.remove("hidden");
      valid = false;
    }

    if (password.value.length < 6) {
      passwordError.textContent = "❌ Password must be at least 6 characters.";
      passwordError.classList.remove("hidden");
      valid = false;
    }

    if (confirmPassword.value !== password.value) {
      confirmPasswordError.textContent = "❌ Passwords do not match.";
      confirmPasswordError.classList.remove("hidden");
      valid = false;
    }

    if (!pincode.value.match(/^\d{6}$/)) {
      pincodeError.textContent = "❌ Pincode must be 6 digits.";
      pincodeError.classList.remove("hidden");
      valid = false;
    }

    if (valid) {
      event.target.submit();
    }
  }
</script>
 <script src="js/roleControl.js"></script>
 
</body>
</html> 