<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SAS School - Empowering Minds for a Brighter Tomorrow</title>
    <link rel="icon" href="https://img.pikbest.com/png-images/20241026/simple-useful-bright-sun-and-cloud-logo-a-clear-sky-icon-design-vector_11001223.png!sw800" type="image/png">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@700&family=Montserrat:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link href="home.css" rel="stylesheet">
</head>
<body>

<div class="modal fade show" id="festivalModal" tabindex="-1" aria-hidden="true" data-bs-backdrop="static">
    <div class="modal-dialog modal-xl modal-dialog-centered">
        <div class="modal-content festival-popup">
            <button type="button" class="btn-close popup-close" data-bs-dismiss="modal" aria-label="Close"></button>
            <div class="row g-0 align-items-stretch">
                <div class="col-lg-6">
                    <div class="festival-bg-container">
                        <img id="festivalBg" src="" class="img-fluid festival-bg">
                        <div class="festival-text">
                            <h2 id="festivalTitle" class="festival-title"></h2>
                            <p class="festival-subtitle">Admissions Open 2026-27 | CBSE Curriculum | Limited Seats</p>
                            <div class="d-flex flex-wrap gap-3">
                                <a href="admissions.jsp" class="btn btn-enroll">Enroll Now</a>
                                <a href="#contact" class="btn btn-contact" data-bs-dismiss="modal">Contact Us</a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6">
                    <div class="achievers-section p-3 p-lg-4">
                        <h3 class="text-center mb-3 mb-lg-4 achievers-title">Our Top Achievers 2024-25</h3>
                        <div class="achievers-grid">
                            <!-- Student 1 -->
                            <div class="achiever-card">
                                <img src="https://images.unsplash.com/photo-1536922246289-88c42f957773?ixlib=rb-4.0.3&auto=format&fit=crop&w=300&q=80" class="achiever-img">
                                <div class="achiever-info">
                                    <h5 class="achiever-name">Rohan Sharma</h5>
                                    <p class="achiever-class">Class XII - Science</p>
                                    <div class="achiever-marks">98.2%</div>
                                </div>
                            </div>
                            
                            <!-- Student 2 -->
                            <div class="achiever-card">
                                <img src="https://images.unsplash.com/photo-1544725176-7c40e5a71c5e?ixlib=rb-4.0.3&auto=format&fit=crop&w=300&q=80" class="achiever-img">
                                <div class="achiever-info">
                                    <h5 class="achiever-name">Priya Patel</h5>
                                    <p class="achiever-class">Class XII - Commerce</p>
                                    <div class="achiever-marks">97.8%</div>
                                </div>
                            </div>
                            
                            <!-- Student 3 -->
                            <div class="achiever-card">
                                <img src="https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixlib=rb-4.0.3&auto=format&fit=crop&w=300&q=80" class="achiever-img">
                                <div class="achiever-info">
                                    <h5 class="achiever-name">Ananya Singh</h5>
                                    <p class="achiever-class">Class X</p>
                                    <div class="achiever-marks">100%</div>
                                </div>
                            </div>
                            
                            <!-- Student 4 -->
                            <div class="achiever-card">
                                <img src="https://images.unsplash.com/photo-1552058544-f2b08422138a?ixlib=rb-4.0.3&auto=format&fit=crop&w=300&q=80" class="achiever-img">
                                <div class="achiever-info">
                                    <h5 class="achiever-name">Arjun Kumar</h5>
                                    <p class="achiever-class">Class XI - Science</p>
                                    <div class="achiever-marks">96.5%</div>
                                </div>
                            </div>
                            
                            <!-- Student 5 -->
                            <div class="achiever-card">
                                <img src="https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.0.3&auto=format&fit=crop&w=300&q=80" class="achiever-img">
                                <div class="achiever-info">
                                    <h5 class="achiever-name">Sneha Reddy</h5>
                                    <p class="achiever-class">Class IX</p>
                                    <div class="achiever-marks">99.1%</div>
                                </div>
                            </div>
                            
                            <!-- Student 6 -->
                            <div class="achiever-card">
                                <img src="https://images.unsplash.com/photo-1544005313-94ddf0286df2?ixlib=rb-4.0.3&auto=format&fit=crop&w=300&q=80" class="achiever-img">
                                <div class="achiever-info">
                                    <h5 class="achiever-name">Kavya Gupta</h5>
                                    <p class="achiever-class">Class XII - Biology</p>
                                    <div class="achiever-marks">95.8%</div>
                                </div>
                            </div>
                            
                            <!-- Student 7 -->
                            <div class="achiever-card">
                                <img src="https://images.unsplash.com/photo-1508214751196-bcfd4ca60f91?ixlib=rb-4.0.3&auto=format&fit=crop&w=300&q=80" class="achiever-img">
                                <div class="achiever-info">
                                    <h5 class="achiever-name">Vikram Joshi</h5>
                                    <p class="achiever-class">Class X</p>
                                    <div class="achiever-marks">97.4%</div>
                                </div>
                            </div>
                            
                            <!-- Student 8 -->
                            <div class="achiever-card">
                                <img src="https://images.unsplash.com/photo-1552058544-f2b08422138a?ixlib=rb-4.0.3&auto=format&fit=crop&w=300&q=80" class="achiever-img">
                                <div class="achiever-info">
                                    <h5 class="achiever-name">Rahul Verma</h5>
                                    <p class="achiever-class">Class XI - Comp. Science</p>
                                    <div class="achiever-marks">98.0%</div>
                                </div>
                            </div>
                            
                            <!-- Student 9 -->
                            <div class="achiever-card">
                                <img src="https://images.unsplash.com/photo-1568602471122-7832951cc4c5?ixlib=rb-4.0.3&auto=format&fit=crop&w=300&q=80" class="achiever-img">
                                <div class="achiever-info">
                                    <h5 class="achiever-name">Neha Sharma</h5>
                                    <p class="achiever-class">Class VIII</p>
                                    <div class="achiever-marks">96.3%</div>
                                </div>
                            </div>
                            
                            <!-- Student 10 -->
                            <div class="achiever-card">
                                <img src="https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?ixlib=rb-4.0.3&auto=format&fit=crop&w=300&q=80" class="achiever-img">
                                <div class="achiever-info">
                                    <h5 class="achiever-name">Aditya Singh</h5>
                                    <p class="achiever-class">Class XII - Economics</p>
                                    <div class="achiever-marks">94.7%</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg fixed-top navbar-enhanced">
        <div class="container-fluid px-4">
            <a class="navbar-brand" href="#home">
                <img src="https://img.pikbest.com/png-images/20241026/simple-useful-bright-sun-and-cloud-logo-a-clear-sky-icon-design-vector_11001223.png!sw800" alt="SAS School Logo" class="logo">
                <span class="brand-text">SAS School</span>
            </a>
            
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto align-items-center">
                    <li class="nav-item">
                        <a class="nav-link active" href="#home">
                            <i class="fas fa-home me-2"></i>Home
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#academics">
                            <i class="fas fa-graduation-cap me-2"></i>Academics
                        </a>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#activities" role="button" data-bs-toggle="dropdown">
                            <i class="fas fa-running me-2"></i>Activities
                        </a>
                        <ul class="dropdown-menu dropdown-menu-end animate-dropdown">
                            <li><a class="dropdown-item" href="#sports">Sports</a></li>
                            <li><a class="dropdown-item" href="#arts">Arts & Culture</a></li>
                            <li><a class="dropdown-item" href="#clubs">Clubs</a></li>
                        </ul>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#gallery">
                            <i class="fas fa-images me-2"></i>Gallery
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#contact">
                            <i class="fas fa-envelope me-2"></i>Contact
                        </a>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#about" role="button" data-bs-toggle="dropdown">
                            <i class="fas fa-info-circle me-2"></i>About
                        </a>
                        <ul class="dropdown-menu dropdown-menu-end animate-dropdown">
                            <li><a class="dropdown-item" href="#vision">Vision & Mission</a></li>
                            <li><a class="dropdown-item" href="#team">Our Team</a></li>
                            <li><a class="dropdown-item" href="#history">History</a></li>
                        </ul>
                    </li>
                    <li class="nav-item ms-2">
                        <a class="nav-link btn-brochure" href="javascript:void(0)" onclick="downloadBrochure()">
                            <i class="fas fa-download me-2"></i>Brochure
                        </a>
                    </li>
                    <li class="nav-item ms-2">
                        <a class="nav-link btn-login" target="_blank" href="../AdminLogin.jsp">
                            <i class="fas fa-sign-in-alt me-2"></i>Login
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>


    <!-- Hero Section -->
    <section id="home" class="hero">
        <div class="hero-overlay">
            <div class="container">
                <div class="hero-content">
                    <h1 class="hero-title" id="typed-title"></h1>
                    <p class="hero-subtitle">Providing Quality Education for a Brighter Future</p>
                    <div class="chairman-message">
                        <div class="row align-items-center">
                            <div class="col-md-3 text-center mb-4 mb-md-0">
                                <img src="https://3vb.com/wp-content/uploads/2025/10/Gopal.Subramanium.jpg" alt="Dr. Rajesh Kumar, Chairman" class="chairman-img">
                            </div>
                            <div class="col-md-9">
                                <h4>Message from the Chairman</h4>
                                <p>"At SAS School, we are dedicated to nurturing young minds with knowledge, values, and innovation. Our vision is to empower every student to become a confident leader and responsible global citizen. Together, let us build a brighter tomorrow."</p>
                                <h6 class="text-end mt-3">- Dr. Rajesh Kumar, Chairman</h6>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="hero-logo-bg">
            <img src="https://img.pikbest.com/png-images/20241026/simple-useful-bright-sun-and-cloud-logo-a-clear-sky-icon-design-vector_11001223.png!sw800" alt="SAS School Logo Background" class="img-fluid">
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
    <section id="about" class="about py-5 hidden fade-from-left">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-6">
                    <h2 class="section-title">Our Vision & Mission</h2>
                    <p class="lead">At SAS School, our vision is to create an inspiring learning environment where students are encouraged to think critically, act ethically, and grow holistically to become global citizens of tomorrow.</p>
                    <p class="lead">We are committed to delivering exceptional education that nurtures creativity, fosters innovation, and builds character for lifelong success.</p>
                    <div class="row mt-5">
                        <div class="col-md-6 mb-4">
                            <div class="stat-card hidden fade-from-left">
                                <i class="fas fa-users"></i>
                                <h3>1500+</h3>
                                <p>Students Enrolled</p>
                            </div>
                        </div>
                        <div class="col-md-6 mb-4">
                            <div class="stat-card hidden fade-from-right">
                                <i class="fas fa-chalkboard-teacher"></i>
                                <h3>100+</h3>
                                <p>Expert Faculty</p>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6 text-center">
                    <img src="https://varthana.com/school/wp-content/uploads/2024/04/B869-School.jpg" alt="About SAS School Campus" class="img-fluid rounded shadow hidden fade-from-right">
                </div>
            </div>
        </div>
    </section>

    <!-- Our Team Popup Modal -->
