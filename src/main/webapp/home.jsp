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
  <style>
    body {
      font-family: 'Segoe UI', sans-serif;
      margin: 0;
      padding-top: 70px; /* space for fixed navbar */
      padding-bottom: 80px; /* space for fixed footer */
    }

    /* Fixed navbar */
    .navbar {
      position: fixed;
      top: 0;
      width: 100%;
      z-index: 1030;
    }

    /* Fixed footer */
    .footer {
      position: fixed;
      bottom: 0;
      width: 100%;
      background-color: #343a40;
      color: white;
      padding: 10px 0;
      font-size: 0.9rem;
    }

    .footer a {
      color: #ffc107;
      text-decoration: none;
    }

    /* Responsive Carousel height */
    .carousel-container {
      width: 80vw;
      height: calc(80vw * 0.3); /* 30% of width */
      margin: auto;
      overflow: hidden;
    }

    .carousel-container img {
      width: 100%;
      height: 100%;
      object-fit: cover;
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
            <li><a class="dropdown-item" href="allStudents.jsp">All Student Info</a></li>
            <li><a class="dropdown-item" href="BillingPage.jsp">Student Fee Payment</a></li>
            <li><a class="dropdown-item" href="#">Create Student Details</a></li>
            <li><a class="dropdown-item" href="bulkimporting.jsp">Create Bulk</a></li>
            <li><a class="dropdown-item" href="#">Update Student Details</a></li>
          </ul>
        </li>
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">Payments</a>
          <ul class="dropdown-menu">
            <li><a class="dropdown-item" href="#">All Payment Details</a></li>
            <li><a class="dropdown-item" href="apbme.jsp">Admin Payment</a></li>
          </ul>
        </li>
        <li class="nav-item"><a class="nav-link" href="#">Contact Us</a></li>
        <li class="nav-item"><a class="nav-link" href="#">About Us</a></li>
      </ul>

      <!-- Right side Login and Signup buttons -->
      <div class="d-flex">
        <a class="btn btn-outline-light me-2" href="#">Login</a>
        <a class="btn btn-outline-warning" href="#">Signup</a>
      </div>
    </div>
  </div>
</nav>

<!-- Carousel -->
<div class="carousel-container my-4">
  <div id="schoolCarousel" class="carousel slide h-100" data-bs-ride="carousel">
    <div class="carousel-inner h-100">
      <div class="carousel-item active h-100">
        <img src="https://images.lifestyleasia.com/wp-content/uploads/2018/07/13104131/Stowe-School-in-Buckinghamshire.jpg" class="d-block w-100" alt="School 1">
      </div>
      <div class="carousel-item h-100">
        <img src="https://images.unsplash.com/photo-1577896851231-70ef18881754?auto=format&fit=crop&w=1400&q=80" class="d-block w-100" alt="School 2">
      </div>
      <div class="carousel-item h-100">
        <img src="https://images.unsplash.com/photo-1571260899304-425eee4c7efc?auto=format&fit=crop&w=1400&q=80" class="d-block w-100" alt="School 3">
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

<!-- Footer -->
<footer class="footer">
  <div class="container">
    <div class="row text-center text-md-start">
      <div class="col-md-4">
        <strong>Contact</strong><br />
        Email: contact@sasschool.edu<br />
        Phone: +1 123 456 7890
      </div>
      <div class="col-md-4">
        <strong>About</strong><br />
        <a href="#">Our Story</a><br />
        <a href="#">Privacy Policy</a>
      </div>
      <div class="col-md-4">
        <strong>Address</strong><br />
        123 Learning Lane<br />
        Education City, Country
      </div>
    </div>
  </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
    