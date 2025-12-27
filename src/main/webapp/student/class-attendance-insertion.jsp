<%@page import="com.DAO.DatabaseConnectivity"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*, java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Class Attendance Insertion - SAS School</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="icon" href="https://cdn-icons-png.flaticon.com/512/2132/2132732.png" type="image/x-icon">
    	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    	
    <!-- BOOTSTRAP -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Select2 -->
    <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet"/>
    <!-- OUR CSS -->
    <link href="../css/class-attendance-insertion.css" rel="stylesheet">
    <link href="../student-profile.css" rel="stylesheet">
    <style type="text/css">
    /* Toast Notifications */
    
.toast {
    min-width: 300px;
    max-width: 300px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.15);
    border: none;
    border-radius: 8px;
}

.toast-header {
    border-radius: 8px 8px 0 0;
    padding: 10px 15px;
}

.toast-body {
    padding: 15px;
    font-size: 0.95rem;
}

.toast i {
    font-size: 1.2rem;
}

/* Toast animations */
@keyframes slideInRight {
    from {
        transform: translateX(100%);
        opacity: 0;
    }
    to {
        transform: translateX(0);
        opacity: 1;
    }
}

@keyframes fadeOut {
    from {
        opacity: 1;
    }
    to {
        opacity: 0;
    }
}

.toast.show {
    animation: slideInRight 0.3s ease-out;
}

.toast.hide {
    animation: fadeOut 0.5s ease-out;
}
    
    </style>
</head>
<body>
<%
    response.setHeader("Cache-Control","no-cache,no-store,must-revalidate");
    response.setHeader("Pragma","no-cache");
    response.setDateHeader("Expires",0);
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    String today = sdf.format(new Date());
    String selectedClass = request.getParameter("class");
    String dateParam = request.getParameter("date");
    String displayDate = dateParam != null ? dateParam : today;
    List<String> classes = new ArrayList<>();
    List<Map<String,String>> students = new ArrayList<>();
    Connection con = DatabaseConnectivity.getConnection();
    try {
        Statement st = con.createStatement();
        ResultSet rs = st.executeQuery("SELECT DISTINCT class FROM students ORDER BY class");
        while(rs.next()) { classes.add(rs.getString("class")); }
        rs.close(); st.close();
        if(selectedClass != null && !selectedClass.isEmpty()) {
            PreparedStatement ps = con.prepareStatement(
                "SELECT admin_no, student_name, father_number, class FROM students WHERE class=? ORDER BY student_name"
            );
            ps.setString(1, selectedClass);
            ResultSet rs2 = ps.executeQuery();
            while(rs2.next()) {
                Map<String,String> map = new HashMap<>();
                map.put("admin_no", rs2.getString("admin_no"));
                map.put("name", rs2.getString("student_name"));
                map.put("phone", rs2.getString("father_number"));
                map.put("class", rs2.getString("class"));
                students.add(map);
            }
            rs2.close(); ps.close();
        }
    } catch(Exception e) {
        e.printStackTrace();
    } finally {
        con.close();
    }
%>
<%
    // Prevent caching after logout
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
    String displayName = (String) session.getAttribute("adminName");
    String role = (String) session.getAttribute("Roles");
    String admissionNo = (String) session.getAttribute("admissionNo");
    if (displayName == null || role == null) {
        response.sendRedirect("../AdminLogin.jsp");
        return;
    }
    String firstName = displayName.split(" ")[0];
%>
<!-- Pass values to JS -->
<script>
    window.userRole = "<%= role %>";
    window.admissionNo = "<%= admissionNo %>";
