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
    <!-- BOOTSTRAP -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Select2 -->
    <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet"/>
    <!-- OUR CSS -->
    <link href="../css/class-attendance-insertion.css" rel="stylesheet">
    <link href="../student-profile.css" rel="stylesheet">
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
<nav class="navbar navbar-expand-lg navbar-dark bg-dark px-4 shadow-sm">
  <div class="container-fluid">
    <!-- LOGO -->
    <a class="navbar-brand d-flex align-items-center" href="../home.jsp">
        <img src="https://img.pikbest.com/png-images/20241026/simple-useful-bright-sun-and-cloud-logo-a-clear-sky-icon-design-vector_11001223.png!sw800"
             style="height:40px;margin-right:10px;">
        SAS School
    </a>
    <button class="navbar-toggler" data-bs-toggle="collapse" data-bs-target="#navbarNav">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
      <!-- LEFT MENU -->
      <ul class="navbar-nav me-auto">
        <li class="nav-item"><a class="nav-link" href="../home.jsp">Home</a></li>
        <li class="nav-item"><a class="nav-link" href="../about.jsp">About Us</a></li>
        <!-- STUDENTS -->
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" data-bs-toggle="dropdown">Students</a>
          <ul class="dropdown-menu">
            <li><a class="dropdown-item" href="../studentdetails.jsp">Student Details</a></li>
            <li><a class="dropdown-item" href="../allStudents.jsp">Student Payment Info</a></li>
            <li><a class="dropdown-item" href="../BillingPage.jsp">Fee Payment</a></li>
            <li><a class="dropdown-item" href="../studentreg.jsp">Create Student</a></li>
            <li><a class="dropdown-item" href="../create-class.jsp">Create Class</a></li>
            <li><a class="dropdown-item" href="../bulkimporting.jsp">Bulk Import</a></li>
            <li><a class="dropdown-item" href="../newupdates.jsp">Update Student</a></li>
          </ul>
        </li>
        <!-- PAYMENTS -->
        <li class="nav-item dropdown" id="hideFunction">
          <a class="nav-link dropdown-toggle" data-bs-toggle="dropdown">Payments</a>
          <ul class="dropdown-menu">
            <li><a class="dropdown-item" href="../allpayments.jsp">All Payment Details</a></li>
            <li><a class="dropdown-item" href="../apbme.jsp">Payment By Admin</a></li>
            <li><a class="dropdown-item" href="../paymentdetails.jsp">Payment Status</a></li>
          </ul>
        </li>
        <!-- Notifications -->
        <li class="nav-item" id="hideFunction">
          <a class="nav-link" href="../fee-notifications.jsp">Send Notifications</a>
        </li>
      </ul>
      <!-- RIGHT SIDE -->
      <div class="d-flex align-items-center gap-3">
          <span class="text-white fw-semibold">Hello, <%= firstName %></span>
          <a href="../AdminLogin.jsp" class="btn btn-outline-light btn-sm">Logout</a>
          <a href="../createaccount.jsp" class="btn btn-outline-warning btn-sm">Signup</a>
      </div>
    </div>
  </div>
</nav>
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
<!-- SCRIPTS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
<script src="../js/class-attendance-insertion.js"></script>
<script>
$("#classSelect").select2();
$("#classSelect").on("change", () => $("#classForm").submit());
</script>
</body>
</html>