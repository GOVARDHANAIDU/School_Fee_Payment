<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*, org.apache.poi.ss.usermodel.*, org.apache.poi.xssf.usermodel.*" %>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<title>Bulk Student Upload – SAS School</title>

<!-- Bootstrap -->

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<!-- Icons -->
  <link rel="icon" href="https://cdn-icons-png.flaticon.com/512/2132/2132732.png" type="image/x-icon">

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>

<style>
body {
    background: #f3f6fb;
}

/* Upload Card */
.upload-card {
    width: 80%;                  /* updated */
    max-width: 950px;            /* new */
    margin: 10px auto;
    padding: 15px;
    background: white;
    border-radius: 16px;
    box-shadow: 0 10px 28px rgba(0,0,0,0.08);
    animation: fadeIn 0.8s ease-in-out;
}

@keyframes fadeIn {
    from { opacity: 0; transform: translateY(15px); }
    to { opacity: 1; transform: translateY(0); }
}

/* Drag Drop Box */
.drop-box {
    border: 2px dashed #007bff;
    padding: 35px;
    border-radius: 14px;
    text-align: center;
    background: #f8fbff;
    transition: 0.3s;
    width: 100%;         /* FULL responsive */
    display: block; 
    cursor: pointer;
    margin-bottom: 15px; /* Prevent overlap */
}

.drop-box:hover {
    background: #e9f3ff;
    border-color: #0056d2;
}

/* Instructions */
.instructions {
    background: #f8f9ff;
    padding: 18px;
    border-left: 4px solid #007bff;
    border-radius: 10px;
}

/* Toast Container */
.toast-container {
    position: fixed;
    top: 25px;
    right: 25px;
    z-index: 3000;
}

/* Smaller toast */
.toast-small {
    font-size: 0.88rem;   /* not big, not small */
    padding: 8px 12px;
}
</style>
<link href="./student-profile.css" rel="stylesheet">
</head>

<body>

<!-- Toast Notification -->
<div class="toast-container">
    <div id="toastBox" class="toast toast-small" data-bs-delay="3800">
        <div class="toast-body" id="toastMessage"></div>
    </div>
</div>

<!-- NAVBAR -->
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
        <li class="nav-item"><a class="nav-link active" href="home.jsp">&#127969; Home</a></li>
 
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

<!-- Title -->
<div class="container text-center mt-4">
<br><br>
    <h2 class="fw-bold text-primary">Bulk Student Upload</h2>
</div>

<!-- Upload Card -->
<div class="upload-card">

    <!-- Instructions -->
    <div class="instructions mb-4">
        <h5><i class="fas fa-info-circle text-primary"></i> Instructions</h5>
        <ul class="mt-2 small">
            <li>Only <b>.xlsx Excel files</b> are supported.</li>
            <li><b>DOB must be</b> in <span class="text-primary fw-bold">YYYY-MM-DD</span> format.</li>
            <li>Email must end with <b>@gmail.com</b> or <b>@email.com</b>.</li>
            <li>Phone number must contain <b>10 digits</b>.</li>
            <li>Class must be a number between <b>1–12</b>.</li>
            <li>If an error occurs, an error sheet will be downloaded automatically.</li>
        </ul>
    </div>

    <!-- Upload Form -->
    <form id="uploadForm" action="upload" method="post" target="uFrame" enctype="multipart/form-data">
	<div class="mb-3">
    <label class="drop-box" for="fileInput">
        <i class="fas fa-cloud-upload-alt fa-3x text-primary mb-3"></i>
        <h5 class="text-primary fw-bold">Click or Drag Excel File</h5>
        <p class="text-muted small">Upload your student_data.xlsx here</p>
    </label>

	    <input type="file" id="fileInput" name="file" accept=".xlsx" required hidden>
	</div>
	
	
        <button class="btn btn-primary w-100 mt-3">
            <i class="fas fa-upload"></i> Upload File
        </button>

        <!-- Spinner -->
        <div id="loadingSpinner" class="text-center mt-3" style="display:none;">
            <div class="spinner-border text-primary"></div>
            <p class="text-primary small mt-2">Processing, please wait...</p>
        </div>

    </form>

    <!-- Download Template -->
    <form method="post" class="mt-3">
        <button name="downloadSample" class="btn btn-success w-100">
            <i class="fas fa-file-arrow-down"></i> Download Sample Excel
        </button>
    </form>