<div class="modal fade" id="teamModal" tabindex="-1" aria-labelledby="teamModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-xl modal-dialog-centered modal-dialog-scrollable">
        <div class="modal-content team-popup">
            <div class="modal-header border-0 pb-0">
                <h2 class="modal-title team-title" id="teamModalLabel">Our Distinguished Team</h2>
                <button type="button" class="btn-close team-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <!-- Leadership Section -->
                <div class="team-section mb-5">
                    <h3 class="section-heading">Leadership</h3>
                    <div class="row justify-content-center">
                        <!-- Chairman -->
                        <div class="col-md-6 col-lg-4 mb-4">
                            <div class="team-card leadership-card">
                                <div class="team-img-container">
                                    <img src="https://3vb.com/wp-content/uploads/2025/10/Gopal.Subramanium.jpg" class="team-img">
                                    <div class="team-badge">Chairman</div>
                                </div>
                                <div class="team-info">
                                    <h4 class="team-name">Dr. Rajesh Kumar</h4>
                                    <p class="team-designation">Chairman & Founder</p>
                                    <p class="team-bio">Visionary leader with 25+ years in education reform and institution building.</p>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Principal -->
                        <div class="col-md-6 col-lg-4 mb-4">
                            <div class="team-card leadership-card">
                                <div class="team-img-container">
                                    <img src="https://images.unsplash.com/photo-1582750433449-648ed127bb54?ixlib=rb-4.0.3&auto=format&fit=crop&w=300&q=80" class="team-img">
                                    <div class="team-badge">Principal</div>
                                </div>
                                <div class="team-info">
                                    <h4 class="team-name">Mrs. Anjali Sharma</h4>
                                    <p class="team-designation">Principal</p>
                                    <p class="team-bio">PhD in Education with 20 years of academic leadership experience.</p>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Vice Principal -->
                        <div class="col-md-6 col-lg-4 mb-4">
                            <div class="team-card leadership-card">
                                <div class="team-img-container">
                                    <img src="https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?ixlib=rb-4.0.3&auto=format&fit=crop&w=300&q=80" class="team-img">
                                    <div class="team-badge">Vice Principal</div>
                                </div>
                                <div class="team-info">
                                    <h4 class="team-name">Mr. Sanjay Verma</h4>
                                    <p class="team-designation">Vice Principal</p>
                                    <p class="team-bio">M.Ed with specialization in curriculum development and student welfare.</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Faculty Section -->
                <div class="team-section">
                    <h3 class="section-heading">Faculty Members</h3>
                    <div class="row faculty-grid">
                        <!-- Science Faculty -->
                        <div class="col-md-6 mb-4">
                            <h4 class="department-heading">Science Department</h4>
                            <div class="row g-3">
                                <!-- Physics Teachers -->
                                <div class="col-12">
                                    <div class="faculty-card">
                                        <img src="https://images.unsplash.com/photo-1568602471122-7832951cc4c5?ixlib=rb-4.0.3&auto=format&fit=crop&w=300&q=80" class="faculty-img">
                                        <div class="faculty-info">
                                            <h5 class="faculty-name">Mr. Ramesh Patel</h5>
                                            <p class="faculty-subject">Physics - Class XI-XII</p>
                                            <p class="faculty-qual">M.Sc, B.Ed | 15 Years Experience</p>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-12">
                                    <div class="faculty-card">
                                        <img src="https://images.unsplash.com/photo-1544725176-7c40e5a71c5e?ixlib=rb-4.0.3&auto=format&fit=crop&w=300&q=80" class="faculty-img">
                                        <div class="faculty-info">
                                            <h5 class="faculty-name">Mrs. Sunita Rao</h5>
                                            <p class="faculty-subject">Physics - Class IX-X</p>
                                            <p class="faculty-qual">M.Sc, M.Ed | 12 Years Experience</p>
                                        </div>
                                    </div>
                                </div>
                                
                                <!-- Chemistry Teachers -->
                                <div class="col-12">
                                    <div class="faculty-card">
                                        <img src="https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixlib=rb-4.0.3&auto=format&fit=crop&w=300&q=80" class="faculty-img">
                                        <div class="faculty-info">
                                            <h5 class="faculty-name">Dr. Amit Kumar</h5>
                                            <p class="faculty-subject">Chemistry - Class XI-XII</p>
                                            <p class="faculty-qual">Ph.D, M.Sc, B.Ed | 18 Years Experience</p>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-12">
                                    <div class="faculty-card">
                                        <img src="https://images.unsplash.com/photo-1494790108755-2616b612b786?ixlib=rb-4.0.3&auto=format&fit=crop&w=300&q=80" class="faculty-img">
                                        <div class="faculty-info">
                                            <h5 class="faculty-name">Mrs. Priya Singh</h5>
                                            <p class="faculty-subject">Chemistry - Class IX-X</p>
                                            <p class="faculty-qual">M.Sc, B.Ed | 10 Years Experience</p>
                                        </div>
                                    </div>
                                </div>
                                
                                <!-- Biology Teachers -->
                                <div class="col-12">
                                    <div class="faculty-card">
                                        <img src="https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.0.3&auto=format&fit=crop&w=300&q=80" class="faculty-img">
                                        <div class="faculty-info">
                                            <h5 class="faculty-name">Mrs. Kavita Desai</h5>
                                            <p class="faculty-subject">Biology - Class XI-XII</p>
                                            <p class="faculty-qual">M.Sc (Zoology), B.Ed | 14 Years Experience</p>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-12">
                                    <div class="faculty-card">
                                        <img src="https://images.unsplash.com/photo-1544005313-94ddf0286df2?ixlib=rb-4.0.3&auto=format&fit=crop&w=300&q=80" class="faculty-img">
                                        <div class="faculty-info">
                                            <h5 class="faculty-name">Mr. Vijay Reddy</h5>
                                            <p class="faculty-subject">Biology - Class IX-X</p>
                                            <p class="faculty-qual">M.Sc (Botany), B.Ed | 11 Years Experience</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Mathematics Department -->
                        <div class="col-md-6 mb-4">
                            <h4 class="department-heading">Mathematics Department</h4>
                            <div class="row g-3">
                                <!-- Math Teachers -->
                                <div class="col-12">
                                    <div class="faculty-card">
                                        <img src="https://images.unsplash.com/photo-1508214751196-bcfd4ca60f91?ixlib=rb-4.0.3&auto=format&fit=crop&w=300&q=80" class="faculty-img">
                                        <div class="faculty-info">
                                            <h5 class="faculty-name">Mr. Suresh Gupta</h5>
                                            <p class="faculty-subject">Mathematics - Class XI-XII</p>
                                            <p class="faculty-qual">M.Sc (Maths), B.Ed | 16 Years Experience</p>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-12">
                                    <div class="faculty-card">
                                        <img src="https://images.unsplash.com/photo-1552058544-f2b08422138a?ixlib=rb-4.0.3&auto=format&fit=crop&w=300&q=80" class="faculty-img">
                                        <div class="faculty-info">
                                            <h5 class="faculty-name">Mrs. Meena Kapoor</h5>
                                            <p class="faculty-subject">Mathematics - Class IX-X</p>
                                            <p class="faculty-qual">M.Sc, M.Ed | 13 Years Experience</p>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-12">
                                    <div class="faculty-card">
                                        <img src="https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?ixlib=rb-4.0.3&auto=format&fit=crop&w=300&q=80" class="faculty-img">
                                        <div class="faculty-info">
                                            <h5 class="faculty-name">Mr. Rajesh Nair</h5>
                                            <p class="faculty-subject">Mathematics - Class VI-VIII</p>
                                            <p class="faculty-qual">M.Sc, B.Ed | 9 Years Experience</p>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <h4 class="department-heading mt-4">Computer Science</h4>
                            <div class="row g-3">
                                <div class="col-12">
                                    <div class="faculty-card">
                                        <img src="https://images.unsplash.com/photo-1580489944761-15a19d654956?ixlib=rb-4.0.3&auto=format&fit=crop&w=300&q=80" class="faculty-img">
                                        <div class="faculty-info">
                                            <h5 class="faculty-name">Mr. Arjun Mehra</h5>
                                            <p class="faculty-subject">Computer Science - Class XI-XII</p>
                                            <p class="faculty-qual">M.Tech (CSE), B.Ed | 8 Years Experience</p>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-12">
                                    <div class="faculty-card">
                                        <img src="https://images.unsplash.com/photo-1582750433449-648ed127bb54?ixlib=rb-4.0.3&auto=format&fit=crop&w=300&q=80" class="faculty-img">
                                        <div class="faculty-info">
                                            <h5 class="faculty-name">Ms. Deepika Joshi</h5>
                                            <p class="faculty-subject">Computer Applications - Class IX-X</p>
                                            <p class="faculty-qual">MCA, B.Ed | 6 Years Experience</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- English Department -->
                        <div class="col-md-6 mb-4">
                            <h4 class="department-heading">English Department</h4>
                            <div class="row g-3">
                                <div class="col-12">
                                    <div class="faculty-card">
                                        <img src="https://images.unsplash.com/photo-1534528741775-53994a69daeb?ixlib=rb-4.0.3&auto=format&fit=crop&w=300&q=80" class="faculty-img">
                                        <div class="faculty-info">
                                            <h5 class="faculty-name">Mrs. Elizabeth Thomas</h5>
                                            <p class="faculty-subject">English - Class XI-XII</p>
                                            <p class="faculty-qual">MA (English), M.Ed | 15 Years Experience</p>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-12">
                                    <div class="faculty-card">
                                        <img src="https://images.unsplash.com/photo-1517841905240-472988babdf9?ixlib=rb-4.0.3&auto=format&fit=crop&w=300&q=80" class="faculty-img">
                                        <div class="faculty-info">
                                            <h5 class="faculty-name">Mr. Robert D'Souza</h5>
                                            <p class="faculty-subject">English - Class IX-X</p>
                                            <p class="faculty-qual">MA (English Lit.), B.Ed | 12 Years Experience</p>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-12">
                                    <div class="faculty-card">
                                        <img src="https://images.unsplash.com/photo-1544005313-94ddf0286df2?ixlib=rb-4.0.3&auto=format&fit=crop&w=300&q=80" class="faculty-img">
                                        <div class="faculty-info">
                                            <h5 class="faculty-name">Mrs. Anita Roy</h5>
                                            <p class="faculty-subject">English - Class VI-VIII</p>
                                            <p class="faculty-qual">BA (Hons), B.Ed | 10 Years Experience</p>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <h4 class="department-heading mt-4">Social Sciences</h4>
                            <div class="row g-3">
                                <div class="col-12">
                                    <div class="faculty-card">
                                        <img src="https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixlib=rb-4.0.3&auto=format&fit=crop&w=300&q=80" class="faculty-img">
                                        <div class="faculty-info">
                                            <h5 class="faculty-name">Mr. Ravi Shankar</h5>
                                            <p class="faculty-subject">History - Class IX-XII</p>
                                            <p class="faculty-qual">MA (History), M.Ed | 14 Years Experience</p>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-12">
                                    <div class="faculty-card">
                                        <img src="https://images.unsplash.com/photo-1494790108755-2616b612b786?ixlib=rb-4.0.3&auto=format&fit=crop&w=300&q=80" class="faculty-img">
                                        <div class="faculty-info">
                                            <h5 class="faculty-name">Mrs. Geeta Prasad</h5>
                                            <p class="faculty-subject">Geography - Class IX-XII</p>
                                            <p class="faculty-qual">MA (Geography), B.Ed | 11 Years Experience</p>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-12">
                                    <div class="faculty-card">
                                        <img src="https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.0.3&auto=format&fit=crop&w=300&q=80" class="faculty-img">
                                        <div class="faculty-info">
                                            <h5 class="faculty-name">Mr. Karan Malhotra</h5>
                                            <p class="faculty-subject">Political Science - Class XI-XII</p>
                                            <p class="faculty-qual">MA (Pol. Science), B.Ed | 9 Years Experience</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Languages & Commerce -->
                        <div class="col-md-6 mb-4">
                            <h4 class="department-heading">Languages & Commerce</h4>
                            <div class="row g-3">
                                <!-- Hindi -->
                                <div class="col-12">
                                    <div class="faculty-card">
                                        <img src="https://images.unsplash.com/photo-1544725176-7c40e5a71c5e?ixlib=rb-4.0.3&auto=format&fit=crop&w=300&q=80" class="faculty-img">
                                        <div class="faculty-info">
                                            <h5 class="faculty-name">Mrs. Usha Sharma</h5>
                                            <p class="faculty-subject">Hindi - All Classes</p>
                                            <p class="faculty-qual">MA (Hindi), B.Ed | 16 Years Experience</p>
                                        </div>
                                    </div>
                                </div>
                                
                                <!-- Sanskrit -->
                                <div class="col-12">
                                    <div class="faculty-card">
                                        <img src="https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixlib=rb-4.0.3&auto=format&fit=crop&w=300&q=80" class="faculty-img">
                                        <div class="faculty-info">
                                            <h5 class="faculty-name">Mr. Pandit Sharma</h5>
                                            <p class="faculty-subject">Sanskrit - Class VI-X</p>
                                            <p class="faculty-qual">MA (Sanskrit), Shastri | 18 Years Experience</p>
                                        </div>
                                    </div>
                                </div>
                                
                                <!-- Commerce -->
                                <div class="col-12">
                                    <div class="faculty-card">
                                        <img src="https://images.unsplash.com/photo-1552058544-f2b08422138a?ixlib=rb-4.0.3&auto=format&fit=crop&w=300&q=80" class="faculty-img">
                                        <div class="faculty-info">
                                            <h5 class="faculty-name">Mr. Alok Jain</h5>
                                            <p class="faculty-subject">Accountancy - Class XI-XII</p>
                                            <p class="faculty-qual">M.Com, CA Inter, B.Ed | 12 Years Experience</p>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-12">
                                    <div class="faculty-card">
                                        <img src="https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixlib=rb-4.0.3&auto=format&fit=crop&w=300&q=80" class="faculty-img">
                                        <div class="faculty-info">
                                            <h5 class="faculty-name">Mrs. Seema Bansal</h5>
                                            <p class="faculty-subject">Business Studies - Class XI-XII</p>
                                            <p class="faculty-qual">MBA, B.Ed | 10 Years Experience</p>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-12">
                                    <div class="faculty-card">
                                        <img src="https://images.unsplash.com/photo-1494790108755-2616b612b786?ixlib=rb-4.0.3&auto=format&fit=crop&w=300&q=80" class="faculty-img">
                                        <div class="faculty-info">
                                            <h5 class="faculty-name">Mr. Vivek Agarwal</h5>
                                            <p class="faculty-subject">Economics - Class XI-XII</p>
                                            <p class="faculty-qual">MA (Economics), B.Ed | 11 Years Experience</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Primary & Other Departments -->
                        <div class="col-md-6 mb-4">
                            <h4 class="department-heading">Primary Department</h4>
                            <div class="row g-3">
                                <div class="col-12">
                                    <div class="faculty-card">
                                        <img src="https://images.unsplash.com/photo-1544005313-94ddf0286df2?ixlib=rb-4.0.3&auto=format&fit=crop&w=300&q=80" class="faculty-img">
                                        <div class="faculty-info">
                                            <h5 class="faculty-name">Mrs. Radhika Singh</h5>
                                            <p class="faculty-subject">Class Teacher - Grade 1</p>
                                            <p class="faculty-qual">B.Ed, NTT | 8 Years Experience</p>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-12">
                                    <div class="faculty-card">
                                        <img src="https://images.unsplash.com/photo-1508214751196-bcfd4ca60f91?ixlib=rb-4.0.3&auto=format&fit=crop&w=300&q=80" class="faculty-img">
                                        <div class="faculty-info">
                                            <h5 class="faculty-name">Mrs. Pooja Mehta</h5>
                                            <p class="faculty-subject">Class Teacher - Grade 2</p>
                                            <p class="faculty-qual">B.Ed, Montessori | 7 Years Experience</p>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-12">
                                    <div class="faculty-card">
                                        <img src="https://images.unsplash.com/photo-1552058544-f2b08422138a?ixlib=rb-4.0.3&auto=format&fit=crop&w=300&q=80" class="faculty-img">
                                        <div class="faculty-info">
                                            <h5 class="faculty-name">Ms. Anjali Roy</h5>
                                            <p class="faculty-subject">Class Teacher - Grade 3</p>
                                            <p class="faculty-qual">B.Ed, ECCE | 6 Years Experience</p>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <h4 class="department-heading mt-4">Co-curricular</h4>
                            <div class="row g-3">
                                <div class="col-12">
                                    <div class="faculty-card">
                                        <img src="https://images.unsplash.com/photo-1568602471122-7832951cc4c5?ixlib=rb-4.0.3&auto=format&fit=crop&w=300&q=80" class="faculty-img">
                                        <div class="faculty-info">
                                            <h5 class="faculty-name">Mr. Vikram Singh</h5>
                                            <p class="faculty-subject">Physical Education</p>
                                            <p class="faculty-qual">M.P.Ed | 10 Years Experience</p>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-12">
                                    <div class="faculty-card">
                                        <img src="https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?ixlib=rb-4.0.3&auto=format&fit=crop&w=300&q=80" class="faculty-img">
                                        <div class="faculty-info">
                                            <h5 class="faculty-name">Mrs. Shalini Rao</h5>
                                            <p class="faculty-subject">Music & Dance</p>
                                            <p class="faculty-qual">Sangeet Visharad, B.Ed | 12 Years Experience</p>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-12">
                                    <div class="faculty-card">
                                        <img src="https://images.unsplash.com/photo-1580489944761-15a19d654956?ixlib=rb-4.0.3&auto=format&fit=crop&w=300&q=80" class="faculty-img">
                                        <div class="faculty-info">
                                            <h5 class="faculty-name">Mr. Rajeev Nair</h5>
                                            <p class="faculty-subject">Art & Craft</p>
                                            <p class="faculty-qual">Diploma in Fine Arts | 9 Years Experience</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer border-0 pt-0">
                <div class="team-stats">
                    <div class="stat-item">
                        <i class="fas fa-chalkboard-teacher"></i>
                        <span>30+ Faculty Members</span>
                    </div>
                    <div class="stat-item">
                        <i class="fas fa-user-graduate"></i>
                        <span>15:1 Student-Teacher Ratio</span>
                    </div>
                    <div class="stat-item">
                        <i class="fas fa-award"></i>
                        <span>100% Qualified Staff</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

    <!-- Academics Section -->
    <section id="academics" class="academics py-5 bg-light hidden">
        <div class="container">
            <h2 class="section-title text-center mb-5">Academic Excellence</h2>
            <div class="row g-4">
                <div class="col-md-4">
                    <div class="card h-100 shadow border-0 hidden fade-from-left">
                        <a href="cur.jsp" class="card-body text-center p-4 text-decoration-none text-dark">
                            <i class="fas fa-graduation-cap"></i>
                            <h5 class="mt-3">Curriculum</h5>
                            <p>CBSE-aligned curriculum with focus on holistic development and modern skills.</p>
                        </a>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card h-100 shadow border-0 hidden fade-from-bottom">
                        <div class="card-body text-center p-4">
                            <i class="fas fa-book-open"></i>
                            <h5 class="mt-3">Library</h5>
                            <p>State-of-the-art digital library with 10,000+ resources for research and reading.</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card h-100 shadow border-0 hidden fade-from-right">
                        <div class="card-body text-center p-4">
                            <i class="fas fa-laptop-code"></i>
                            <h5 class="mt-3">STEM Labs</h5>
                            <p>Advanced labs for science, tech, engineering, and math explorations.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Activities Section -->
    <section id="activities" class="activities py-5 hidden">
        <div class="container">
            <h2 class="section-title text-center mb-5">Extracurricular Activities</h2>
            <div class="row g-4">
                <div class="col-md-6">
                    <div class="card h-100 shadow border-0 hidden fade-from-left">
                        <div class="card-img-container">
                            <img src="https://img.freepik.com/free-photo/medium-shot-smiley-kids-posing-together_23-2149351802.jpg?semt=ais_hybrid&w=740&q=80" alt="Sports Activities" class="card-img-top">
                        </div>
                        <div class="card-body">
                            <h5>Sports & Fitness</h5>
                            <p>Championship teams in cricket, football, and more. Promoting health and teamwork.</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="card h-100 shadow border-0 hidden fade-from-right">
                        <div class="card-img-container">
                            <img src="https://ministerwhite.com/cdn/shop/articles/WhatsApp_Image_2021-09-07_at_12.08.22_PM_copy.jpg?v=1631179865" alt="Arts & Culture" class="card-img-top">
                        </div>
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
    <section id="gallery" class="gallery py-5 bg-light hidden">
        <div class="container">
            <h2 class="section-title text-center mb-5">Gallery</h2>
            <div class="row g-3">
                <div class="col-md-4 col-sm-6 mb-4"><img src="https://www.indianhighschool.edu.in/images/inner-img/assembly-img1.jpg" alt="School Event 1" class="img-fluid rounded shadow gallery-item" data-bs-toggle="modal" data-bs-target="#imageModal" onclick="openModal(this.src)"></div>
                <div class="col-md-4 col-sm-6 mb-4"><img src="https://www.adhirainternationalschool.co.in/img/gallery/events/janmastami-and-orange-colour-day-celebration3.webp" alt="School Event 2" class="img-fluid rounded shadow gallery-item" data-bs-toggle="modal" data-bs-target="#imageModal" onclick="openModal(this.src)"></div>
                <div class="col-md-4 col-sm-6 mb-4"><img src="https://www.proeves.com/blog/wp-content/uploads/2018/12/atticus.png" alt="School Event 3" class="img-fluid rounded shadow gallery-item" data-bs-toggle="modal" data-bs-target="#imageModal" onclick="openModal(this.src)"></div>
                <div class="col-md-4 col-sm-6 mb-4"><img src="https://www.apeejay.edu/kharghar/images/events/2024/childrens-day-celebration-1.jpg" alt="School Event 4" class="img-fluid rounded shadow gallery-item" data-bs-toggle="modal" data-bs-target="#imageModal" onclick="openModal(this.src)"></div>
                <div class="col-md-4 col-sm-6 mb-4"><img src="https://dktix1rrcd7mv.cloudfront.net/images/3:2/winterfaire-winterslide-afternoon.jpg" alt="School Event 5" class="img-fluid rounded shadow gallery-item" data-bs-toggle="modal" data-bs-target="#imageModal" onclick="openModal(this.src)"></div>
                <div class="col-md-4 col-sm-6 mb-4"><img src="https://bookosmia.com/wp-content/uploads/2021/12/IMG_1345-1536x1026.jpg" alt="School Event 6" class="img-fluid rounded shadow gallery-item" data-bs-toggle="modal" data-bs-target="#imageModal" onclick="openModal(this.src)"></div>
            </div>
        </div>
    </section>

    <!-- Testimonials Section -->
    <section class="testimonials py-5 hidden">
        <div class="container">
            <h2 class="section-title text-center mb-5 text-white">What Our Community Says</h2>
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
                </div>
                <button class="carousel-control-prev" type="button" data-bs-target="#testimonialCarousel" data-bs-slide="prev"><span class="carousel-control-prev-icon"></span></button>
                <button class="carousel-control-next" type="button" data-bs-target="#testimonialCarousel" data-bs-slide="next"><span class="carousel-control-next-icon"></span></button>
            </div>
        </div>
    </section>

    <!-- Contact Section -->
    <section id="contact" class="contact py-5 bg-light hidden">
        <div class="container">
            <h2 class="section-title text-center mb-5">Get in Touch</h2>
            <div class="row">
                <div class="col-md-6 mb-4 mb-md-0">
                    <form id="contactForm" class="hidden fade-from-left">
                        <div class="mb-3">
                            <input type="text" class="form-control" placeholder="Your Name" required>
                        </div>
                        <div class="mb-3">
                            <input type="number" class="form-control" placeholder="Your Phone Number" required>
                        </div>
                        <div class="mb-3">
                            <input type="email" class="form-control" placeholder="Your Email" required>
                        </div>
                        <div class="mb-3">
                            <textarea class="form-control" rows="4" placeholder="Your Message" required></textarea>
                        </div>
                        <button type="submit" class="btn btn-primary w-100">Send Message</button>
                    </form>
                </div>
                <div class="col-md-6">
                    <div class="contact-info hidden fade-from-right">
                        <h5><i class="fas fa-map-marker-alt me-2"></i>Address</h5>
                        <p class="mb-3">123 Education Avenue, Learning City, IN 12345</p>
                        
                        <h5><i class="fas fa-phone me-2"></i>Phone</h5>
                        <p class="mb-3">+91 123 456 7890</p>
                        
                        <h5><i class="fas fa-envelope me-2"></i>Email</h5>
                        <p class="mb-4">info@sasschool.edu</p>
                        
                        <div class="social-links mt-4">
                            <a href="#" class="me-3"><i class="fab fa-facebook"></i></a>
                            <a href="#" class="me-3"><i class="fab fa-twitter"></i></a>
                            <a href="#" class="me-3"><i class="fab fa-instagram"></i></a>
                            <a href="#" class="me-3"><i class="fab fa-linkedin"></i></a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer class="footer py-4 hidden">
        <div class="container text-center">
            <p class="mb-2">&copy; 2025 SAS School. All Rights Reserved.</p>
            <p class="mb-0">
                <a href="#" class="text-light me-3">Privacy Policy</a> | 
                <a href="#" class="text-light ms-3">Terms of Service</a>
            </p>
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

    <!-- Back to Top Button -->
    <div id="backToTop" class="back-to-top">
        <i class="fas fa-chevron-up"></i>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/typed.js@2.0.12"></script>
    <script src="home.js"></script>
</body>
</html>