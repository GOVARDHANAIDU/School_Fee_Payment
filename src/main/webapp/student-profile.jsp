<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Profile Management</title>
    
    <!-- CSS: Bootstrap, Select2, custom -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="./student-profile.css" rel="stylesheet">
    <link rel="icon" href="https://cdn-icons-png.flaticon.com/512/2132/2132732.png" type="image/x-icon">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
</head>
<body>
<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark px-3 py-1">
  <div class="container-fluid">
    <a class="navbar-brand" href="home.jsp">SAS School</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav me-auto">
        <li class="nav-item"><a class="nav-link" href="home.jsp">Home</a></li>
        <li class="nav-item"><a class="nav-link" href="about.jsp">About Us</a></li>
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
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">Payments</a>
          <ul class="dropdown-menu">
            <li><a class="dropdown-item" href="allpayments.jsp">All Payment Details</a></li>
            <li><a class="dropdown-item" href="apbme.jsp">Payment By Admin</a></li>
            <li><a class="dropdown-item" href="paymentdetails.jsp">All Payment Status</a></li>
          </ul>
        </li>
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">Explore</a>
          <ul class="dropdown-menu">
            <li><a class="dropdown-item" href="#">360° View</a></li>
            <li><a class="dropdown-item" href="#">Videos</a></li>
            <li><a class="dropdown-item" href="images.jsp">Images</a></li>
          </ul>
        </li>
        <li class="nav-item"><a class="nav-link" href="fee-notifications.jsp">Send Notifications</a></li>
        <li class="nav-item"><a class="nav-link" href="#">Contact Us</a></li>
      </ul>
      <%
        if (session == null || (session.getAttribute("adminName") == null && session.getAttribute("studentId") == null && session.getAttribute("facultyId") == null)) {
            response.sendRedirect("AdminLogin.jsp");
            return;
        }
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setDateHeader("Expires", 0);
        String displayName = (String) session.getAttribute("adminName");
        if (displayName == null) displayName = "User";
        String userName = "";
        for(int i = 0; i < displayName.length(); i++) {
            char ch = displayName.charAt(i);
            if(ch == ' ') break;
            else userName += ch;
        }
        String role = (String)session.getAttribute("Roles");
        String admissionNo = (String)session.getAttribute("admissionNo");
      %>
      <div class="d-flex align-items-center">
        <span class="text-white me-2 fs-6">Hello, <%=userName%></span>
        <div class="dropdown me-2">
          <a class="btn btn-sm btn-outline-light dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">
            Roles
          </a>
          <ul class="dropdown-menu dropdown-menu-end">
            <li><a class="dropdown-item" href="home.jsp">Channel Admin</a></li>
            <li><a class="dropdown-item" href="#">Student</a></li>
            <li><a class="dropdown-item" href="./faculty/faculty.jsp">Faculty</a></li>
          </ul>
        </div>
        <a class="btn btn-outline-light btn-sm me-1" href="AdminLogin.jsp">Logout</a>
        <a class="btn btn-outline-warning btn-sm" href="createaccount.jsp">Signup</a>
      </div>
    </div>
  </div>
</nav>