</div>

<!-- Hidden frame -->
<iframe name="uFrame" id="uFrame" style="display:none;"></iframe>

<script>
// Show small toast
function showToast(msg, isError) {
    const toastEl = document.getElementById("toastBox");
    const msgEl = document.getElementById("toastMessage");

    toastEl.classList.remove("text-bg-danger", "text-bg-success");
    toastEl.classList.add(isError ? "text-bg-danger" : "text-bg-success");

    msgEl.innerText = msg;
    new bootstrap.Toast(toastEl).show();
}

// File attached toast
document.getElementById("fileInput").addEventListener("change", function() {
    if (this.files.length > 0) {
        showToast("File Attached: " + this.files[0].name, false);
    }
});

// Show spinner on submit
document.getElementById("uploadForm").onsubmit = function () {
    document.getElementById("loadingSpinner").style.display = "block";
    
};

// Handle response from iframe
document.getElementById("uFrame").onload = function () {
    document.getElementById("loadingSpinner").style.display = "none";

    let msg = this.contentWindow.document.body.innerText.trim();

    if (msg === "SUCCESS") {
        showToast("Upload Successful!", false);
        document.getElementById("loadingSpinner").style.display = "none";
    } 
    else if (msg.includes("ErrorReport")) {
        showToast("Upload Failed! Check downloaded error sheet.", true);
        document.getElementById("loadingSpinner").style.display = "none";
    }

};
</script>

<!-- SAMPLE FILE GENERATOR -->
<%
if (request.getParameter("downloadSample") != null) {

    response.reset();
    response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
    response.setHeader("Content-Disposition", "attachment; filename=student_template.xlsx");

    XSSFWorkbook wb = new XSSFWorkbook();
    Sheet sheet = wb.createSheet("Students");

    String[] headers = {
        "admin_no","student_name","father_name","email","father_number",
        "mother_name","mother_number","guardian_name","guardian_number",
        "address","class","aadhar_number","total_fee","gender",
        "age","dob","pincode","paid_fee","photo"
    };

    String[] required = {
        "Required","Required","Required","Required","Required",
        "Required","Optional","Optional","Optional",
        "Required","Required","Optional","Required","Required",
        "Required","Required","Required","Required","Optional"
    };

    String[] example = {
        "ADM001","John Doe","Robert","john@gmail.com","9876543210",
        "Alice","9876512340","Sam","9876501234",
        "123 Street","10","456789012345","35000","Male",
        "15","2010-01-05","500001","15000","photo.jpg"
    };

    Row h = sheet.createRow(0);
    Row r = sheet.createRow(1);
    Row e = sheet.createRow(2);

    for (int i = 0; i < headers.length; i++) {
        h.createCell(i).setCellValue(headers[i]);
        r.createCell(i).setCellValue(required[i]);
        e.createCell(i).setCellValue(example[i]);
        sheet.autoSizeColumn(i);
    }

    OutputStream out1 = response.getOutputStream();
    wb.write(out1);
    wb.close();
    out1.close();
    return;
}
%>
<footer class="footer bg-dark text-white py-4">
  <div class="container">
    <div class="row text-center text-md-start">
      <div class="col-md-4 mb-3">
        <h6><strong>Contact</strong></h6>
        <p>Email: contact@sasschool.edu<br>Phone: +1 123 456 7890</p>
      </div>
      <div class="col-md-4 mb-3">
        <h6><strong>About</strong></h6>
        <a href="#" class="d-block text-warning">Our Story</a>
        <a href="#" class="d-block text-warning">Privacy Policy</a>
      </div>
      <div class="col-md-4 mb-3">
        <h6><strong>Address</strong></h6>
        <p>123 Learning Lane<br>Education City, Country</p>
      </div>
    </div>
  </div>
</footer>
</body>
</html>
