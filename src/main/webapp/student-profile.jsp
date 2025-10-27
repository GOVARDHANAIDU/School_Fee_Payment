<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Student Profile Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="icon" href="https://cdn-icons-png.flaticon.com/512/2132/2132732.png" type="image/x-icon">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"> 
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <!-- Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            margin: 0;
            padding-top: 70px;
            background: linear-gradient(135deg, #dff6ff, #b6e3f9);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }
        /* Navbar - Matching home.jsp style */
        .navbar {
            position: fixed;
            top: 0;
            width: 100%;
            z-index: 1030;
            font-size: 0.9rem;
            height: 50px;
        }
        .navbar-brand {
            font-size: 0.9rem;
            font-weight: 600;
        }
        .navbar-nav .nav-link {
            padding: 4px 8px;
        }
        .dropdown-menu {
            font-size: 0.8rem;
        }
        .dropdown-item {
            padding: 6px 12px;
        }
        /* Search Section - Like BillingPage, no background */
        .search-container {
            background: transparent;
            padding: 30px 40px;
            text-align: center;
        }
        .search-input {
            max-width: 600px;
            margin: 0 auto 20px auto;
            display: block;
        }
        .fetch-btn {
            max-width: 600px;
            margin: 0 auto;
            display: block;
        }
        /* Profile Card */
        .profile-card {
            background: white;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.15);
            overflow: hidden;
        }
        .left-section {
            background: #f8f9fa;
            color: #212529;
            padding: 40px 20px;
            text-align: center;
        }
        .avatar-container {
            position: relative;
            display: inline-block;
            margin-bottom: 20px;
        }
        .avatar {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            border: 3px solid #dee2e6;
            object-fit: cover;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }
        .plus-icon {
            position: absolute;
            bottom: 0;
            right: 0;
            background: #007bff;
            color: white;
            border-radius: 50%;
            width: 30px;
            height: 30px;
            text-align: center;
            line-height: 30px;
            cursor: pointer;
            font-size: 18px;
        }
        .full-photo {
            width: 90%;
            height: 200px;
            object-fit: cover;
            border-radius: 8px;
            margin-bottom: 15px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        .right-section {
            padding: 30px;
        }
        .profile-label {
            font-weight: 600;
            color: #6c757d;
            font-size: 0.9rem;
        }
        .profile-value {
            color: #212529;
            font-weight: 500;
        }
        .form-control {
            border: 1px solid #cbd5e0;
            border-radius: 6px;
            font-size: 14px;
        }
        .form-control[readonly] {
            background-color: #f1f5f9;
        }
        .nav-tabs .nav-link {
            color: #2a4365;
            border: none;
            border-bottom: 2px solid transparent;
        }
        .nav-tabs .nav-link.active {
            color: #2b6cb0;
            border-bottom: 2px solid #2b6cb0;
            background: transparent;
        }
        .tab-pane {
            padding-top: 20px;
        }
        .btn-group {
            gap: 10px;
        }
        .btn {
            border-radius: 25px;
            padding: 8px 20px;
            font-weight: 500;
            transition: transform 0.2s ease;
        }
        .btn:hover {
            transform: scale(1.02);
        }
        .balance-positive {
            color: #28a745;
            font-weight: bold;
        }
        .balance-negative {
            color: #dc3545;
            font-weight: bold;
        }
        .main-content {
            flex: 1;
        }
        .footer {
            background: #2c3e50;
            color: white;
            padding: 20px 0;
            margin-top: auto;
        }
        .footer a {
            color: #ffc107;
            text-decoration: none;
        }
        #profileContainer {
            display: none;
        }
    </style>
</head>
<body>