<div class="main-content d-flex flex-column min-vh-100">
    <!-- Search Section - Compact -->
    <!-- Wrapped in a wrapper so we can hide everything easily for students -->
    <div id="studentSearchWrapper">
        <div class="search-container py-3 text-center bg-light">
            <h3 class="fw-bold text-primary mb-3"><i class="bi bi-person-lines-fill me-2"></i>Manage Profile</h3>
            <div class="row justify-content-center">
                <div class="col-md-8">
                    <label for="studentDropdown" class="form-label fw-bold mb-2 d-block">Select Student:</label>
                    <div class="input-group">
                        <select id="studentDropdown" class="form-select form-select-sm">
                            <option></option>
                        </select>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Loading Spinner -->
    <div id="profileLoading" class="text-center py-5 d-none">
        <div class="spinner-border text-primary" role="status" style="width: 3rem; height: 3rem;">
            <span class="visually-hidden">Loading...</span>
        </div>
        <p class="mt-2 text-muted">Loading profile...</p>
    </div>

    <!-- Profile Container - Hidden initially -->
    <div id="profileContainer" class="container-fluid px-3 pb-3 flex-grow-1" style="display: none;">
        <div class="row justify-content-center">
            <div class="col-12 col-lg-10">
                <div class="card shadow-sm border-0 overflow-hidden">
                    <!-- Header with Photo and Name -->
                    <div class="row g-0 align-items-center bg-light">
                        <div class="col-md-3 text-center py-3">
                            <img id="photo" src="" class="img-fluid mb-2 rounded-3 shadow-sm d-none" style="max-height: 180px; object-fit: cover; width: 100%;">
				<div class="avatar-container position-relative d-inline-block mb-2">
				    <img id="avatarPreview"
				     src=""
				     class="rounded-circle border border-2 border-primary shadow"
				     style="width: 100px; height: 100px; object-fit: contain; background:white;">
				         
				    <div class="position-absolute bottom-0 end-0 bg-primary text-white rounded-circle d-flex align-items-center justify-content-center"
				         style="width: 25px; height: 25px; font-size: 14px; cursor: pointer;"
				         data-bs-toggle="modal" data-bs-target="#avatarModal">+</div>
				</div>

                            <h4 class="fw-bold text-primary mb-1" id="student_name">Student Name</h4>
                            <p class="text-muted small mb-0" id="adminNoDisplay">ADM No.</p>
                        </div>
                        <div class="col-md-9 p-3">
                            <ul class="nav nav-tabs border-0 flex-wrap justify-content-center justify-content-md-start" id="profileTabs" role="tablist">
                                <li class="nav-item" role="presentation">
                                    <button class="nav-link active fw-bold px-3 py-2" id="personal-tab" data-bs-toggle="tab" data-bs-target="#personal" type="button" role="tab">Personal</button>
                                </li>
                                <li class="nav-item" role="presentation">
                                    <button class="nav-link fw-bold px-3 py-2" id="parents-tab" data-bs-toggle="tab" data-bs-target="#parents" type="button" role="tab">Parents/Guardian</button>
                                </li>
                                <li class="nav-item" role="presentation">
                                    <button class="nav-link fw-bold px-3 py-2" id="payment-tab" data-bs-toggle="tab" data-bs-target="#payment" type="button" role="tab">Payment</button>
                                </li>
                                <li class="nav-item" role="presentation">
                                    <button class="nav-link fw-bold px-3 py-2" id="marks-tab" data-bs-toggle="tab" data-bs-target="#marks" type="button" role="tab">Marks</button>
                                </li>
                                <li class="nav-item" role="presentation">
                                    <button class="nav-link fw-bold px-3 py-2" id="attendance-tab" data-bs-toggle="tab" data-bs-target="#attendance" type="button" role="tab">Attendance</button>
                                </li>
                                <li class="nav-item" role="presentation">
                                    <button class="nav-link fw-bold px-3 py-2" id="class-tab" data-bs-toggle="tab" data-bs-target="#class" type="button" role="tab">Class/Section</button>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <!-- Tab Content -->
                    <div class="tab-content p-3" id="profileTabContent">
                        <!-- Personal Tab -->
                        <div class="tab-pane fade show active" id="personal" role="tabpanel">
                            <div class="row g-2">
                                <div class="col-md-6">
                                    <div class="row g-2 align-items-center mb-2">
                                        <div class="col-4 fw-bold text-muted small">Admission No:</div>
                                        <div class="col-8"><input type="text" class="form-control form-control-sm" id="adminNo" readonly></div>
                                    </div>
                                    <div class="row g-2 align-items-center mb-2">
                                        <div class="col-4 fw-bold text-muted small">Name:</div>
                                        <div class="col-8"><input type="text" class="form-control form-control-sm" id="studentName" readonly></div>
                                    </div>
                                    <div class="row g-2 align-items-center mb-2">
                                        <div class="col-4 fw-bold text-muted small">Email:</div>
                                        <div class="col-8"><input type="text" class="form-control form-control-sm" id="email" readonly></div>
                                    </div>
                                    <div class="row g-2 align-items-center mb-2">
                                        <div class="col-4 fw-bold text-muted small">Gender:</div>
                                        <div class="col-8"><input type="text" class="form-control form-control-sm" id="gender" readonly></div>
                                    </div>
                                    <div class="row g-2 align-items-center mb-2">
                                        <div class="col-4 fw-bold text-muted small">DOB:</div>
                                        <div class="col-8"><input type="text" class="form-control form-control-sm" id="dob" readonly></div>
                                    </div>
                                    <div class="row g-2 align-items-center mb-2">
                                        <div class="col-4 fw-bold text-muted small">Age:</div>
                                        <div class="col-8"><input type="text" class="form-control form-control-sm" id="age" readonly></div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="row g-2 align-items-center mb-2">
                                        <div class="col-4 fw-bold text-muted small">Aadhaar:</div>
                                        <div class="col-8"><input type="text" class="form-control form-control-sm" id="aadharNumber" readonly></div>
                                    </div>
                                    <div class="row g-2 align-items-start mb-2"> <!-- align-items-start for textarea -->
                                        <div class="col-4 fw-bold text-muted small pt-1">Address:</div>
                                        <div class="col-8"><textarea class="form-control form-control-sm" id="address" rows="3" readonly></textarea></div>
                                    </div>
                                    <div class="row g-2 align-items-center mb-2">
                                        <div class="col-4 fw-bold text-muted small">Pincode:</div>
                                        <div class="col-8"><input type="text" class="form-control form-control-sm" id="pincode" readonly></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- Parents Tab -->
                        <div class="tab-pane fade" id="parents" role="tabpanel">
                            <div class="row g-2">
                                <div class="col-md-6">
                                    <div class="row g-2 align-items-center mb-2">
                                        <div class="col-4 fw-bold text-muted small">Father's Name:</div>
                                        <div class="col-8"><input type="text" class="form-control form-control-sm" id="fatherName" readonly></div>
                                    </div>
                                    <div class="row g-2 align-items-center mb-2">
                                        <div class="col-4 fw-bold text-muted small">Father's Phone:</div>
                                        <div class="col-8"><input type="text" class="form-control form-control-sm" id="fatherNumber" readonly></div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="row g-2 align-items-center mb-2">
                                        <div class="col-4 fw-bold text-muted small">Mother's Name:</div>
                                        <div class="col-8"><input type="text" class="form-control form-control-sm" id="motherName" readonly></div>
                                    </div>
                                    <div class="row g-2 align-items-center mb-2">
                                        <div class="col-4 fw-bold text-muted small">Mother's Phone:</div>
                                        <div class="col-8"><input type="text" class="form-control form-control-sm" id="motherNumber" readonly></div>
                                    </div>
                                    <div class="row g-2 align-items-center mb-2">
                                        <div class="col-4 fw-bold text-muted small">Guardian Name:</div>
                                        <div class="col-8"><input type="text" class="form-control form-control-sm" id="guardianName" readonly></div>
                                    </div>
                                    <div class="row g-2 align-items-center mb-2">
                                        <div class="col-4 fw-bold text-muted small">Guardian Phone:</div>
                                        <div class="col-8"><input type="text" class="form-control form-control-sm" id="guardianNumber" readonly></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- Payment Tab -->
                        <div class="tab-pane fade" id="payment" role="tabpanel">
                            <div class="row g-2">
                                <div class="col-md-6">
                                    <div class="row g-2 align-items-center mb-2">
                                        <div class="col-4 fw-bold text-muted small">Total Fee:</div>
                                        <div class="col-8"><input type="text" class="form-control form-control-sm" id="totalFee" readonly></div>
                                    </div>
                                    <div class="row g-2 align-items-center mb-2">
                                        <div class="col-4 fw-bold text-muted small">Paid Fee:</div>
                                        <div class="col-8"><input type="text" class="form-control form-control-sm" id="paidFee" readonly></div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="row g-2 align-items-center mb-3">
                                        <div class="col-4 fw-bold text-muted small">Balance:</div>
                                        <div class="col-8"><span id="balance" class="fw-bold fs-5 d-block"></span></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- Marks Tab -->
                        <div class="tab-pane fade" id="marks" role="tabpanel">
                            <div class="row g-2">
                                <div class="col-12">
                                    <table class="table table-sm table-bordered">
                                        <thead class="table-light">
                                            <tr><th>Subject</th><th>Marks</th><th>Grade</th></tr>
                                        </thead>
                                        <tbody>
                                            <tr><td>Math</td><td><input type="text" class="form-control form-control-sm" value="85" readonly></td><td><input type="text" class="form-control form-control-sm" value="A" readonly></td></tr>
                                            <tr><td>Science</td><td><input type="text" class="form-control form-control-sm" value="90" readonly></td><td><input type="text" class="form-control form-control-sm" value="O" readonly></td></tr>
                                            <tr><td>English</td><td><input type="text" class="form-control form-control-sm" value="80" readonly></td><td><input type="text" class="form-control form-control-sm" value="A" readonly></td></tr>
                                            <tr><td>Average</td><td><input type="text" class="form-control form-control-sm" value="83" readonly></td><td><input type="text" class="form-control form-control-sm" value="A" readonly></td></tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                        <!-- Attendance Tab -->
                        <div class="tab-pane fade" id="attendance" role="tabpanel">
                            <div class="row g-2">
                                <div class="col-md-6">
                                    <div class="row g-2 align-items-center mb-2">
                                        <div class="col-4 fw-bold text-muted small">Total Days:</div>
                                        <div class="col-8"><input type="text" class="form-control form-control-sm"  readonly value="180"></div>
                                    </div>
                                    <div class="row g-2 align-items-center mb-2">
                                        <div class="col-4 fw-bold text-muted small">Present Days:</div>
                                        <div class="col-8"><input type="text" class="form-control form-control-sm"  readonly value="162"></div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="row g-2 align-items-center mb-2">
                                        <div class="col-4 fw-bold text-muted small">Attendance %:</div>
                                        <div class="col-8"><input type="text" class="form-control form-control-sm" readonly value="90%"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- Class/Section Tab -->
                         <div class="tab-pane fade" id="class" role="tabpanel">
                            <div class="row g-2">
                                <div class="col-md-6">
                                    <div class="row g-2 align-items-center mb-2">
                                        <div class="col-4 fw-bold text-muted small">Class:</div>
                                        <div class="col-8"><input type="text" class="form-control form-control-sm"  readonly value="10th Grade"></div>
                                    </div>
                                    <div class="row g-2 align-items-center mb-2">
                                        <div class="col-4 fw-bold text-muted small">Section:</div>
                                        <div class="col-8"><input type="text" class="form-control form-control-sm"  readonly value="A"></div>
                                    </div>
                                    <div class="row g-2 align-items-center mb-2">
                                        <div class="col-4 fw-bold text-muted small">Academic Year:</div>
                                        <div class="col-8"><input type="text" class="form-control form-control-sm"  readonly value="2025-2026"></div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="row g-2 align-items-center mb-2">
                                        <div class="col-4 fw-bold text-muted small">Roll No:</div>
                                        <div class="col-8"><input type="text" class="form-control form-control-sm"  readonly value="15"></div>
                                    </div>
                                    <div class="row g-2 align-items-center mb-2">
                                        <div class="col-4 fw-bold text-muted small">Teacher:</div>
                                        <div class="col-8"><input type="text" class="form-control form-control-sm" readonly value="John Doe"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- Hidden Student ID -->
                    <input type="hidden" id="studentId">

                    <!-- Action Buttons -->
                    <div class="card-footer bg-light text-center p-2">
                        <div class="btn-group" role="group">
                            <button type="button" class="btn btn-outline-secondary btn-sm" id="editBtn"><i class="bi bi-pencil me-1"></i>Edit</button>
                            <button type="button" class="btn btn-primary btn-sm d-none" id="updateBtn"><i class="bi bi-check-lg me-1"></i>Update</button>
                            <button type="button" class="btn btn-danger btn-sm d-none" id="resetBtn"><i class="bi bi-arrow-clockwise me-1"></i>Reset</button>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