</script>
<!-- NAVBAR -->
<!-- Navbar - Keep dark green as is -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark px-4">
  <div class="container-fluid">
    <div class="d-flex align-items-center">
      <img src="https://img.pikbest.com/png-images/20241026/simple-useful-bright-sun-and-cloud-logo-a-clear-sky-icon-design-vector_11001223.png!sw800" alt="SAS Logo"
      style="height: 40px; margin-right: 10px;">
      <a class="navbar-brand mb-0" href="home.jsp">SAS School</a>
    </div>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
      <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarNav">
      <!-- Left side nav items -->
      <ul class="navbar-nav me-auto">
        <li class="nav-item"><a class="nav-link active" href="../home.jsp">Home</a></li>

        <li class="nav-item"><a class="nav-link" href="../about.jsp">About Us</a></li>

        <!-- Students Dropdown -->
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">Students</a>
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

        <!-- Payments Dropdown -->
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">Payments</a>
          <ul class="dropdown-menu">
            <li><a class="dropdown-item" href="../allpayments.jsp">All Payment Details</a></li>
            <li><a class="dropdown-item" href="../apbme.jsp">Payment By Admin</a></li>
            <li><a class="dropdown-item" href="../paymentdetails.jsp">All Payment Status</a></li>
          </ul>
        </li>

        <!-- Explore Dropdown -->
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">Explore</a>
          <ul class="dropdown-menu">
            <li><a class="dropdown-item" href="#">360° View</a></li>
            <li><a class="dropdown-item" href="#">Videos</a></li>
            <li><a class="dropdown-item" href="../images.jsp">Images</a></li>
          </ul>
        </li>

        <!-- Other Links -->
        <li class="nav-item"><a class="nav-link" href="../fee-notifications.jsp">Send Notifications</a></li>
        <li class="nav-item"><a class="nav-link" href="#">Contact Us</a></li>
      </ul>

      <!-- Right Side -->
<%
    // Prevent caching to avoid back/forward navigation issues after logout or session expiry
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

    // Get user name for display (prioritize adminName, fallback to others if needed)
    //String displayName = (String) session.getAttribute("adminName");
    //String role = (String)session.getAttribute("Roles");
   // String admissionNo = (String)session.getAttribute("admissionNo");

    if (displayName == null || role == null) {
        response.sendRedirect("AdminLogin.jsp");
        return;
    }
    String userName = "";
    for(int i = 0; i < displayName.length(); i++) {
        char ch = displayName.charAt(i);
        if(ch == ' ') break;
        else userName += ch;
    }
%>
      <div class="ms-lg-auto mt-3 mt-lg-0
            d-flex flex-column flex-lg-row
            align-items-start align-items-lg-center
            gap-2">

    <!-- Hello Admin -->
    <span class="text-white fw-semibold">
        Hello, <%= userName %>
    </span>

    <!-- Roles Dropdown -->
    <div class="dropdown">
        <button class="btn btn-sm btn-outline-light dropdown-toggle"
                data-bs-toggle="dropdown">
            Roles
        </button>
        <ul class="dropdown-menu dropdown-menu-end">
            <li><a class="dropdown-item" href="../home.jsp">Channel Admin</a></li>
            <li><a class="dropdown-item" href="../students.jsp">Student</a></li>
            <li><a class="dropdown-item" href="./faculty/faculty.jsp">Faculty</a></li>
        </ul>
    </div>

    <!-- Auth Buttons (ALWAYS UNDER Roles in mobile) -->
    <div class="d-flex flex-column flex-lg-row gap-2 mt-2 mt-lg-0">
        <a class="btn btn-outline-light btn-sm" href="../AdminLogin.jsp">Logout</a>
        <a class="btn btn-outline-warning btn-sm" href="../createaccount.jsp">Signup</a>
    </div>

</div>

    </div>
  </div>
</nav>


