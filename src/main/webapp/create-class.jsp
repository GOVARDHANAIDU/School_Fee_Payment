<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>School Management Home</title>
  <link rel="icon" href="https://cdn-icons-png.flaticon.com/512/2132/2132732.png" type="image/x-icon">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" /> 
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <style>
    body {
      font-family: 'Segoe UI', sans-serif;
      margin: 0;
      padding-top: 70px; /* space for fixed navbar */
      background-color: #f8f9fa;
    }
    /* Fixed navbar */
    .navbar {
      position: fixed;
      top: 0;
      width: 100%;
      z-index: 1030;
    }
    /* Container for the upload form */
    .upload-container {
      background: #ffffff;
      border-radius: 8px;
      box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
      padding: 30px;
      margin-top: 40px;
      margin-bottom: 40px;
    }
    /* Instructions box */
    .instructions {
      background: #f0f4f9;
      border-left: 4px solid #0d6efd;
      padding: 12px 16px;
      margin-bottom: 24px;
      border-radius: 6px;
      color: #343a40;
      line-height: 1.5;
    }
    /* Hover effect on instruction list items */
    .instructions ol li:hover {
      background-color: #e9ecef;
    }
    /* Label styling */
    label {
      font-weight: 600;
      color: #495057;
    }
    /* Input fields styling */
    input[type="text"], input[type="file"] {
      width: 100%;
      padding: 8px 10px;
      margin-bottom: 16px;
      border: 2px solid #ced4da;
      border-radius: 6px;
      font-size: 1rem;
      transition: border-color 0.3s;
    }
    input[type="text"]:focus, input[type="file"]:focus {
      border-color: #0d6efd;
      outline: none;
    }
    /* Upload button styling */
    .btn-upload {
      width: 100%;
      padding: 12px;
      background-color: #0d6efd;
      color: white;
      border: none;
      border-radius: 6px;
      font-size: 1rem;
      font-weight: 600;
      transition: background-color 0.3s, transform 0.1s;
    }
    .btn-upload:hover {
      background-color: #0b5ed7;
      transform: translateY(-2px);
    }
    .btn-upload:active {
      transform: translateY(0);
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
              <li><a class="dropdown-item" href="apbme.jsp">Payment By Admin</a></li>
              <li><a class="dropdown-item" href="paymentdetails.jsp">All Payment Status</a></li>
            </ul>
          </li>
          <li class="nav-item"><a class="nav-link" href="#">Contact Us</a></li>
          <li class="nav-item"><a class="nav-link" href="#">About Us</a></li>
        </ul>

        
        <div class="d-flex align-items-center me-3">
          <span class="text-white">Hello!</span>
        </div>

        <!-- Right side Logout and Signup buttons -->
        <div class="d-flex">
          <a class="btn btn-outline-light me-2" href="AdminLogin.jsp">Logout</a>
          <a class="btn btn-outline-warning" href="createaccount.jsp">Signup</a>
        </div>
      </div>
    </div>
  </nav>

  <!-- Main content container -->
  <div class="container upload-container">
    <h2 class="text-center text-primary mb-4">Upload Excel to Create New Class</h2>

    <!-- Instructions -->
    <div class="instructions">
      <strong>How to proceed:</strong>
      <ol>
        <li>Enter the <em>Class Name</em> you want to create. 
          <br/><small>(Must start with a letter; letters, digits, or underscores only.)</small>
        </li>
        <li>Click <em>Select Excel File</em> and choose your <code>.xls</code> or <code>.xlsx</code> file.
          <br/><small>(First row should contain the column names exactly as you want them in the new class.)</small>
        </li>
        <li>Click <strong>Upload &amp; Create Class</strong>.
          <br/><small>(The system will read your Excel and build the class structure automatically.)</small>
        </li>
        <li>Upon success, you’ll see a confirmation message, and your new class is ready to use!</li>
      </ol>
    </div>

    <!-- File upload form -->
   <form action="uploadExcel" method="post" enctype="multipart/form-data" id="uploadForm">
      <div class="mb-3">
        <label for="className" class="form-label">Class Name:</label>
        <input
          type="text"
          class="form-control"
          id="className"
          name="className"
          required
          pattern="[A-Za-z][A-Za-z0-9_]*"
          title="Must start with a letter; letters, digits or underscores only."
        />
      </div>

      <div class="mb-4">
        <label for="excelFile" class="form-label">Select Excel File:</label>
        <input
          type="file"
          class="form-control"
          id="excelFile"
          name="excelFile"
          accept=".xls,.xlsx"
          required
        />
      </div>

      <button type="submit" class="btn-upload">Upload &amp; Create Class</button>
    </form>
  </div>

  

</body>
</html>
