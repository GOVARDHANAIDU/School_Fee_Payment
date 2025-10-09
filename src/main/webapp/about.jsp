<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>About Us - SAS School</title>
  <link rel="icon" href="https://cdn-icons-png.flaticon.com/512/2132/2132732.png" type="image/x-icon">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"> 
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <style>
    body {
      font-family: 'Segoe UI', sans-serif;
      margin: 0;
      padding-top: 70px;
      background-color: #f8f9fa;
    }

    /* Navbar */
    .navbar {
      position: fixed;
      top: 0;
      width: 100%;
      z-index: 1030;
      font-size: 0.9rem;
    }
    .navbar-brand {
      font-size: 1rem;
      font-weight: 600;
    }
    .navbar-nav .nav-link {
      padding: 6px 12px;
    }

    /* Hero Section */
    .hero {
      background: linear-gradient(rgba(0,0,0,0.6), rgba(0,0,0,0.6)),
                  url("https://images.unsplash.com/photo-1523240795612-9a054b0db644?auto=format&fit=crop&w=1400&q=80") no-repeat center center/cover;
      color: white;
      padding: 120px 20px;
      text-align: center;
    }
    .hero h1 {
      font-size: 2.8rem;
      font-weight: bold;
      color: #ffc107;
    }
    .hero p {
      font-size: 1.2rem;
      max-width: 700px;
      margin: auto;
    }

    /* Section Titles */
    .section-title {
      color: #343a40;
      font-weight: 700;
      margin-bottom: 20px;
      text-align: center;
    }

    /* Cards */
    .info-card {
      background: white;
      border-radius: 12px;
      padding: 30px;
      text-align: center;
      box-shadow: 0 4px 12px rgba(0,0,0,0.08);
      transition: transform 0.2s;
    }
    .info-card:hover {
      transform: scale(1.03);
    }
    .info-card h5 {
      margin-top: 15px;
      color: #ffc107;
      font-weight: bold;
    }

    /* Footer */
    .footer {
      background: #212529;
      color: white;
      padding: 30px 0;
      margin-top: 50px;
    }
    .footer a {
      color: #ffc107;
      text-decoration: none;
    }
  </style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark px-4">
  <div class="container-fluid">
    <a class="navbar-brand" href="home.jsp">SAS School</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
      <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav me-auto">
        <li class="nav-item"><a class="nav-link" href="home.jsp">Home</a></li>
                <li class="nav-item"><a class="nav-link active" href="aboutus.jsp">About Us</a></li>
        <li class="nav-item"><a class="nav-link" href="studentdetails.jsp">Students</a></li>
        <li class="nav-item"><a class="nav-link" href="allpayments.jsp">Payments</a></li>
        <li class="nav-item"><a class="nav-link" href="#">Contact Us</a></li>
      </ul>
      <a class="btn btn-outline-light btn-sm me-2" href="AdminLogin.jsp">Login</a>
      <a class="btn btn-outline-warning btn-sm" href="createaccount.jsp">Signup</a>
    </div>
  </div>
</nav>

<!-- Hero Section -->
<section class="hero">
  <h1>About SAS School</h1>
  <p>“Shaping bright minds, building strong values, and empowering future leaders.”</p>
</section>

<!-- Our Story -->
<div class="container my-5">
  <h2 class="section-title">Our Story</h2>
  <p class="text-center mx-auto" style="max-width: 800px;">
    SAS School was founded with the vision of creating a world-class learning environment
    where students are inspired to discover, innovate, and excel. With over 25 years of
    excellence in education, we remain dedicated to nurturing curiosity, creativity, and compassion.
  </p>
</div>

<!-- Motto and Values -->
<div class="container my-5">
  <div class="row g-4">
    <div class="col-md-4">
      <div class="info-card">
        <img src="https://cdn-icons-png.flaticon.com/512/3135/3135715.png" width="60" alt="Motto">
        <h5>Our Motto</h5>
        <p>“Knowledge with Integrity.” We believe education is meaningful only when it builds character alongside intellect.</p>
      </div>
    </div>
    <div class="col-md-4">
      <div class="info-card">
        <img src="https://cdn-icons-png.flaticon.com/512/1828/1828884.png" width="60" alt="Values">
        <h5>Our Core Values</h5>
        <p>Excellence, Integrity, Innovation, and Empathy form the backbone of our teaching philosophy and culture.</p>
      </div>
    </div>
    <div class="col-md-4">
      <div class="info-card">
        <img src="https://cdn-icons-png.flaticon.com/512/3703/3703273.png" width="60" alt="Why Us">
        <h5>Why Choose Us</h5>
        <p>We offer holistic development, modern facilities, skilled faculty, and personalized learning paths for every child.</p>
      </div>
    </div>
  </div>
</div>

<!-- Footer -->
<footer class="footer text-center">
  <div class="container">
    <p>&copy; 2025 SAS School | All Rights Reserved</p>
    <a href="#">Privacy Policy</a> | <a href="#">Terms & Conditions</a>
  </div>
</footer>

</body>
</html>