<!-- Navbar - Matching home.jsp with right side buttons -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark px-4">
  <div class="container-fluid">
    <a class="navbar-brand" href="home.jsp">SAS School</a>
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
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">Payments</a>
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
        <li class="nav-item"><a class="nav-link" href="fee-notifications.jsp">Send Notifications</a></li>
        <li class="nav-item"><a class="nav-link" href="#">Contact Us</a></li>
      </ul>

      <!-- Right Side - Matching home.jsp -->
      <%
        // Session validation
        HttpSession sessio = request.getSession(false);
        if (sessio == null || 
            (sessio.getAttribute("adminName") == null && 
            sessio.getAttribute("studentId") == null && 
            sessio.getAttribute("facultyId") == null)) {
            response.sendRedirect("AdminLogin.jsp");
            return;
        }

        // Prevent caching
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setDateHeader("Expires", 0);

        // Get user name
        String displayName = (String) session.getAttribute("adminName");
        if (displayName == null) {
            displayName = "User";
        }
        String userName = "";
        for(int i = 0; i < displayName.length(); i++) {
            char ch = displayName.charAt(i);
            if(ch == ' ') break;
            else userName += ch;
        }
      %>
      <div class="d-flex align-items-center ms-3">
        <p class="text-white mb-0 me-3">Hello, <%=userName%></p>

        <!-- Roles Dropdown -->
        <div class="dropdown me-3">
          <a class="btn btn-sm btn-outline-light dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">
            Roles
          </a>
          <ul class="dropdown-menu dropdown-menu-end">
            <li><a class="dropdown-item" href="home.jsp">Channel Admin</a></li>
            <li><a class="dropdown-item" href="#">Student</a></li>
            <li><a class="dropdown-item" href="./faculty/faculty.jsp">Faculty</a></li>
          </ul>
        </div>

        <!-- Auth Buttons -->
        <a class="btn btn-outline-light btn-sm me-2" href="AdminLogin.jsp">Logout</a>
        <a class="btn btn-outline-warning btn-sm" href="createaccount.jsp">Signup</a>
      </div>
    </div>
  </div>
</nav>

<div class="main-content">
    <!-- Manage Profile Search Section - Like BillingPage -->
    <div class="search-container">
        <h2 style="text-align: center; color: #2b6cb0; margin-bottom: 30px;">Manage Profile</h2>
        <input list="studentsList" id="searchInput" class="form-control search-input" placeholder="Search by Admission No - Name">
        <datalist id="studentsList">
            
        </datalist>
        <select id="searchInput" name="searchInput" style="width: 100%">
        <option></option>
      </select>
        <button class="btn btn-primary fetch-btn" onclick="fetchStudent()">Fetch</button>
    </div>

    <!-- Profile Card - Hidden initially -->
    <div id="profileContainer" class="container my-5">
        <div class="card profile-card shadow">
            <div class="row g-0">
                <!-- Left: Full Photo and Avatar -->
                <div class="col-md-4 bg-light text-center py-4 left-section">
                    <h4>Student Profile</h4>
                    <img id="photo" src="" class="img-fluid mb-3 mx-auto d-block full-photo" style="display: none;">
                    <div class="avatar-container">
                        <img id="avatarPreview" src="https://via.placeholder.com/120?text=Avatar" class="avatar">
                        <div class="plus-icon" data-bs-toggle="modal" data-bs-target="#avatarModal">+</div>
                    </div>
                </div>

                <!-- Right: Student Info with Tabs -->
                <div class="col-md-8 p-4 right-section">
                    <h3 class="mb-4" id="studentNameHeader" style="color: #2b6cb0;"></h3>
                    <form id="studentForm">
                        <ul class="nav nav-tabs">
                            <li class="nav-item"><a class="nav-link active" data-bs-toggle="tab" href="#personal">Personal</a></li>
                            <li class="nav-item"><a class="nav-link" data-bs-toggle="tab" href="#parents">Parents/Guardian</a></li>
                            <li class="nav-item"><a class="nav-link" data-bs-toggle="tab" href="#payment">Payment</a></li>
                        </ul>
                        <div class="tab-content mt-3">
                            <div id="personal" class="tab-pane fade show active">
                                <div class="row mb-2"><div class="col-sm-5 profile-label">Admission No:</div><div class="col-sm-7"><input type="text" class="form-control" id="adminNo" readonly></div></div>
                                <div class="row mb-2"><div class="col-sm-5 profile-label">Name:</div><div class="col-sm-7"><input type="text" class="form-control" id="studentName" readonly></div></div>
                                <div class="row mb-2"><div class="col-sm-5 profile-label">Email:</div><div class="col-sm-7"><input type="text" class="form-control" id="email" readonly></div></div>
                                <div class="row mb-2"><div class="col-sm-5 profile-label">Class:</div><div class="col-sm-7"><input type="text" class="form-control" id="class" readonly></div></div>
                                <div class="row mb-2"><div class="col-sm-5 profile-label">Gender:</div><div class="col-sm-7"><input type="text" class="form-control" id="gender" readonly></div></div>
                                <div class="row mb-2"><div class="col-sm-5 profile-label">Date of Birth:</div><div class="col-sm-7"><input type="text" class="form-control" id="dob" readonly></div></div>
                                <div class="row mb-2"><div class="col-sm-5 profile-label">Age:</div><div class="col-sm-7"><input type="text" class="form-control" id="age" readonly></div></div>
                                <div class="row mb-2"><div class="col-sm-5 profile-label">Aadhaar Number:</div><div class="col-sm-7"><input type="text" class="form-control" id="aadharNumber" readonly></div></div>
                                <div class="row mb-2"><div class="col-sm-5 profile-label">Address:</div><div class="col-sm-7"><input type="text" class="form-control" id="address" readonly></div></div>
                                <div class="row mb-2"><div class="col-sm-5 profile-label">Pincode:</div><div class="col-sm-7"><input type="text" class="form-control" id="pincode" readonly></div></div>
                            </div>
                            <div id="parents" class="tab-pane fade">
                                <div class="row mb-2"><div class="col-sm-5 profile-label">Father's Name:</div><div class="col-sm-7"><input type="text" class="form-control" id="fatherName" readonly></div></div>
                                <div class="row mb-2"><div class="col-sm-5 profile-label">Father's Number:</div><div class="col-sm-7"><input type="text" class="form-control" id="fatherNumber" readonly></div></div>
                                <div class="row mb-2"><div class="col-sm-5 profile-label">Mother's Name:</div><div class="col-sm-7"><input type="text" class="form-control" id="motherName" readonly></div></div>
                                <div class="row mb-2"><div class="col-sm-5 profile-label">Mother's Number:</div><div class="col-sm-7"><input type="text" class="form-control" id="motherNumber" readonly></div></div>
                                <div class="row mb-2"><div class="col-sm-5 profile-label">Guardian's Name:</div><div class="col-sm-7"><input type="text" class="form-control" id="guardianName" readonly></div></div>
                                <div class="row mb-2"><div class="col-sm-5 profile-label">Guardian's Number:</div><div class="col-sm-7"><input type="text" class="form-control" id="guardianNumber" readonly></div></div>
                            </div>
                            <div id="payment" class="tab-pane fade">
                                <div class="row mb-2"><div class="col-sm-5 profile-label">Total Fee:</div><div class="col-sm-7"><input type="text" class="form-control" id="totalFee" readonly></div></div>
                                <div class="row mb-2"><div class="col-sm-5 profile-label">Paid Fee:</div><div class="col-sm-7"><input type="text" class="form-control" id="paidFee" readonly></div></div>
                                <div class="row mb-2"><div class="col-sm-5 profile-label">Balance:</div><div class="col-sm-7 profile-value"><span id="balance"></span></div></div>
                            </div>
                        </div>
                        <input type="hidden" id="studentId">
                        <div class="mt-4 text-center btn-group">
                            <button type="button" class="btn btn-secondary" id="editBtn">Edit</button>
                            <button type="submit" class="btn btn-primary" id="updateBtn" style="display:none">Update</button>
                            <button type="button" class="btn btn-danger" id="resetBtn" style="display:none">Reset</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Modal: Upload or Camera for Avatar -->