<div class="toast-container position-fixed bottom-0 end-0 p-3" style="z-index: 1055;">
    <div id="successToast" class="toast" role="alert" aria-live="assertive" aria-atomic="true">
        <div class="toast-header bg-success text-white">
            <strong class="me-auto"><i class="bi bi-check-circle-fill me-2"></i>Success</strong>
            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="toast"></button>
        </div>
        <div class="toast-body">
            <div class="d-flex align-items-center">
                <i class="bi bi-check-circle-fill text-success fs-5 me-3"></i>
                <span id="successMessage"></span>
            </div>
        </div>
    </div>
    
    <div id="errorToast" class="toast" role="alert" aria-live="assertive" aria-atomic="true">
        <div class="toast-header bg-danger text-white">
            <strong class="me-auto"><i class="bi bi-exclamation-circle-fill me-2"></i>Error</strong>
            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="toast"></button>
        </div>
        <div class="toast-body">
            <div class="d-flex align-items-center">
                <i class="bi bi-exclamation-circle-fill text-danger fs-5 me-3"></i>
                <span id="errorMessage"></span>
            </div>
        </div>
    </div>
    
    <div id="warningToast" class="toast" role="alert" aria-live="assertive" aria-atomic="true">
        <div class="toast-header bg-warning text-white">
            <strong class="me-auto"><i class="bi bi-exclamation-triangle-fill me-2"></i>Warning</strong>
            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="toast"></button>
        </div>
        <div class="toast-body">
            <div class="d-flex align-items-center">
                <i class="bi bi-exclamation-triangle-fill text-warning fs-5 me-3"></i>
                <span id="warningMessage"></span>
            </div>
        </div>
    </div>
    
    <div id="infoToast" class="toast" role="alert" aria-live="assertive" aria-atomic="true">
        <div class="toast-header bg-info text-white">
            <strong class="me-auto"><i class="bi bi-info-circle-fill me-2"></i>Information</strong>
            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="toast"></button>
        </div>
        <div class="toast-body">
            <div class="d-flex align-items-center">
                <i class="bi bi-info-circle-fill text-info fs-5 me-3"></i>
                <span id="infoMessage"></span>
            </div>
        </div>
    </div>
</div>


<!-- MAIN -->
<div class="container py-4 flex-grow-1">
    <h4 class="text-center fw-bold">Class Attendance Insertion</h4>
    <p class="text-center text-muted small">Mark Present or Absent for each student.</p>
    <!-- DATE + LEGEND -->
    <!-- ONE ROW WITH DATE — CLASS — LEGEND IN A LIGHT BORDER BOX -->
    <form id="classForm" method="get" action="">
        <div class="border border-light rounded p-3 bg-light mb-4">
            <div class="row align-items-center justify-content-between" style="padding: 0 3%;">
                <!-- LEFT: DATE PICKER -->
                <div class="col-md-3">
                    <label class="small fw-semibold">Select Date</label>
                    <input type="date" name="date" id="datePicker" value="<%=displayDate%>"
                           class="form-control form-control-md" onchange="this.form.submit()">
                </div>
                <!-- CENTER: CLASS DROPDOWN -->
                <div class="col-md-4 text-center">
                    <label class="small fw-semibold">Select Class</label>
                    <select name="class" id="classSelect"
                            class="form-control form-control-md mx-auto" style="max-width:300px;">
                        <option value="">Choose Class</option>
                        <% for(String cls : classes){ %>
                            <option value="<%=cls%>"
                                    <%= selectedClass != null && selectedClass.equals(cls) ? "selected" : "" %>>
                                <%=cls%>
                            </option>
                        <% } %>
                    </select>
                </div>
                <!-- RIGHT: LEGEND -->
                <div class="col-md-3 text-end">
                    <div class="p-2 bg-light rounded small d-inline-block">
                        <div class="legend-item mb-1">
                            <span class="legend-color"
                                  style="background:#28a745; width:10px;height:10px;border-radius:50%;display:inline-block;margin-right:6px;">
                            </span>
                            P - Present
                        </div>
                        <div class="legend-item">
                            <span class="legend-color"
                                  style="background:#dc3545; width:10px;height:10px;border-radius:50%;display:inline-block;margin-right:6px;">
                            </span>
                            A - Absent
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
    <% if(selectedClass != null && !selectedClass.isEmpty()) { %>
        <% if(!students.isEmpty()) { %>
        <table class="table table-sm table-hover attendance-table">
            <thead class="table-light">
                <tr>
                    <th>S.No</th>
                    <th>Class</th>
                    <th>Student (Admin No)</th>
                    <th>Phone</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody id="tableBody">
            <% int i=1; for(Map<String,String> st : students){ %>
            <tr data-admin-no="<%=st.get("admin_no")%>">
                <td><%=i++%></td>
                <td><%=st.get("class")%></td>
                <td data-label="Student"><%=st.get("name")%> (<%=st.get("admin_no")%>)</td>
                <td><%=st.get("phone")%></td>
                <td>
                    <div class="radio-group small">
                        <input type="radio" name="status_<%=st.get("admin_no")%>" value="P" checked hidden>
                        <label onclick="this.previousElementSibling.checked=true; updateStatus(this);"
                               class="btn btn-sm btn-outline-success p-1">P</label>
                        <input type="radio" name="status_<%=st.get("admin_no")%>" value="A" hidden>
                        <label onclick="this.previousElementSibling.checked=true; updateStatus(this);"
                               class="btn btn-sm btn-outline-danger p-1">A</label>
                    </div>
                </td>
            </tr>
            <% } %>
            </tbody>
        </table>
        <button type="button" id="reviewBtn"
                class="btn btn-primary btn-sm review-btn"
                onclick="openAbsenteeModal()">
            Review Absentees & Details
        </button>
        <% } else { %>
            <p class="text-center text-warning small">No students found.</p>
        <% } %>
    <% } %>
