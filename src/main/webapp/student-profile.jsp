<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Student Profile</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="icon" href="https://cdn-icons-png.flaticon.com/512/2132/2132732.png" type="image/x-icon">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"> 
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <style>
        .avatar-container {
            position: relative;
            display: inline-block;
            margin-bottom: 10px;
            align-content: center;
        }
        .avatar {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            border: 3px solid #dee2e6;
            object-fit: cover;
            align-content: center;
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
        .profile-label {
            font-weight: 600;
            color: #6c757d;
        }
        .profile-value {
            color: #212529;
        }
        .col-md-4.bg-light {
            display: flex;
            flex-direction: column;
            align-items: center; /* horizontal center */
            justify-content: center; /* vertical center */
            padding: 2rem 0; /* adjust as needed */
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
        String name = (String) session2.getAttribute("adminName");
        
        if (name == null) {
            response.sendRedirect("AdminLogin.jsp");
            return;
        }
        
        String userName = "";
        for(int i = 0; i <= name.length() - 1; i++) {
            char ch = name.charAt(i);
            if (ch == ' ') {
                break;
            } else {
                userName = userName + ch;
            }
        }
      %>
      <div style="display: flex; align-items: center; margin-left: 20px; gap: 10px;">
        <p style="color: white; margin-right: 40px; padding-top: 10px;">Hello, <%= userName %></p>
      </div>
         
      <!-- Right side Login and Signup buttons -->
      <div class="d-flex">
        <a class="btn btn-outline-light me-2" href="AdminLogin.jsp">Logout</a>
        <a class="btn btn-outline-warning" href="createaccount.jsp">Signup</a>
      </div>
    </div>
  </div>
</nav>

<!-- Search Section -->
<div class="container my-3">
    <div class="input-group">
        <input list="studentsList" id="searchInput" class="form-control" placeholder="Search by Admission No - Name">
        <button class="btn btn-primary" onclick="fetchStudent()">Fetch</button>
    </div>
    <datalist id="studentsList">
        <%
            // Database connection details - replace with your actual DB credentials
            String dbUrl = "jdbc:mysql://localhost:3306/your_database_name"; // Change to your DB
            String dbUser = "root";
            String dbPass = "";
            Connection conn = null;
            Statement stmt = null;
            ResultSet rs = null;
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection(dbUrl, dbUser, dbPass);
                stmt = conn.createStatement();
                rs = stmt.executeQuery("SELECT admin_no, student_name FROM students ORDER BY student_name");
                while (rs.next()) {
                    String adminNo = rs.getString("admin_no");
                    String studentName = rs.getString("student_name");
        %>
                    <option value="<%= adminNo %> - <%= studentName %>">
        <%
                }
            } catch (Exception e) {
                e.printStackTrace();
                // Handle error, perhaps show message
            } finally {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            }
        %>
    </datalist>
</div>

<div class="container my-5">
    <div class="card shadow">
        <div class="row g-0">
            <!-- Left: Full Photo and Avatar -->
            <div class="col-md-4 bg-light text-center py-4">
                <h4>Student Profile</h4>
                <img id="photo" src="" class="img-fluid mb-3 mx-auto d-block" style="border-radius: 12px; max-width: 90%;">
                <div class="avatar-container">
                    <img id="avatarPreview" src="" class="avatar">
                    <div class="plus-icon" data-bs-toggle="modal" data-bs-target="#avatarModal">+</div>
                </div>
            </div>

            <!-- Right: Student Info with Tabs -->
            <div class="col-md-8 p-4">
                <h3 class="mb-4" id="studentNameHeader"></h3>
                <form id="studentForm">
                    <ul class="nav nav-tabs">
                        <li class="nav-item"><a class="nav-link active" data-bs-toggle="tab" href="#personal">Personal</a></li>
                        <li class="nav-item"><a class="nav-link" data-bs-toggle="tab" href="#parents">Parents/Guardian</a></li>
                        <li class="nav-item"><a class="nav-link" data-bs-toggle="tab" href="#payment">Payment</a></li>
                    </ul>
                    <div class="tab-content mt-3">
                        <div id="personal" class="tab-pane fade show active">
                            <div class="row mb-2"><div class="col-sm-5 profile-label">Admission No:</div><div class="col-sm-7"><input type="text" class="form-control" id="admissionNo" readonly></div></div>
                            <div class="row mb-2"><div class="col-sm-5 profile-label">Name:</div><div class="col-sm-7"><input type="text" class="form-control" id="name" readonly></div></div>
                            <div class="row mb-2"><div class="col-sm-5 profile-label">Email:</div><div class="col-sm-7"><input type="text" class="form-control" id="email" readonly></div></div>
                            <div class="row mb-2"><div class="col-sm-5 profile-label">Class:</div><div class="col-sm-7"><input type="text" class="form-control" id="className" readonly></div></div>
                            <div class="row mb-2"><div class="col-sm-5 profile-label">Gender:</div><div class="col-sm-7"><input type="text" class="form-control" id="gender" readonly></div></div>
                            <div class="row mb-2"><div class="col-sm-5 profile-label">Date of Birth:</div><div class="col-sm-7"><input type="text" class="form-control" id="dob" readonly></div></div>
                            <div class="row mb-2"><div class="col-sm-5 profile-label">Age:</div><div class="col-sm-7"><input type="text" class="form-control" id="age" readonly></div></div>
                            <div class="row mb-2"><div class="col-sm-5 profile-label">Aadhaar Number:</div><div class="col-sm-7"><input type="text" class="form-control" id="aadhaar" readonly></div></div>
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
                    <div class="mt-4">
                        <button type="button" class="btn btn-secondary" id="editBtn">Edit</button>
                        <button type="submit" class="btn btn-primary" id="updateBtn" style="display:none">Update</button>
                        <button type="button" class="btn btn-danger" id="resetBtn" style="display:none">Reset</button>
                    </div>
                </form>
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

<!-- Scripts -->
<script>
    let originalData = {};

    function fetchStudent() {
        let val = $('#searchInput').val();
        if (!val) return;
        let adminNo = val.split(" - ")[0];
        $.ajax({
            url: 'getStudentServlet', // Assume this servlet returns JSON for the student based on admin_no
            data: { admin_no: adminNo },
            success: function(data) {
                fillInputs(data);
                originalData = { ...data };
                $('#studentNameHeader').text(data.name || '');
                $('#photo').attr('src', data.photoUrl || '');
                $('#avatarPreview').attr('src', data.avatarUrl || '');
                $('#balance').text('₹' + (parseFloat(data.totalFee || 0) - parseFloat(data.paidFee || 0)));
            },
            error: function() {
                alert('Error fetching student data');
            }
        });
    }

    function fillInputs(data) {
        $('#studentId').val(data.student_id || '');
        $('#admissionNo').val(data.admin_no || '');
        $('#name').val(data.student_name || '');
        $('#email').val(data.email || '');
        $('#className').val(data.class || '');
        $('#gender').val(data.gender || '');
        $('#dob').val(data.dob || '');
        $('#age').val(data.age || '');
        $('#aadhaar').val(data.aadhar_number || '');
        $('#address').val(data.address || '');
        $('#pincode').val(data.pincode || '');
        $('#fatherName').val(data.father_name || '');
        $('#fatherNumber').val(data.father_number || '');
        $('#motherName').val(data.mother_name || '');
        $('#motherNumber').val(data.mother_number || '');
        $('#guardianName').val(data.guardian_name || '');
        $('#guardianNumber').val(data.guardian_number || '');
        $('#totalFee').val('₹' + data.total_fee || '');
        $('#paidFee').val('₹' + data.paid_fee || '');
        $('#balance').text('₹' + (parseFloat(data.total_fee || 0) - parseFloat(data.paid_fee || 0)));
    }

    $('#editBtn').click(function() {
        $('input.form-control').removeAttr('readonly');
        $('#editBtn').hide();
        $('#updateBtn, #resetBtn').show();
    });

    $('#resetBtn').click(function() {
        fillInputs(originalData);
        $('input.form-control').attr('readonly', true);
        $('#editBtn').show();
        $('#updateBtn, #resetBtn').hide();
    });

    $('#studentForm').submit(function(e) {
        e.preventDefault();
        let updatedData = {
            student_id: $('#studentId').val(),
            admin_no: $('#admissionNo').val(),
            student_name: $('#name').val(),
            email: $('#email').val(),
            class: $('#className').val(),
            gender: $('#gender').val(),
            dob: $('#dob').val(),
            age: $('#age').val(),
            aadhar_number: $('#aadhaar').val(),
            address: $('#address').val(),
            pincode: $('#pincode').val(),
            father_name: $('#fatherName').val(),
            father_number: $('#fatherNumber').val(),
            mother_name: $('#motherName').val(),
            mother_number: $('#motherNumber').val(),
            guardian_name: $('#guardianName').val(),
            guardian_number: $('#guardianNumber').val(),
            total_fee: $('#totalFee').val().replace('₹', ''),
            paid_fee: $('#paidFee').val().replace('₹', ''),
            photoUrl: $('#photo').attr('src'), // Send current src, handle on server if data URL
            avatarUrl: $('#avatarPreview').attr('src') // Send current src, handle on server if data URL
        };
        $.post('updateStudentServlet', updatedData, function() { // Assume this servlet updates the DB
            alert('Student updated successfully');
            originalData = { ...updatedData };
            fillInputs(originalData);
            $('input.form-control').attr('readonly', true);
            $('#editBtn').show();
            $('#updateBtn, #resetBtn').hide();
        }).fail(function() {
            alert('Error updating student');
        });
    });

    function previewAvatar(event) {
        const reader = new FileReader();
        reader.onload = function () {
            document.getElementById('avatarPreview').src = reader.result;
            const modal = bootstrap.Modal.getInstance(document.getElementById('avatarModal'));
            modal.hide();
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
        document.getElementById('avatarPreview').src = dataUrl;

        // Stop video stream
        const stream = video.srcObject;
        const tracks = stream.getTracks();
        tracks.forEach(track => track.stop());

        const modal = bootstrap.Modal.getInstance(document.getElementById('avatarModal'));
        modal.hide();
    }
</script>
</body>
</html>