</div>

<!-- Avatar Modal -->
<div class="modal fade" id="avatarModal" tabindex="-1">
  <div class="modal-dialog modal-sm">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">Choose Photo</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>
      <div class="modal-body text-center">
        <button class="btn btn-primary btn-sm me-2 mb-2" onclick="document.getElementById('fileInput').click()"><i class="bi bi-upload me-1"></i>Upload</button>
        <button class="btn btn-secondary btn-sm mb-2" onclick="startCamera()"><i class="bi bi-camera me-1"></i>Camera</button>
        <input type="file" id="fileInput" accept="image/*" style="display:none" onchange="previewAvatar(event)">
        <div id="cameraContainer" class="mt-2 d-none">
            <video id="video" width="100%" autoplay playsinline></video>
            <button class="btn btn-success btn-sm mt-2 w-100" onclick="capturePhoto()"><i class="bi bi-camera me-1"></i>Take Photo</button>
            <p id="cameraError" class="text-danger small mt-2 d-none">Camera access denied.</p>
        </div>
        <canvas id="canvas" style="display:none;"></canvas>
        <!-- Upload Button - Shown after image selection/capture for upload check -->
        <button id="uploadPhotoBtn" class="btn btn-success btn-sm w-100 mt-3 d-none">
            <i class="bi bi-cloud-upload me-1"></i> Upload Photo
        </button>
      </div>
    </div>
  </div>