</div>
<!-- ABSENTEE MODAL -->
<div class="modal fade" id="absenteeModal" data-bs-backdrop="static" data-bs-keyboard="false">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Absent Student Details</h5>
                <button class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <div id="absenteeForms"></div>
            </div>
            <div class="modal-footer">
                <button class="btn btn-secondary btn-sm" data-bs-dismiss="modal">Cancel</button>
                <button class="btn btn-primary btn-sm" onclick="generatePreview()">Next → Preview</button>
            </div>
        </div>
    </div>
</div>
<!-- PREVIEW MODAL -->
<div class="modal fade" id="previewModal" data-bs-backdrop="static" data-bs-keyboard="false">
    <div class="modal-dialog modal-xl">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Attendance Preview</h5>
                <button class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <table class="table table-sm preview-table">
                    <thead>
                        <tr>
                            <th>Student</th>
                            <th>Status</th>
                            <th>Type</th>
                            <th>Reason</th>
                            <th>Document</th>
                        </tr>
                    </thead>
                    <tbody id="previewBody"></tbody>
                </table>
            </div>
            <div class="modal-footer">
                <button class="btn btn-secondary btn-sm" onclick="openAbsenteeModal()">← Edit</button>
                <button class="btn btn-success btn-sm" onclick="saveAllAttendance()">Confirm & Save</button>
            </div>
        </div>
    </div>
</div>
<!-- FOOTER -->
<footer class="footer bg-dark text-white py-3 mt-auto">
    <div class="container text-center small">
        SAS School © 2025 — All Rights Reserved
    </div>
</footer>


<!-- Toast Container for Notifications -->

<!-- Bootstrap Icons -->
<!-- SCRIPTS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
<script src="../js/class-attendance-insertion.js"></script>
<script>
$("#classSelect").select2();
$("#classSelect").on("change", () => $("#classForm").submit());
// Set the application context path from server side
// This is the most reliable way to get the correct context path
window.contextPath = '<%= request.getContextPath() %>';
console.log("Server Context Path:", window.contextPath);

//Set environment variables
window.APP_CONFIG = {
    isLocal: window.location.hostname === 'localhost' || 
             window.location.hostname === '127.0.0.1' ||
             window.location.hostname.includes('192.168.'),
    contextPath: '<%= request.getContextPath() %>',
    requestURI: '<%= request.getRequestURI() %>'
};

console.log("App Config:", window.APP_CONFIG);

</script>
</body>
</html>