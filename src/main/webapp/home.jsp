<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>School Management Home</title>
  <link rel="icon" href="https://cdn-icons-png.flaticon.com/512/2132/2132732.png" type="image/x-icon">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <style>
    body {
      font-family: 'Segoe UI', sans-serif;
      margin: 0;
      padding-top: 70px;
      padding-bottom: 0;
    }
 
    /* Navbar */
    .navbar {
      position: fixed;
      top: 0;
      width: 100%;
      z-index: 1030;
      font-size: 0.9rem; /* Smaller font */
      height: 52px;
    }
 
    .navbar-nav .nav-link {
      padding: 6px 12px;
    }

    
.carousel-inner,
.carousel-item {
    width: 100%;
    height: 350px; /* or whatever height you want */
    position: relative;
    overflow: hidden;
}

video,
.carousel-item img {
    width: 100%;
    height: 100%;
    object-fit: cover;
    object-position: center center;
    display: block;
    min-height: 100%;
    min-width: 100%;
}
.announcement-bar {
    background: linear-gradient(90deg, #e3f2fd, #bbdefb);
    color: #0d47a1;
    padding: 0px;
    font-size: 16px;
    font-weight: 500;
    border-bottom: 1px solid #90caf9;
    text-align: center;
}

.announcement-bar marquee {
    font-size: 16px;
    letter-spacing: 0.5px;
    color: #0d47a1;
}

  </style>
  <link href="./student-profile.css" rel="stylesheet">
</head>
<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark px-4">
  <div class="container-fluid">
    <div class="d-flex align-items-center">
      <img src="https://img.pikbest.com/png-images/20241026/simple-useful-bright-sun-and-cloud-logo-a-clear-sky-icon-design-vector_11001223.png!sw800" alt="SAS Logo" 
      style="height: 40px; margin-right: 10px;" href="home.jsp">
      <a class="navbar-brand mb-0" href="home.jsp">SAS School</a>
    </div>
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
    String role = (String)session.getAttribute("Roles");
    String admissionNo = (String)session.getAttribute("admissionNo");

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


    //System.out.println(role);
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
            <li><a class="dropdown-item" href="home.jsp">Channel Admin</a></li>
            <li><a class="dropdown-item" href="home.jsp">Student</a></li>
            <li><a class="dropdown-item" href="./faculty/faculty.jsp">Faculty</a></li>
        </ul>
    </div>

    <!-- Auth Buttons (ALWAYS UNDER Roles in mobile) -->
    <div class="d-flex flex-column flex-lg-row gap-2 mt-2 mt-lg-0">
        <a class="btn btn-outline-light btn-sm" href="AdminLogin.jsp">Logout</a>
        <a class="btn btn-outline-warning btn-sm" href="createaccount.jsp">Signup</a>
    </div>

</div>

    </div>
  </div>
</nav>
 <!-- marquee -->
 <div class="announcement-bar">
  <marquee behavior="scroll" direction="left" scrollamount="6">
    📢 Welcome to Bright Future High School — Latest Announcements:  
    <a href="announcement.jsp" style="color:#0d47a1; text-decoration:none; font-weight:600;">
        Admission Open 2025
    </a>
    |
    <a href="announcement.jsp" style="color:#0d47a1; text-decoration:none; font-weight:600;">
        Annual Sports Meet on 12th December
    </a>
    |
    <a href="announcement.jsp" style="color:#0d47a1; text-decoration:none; font-weight:600;">
        Fee Payment Portal Updated
    </a>
    |
    <a href="announcement.jsp" style="color:#0d47a1; text-decoration:none; font-weight:600;">
        Parent–Teacher Meeting on Friday
    </a>
    |
    <a href="announcement.jsp" style="color:#0d47a1; text-decoration:none; font-weight:600;">
        New Computer Lab Inauguration
    </a>
</marquee>

</div>
 
 
<!-- Carousel -->
<div class="carousel-container my-4">
  <div id="schoolCarousel" class="carousel slide h-100" data-bs-ride="carousel">

    <div class="carousel-inner h-100">

      <div class="carousel-item active h-100">
        <video class="d-block w-600 h-100" autoplay muted loop playsinline>
          <source src="images/20251120-1902-27.8452048.mp4" type="video/mp4">
        </video>
      </div>

      <div class="carousel-item h-100">
        <img src="https://images.unsplash.com/photo-1577896851231-70ef18881754?auto=format&fit=crop&w=1400&q=80" 
             class="d-block w-100" alt="School 2">
      </div>

      <div class="carousel-item h-100">
        <img src="https://images.unsplash.com/photo-1571260899304-425eee4c7efc?auto=format&fit=crop&w=1400&q=80" 
             class="d-block w-100" alt="School 3">
      </div>

    </div>

    <button class="carousel-control-prev" type="button" data-bs-target="#schoolCarousel" data-bs-slide="prev">
      <span class="carousel-control-prev-icon"></span>
    </button>

    <button class="carousel-control-next" type="button" data-bs-target="#schoolCarousel" data-bs-slide="next">
      <span class="carousel-control-next-icon"></span>
    </button>

  </div>
</div>

<div class="container my-5 text-center">
  <h2>Welcome to SAS School</h2>
  <p class="lead">Empowering Students for a Brighter Future</p>
</div>
 
<!-- Info Cards -->
<div class="container my-4">
  <div class="row text-center">
    <div class="col-md-4">
      <a href="students.jsp" style="text-decoration: none;">
        <div class="card shadow p-3">
          <img src="https://cdn-icons-png.flaticon.com/512/3135/3135768.png" class="card-img-top w-25 mx-auto my-2" alt="Students">
          <div class="card-body">
            <h5 class="card-title">Students</h5>
            <p class="card-text">Track progress, manage fees, and explore academic resources.</p>
          </div>
        </div>
      </a>
    </div>
    <div class="col-md-4">
      <a href="faculty/faculty.jsp" style="text-decoration: none;">
        <div class="card shadow p-3">
          <img src="https://cdn-icons-png.flaticon.com/512/1828/1828884.png" class="card-img-top w-25 mx-auto my-2" alt="Faculty">
          <div class="card-body">
            <h5 class="card-title">Faculty</h5>
            <p class="card-text">Experienced mentors guiding every student’s journey.</p>
          </div>
        </div>
      </a>
    </div>
    <div class="col-md-4">
      <div class="card shadow p-3">
        <img src="https://cdn-icons-png.flaticon.com/512/3703/3703273.png" class="card-img-top w-25 mx-auto my-2" alt="Facilities">
        <div class="card-body">
          <h5 class="card-title">Facilities</h5>
          <p class="card-text">State-of-the-art infrastructure and learning environment.</p>
        </div>
      </div>
    </div>
  </div>
</div>
 
<!-- Vision & Mission -->
<div class="container my-5">
  <div class="row">
    <div class="col-md-6">
      <h3>Our Vision</h3>
      <p>To foster a nurturing and innovative learning environment that encourages every student to thrive intellectually and emotionally.</p>
    </div>
    <div class="col-md-6">
      <h3>Our Mission</h3>
      <p>We aim to provide high-quality education, instill strong values, and prepare students for global citizenship and lifelong success.</p>
    </div>
  </div>
</div>
 
<!-- Stats Section -->
<div class="container text-center my-5">
  <div class="row">
    <div class="col">
      <h2 id="students">1200+</h2>
      <p>Students Enrolled</p>
    </div>
    <div class="col">
      <h2 id="teachers">80+</h2>
      <p>Dedicated Teachers</p>
    </div>
    <div class="col">
      <h2 id="years">25+</h2>
      <p>Years of Excellence</p>
    </div>
  </div>
</div>
 
<!-- Footer -->
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
<script>
document.addEventListener("DOMContentLoaded", function () {
    const video = document.querySelector("#schoolCarousel video");
    const carousel = document.querySelector("#schoolCarousel");
    let firstLoopDone = false;

    video.addEventListener("timeupdate", function () {
        if (!firstLoopDone && (video.currentTime / video.duration) > 0.95) {
            firstLoopDone = true;

            // After first full video loop → enable auto slide
            const bsCarousel = bootstrap.Carousel.getInstance(carousel);
            bsCarousel.cycle();
        }
    });
});

  window.userRole = "<%= role.replace("\"", "\\\"") %>";
  window.admissionNo = "<%= admissionNo.replace("\"", "\\\"") %>";
  console.log("User role:", window.userRole);
  
  window.addEventListener("load", function () {
      setTimeout(() => {
          document.getElementById("sun-loader").style.display = "none";
      }, 2000); // 4 seconds
  });

  
  window.addEventListener("load", function() {
      setTimeout(() => {
          document.getElementById("sun-loader").style.display = "none";
      }, 1200); // fade delay
  });

</script>

 <script src="js/roleControl.js"></script>
 
</body>
</html>