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
    /* Fixed navbar */
    .navbar {
      position: fixed;
      top: 0;
      width: 100%;
      z-index: 1030;
    }

    /* Fixed footer */
   .footer {
  margin-bottom: 0;
  padding-bottom: 0;
}
      .col-md-4:hover {
            transform: scale(1.03);
            
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

   .carousel-inner img {
    width: 100%;
    height: 450px;
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

<div class="container my-5">
    <div class="text-center">
        <h2>Welcome to SAS School</h2>
        <p class="lead">Empowering Students for a Brighter Future</p>
    </div>
</div>

<!-- Info Cards -->
<div class="container my-4">
    <div class="row text-center">
        <div class="col-md-4">
           <a href="students.jsp" style="text-decoration: none;">  <div class="card shadow p-3">
                <img src="https://cdn-icons-png.flaticon.com/512/3135/3135768.png" class="card-img-top w-25 mx-auto my-2" alt="Students">
                 <div class="card-body">
                    <h5 class="card-title">Students</h5>
                    <p class="card-text">Track progress, manage fees, and explore academic resources.</p>
                </div>
            </div>  </a>
        </div>
        <div class="col-md-4">
        <a href="allStudents.jsp" style="text-decoration: none;">
            <div class="card shadow p-3">
                <img src="https://cdn-icons-png.flaticon.com/512/1828/1828884.png" class="card-img-top w-25 mx-auto my-2" alt="Faculty">
                <div class="card-body">
                    <h5 class="card-title">Faculty</h5>
                    <p class="card-text">Experienced mentors guiding every student’s journey.</p>
                </div>
            </div> </a>
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
    <footer class="footer bg-dark text-white py-4" id = "footer">
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

</body>
</html>
    