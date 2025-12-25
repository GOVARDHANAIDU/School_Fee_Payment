<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SAS School - Empowering Minds for a Brighter Tomorrow</title>
    <link rel="icon" href="https://img.pikbest.com/png-images/20241026/simple-useful-bright-sun-and-cloud-logo-a-clear-sky-icon-design-vector_11001223.png!sw800" type="image/x-icon"> <!-- Replace with your SAS logo -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="home.css" rel="stylesheet">
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg fixed-top navbar-enhanced" data-animate="true">
        <div class="container">
            <a class="navbar-brand" href="#home">
                <img src="https://img.pikbest.com/png-images/20241026/simple-useful-bright-sun-and-cloud-logo-a-clear-sky-icon-design-vector_11001223.png!sw800" alt="SAS School Logo" class="logo"> <!-- Replace with your SAS logo -->
                <span class="brand-text">SAS School</span>
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item"><a class="nav-link" href="#home"><i class="fas fa-home me-1"></i>Home</a></li>
                    <li class="nav-item"><a class="nav-link" href="#academics"><i class="fas fa-graduation-cap me-1"></i>Academics</a></li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#activities" role="button" data-bs-toggle="dropdown">
                            <i class="fas fa-running me-1"></i>Activities
                        </a>
                        <ul class="dropdown-menu dropdown-menu-end animate-dropdown">
                            <li><a class="dropdown-item" href="#sports">Sports</a></li>
                            <li><a class="dropdown-item" href="#arts">Arts & Culture</a></li>
                            <li><a class="dropdown-item" href="#clubs">Clubs</a></li>
                        </ul>
                    </li>
                    <li class="nav-item"><a class="nav-link" href="#gallery"><i class="fas fa-images me-1"></i>Gallery</a></li>
                    <li class="nav-item"><a class="nav-link" href="#contact"><i class="fas fa-envelope me-1"></i>Contact</a></li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#about" role="button" data-bs-toggle="dropdown">
                            <i class="fas fa-info-circle me-1"></i>About
                        </a>
                        <ul class="dropdown-menu dropdown-menu-end animate-dropdown">
                            <li><a class="dropdown-item" href="#vision">Vision & Mission</a></li>
                            <li><a class="dropdown-item" href="#team">Our Team</a></li>
                            <li><a class="dropdown-item" href="#history">History</a></li>
                        </ul>
                    </li>
                    <li class="nav-item"><a class="nav-link btn-login" target="blank" href="../AdminLogin.jsp"><i class="fas fa-sign-in-alt me-1"></i>Login</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Hero Section -->
    <section id="home" class="hero">
        <div class="hero-overlay">
            <div class="container text-center">
                <h1 class="hero-title animate-fade-in">Welcome to SAS School</h1>
                <p class="hero-subtitle animate-fade-in-delay">Providing Quality Education for a Brighter Future</p>
                <div class="hero-buttons animate-fade-in-delay2">
                    <a href="#about" class="btn btn-primary btn-lg me-3">Learn More</a>
                    <a href="admissions.jsp" class="btn btn-outline-light btn-lg">Admissions Open</a>
                </div>
            </div>
        </div>
        <div class="hero-image">
            <img src="https://img.pikbest.com/png-images/20241026/simple-useful-bright-sun-and-cloud-logo-a-clear-sky-icon-design-vector_11001223.png!sw800" alt="School Campus" class="img-fluid"> <!-- Replace with your hero image -->
        </div>
    </section>

    <!-- Announcement Bar -->
    <div class="announcement-bar">
        <div class="container">
            <marquee behavior="scroll" direction="left">
                <i class="fas fa-bullhorn me-2"></i>
                Latest Updates: Admissions Open for 2026 | Annual Sports Day on Jan 15 | New STEM Lab Inaugurated | Parent-Teacher Meet Scheduled
            </marquee>
        </div>
    </div>

    <!-- About Section -->
    <section id="about" class="about py-5">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-6">
                    <img src="assets/about-image.jpg" alt="About SAS School" class="img-fluid rounded shadow"> <!-- Replace with your image -->
                </div>
                <div class="col-lg-6">
                    <h2 class="section-title">Our Vision</h2>
                    <p class="lead">At SAS School, our vision is to create an inspiring learning environment where students are encouraged to think critically, act ethically, and grow holistically to become global citizens of tomorrow.</p>
                    <h5 class="mt-4">Our Mission</h5>
                    <p>We are committed to delivering exceptional education that nurtures creativity, fosters innovation, and builds character for lifelong success.</p>
                    <div class="row mt-4">
                        <div class="col-md-6">
                            <div class="stat-card">
                                <i class="fas fa-users fa-2x text-primary"></i>
                                <h3>1500+</h3>
                                <p>Students Enrolled</p>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="stat-card">
                                <i class="fas fa-chalkboard-teacher fa-2x text-primary"></i>
                                <h3>100+</h3>
                                <p>Expert Faculty</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Academics Section -->
    <section id="academics" class="academics py-5 bg-light">
        <div class="container">
            <h2 class="section-title text-center mb-5">Academic Excellence</h2>
            <div class="row g-4">
                <div class="col-md-4">
                    <div class="card h-100 shadow border-0">
                        <div class="card-body text-center">
                            <i class="fas fa-graduation-cap fa-3x text-primary mb-3"></i>
                            <h5>Curriculum</h5>
                            <p>CBSE-aligned curriculum with focus on holistic development and modern skills.</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card h-100 shadow border-0">
                        <div class="card-body text-center">
                            <i class="fas fa-book-open fa-3x text-primary mb-3"></i>
                            <h5>Library</h5>
                            <p>State-of-the-art digital library with 10,000+ resources for research and reading.</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card h-100 shadow border-0">
                        <div class="card-body text-center">
                            <i class="fas fa-laptop-code fa-3x text-primary mb-3"></i>
                            <h5>STEM Labs</h5>
                            <p>Advanced labs for science, tech, engineering, and math explorations.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Activities Section -->
    <section id="activities" class="activities py-5">
        <div class="container">
            <h2 class="section-title text-center mb-5">Extracurricular Activities</h2>
            <div class="row g-4">
                <div class="col-md-6">
                    <div class="card h-100 shadow border-0">
                        <img src="assets/sports.jpg" alt="Sports" class="card-img-top"> <!-- Replace with your image -->
                        <div class="card-body">
                            <h5>Sports & Fitness</h5>
                            <p>Championship teams in cricket, football, and more. Promoting health and teamwork.</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="card h-100 shadow border-0">
                        <img src="assets/arts.jpg" alt="Arts" class="card-img-top"> <!-- Replace with your image -->
                        <div class="card-body">
                            <h5>Arts & Culture</h5>
                            <p>Theater, music, and dance programs to ignite creativity and expression.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Gallery Section -->
    <section id="gallery" class="gallery py-5 bg-light">
        <div class="container">
            <h2 class="section-title text-center mb-5">Gallery</h2>
            <div class="row g-3">
                <div class="col-md-4">
                    <img src="assets/gallery1.jpg" alt="Event 1" class="img-fluid rounded shadow" data-bs-toggle="modal" data-bs-target="#imageModal" onclick="openModal(this.src)">
                </div>
                <div class="col-md-4">
                    <img src="assets/gallery2.jpg" alt="Event 2" class="img-fluid rounded shadow" data-bs-toggle="modal" data-bs-target="#imageModal" onclick="openModal(this.src)">
                </div>
                <div class="col-md-4">
                    <img src="assets/gallery3.jpg" alt="Event 3" class="img-fluid rounded shadow" data-bs-toggle="modal" data-bs-target="#imageModal" onclick="openModal(this.src)">
                </div>
                <!-- Add more images as needed -->
            </div>
        </div>
    </section>

    <!-- Testimonials Section -->
    <section class="testimonials py-5">
        <div class="container">
            <h2 class="section-title text-center mb-5">What Our Community Says</h2>
            <div id="testimonialCarousel" class="carousel slide" data-bs-ride="carousel">
                <div class="carousel-inner">
                    <div class="carousel-item active">
                        <div class="row justify-content-center">
                            <div class="col-md-8 text-center">
                                <p class="lead">"SAS School transformed my child's learning journey with innovative teaching and caring staff."</p>
                                <h6>- Parent, Rajesh K.</h6>
                            </div>
                        </div>
                    </div>
                    <div class="carousel-item">
                        <div class="row justify-content-center">
                            <div class="col-md-8 text-center">
                                <p class="lead">"The best environment for holistic growth. Grateful for the opportunities provided."</p>
                                <h6>- Alumni, Priya S.</h6>
                            </div>
                        </div>
                    </div>
                    <!-- Add more testimonials -->
                </div>
                <button class="carousel-control-prev" type="button" data-bs-target="#testimonialCarousel" data-bs-slide="prev">
                    <span class="carousel-control-prev-icon"></span>
                </button>
                <button class="carousel-control-next" type="button" data-bs-target="#testimonialCarousel" data-bs-slide="next">
                    <span class="carousel-control-next-icon"></span>
                </button>
            </div>
        </div>
    </section>

    <!-- Contact Section -->
    <section id="contact" class="contact py-5 bg-light">
        <div class="container">
            <h2 class="section-title text-center mb-5">Get in Touch</h2>
            <div class="row">
                <div class="col-md-6">
                    <form id="contactForm">
                        <div class="mb-3">
                            <input type="text" class="form-control" placeholder="Your Name" required>
                        </div>
                        <div class="mb-3">
                            <input type="email" class="form-control" placeholder="Your Email" required>
                        </div>
                        <div class="mb-3">
                            <textarea class="form-control" rows="4" placeholder="Your Message" required></textarea>
                        </div>
                        <button type="submit" class="btn btn-primary">Send Message</button>
                    </form>
                </div>
                <div class="col-md-6">
                    <div class="contact-info">
                        <h5><i class="fas fa-map-marker-alt me-2"></i>Address</h5>
                        <p>123 Education Avenue, Learning City, IN 12345</p>
                        <h5><i class="fas fa-phone me-2"></i>Phone</h5>
                        <p>+91 123 456 7890</p>
                        <h5><i class="fas fa-envelope me-2"></i>Email</h5>
                        <p>info@sasschool.edu</p>
                        <div class="social-links mt-4">
                            <a href="#" class="me-3"><i class="fab fa-facebook fa-2x"></i></a>
                            <a href="#" class="me-3"><i class="fab fa-twitter fa-2x"></i></a>
                            <a href="#" class="me-3"><i class="fab fa-instagram fa-2x"></i></a>
                            <a href="#" class="me-3"><i class="fab fa-linkedin fa-2x"></i></a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer class="footer py-4">
        <div class="container text-center">
            <p>&copy; 2025 SAS School. All Rights Reserved. | <a href="#" class="text-light">Privacy Policy</a> | <a href="#" class="text-light">Terms of Service</a></p>
        </div>
    </footer>

    <!-- Image Modal -->
    <div class="modal fade" id="imageModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-body p-0">
                    <img id="modalImage" src="" alt="Gallery Image" class="img-fluid w-100">
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="home.js"></script>
</body>
</html>