<div class="modal fade" id="avatarModal" tabindex="-1" aria-labelledby="avatarModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">Choose Photo Source</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>
      <div class="modal-body text-center">
        <button class="btn btn-primary me-2" onclick="document.getElementById('fileInput').click()">📁 Upload</button>
        <button class="btn btn-secondary" onclick="startCamera()">📷 Camera</button>
        <input type="file" id="fileInput" accept="image/*" style="display:none" onchange="previewAvatar(event)">
        <div id="cameraContainer" class="mt-3" style="display:none">
            <video id="video" width="100%" autoplay></video>
            <button class="btn btn-sm btn-success mt-2" onclick="capturePhoto()">Take Photo</button>
            <p id="cameraError" class="text-danger mt-2" style="display: none;">Camera not accessible. Please check your camera settings.</p>
        </div>
        <canvas id="canvas" style="display:none;"></canvas>
      </div>
    </div>
  </div>
</div>

<!-- Footer - Matching home.jsp -->
<footer class="footer text-white py-3">
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

<!-- Scripts -->
<script>
    let originalData = {};
    let studentData = []; // For populating search

    $(document).ready(function() {
        // Fetch all students for datalist
        $.ajax({
            url: 'SearchServlet',
            method: 'GET',
            success: function (data) {
                studentData = data;
                const datalist = $('#studentsList');
                data.forEach(function (student) {
                    if (student.admin_no && student.name) { // Ensure no undefined
                        datalist.append(`<option value="${student.admin_no} - ${student.name}">`);
                    }
                });
            },
            error: function() {
                console.error('Error fetching students for search');
            }
        });

        // Edit button
        $('#editBtn').click(function() {
            $('input.form-control').removeAttr('readonly');
            $('#editBtn').hide();
            $('#updateBtn, #resetBtn').show();
        });

        // Reset button
        $('#resetBtn').click(function() {
            fillInputs(originalData);
            updateBalance();
            $('input.form-control').attr('readonly', true);
            $('#editBtn').show();
            $('#updateBtn, #resetBtn').hide();
        });

        // Form submit for update (placeholder for now)
        $('#studentForm').submit(function(e) {
            e.preventDefault();
            alert('Update functionality to be implemented');
        });
    });

    function fetchStudent() {
        let val = $('#searchInput').val();
        if (!val) {
            alert('Please enter a student name or admission number.');
            return;
        }
        let adminNo = val.split(" - ")[0];
        $.ajax({
            url: 'getStudentServlet',
            type: 'GET',
            data: { admin_no: adminNo },
            success: function(data) {
                fillInputs(data);
                originalData = { ...data };
                $('#studentNameHeader').text(data.student_name || 'Unknown Student');
                updateBalance();
                $('#profileContainer').show(); // Show the profile after fetch
            },
            error: function() {
                alert('Error fetching student data');
            }
        });
    }

    function fillInputs(data) {
        $('#studentId').val(data.student_id || '');
        $('#adminNo').val(data.admin_no || '');
        $('#studentName').val(data.student_name || '');
        $('#email').val(data.email || '');
        $('#class').val(data.class || '');
        $('#gender').val(data.gender || '');
        $('#dob').val(data.dob || '');
        $('#age').val(data.age || '');
        $('#aadharNumber').val(data.aadhar_number || '');
        $('#address').val(data.address || '');
        $('#pincode').val(data.pincode || '');
        $('#fatherName').val(data.father_name || '');
        $('#fatherNumber').val(data.father_number || '');
        $('#motherName').val(data.mother_name || '');
        $('#motherNumber').val(data.mother_number || '');
        $('#guardianName').val(data.guardian_name || '');
        $('#guardianNumber').val(data.guardian_number || '');
        $('#totalFee').val('₹' + (data.total_fee || 0));
        $('#paidFee').val('₹' + (data.paid_fee || 0));
    }

    function updateBalance() {
        const total = parseFloat($('#totalFee').val().replace('₹', '') || 0);
        const paid = parseFloat($('#paidFee').val().replace('₹', '') || 0);
        const balance = total - paid;
        const balanceEl = $('#balance');
        balanceEl.text('₹' + balance.toFixed(2));
        balanceEl.removeClass('balance-positive balance-negative');
        balanceEl.addClass(balance >= 0 ? 'balance-positive' : 'balance-negative');
    }

    // Image handling functions (placeholder, no DB fields yet)
    function previewAvatar(event) {
        const reader = new FileReader();
        reader.onload = function () {
            $('#avatarPreview').attr('src', reader.result);
            originalData.avatarUrl = reader.result;
            bootstrap.Modal.getInstance(document.getElementById('avatarModal')).hide();
        };
        reader.readAsDataURL(event.target.files[0]);
    }

    function startCamera() {
        const video = document.getElementById('video');
        const container = document.getElementById('cameraContainer');
        const errorText = document.getElementById('cameraError');
        navigator.mediaDevices.getUserMedia({ video: true })
            .then(stream => {
                video.srcObject = stream;
                container.style.display = 'block';
                errorText.style.display = 'none';
            })
            .catch(() => {
                container.style.display = 'block';
                errorText.style.display = 'block';
            });
    }

    function capturePhoto() {
        const video = document.getElementById('video');
        const canvas = document.getElementById('canvas');
        canvas.width = video.videoWidth;
        canvas.height = video.videoHeight;
        const context = canvas.getContext('2d');
        context.drawImage(video, 0, 0);
        const dataUrl = canvas.toDataURL('image/png');
        $('#avatarPreview').attr('src', dataUrl);
        originalData.avatarUrl = dataUrl;
        const stream = video.srcObject;
        stream.getTracks().forEach(track => track.stop());
        bootstrap.Modal.getInstance(document.getElementById('avatarModal')).hide();
        document.getElementById('cameraContainer').style.display = 'none';
    }
</script>
</body>
</html>