</div>

<!-- Compact Footer -->
<footer class="bg-dark text-white py-2 mt-auto">
  <div class="container">
    <div class="row text-center text-md-start g-2">
      <div class="col-md-4">
        <h6 class="fw-bold mb-1">Contact</h6>
        <small>Email: contact@sasschool.edu | Phone: +1 123 456 7890</small>
      </div>
      <div class="col-md-4">
        <h6 class="fw-bold mb-1">About</h6>
        <small><a href="#" class="text-warning text-decoration-none d-block">Our Story</a><a href="#" class="text-warning text-decoration-none d-block">Privacy Policy</a></small>
      </div>
      <div class="col-md-4">
        <h6 class="fw-bold mb-1">Address</h6>
        <small>123 Learning Lane, Education City, Country</small>
      </div>
    </div>
  </div>
</footer>

<!-- Toast Container -->
<div class="toast-container position-fixed top-0 end-0 p-3" style="z-index: 1055">
  <div id="liveToast" class="toast" role="alert" aria-live="assertive" aria-atomic="true">
    
    <div class="toast-body">
      <span id="toastMessage" data-bs-dismiss="toast"></span>
    </div>
  </div>
</div>

<!-- JS: jQuery, Select2, Bootstrap JS -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<!-- expose role/admission to client before loading student-profile.js -->
<script>
  window.userRole = "<%= (role != null ? role.replace("\"", "\\\"") : "") %>";
  window.admissionNo = "<%= (admissionNo != null ? admissionNo.replace("\"", "\\\"") : "") %>";
  console.log("User role:", window.userRole, "admissionNo:", window.admissionNo);
</script>

<!-- Load corrected client script (must be after window.userRole is set) -->
<script src="./student-profile.js"></script>

<!-- optional role control -->
<script src="js/roleControl.js"></script>
</body>
</html>