<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Student Profile</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
     <link rel="icon" href="https://cdn-icons-png.flaticon.com/512/2132/2132732.png" type="image/x-icon">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"> 
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
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
            // Redirect if not logged in
            response.sendRedirect("AdminLogin.jsp");
            return;
        }
        
        String userName = "";
        for(int i= 0 ; i<=name.length()-1 ; i++)
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
        <a class="btn btn-outline-light me-2" href="AdminLogin.jsp">Logout</a>
        <a class="btn btn-outline-warning" href="createaccount.jsp">Signup</a>
      </div>
    </div>
  </div>
</nav>


<div class="container my-5">
    <div class="card shadow">
        <div class="row g-0">
            <!-- Left: Full Photo and Avatar -->
            <div class="col-md-4 bg-light text-center py-4">
              <h4> Student Profile</h4>
              <img src="${student.photoUrl}" class="img-fluid mb-3 mx-auto d-block" style="border-radius: 12px; max-width: 90%;">
                <div class="avatar-container">
                    <img src="${student.avatarUrl}" id="avatarPreview" class="avatar">
                    <div class="plus-icon" data-bs-toggle="modal" data-bs-target="#avatarModal">+</div>
                </div>

            </div>

            <!-- Right: Student Info -->
            <div class="col-md-8 p-4">
                <h3 class="mb-4">${student.name}</h3>
                <div class="row mb-2"><div class="col-sm-5 profile-label">Admission No:</div><div class="col-sm-7 profile-value">${student.admissionNo}</div></div>
                <div class="row mb-2"><div class="col-sm-5 profile-label">Father's Name:</div><div class="col-sm-7 profile-value">${student.fatherName}</div></div>
                <div class="row mb-2"><div class="col-sm-5 profile-label">Mother's Name:</div><div class="col-sm-7 profile-value">${student.motherName}</div></div>
                <div class="row mb-2"><div class="col-sm-5 profile-label">Father's Number:</div><div class="col-sm-7 profile-value">${student.fatherNumber}</div></div>
                <div class="row mb-2"><div class="col-sm-5 profile-label">Mother's Number:</div><div class="col-sm-7 profile-value">${student.motherNumber}</div></div>
                <div class="row mb-2"><div class="col-sm-5 profile-label">Aadhaar Number:</div><div class="col-sm-7 profile-value">${student.aadhaar}</div></div>
                <div class="row mb-2"><div class="col-sm-5 profile-label">Total Fee:</div><div class="col-sm-7 profile-value">₹${student.totalFee}</div></div>
                <div class="row mb-2"><div class="col-sm-5 profile-label">Paid Fee:</div><div class="col-sm-7 profile-value">₹${student.paidFee}</div></div>
                <div class="row mb-2"><div class="col-sm-5 profile-label">Class:</div><div class="col-sm-7 profile-value">${student.className}</div></div>
                <div class="row mb-2"><div class="col-sm-5 profile-label">Gender:</div><div class="col-sm-7 profile-value">${student.gender}</div></div>
                <div class="row mb-2"><div class="col-sm-5 profile-label">Date of Birth:</div><div class="col-sm-7 profile-value">${student.dob}</div></div>
                <div class="row mb-2"><div class="col-sm-5 profile-label">Address:</div><div class="col-sm-7 profile-value">${student.address}</div></div>
                <div class="row mb-2"><div class="col-sm-5 profile-label">Pincode:</div><div class="col-sm-7 profile-value">${student.pincode}</div></div>
            </div>
        </div>
    </div>
</div>

<!-- Modal: Upload or Camera -->
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
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
