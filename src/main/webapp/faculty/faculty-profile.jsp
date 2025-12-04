<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Faculty Profile Management</title>
    
    <!-- CSS: Bootstrap, Select2, custom -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="../student-profile.css" rel="stylesheet"> <!-- Rename to faculty-profile.css if needed -->
    <link rel="icon" href="https://cdn-icons-png.flaticon.com/512/2132/2132732.png" type="image/x-icon">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark px-3 py-1">
  <div class="container-fluid">
    <a class="navbar-brand" href="../home.jsp">SAS School</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav me-auto">
        <li class="nav-item"><a class="nav-link" href="../home.jsp">Home</a></li>
        <li class="nav-item"><a class="nav-link" href="../about.jsp">About Us</a></li>
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="../students.jsp" role="button" data-bs-toggle="dropdown">Students</a>
          <ul class="dropdown-menu">
            <li><a class="dropdown-item" href="../studentdetails.jsp">Student Details</a></li>
            <li><a class="dropdown-item" href="../allStudents.jsp">Student Payment Info</a></li>
            <li><a class="dropdown-item" href="../BillingPage.jsp">Student Fee Payment</a></li>
            <li><a class="dropdown-item" href="../studentreg.jsp">Create Student Details</a></li>
            <li><a class="dropdown-item" href="../create-class.jsp">Create Class</a></li>
            <li><a class="dropdown-item" href="../bulkimporting.jsp">Create Bulk</a></li>
            <li><a class="dropdown-item" href="../newupdates.jsp">Update Student Details</a></li>
          </ul>
        </li>
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">Payments</a>
          <ul class="dropdown-menu">
            <li><a class="dropdown-item" href="../allpayments.jsp">All Payment Details</a></li>
            <li><a class="dropdown-item" href="../apbme.jsp">Payment By Admin</a></li>
            <li><a class="dropdown-item" href="../paymentdetails.jsp">All Payment Status</a></li>
          </ul>
        </li>
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">Explore</a>
          <ul class="dropdown-menu">
            <li><a class="dropdown-item" href="#">360° View</a></li>
            <li><a class="dropdown-item" href="#">Videos</a></li>
            <li><a class="dropdown-item" href="../images.jsp">Images</a></li>
          </ul>
        </li>
        <li class="nav-item"><a class="nav-link" href="../fee-notifications.jsp">Send Notifications</a></li>
        <li class="nav-item"><a class="nav-link" href="#">Contact Us</a></li>
      </ul>
      <%
        if (session == null || (session.getAttribute("adminName") == null && session.getAttribute("studentId") == null && session.getAttribute("facultyID") == null)) {
            response.sendRedirect("../AdminLogin.jsp");
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
        String facultyIDSession = (String)session.getAttribute("facultyID");
      %>
      <div class="d-flex align-items-center">
        <span class="text-white me-2 fs-6">Hello, <%=userName%></span>
        <div class="dropdown me-2">
          <a class="btn btn-sm btn-outline-light dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">
            Roles
          </a>
          <ul class="dropdown-menu dropdown-menu-end">
            <li><a class="dropdown-item" href="../home.jsp">Channel Admin</a></li>
            <li><a class="dropdown-item" href="#">Student</a></li>
            <li><a class="dropdown-item" href="../faculty.jsp">Faculty</a></li>
          </ul>
        </div>
        <a class="btn btn-outline-light btn-sm me-1" href="../AdminLogin.jsp">Logout</a>
        <a class="btn btn-outline-warning btn-sm" href="../createaccount.jsp">Signup</a>
      </div>
    </div>
  </div>
</nav>

<div class="main-content d-flex flex-column min-vh-100">

    <!-- Search Section - Compact -->
    <!-- Wrapped in a wrapper so we can hide everything easily for faculty -->
    <div id="facultySearchWrapper">
        <div class="search-container py-3 text-center bg-light">
            <h4 class="fw-bold text-primary mb-3">
                <i class="bi bi-person-lines-fill me-2"></i>Faculty Profile Management
            </h4>
            <div class="row justify-content-center">
                <div class="col-md-8">
                    <label for="facultyDropdown" class="form-label fw-bold mb-2 d-block">Select Faculty:</label>
                    <div class="input-group">
                        <select id="facultyDropdown" class="form-select form-select-sm">
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

                            <div class="avatar-container position-relative d-inline-block mb-2">
                                <img id="avatarPreview"
                                    src=""
                                    class="rounded-circle border border-2 border-primary shadow"
                                    style="width: 100px; height: 100px; object-fit: cover; background: white;">
                                
                                <div class="position-absolute bottom-0 end-0 bg-primary text-white rounded-circle d-flex align-items-center justify-content-center"
                                     style="width: 25px; height: 25px; font-size: 14px; cursor: pointer;"
                                     data-bs-toggle="modal" data-bs-target="#avatarModal">+</div>
                            </div>

                            <h4 class="fw-bold text-primary mb-1" id="facultyNameHeader">Faculty Name</h4>
                            <p class="text-muted small mb-0" id="facultyIDDisplay">FAC-ID</p>
                        </div>
                        <div class="col-md-9 p-3">
                            <ul class="nav nav-tabs border-0 flex-wrap justify-content-center justify-content-md-start" id="profileTabs" role="tablist">
                                <li class="nav-item" role="presentation">
                                    <button class="nav-link active fw-bold px-3 py-2" id="personal-tab" data-bs-toggle="tab" data-bs-target="#personal" type="button" role="tab">Personal</button>
                                </li>
                                <li class="nav-item" role="presentation">
                                    <button class="nav-link fw-bold px-3 py-2" id="professional-tab" data-bs-toggle="tab" data-bs-target="#professional" type="button" role="tab">Professional</button>
                                </li>
                                <li class="nav-item" role="presentation">
                                    <button class="nav-link fw-bold px-3 py-2" id="salary-tab" data-bs-toggle="tab" data-bs-target="#salary" type="button" role="tab">Salary</button>
                                </li>
                                <li class="nav-item" role="presentation">
                                    <button class="nav-link fw-bold px-3 py-2" id="subjects-tab" data-bs-toggle="tab" data-bs-target="#subjects" type="button" role="tab">Subjects</button>
                                </li>
                                <li class="nav-item" role="presentation">
                                    <button class="nav-link fw-bold px-3 py-2" id="timetable-tab" data-bs-toggle="tab" data-bs-target="#timetable" type="button" role="tab">Timetable</button>
                                </li>
                                <li class="nav-item" role="presentation">
                                    <button class="nav-link fw-bold px-3 py-2" id="documents-tab" data-bs-toggle="tab" data-bs-target="#documents" type="button" role="tab">Documents</button>
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
                                        <div class="col-4 fw-bold text-muted small">Faculty ID:</div>
                                        <div class="col-8"><input type="text" class="form-control form-control-sm" id="facultyID" readonly></div>
                                    </div>
                                    <div class="row g-2 align-items-center mb-2">
                                        <div class="col-4 fw-bold text-muted small">Name:</div>
                                        <div class="col-8"><input type="text" class="form-control form-control-sm" id="name" readonly></div>
                                    </div>
                                    <div class="row g-2 align-items-center mb-2">
                                        <div class="col-4 fw-bold text-muted small">Email:</div>
                                        <div class="col-8"><input type="text" class="form-control form-control-sm" id="email" readonly></div>
                                    </div>
                                    <div class="row g-2 align-items-center mb-2">
                                        <div class="col-4 fw-bold text-muted small">Phone:</div>
                                        <div class="col-8"><input type="text" class="form-control form-control-sm" id="phone_number" readonly></div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="row g-2 align-items-center mb-2">
                                        <div class="col-4 fw-bold text-muted small">Aadhaar:</div>
                                        <div class="col-8"><input type="text" class="form-control form-control-sm" id="aadhar_number" readonly></div>
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
                            </div>
                            <!-- Address Section -->
                            <div class="row g-2 mt-3">
                                <div class="col-12">
                                    <div class="row g-2 align-items-start mb-2">
                                        <div class="col-2 fw-bold text-muted small pt-1">Address:</div>
                                        <div class="col-10"><textarea class="form-control form-control-sm" id="address" rows="3" readonly></textarea></div>
                                    </div>
                                </div>
                            </div>
                            <div class="row g-2">
                                <div class="col-md-4">
                                    <div class="row g-2 align-items-center mb-2">
                                        <div class="col-4 fw-bold text-muted small">City:</div>
                                        <div class="col-8"><input type="text" class="form-control form-control-sm" id="city" readonly></div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="row g-2 align-items-center mb-2">
                                        <div class="col-4 fw-bold text-muted small">State:</div>
                                        <div class="col-8"><input type="text" class="form-control form-control-sm" id="state" readonly></div>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="row g-2 align-items-center mb-2">
                                        <div class="col-4 fw-bold text-muted small">Pincode:</div>
                                        <div class="col-8"><input type="text" class="form-control form-control-sm" id="pincode" readonly></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- Professional Tab -->
                        <div class="tab-pane fade" id="professional" role="tabpanel">
                            <div class="row g-2">
                                <div class="col-md-6">
                                    <div class="row g-2 align-items-center mb-2">
                                        <div class="col-4 fw-bold text-muted small">Qualification:</div>
                                        <div class="col-8"><input type="text" class="form-control form-control-sm" id="qualification" readonly></div>
                                    </div>
                                    <div class="row g-2 align-items-center mb-2">
                                        <div class="col-4 fw-bold text-muted small">Department:</div>
                                        <div class="col-8"><input type="text" class="form-control form-control-sm" id="department" readonly></div>
                                    </div>
                                    <div class="row g-2 align-items-center mb-2">
                                        <div class="col-4 fw-bold text-muted small">Designation:</div>
                                        <div class="col-8"><input type="text" class="form-control form-control-sm" id="designation" readonly></div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="row g-2 align-items-center mb-2">
                                        <div class="col-4 fw-bold text-muted small">Experience (Years):</div>
                                        <div class="col-8"><input type="text" class="form-control form-control-sm" id="experience_years" readonly></div>
                                    </div>
                                    <div class="row g-2 align-items-center mb-2">
                                        <div class="col-4 fw-bold text-muted small">Join Date:</div>
                                        <div class="col-8"><input type="text" class="form-control form-control-sm" id="join_date" readonly></div>
                                    </div>
                                    <div class="row g-2 align-items-center mb-2">
                                        <div class="col-4 fw-bold text-muted small">Status:</div>
                                        <div class="col-8"><input type="text" class="form-control form-control-sm" id="status" readonly></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- Salary Tab -->
						<div class="tab-pane fade" id="salary" role="tabpanel">
						    <div class="row g-2">
						        <div class="col-md-6">
						            <div class="row g-2 align-items-center mb-2">
						                <div class="col-4 fw-bold text-muted small">Annual Salary:</div>
						                <div class="col-8">
						                    <div class="input-group input-group-sm">
						                        <span class="input-group-text">₹</span>
						                        <input type="text" class="form-control form-control-sm" id="salary" readonly placeholder="0" value="">
						                    </div>
						                </div>
						            </div>
						        </div>
						        <div class="col-md-6">
						            <div class="row g-2 align-items-center mb-2">
						                <div class="col-4 fw-bold text-muted small">Monthly Salary:</div>
						                <div class="col-8">
						                    <div class="input-group input-group-sm">
						                        <span class="input-group-text">₹</span>
						                        <input type="text" class="form-control form-control-sm" id="monthly_salary" readonly placeholder="0" value="">
						                    </div>
						                </div>
						            </div>
						        </div>
						    </div>
						    <div class="row mt-2">
						        <div class="col-12 text-center text-muted small">
						            <em>(Monthly is auto-calculated from Annual / 12)</em>
						        </div>
						    </div>
						</div>
                        <!-- Subjects Tab -->
                        <div class="tab-pane fade" id="subjects" role="tabpanel">
                            <label class="fw-bold small">Subjects Taught:</label>
                            <div id="subjectsList" class="mt-2"></div>
                            
                            <label class="fw-bold small mt-3">Class Teacher For:</label>
                            <p id="classTeacherOf" class="mt-1 fw-bold text-primary"></p>
                        </div>
                        <!-- Timetable Tab -->
                        <div class="tab-pane fade" id="timetable" role="tabpanel">
                            <table class="table table-sm table-bordered">
                                <thead class="table-light">
                                    <tr><th>Time</th><th>Subject</th></tr>
                                </thead>
                                <tbody id="timetableBody"></tbody>
                            </table>
                        </div>
                        <!-- Documents Tab -->
                        <div class="tab-pane fade" id="documents" role="tabpanel">
                            <table class="table table-sm table-striped">
                                <thead>
                                    <tr><th>Document</th><th>Status</th></tr>
                                </thead>
                                <tbody id="documentsBody"></tbody>
                            </table>
                        </div>
                    </div>
                    <!-- Hidden Faculty ID -->
                    <input type="hidden" id="facultyIDHidden">

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

<!-- expose role/facultyID to client before loading faculty-profile.js -->
<script>
  window.userRole = "<%= (role != null ? role.replace("\"", "\\\"") : "") %>";
  window.facultyID = "<%= (facultyIDSession != null ? facultyIDSession.replace("\"", "\\\"") : "") %>";
  console.log("User role:", window.userRole, "facultyID:", window.facultyID);
</script>

<!-- Load client script (must be after window.userRole is set) -->
<script src="./faculty-profile.js"></script>

<!-- optional role control -->
<script src="../js/roleControl.js"></script>

</body>
</html>