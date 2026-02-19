<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    // Prevent caching
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

    // Get session attributes
    String displayName = (String) session.getAttribute("adminName");
    String role = (String) session.getAttribute("Roles");
    String admissionNo = (String) session.getAttribute("admissionNo");

    // Redirect if not logged in
    if (displayName == null || role == null) {
        response.sendRedirect(request.getContextPath() + "/AdminLogin.jsp");
        return;
    }

    // Extract first name
    String userName = "";
    for(int i = 0; i < displayName.length(); i++) {
        char ch = displayName.charAt(i);
        if(ch == ' ') break;
        else userName += ch;
    }
    
    // Get base path dynamically
    String basePath = request.getContextPath();
    String currentPage = request.getRequestURI();
    boolean isRoot = currentPage.equals(request.getContextPath() + "/") || 
                     currentPage.endsWith("home.jsp");
    
    // Normalize role (remove quotes, trim, handle case)
    String normalizedRole = role.replace("\"", "").trim();
%>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark px-4">
  <div class="container-fluid">
    <div class="d-flex align-items-center">
      <img src="https://img.pikbest.com/png-images/20241026/simple-useful-bright-sun-and-cloud-logo-a-clear-sky-icon-design-vector_11001223.png!sw800" 
           alt="SAS Logo" style="height: 40px; margin-right: 10px;">
      <a class="navbar-brand mb-0" href="<%= basePath %>/home.jsp">SAS School</a>
    </div>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
      <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarNav">
      <!-- Left side nav items -->
      <ul class="navbar-nav me-auto">
        <li class="nav-item">
          <a class="nav-link <%= isRoot ? "active" : "" %>" href="<%= basePath %>/home.jsp">Home</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="<%= basePath %>/about.jsp">About Us</a>
        </li>

        <!-- Students Dropdown (Admin/Channel Admin only) -->
        <li class="nav-item dropdown hideFunction" data-roles="ADMIN,CHANNEL_ADMIN">
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">Students</a>
          <ul class="dropdown-menu">
            <li><a class="dropdown-item" href="<%= basePath %>/studentdetails.jsp">Student Details</a></li>
            <li><a class="dropdown-item" href="<%= basePath %>/allStudents.jsp">Student Payment Info</a></li>
            <li><a class="dropdown-item" href="<%= basePath %>/BillingPage.jsp">Student Fee Payment</a></li>
            <li><a class="dropdown-item" href="<%= basePath %>/studentreg.jsp">Create Student Details</a></li>
            <li><a class="dropdown-item" href="<%= basePath %>/create-class.jsp">Create Class</a></li>
            <li><a class="dropdown-item" href="<%= basePath %>/bulkimporting.jsp">Create Bulk</a></li>
            <li><a class="dropdown-item" href="<%= basePath %>/newupdates.jsp">Update Student Details</a></li>
          </ul>
        </li>

        <!-- Payments Dropdown (Admin/Channel Admin only) -->
        <li class="nav-item dropdown hideFunction" data-roles="ADMIN,CHANNEL_ADMIN">
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">Payments</a>
          <ul class="dropdown-menu">
            <li><a class="dropdown-item" href="<%= basePath %>/allpayments.jsp">All Payment Details</a></li>
            <li><a class="dropdown-item" href="<%= basePath %>/apbme.jsp">Payment By Admin</a></li>
            <li><a class="dropdown-item" href="<%= basePath %>/paymentdetails.jsp">All Payment Status</a></li>
          </ul>
        </li>

        <!-- Explore Dropdown -->
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">Explore</a>
          <ul class="dropdown-menu">
            <li><a class="dropdown-item" href="<%= basePath %>/addAnnouncement.jsp">Announcements</a></li>
            <li><a class="dropdown-item" href="#">360° View</a></li>
            <li><a class="dropdown-item" href="#">Videos</a></li>
            <li><a class="dropdown-item" href="<%= basePath %>/images.jsp">Images</a></li>
          </ul>
        </li>

        <!-- Other Links -->
        <li class="nav-item hideFunction" data-roles="ADMIN,CHANNEL_ADMIN">
          <a class="nav-link" href="<%= basePath %>/fee-notifications.jsp">Send Notifications</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="<%= basePath %>/contact.jsp">Contact Us</a>
        </li>
      </ul>

      <!-- Right Side -->
      <div class="ms-lg-auto mt-3 mt-lg-0
            d-flex flex-column flex-lg-row
            align-items-start align-items-lg-center
            gap-2">

        <!-- Hello User -->
        <span class="text-white fw-semibold">
          Hello, <%= userName %>
        </span>

        <!-- Role Display (Instead of Roles Dropdown) -->
        <div class="role-display-container">
          <!-- Show actual role as badge -->
          <span class="badge 
            <% if (normalizedRole.equalsIgnoreCase("ADMIN")) { %>bg-danger
            <% } else if (normalizedRole.equalsIgnoreCase("CHANNEL_ADMIN")) { %>bg-warning text-dark
            <% } else if (normalizedRole.equalsIgnoreCase("FACULTY")) { %>bg-info
            <% } else if (normalizedRole.equalsIgnoreCase("STUDENT")) { %>bg-success
            <% } else { %>bg-secondary<% } %> 
            role-badge">
            <%= normalizedRole.toUpperCase().replace("_", " ") %>
          </span>
          
          <!-- Roles Dropdown (only for ADMIN) -->
          <% if (normalizedRole.equalsIgnoreCase("ADMIN")) { %>
          <div class="dropdown d-inline-block ms-2">
            <button class="btn btn-sm btn-outline-light dropdown-toggle"
                    data-bs-toggle="dropdown">
              Switch
            </button>
            <ul class="dropdown-menu dropdown-menu-end">
              <li><a class="dropdown-item" href="<%= basePath %>/home.jsp">Channel Admin</a></li>
              <li><a class="dropdown-item" href="<%= basePath %>/students.jsp">Student</a></li>
              <li><a class="dropdown-item" href="<%= basePath %>/faculty/faculty.jsp">Faculty</a></li>
            </ul>
          </div>
          <% } %>
        </div>

        <!-- Auth Buttons -->
        <div class="d-flex flex-column flex-lg-row gap-2 mt-2 mt-lg-0">
          <a class="btn btn-outline-light btn-sm" href="<%= basePath %>/AdminLogin.jsp">Logout</a>
          <a class="btn btn-outline-warning btn-sm hideFunction" 
             href="<%= basePath %>/createaccount.jsp" 
             data-roles="ADMIN,CHANNEL_ADMIN">Signup</a>
        </div>
      </div>
    </div>
  </div>
</nav>

<!-- Store role data for JavaScript -->
<script>
  // Set global variables with context path
  window.contextPath = '<%= basePath %>';
  window.userRole = '<%= normalizedRole %>';
  window.userAdmissionNo = '<%= admissionNo != null ? admissionNo.replace("\"", "\\\"") : "" %>';
  
  // Debug log
  console.log("User Role from JSP:", '<%= normalizedRole %>');
</script>
 <script src="js/roleControl.js"></script>

<style>
.role-badge {
  font-size: 0.75rem;
  padding: 0.25rem 0.5rem;
  margin-left: 0.5rem;
}
.role-display-container {
  display: flex;
  align-items: center;
}


</style>