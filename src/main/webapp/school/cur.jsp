<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SAS School - CBSE Curriculum</title>
    <link rel="icon" href="https://img.pikbest.com/png-images/20241026/simple-useful-bright-sun-and-cloud-logo-a-clear-sky-icon-design-vector_11001223.png!sw800" type="image/png">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@700&family=Montserrat:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-color: #1a237e;
            --secondary-color: #283593;
            --accent-color: #3949ab;
            --gold-color: #ffd700;
            --light-blue: #e8eaf6;
            --dark-blue: #0d1458;
            --text-color: #2c3e50;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Montserrat', sans-serif;
            line-height: 1.6;
            color: var(--text-color);
            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
            min-height: 100vh;
        }

        h1, h2, h3, h4, h5, h6 {
            font-family: 'Playfair Display', serif;
            font-weight: 600;
        }

        /* Navbar */
       .navbar-curriculum {
    background: linear-gradient(135deg, #ffffff, #f8f9fa);
    padding: 0;
    height: 70px;
    box-shadow: 0 2px 15px rgba(0,0,0,0.1);
    position: fixed;
    width: 100%;
    top: 0;
    z-index: 1000;
    border-bottom: 3px solid var(--primary-color);
}

.navbar-curriculum .container-fluid {
    padding: 0 30px;
}

.navbar-curriculum .logo {
    height: 45px;
    margin-right: 10px;
    transition: transform 0.3s ease;
}

.navbar-curriculum .logo:hover {
    transform: scale(1.05);
}

.navbar-curriculum .brand-text {
    font-size: 1.6rem;
    color: var(--primary-color);
    font-weight: 700;
    text-decoration: none;
}

.navbar-curriculum .nav-link {
    color: var(--text-color) !important;
    font-weight: 500;
    padding: 15px 20px !important;
    transition: all 0.3s ease;
    border-left: 1px solid rgba(0,0,0,0.1);
    height: 70px;
    display: flex;
    align-items: center;
    position: relative;
}

.navbar-curriculum .nav-link:hover,
.navbar-curriculum .nav-link.active {
    background: rgba(26, 35, 126, 0.05);
    color: var(--primary-color) !important;
}

.navbar-curriculum .nav-link::after {
    content: '';
    position: absolute;
    bottom: 0;
    left: 50%;
    transform: translateX(-50%);
    width: 0;
    height: 3px;
    background: var(--primary-color);
    transition: width 0.3s ease;
}

.navbar-curriculum .nav-link:hover::after,
.navbar-curriculum .nav-link.active::after {
    width: 80%;
}

.navbar-curriculum .nav-link i {
    margin-right: 8px;
    font-size: 1.1rem;
    color: var(--accent-color);
}

.navbar-curriculum .nav-link.active i {
    color: var(--primary-color);
}

.back-to-home {
    color: white !important;
    padding: 15px 25px !important;
    height: 70px;
    border-left: 1px solid rgba(255,255,255,0.2);
    margin-left: 10px;
    border-radius: 0;
    transition: all 0.3s ease;
}

.back-to-home:hover {
    color: white !important;
    transform: none;
}

/* Mobile Responsive Styles */
@media (max-width: 991px) {
    .navbar-curriculum {
        height: auto;
        padding: 10px 0;
    }
    
    .navbar-curriculum .container-fluid {
        padding: 0 15px;
    }
    
    .navbar-curriculum .nav-link {
        height: auto;
        padding: 12px 20px !important;
        border-left: none;
        border-bottom: 1px solid rgba(0,0,0,0.1);
    }
    
    .navbar-curriculum .nav-link::after {
        display: none;
    }
    
    .back-to-home {
        height: auto;
        margin-left: 0;
        margin-top: 10px;
        padding: 12px 20px !important;
        border-radius: 5px;
        border-left: none;
        width: 100%;
        text-align: center;
    }
    
    .navbar-curriculum .nav-link i {
        min-width: 20px;
    }
}

/* Tablets */
@media (min-width: 768px) and (max-width: 991px) {
    .navbar-curriculum .nav-link {
        padding: 15px 15px !important;
        font-size: 0.9rem;
    }
    
    .navbar-curriculum .brand-text {
        font-size: 1.4rem;
    }
}

/* Navbar Toggler */
.navbar-curriculum .navbar-toggler {
    border: 2px solid var(--primary-color);
    padding: 5px 10px;
    transition: all 0.3s ease;
}

.navbar-curriculum .navbar-toggler:hover {
    background: var(--light-blue);
}

.navbar-curriculum .navbar-toggler:focus {
    box-shadow: 0 0 0 0.25rem rgba(26, 35, 126, 0.25);
}

.navbar-curriculum .navbar-toggler-icon {
    background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 30 30'%3e%3cpath stroke='%231a237e' stroke-linecap='round' stroke-miterlimit='10' stroke-width='2' d='M4 7h22M4 15h22M4 23h22'/%3e%3c/svg%3e");
}

/* Scrolled State */
.navbar-curriculum.scrolled {
    background: rgba(255, 255, 255, 0.98);
    backdrop-filter: blur(10px);
    box-shadow: 0 4px 20px rgba(0,0,0,0.1);
    height: 60px;
}

.navbar-curriculum.scrolled .nav-link {
    height: 60px;
}

.navbar-curriculum.scrolled .back-to-home {
    height: 60px;
}

/* Animation for navbar on scroll */
.navbar-curriculum {
    transition: all 0.3s ease;
}

/* Make sure the main content starts below navbar */
.main-content {
    margin-top: 70px;
}

.navbar-curriculum.scrolled ~ .main-content {
    margin-top: 60px;
}

        /* Main Content */
        .main-content {
            margin-top: 70px;
            padding: 0;
        }

        /* Hero Section */
        .curriculum-hero {
            background: linear-gradient(135deg, rgba(26, 35, 126, 0.9), rgba(13, 20, 88, 0.9)),
                        url('https://images.unsplash.com/photo-1523050854058-8df90110c9f1?ixlib=rb-4.0.3&auto=format&fit=crop&w=1950&q=80');
            background-size: cover;
            background-position: center;
            color: white;
            padding: 80px 0 60px;
            text-align: center;
        }

        .curriculum-hero h2 {
            font-size: 3.5rem;
            margin-bottom: 20px;
            color: var(--gold-color);
            text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
        }

        .curriculum-hero p {
            font-size: 1.2rem;
            max-width: 800px;
            margin: 0 auto 30px;
            opacity: 0.9;
        }

        .cbse-badge {
            display: inline-block;
            background: var(--gold-color);
            color: var(--text-color);
            padding: 10px 25px;
            border-radius: 30px;
            font-weight: 600;
            font-size: 1.1rem;
            margin: 20px 0;
            box-shadow: 0 4px 15px rgba(0,0,0,0.2);
        }

        /* Curriculum Overview */
        .curriculum-overview {
            padding: 60px 0;
            background: white;
        }

        .section-title {
            color: var(--primary-color);
            font-size: 2.2rem;
            margin-bottom: 40px;
            text-align: center;
            position: relative;
            padding-bottom: 15px;
        }

        .section-title::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 50%;
            transform: translateX(-50%);
            width: 80px;
            height: 4px;
            background: var(--gold-color);
            border-radius: 2px;
        }

        .overview-card {
            background: var(--light-blue);
            border-radius: 15px;
            padding: 30px;
            height: 100%;
            transition: all 0.3s ease;
            border: 2px solid transparent;
        }

        .overview-card:hover {
            transform: translateY(-10px);
            border-color: var(--accent-color);
            box-shadow: 0 15px 30px rgba(0,0,0,0.1);
        }

        .overview-card i {
            font-size: 2.5rem;
            color: var(--accent-color);
            margin-bottom: 20px;
        }

        .overview-card h4 {
            color: var(--primary-color);
            margin-bottom: 15px;
        }

        /* Grade Structure */
        .grade-structure {
            padding: 60px 0;
            background: linear-gradient(135deg, #f5f7ff 0%, #e3e8ff 100%);
        }

        .grade-card {
            background: white;
            border-radius: 15px;
            padding: 30px;
            margin-bottom: 30px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.08);
            transition: all 0.3s ease;
            border-left: 5px solid var(--accent-color);
        }

        .grade-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 35px rgba(0,0,0,0.12);
        }

        .grade-card h3 {
            color: var(--primary-color);
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 2px solid var(--light-blue);
        }

        .subject-list {
            list-style: none;
            padding: 0;
        }

        .subject-list li {
            padding: 8px 0;
            border-bottom: 1px solid #eee;
            display: flex;
            align-items: center;
        }

        .subject-list li:last-child {
            border-bottom: none;
        }

        .subject-list li i {
            color: var(--accent-color);
            margin-right: 10px;
            font-size: 0.9rem;
        }

        /* Subjects Table */
        .subjects-table {
            padding: 60px 0;
            background: white;
        }

        .table-responsive {
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
        }

        .table thead {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: white;
        }

        .table th {
            border: none;
            padding: 20px;
            font-weight: 600;
        }

        .table td {
            padding: 18px 20px;
            vertical-align: middle;
            border-color: #eee;
        }

        .table-striped tbody tr:nth-of-type(odd) {
            background-color: var(--light-blue);
        }

        .subject-category {
            background: var(--gold-color) !important;
            color: var(--text-color);
            font-weight: 600;
        }

        /* Co-curricular */
        .co-curricular {
            padding: 60px 0;
            background: linear-gradient(135deg, #f5f7ff 0%, #e3e8ff 100%);
        }

        .activity-card {
            background: white;
            border-radius: 15px;
            padding: 25px;
            text-align: center;
            height: 100%;
            transition: all 0.3s ease;
            box-shadow: 0 8px 20px rgba(0,0,0,0.08);
        }

        .activity-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 35px rgba(0,0,0,0.15);
        }

        .activity-card i {
            font-size: 2.5rem;
            color: var(--accent-color);
            margin-bottom: 20px;
            background: var(--light-blue);
            width: 70px;
            height: 70px;
            line-height: 70px;
            border-radius: 50%;
            display: inline-block;
        }

        /* Assessment System */
        .assessment-system {
            padding: 60px 0;
            background: white;
        }

        .assessment-card {
            background: var(--light-blue);
            border-radius: 15px;
            padding: 30px;
            text-align: center;
            height: 100%;
            transition: all 0.3s ease;
        }

        .assessment-card:hover {
            background: white;
            box-shadow: 0 15px 30px rgba(0,0,0,0.1);
        }

        .assessment-card .percentage {
            font-size: 2.5rem;
            font-weight: 700;
            color: var(--primary-color);
            margin: 15px 0;
        }

        /* Timeline */
        .timeline-section {
            padding: 60px 0;
            background: linear-gradient(135deg, #f5f7ff 0%, #e3e8ff 100%);
        }

        .timeline {
            position: relative;
            max-width: 1200px;
            margin: 0 auto;
        }

        .timeline::after {
            content: '';
            position: absolute;
            width: 6px;
            background: var(--accent-color);
            top: 0;
            bottom: 0;
            left: 50%;
            margin-left: -3px;
            border-radius: 3px;
        }

        .timeline-item {
            padding: 10px 40px;
            position: relative;
            width: 50%;
            margin-bottom: 30px;
        }

        .timeline-item:nth-child(odd) {
            left: 0;
        }

        .timeline-item:nth-child(even) {
            left: 50%;
        }

        .timeline-content {
            padding: 20px 30px;
            background: white;
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            position: relative;
        }

        .timeline-content::after {
            content: '';
            position: absolute;
            width: 20px;
            height: 20px;
            background: var(--accent-color);
            border-radius: 50%;
            top: 50%;
            transform: translateY(-50%);
        }

        .timeline-item:nth-child(odd) .timeline-content::after {
            right: -10px;
        }

        .timeline-item:nth-child(even) .timeline-content::after {
            left: -10px;
        }

        /* Footer */
        .curriculum-footer {
            background: linear-gradient(135deg, var(--primary-color), var(--dark-blue));
            color: white;
            padding: 40px 0 20px;
        }

        .footer-links a {
            color: white;
            text-decoration: none;
            margin-right: 20px;
            transition: color 0.3s ease;
        }

        .footer-links a:hover {
            color: var(--gold-color);
        }

        /* Responsive Design */
        @media (max-width: 991px) {
            .navbar-curriculum {
                height: auto;
                padding: 10px 0;
            }
            
            .navbar-curriculum .container-fluid {
                padding: 0 15px;
            }
            
            .navbar-curriculum .nav-link {
                height: auto;
                padding: 12px 20px !important;
                border-left: none;
                border-bottom: 1px solid rgba(255,255,255,0.1);
            }
            
            .curriculum-hero h1 {
                font-size: 2.5rem;
            }
            
            .timeline::after {
                left: 31px;
            }
            
            .timeline-item {
                width: 100%;
                padding-left: 70px;
                padding-right: 25px;
            }
            
            .timeline-item:nth-child(odd),
            .timeline-item:nth-child(even) {
                left: 0;
            }
            
            .timeline-content::after {
                left: -10px !important;
            }
        }

        @media (max-width: 768px) {
            .curriculum-hero {
                padding: 60px 0 40px;
            }
            
            .curriculum-hero h2 {
                font-size: 1.6rem;
            }
            
            .section-title {
                font-size: 1.8rem;
            }
            
            .table td, .table th {
                padding: 12px 15px;
                font-size: 0.9rem;
            }
        }

        @media (max-width: 576px) {
            .curriculum-hero h1 {
                font-size: 1.8rem;
            }
            
            .section-title {
                font-size: 1.5rem;
            }
            
            .overview-card,
            .grade-card,
            .activity-card {
                padding: 20px;
            }
            
            .timeline-item {
                padding-left: 50px;
            }
        }
    </style>
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-curriculum">
        <div class="container-fluid">
            <a class="navbar-brand" href="home.jsp">
                <img src="https://img.pikbest.com/png-images/20241026/simple-useful-bright-sun-and-cloud-logo-a-clear-sky-icon-design-vector_11001223.png!sw800" alt="SAS School Logo" class="logo">
                <span class="brand-text">SAS School</span>
            </a>
            
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#curriculumNavbar">
                <span class="navbar-toggler-icon text-white"></span>
            </button>
            
            <div class="collapse navbar-collapse" id="curriculumNavbar">
                <ul class="navbar-nav ms-auto align-items-center">
                    <li class="nav-item">
                        <a class="nav-link active" href="#overview">
                            <i class="fas fa-book-open"></i>Overview
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#grades">
                            <i class="fas fa-graduation-cap"></i>Grade Structure
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#subjects">
                            <i class="fas fa-clipboard-list"></i>Subjects
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#co-curricular">
                            <i class="fas fa-running"></i>Co-curricular
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#assessment">
                            <i class="fas fa-chart-line"></i>Assessment
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#timeline">
                            <i class="fas fa-calendar-alt"></i>Academic Year
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link back-to-home" href="home.jsp">
                            <i class="fas fa-home"></i>Back to Home
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <div class="main-content">
        <!-- Hero Section -->
        <section class="curriculum-hero">
            <div class="container">
                <div class="cbse-badge">
                    <i class="fas fa-certificate me-2"></i>Affiliated to CBSE, New Delhi
                </div>
                <h2>CBSE & State Curriculum</h2>
                <p class="lead">Comprehensive, Holistic, and Future-Ready Education System</p>
                <p>Our curriculum aligns with the National Education Policy 2020, focusing on conceptual understanding, skill development, and value-based education for holistic growth.</p>
                <div class="mt-4">
                    <span class="badge bg-light text-dark me-2 p-2">NEP 2020 Aligned</span>
                    <span class="badge bg-light text-dark me-2 p-2">Competency-Based</span>
                    <span class="badge bg-light text-dark me-2 p-2">Multidisciplinary</span>
                    <span class="badge bg-light text-dark p-2">Technology Integrated</span>
                </div>
            </div>
        </section>

        <!-- Curriculum Overview -->
        <section id="overview" class="curriculum-overview">
            <div class="container">
                <h2 class="section-title">Curriculum Overview</h2>
                <div class="row g-4">
                    <div class="col-md-4">
                        <div class="overview-card">
                            <i class="fas fa-brain"></i>
                            <h4>Holistic Development</h4>
                            <p>Focus on cognitive, emotional, social, and physical development through integrated learning approaches.</p>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="overview-card">
                            <i class="fas fa-laptop-code"></i>
                            <h4>21st Century Skills</h4>
                            <p>Emphasis on critical thinking, creativity, collaboration, communication, and digital literacy.</p>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="overview-card">
                            <i class="fas fa-heart"></i>
                            <h4>Value Education</h4>
                            <p>Integration of moral values, ethics, and citizenship education in daily curriculum.</p>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Grade Structure -->
        <section id="grades" class="grade-structure">
            <div class="container">
                <h2 class="section-title">Grade-Wise Structure</h2>
                <div class="row">
                    <!-- Foundation Stage (Pre-Primary) -->
                    <div class="col-lg-6">
                        <div class="grade-card">
                            <h3><i class="fas fa-child me-2"></i>Foundation Stage (Pre-Primary)</h3>
                            <p><strong>Age Group:</strong> 3-6 years</p>
                            <p><strong>Focus:</strong> Play-based learning, language development, and sensory-motor skills</p>
                            <ul class="subject-list">
                                <li><i class="fas fa-language"></i> Language Development (English & Hindi)</li>
                                <li><i class="fas fa-calculator"></i> Number Work & Pre-Mathematics</li>
                                <li><i class="fas fa-palette"></i> Creative Arts & Craft</li>
                                <li><i class="fas fa-music"></i> Music & Movement</li>
                                <li><i class="fas fa-running"></i> Physical Development Activities</li>
                            </ul>
                        </div>
                    </div>
                    
                    <!-- Preparatory Stage (Classes 1-5) -->
                    <div class="col-lg-6">
                        <div class="grade-card">
                            <h3><i class="fas fa-book-reader me-2"></i>Preparatory Stage (Classes 1-5)</h3>
                            <p><strong>Age Group:</strong> 6-11 years</p>
                            <p><strong>Focus:</strong> Foundational literacy, numeracy, and basic concepts</p>
                            <ul class="subject-list">
                                <li><i class="fas fa-language"></i> English, Hindi, Sanskrit</li>
                                <li><i class="fas fa-calculator"></i> Mathematics</li>
                                <li><i class="fas fa-seedling"></i> Environmental Studies</li>
                                <li><i class="fas fa-desktop"></i> Computer Education</li>
                                <li><i class="fas fa-paint-brush"></i> Art Education</li>
                                <li><i class="fas fa-dumbbell"></i> Physical Education</li>
                            </ul>
                        </div>
                    </div>
                    
                    <!-- Middle Stage (Classes 6-8) -->
                    <div class="col-lg-6">
                        <div class="grade-card">
                            <h3><i class="fas fa-user-graduate me-2"></i>Middle Stage (Classes 6-8)</h3>
                            <p><strong>Age Group:</strong> 11-14 years</p>
                            <p><strong>Focus:</strong> Subject exploration and skill development</p>
                            <ul class="subject-list">
                                <li><i class="fas fa-language"></i> English, Hindi, Sanskrit/French</li>
                                <li><i class="fas fa-calculator"></i> Mathematics</li>
                                <li><i class="fas fa-flask"></i> Science (Physics, Chemistry, Biology)</li>
                                <li><i class="fas fa-globe-asia"></i> Social Science</li>
                                <li><i class="fas fa-desktop"></i> Computer Science</li>
                                <li><i class="fas fa-chart-line"></i> Life Skills</li>
                            </ul>
                        </div>
                    </div>
                    
                    <!-- Secondary Stage (Classes 9-12) -->
                    <div class="col-lg-6">
                        <div class="grade-card">
                            <h3><i class="fas fa-university me-2"></i>Secondary Stage (Classes 9-12)</h3>
                            <p><strong>Age Group:</strong> 14-18 years</p>
                            <p><strong>Focus:</strong> Specialization and career preparation</p>
                            <div class="row">
                                <div class="col-md-6">
                                    <h6>Science Stream</h6>
                                    <ul class="subject-list">
                                        <li>Physics</li>
                                        <li>Chemistry</li>
                                        <li>Biology/Mathematics</li>
                                        <li>Computer Science</li>
                                    </ul>
                                </div>
                                <div class="col-md-6">
                                    <h6>Commerce Stream</h6>
                                    <ul class="subject-list">
                                        <li>Accountancy</li>
                                        <li>Business Studies</li>
                                        <li>Economics</li>
                                        <li>Mathematics/IP</li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Subjects Table -->
        <section id="subjects" class="subjects-table">
            <div class="container">
                <h2 class="section-title">Detailed Subject List</h2>
                <div class="table-responsive">
                    <table class="table table-striped">
                        <thead>
                            <tr>
                                <th>Class</th>
                                <th>Core Subjects</th>
                                <th>Additional Subjects</th>
                                <th>Co-scholastic</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr class="subject-category">
                                <td colspan="4"><strong>Primary Section (Classes 1-5)</strong></td>
                            </tr>
                            <tr>
                                <td>Classes 1-2</td>
                                <td>English, Hindi, Mathematics</td>
                                <td>Environmental Studies, Computer Basics</td>
                                <td>Art, Music, Yoga, Games</td>
                            </tr>
                            <tr>
                                <td>Classes 3-5</td>
                                <td>English, Hindi, Mathematics</td>
                                <td>Science, Social Studies, Sanskrit, Computers</td>
                                <td>Art, Music, Sports, SUPW</td>
                            </tr>
                            
                            <tr class="subject-category">
                                <td colspan="4"><strong>Middle Section (Classes 6-8)</strong></td>
                            </tr>
                            <tr>
                                <td>Classes 6-8</td>
                                <td>English, Hindi, Mathematics, Science</td>
                                <td>Social Science, Sanskrit/French, Computers</td>
                                <td>Art, Music, Physical Education, Life Skills</td>
                            </tr>
                            
                            <tr class="subject-category">
                                <td colspan="4"><strong>Secondary Section (Classes 9-10)</strong></td>
                            </tr>
                            <tr>
                                <td>Classes 9-10</td>
                                <td>English, Hindi, Mathematics, Science, Social Science</td>
                                <td>Computer Applications, Sanskrit, Artificial Intelligence</td>
                                <td>Art, Music, Sports, SUPW, Work Experience</td>
                            </tr>
                            
                            <tr class="subject-category">
                                <td colspan="4"><strong>Senior Secondary (Classes 11-12)</strong></td>
                            </tr>
                            <tr>
                                <td>Science Stream</td>
                                <td>English, Physics, Chemistry</td>
                                <td>Biology/Mathematics, Computer Science, Physical Education</td>
                                <td>Career Counseling, Project Work</td>
                            </tr>
                            <tr>
                                <td>Commerce Stream</td>
                                <td>English, Accountancy, Business Studies</td>
                                <td>Economics, Mathematics/IP, Physical Education</td>
                                <td>Career Counseling, Project Work</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </section>

        <!-- Co-curricular Activities -->
        <section id="co-curricular" class="co-curricular">
            <div class="container">
                <h2 class="section-title">Co-curricular Activities</h2>
                <div class="row g-4">
                    <div class="col-md-3 col-sm-6">
                        <div class="activity-card">
                            <i class="fas fa-robot"></i>
                            <h5>STEM Club</h5>
                            <p>Science fairs, robotics, coding competitions, and innovation projects</p>
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-6">
                        <div class="activity-card">
                            <i class="fas fa-theater-masks"></i>
                            <h5>Performing Arts</h5>
                            <p>Drama, dance, music, debate, and elocution competitions</p>
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-6">
                        <div class="activity-card">
                            <i class="fas fa-paint-brush"></i>
                            <h5>Visual Arts</h5>
                            <p>Drawing, painting, craft, pottery, and photography workshops</p>
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-6">
                        <div class="activity-card">
                            <i class="fas fa-futbol"></i>
                            <h5>Sports</h5>
                            <p>Cricket, football, basketball, athletics, swimming, and martial arts</p>
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-6">
                        <div class="activity-card">
                            <i class="fas fa-leaf"></i>
                            <h5>Eco Club</h5>
                            <p>Environment conservation, gardening, and sustainability projects</p>
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-6">
                        <div class="activity-card">
                            <i class="fas fa-hands-helping"></i>
                            <h5>Social Service</h5>
                            <p>Community service, NGO partnerships, and social awareness programs</p>
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-6">
                        <div class="activity-card">
                            <i class="fas fa-book"></i>
                            <h5>Literary Club</h5>
                            <p>Creative writing, book reviews, poetry, and language enrichment</p>
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-6">
                        <div class="activity-card">
                            <i class="fas fa-chess"></i>
                            <h5>Mind Sports</h5>
                            <p>Chess, quiz competitions, puzzles, and strategy games</p>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Assessment System -->
        <section id="assessment" class="assessment-system">
            <div class="container">
                <h2 class="section-title">Continuous & Comprehensive Evaluation</h2>
                <div class="row g-4">
                    <div class="col-md-4">
                        <div class="assessment-card">
                            <i class="fas fa-clipboard-check"></i>
                            <h4>Formative Assessment</h4>
                            <div class="percentage">40%</div>
                            <p>Class activities, projects, quizzes, presentations, and assignments</p>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="assessment-card">
                            <i class="fas fa-file-alt"></i>
                            <h4>Summative Assessment</h4>
                            <div class="percentage">60%</div>
                            <p>Term-end examinations, practical tests, and final evaluations</p>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="assessment-card">
                            <i class="fas fa-chart-pie"></i>
                            <h4>Holistic Evaluation</h4>
                            <div class="percentage">100%</div>
                            <p>Academic + Co-scholastic + Life Skills + Values & Attitudes</p>
                        </div>
                    </div>
                </div>
                
                <div class="row mt-5">
                    <div class="col-md-6">
                        <h4 class="mb-4">Grading System (Classes 1-8)</h4>
                        <table class="table table-bordered">
                            <thead class="table-primary">
                                <tr>
                                    <th>Grade</th>
                                    <th>Range</th>
                                    <th>Remarks</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr><td>A+</td><td>91-100%</td><td>Outstanding</td></tr>
                                <tr><td>A</td><td>81-90%</td><td>Excellent</td></tr>
                                <tr><td>B+</td><td>71-80%</td><td>Very Good</td></tr>
                                <tr><td>B</td><td>61-70%</td><td>Good</td></tr>
                                <tr><td>C</td><td>51-60%</td><td>Fair</td></tr>
                                <tr><td>D</td><td>33-50%</td><td>Needs Improvement</td></tr>
                            </tbody>
                        </table>
                    </div>
                    <div class="col-md-6">
                        <h4 class="mb-4">Board Examination (Classes 10 & 12)</h4>
                        <ul class="list-group">
                            <li class="list-group-item d-flex justify-content-between align-items-center">
                                Theory Examination
                                <span class="badge bg-primary rounded-pill">80%</span>
                            </li>
                            <li class="list-group-item d-flex justify-content-between align-items-center">
                                Practical/Internal Assessment
                                <span class="badge bg-primary rounded-pill">20%</span>
                            </li>
                            <li class="list-group-item d-flex justify-content-between align-items-center">
                                Minimum Passing Percentage
                                <span class="badge bg-success rounded-pill">33%</span>
                            </li>
                            <li class="list-group-item d-flex justify-content-between align-items-center">
                                Grading System (10-point scale)
                                <span class="badge bg-info rounded-pill">A1 to E2</span>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </section>

        <!-- Academic Timeline -->
        <section id="timeline" class="timeline-section">
            <div class="container">
                <h2 class="section-title">Academic Year Timeline</h2>
                <div class="timeline">
                    <div class="timeline-item">
                        <div class="timeline-content">
                            <h5>April - May</h5>
                            <p><strong>Summer Vacation & New Session Begins</strong></p>
                            <p>• New academic session starts<br>• Summer break for students<br>• Teacher training programs</p>
                        </div>
                    </div>
                    <div class="timeline-item">
                        <div class="timeline-content">
                            <h5>June - July</h5>
                            <p><strong>First Term Begins</strong></p>
                            <p>• Regular classes commence<br>• Internal assessments begin<br>• Co-curricular activities start</p>
                        </div>
                    </div>
                    <div class="timeline-item">
                        <div class="timeline-content">
                            <h5>August</h5>
                            <p><strong>Formative Assessment-I</strong></p>
                            <p>• First unit tests<br>• Project submissions<br>• Independence Day celebrations</p>
                        </div>
                    </div>
                    <div class="timeline-item">
                        <div class="timeline-content">
                            <h5>September</h5>
                            <p><strong>Summative Assessment-I</strong></p>
                            <p>• First term examinations<br>• Teacher-Parent meetings<br>• Mid-term break</p>
                        </div>
                    </div>
                    <div class="timeline-item">
                        <div class="timeline-content">
                            <h5>October - November</h5>
                            <p><strong>Second Term Begins</strong></p>
                            <p>• Result declaration<br>• Diwali break<br>• Sports Day preparations</p>
                        </div>
                    </div>
                    <div class="timeline-item">
                        <div class="timeline-content">
                            <h5>December</h5>
                            <p><strong>Formative Assessment-II</strong></p>
                            <p>• Second unit tests<br>• Annual Sports Day<br>• Winter vacation begins</p>
                        </div>
                    </div>
                    <div class="timeline-item">
                        <div class="timeline-content">
                            <h5>January - February</h5>
                            <p><strong>Final Preparations</strong></p>
                            <p>• Pre-board exams (Classes 10 & 12)<br>• Revision classes<br>• Cultural fest</p>
                        </div>
                    </div>
                    <div class="timeline-item">
                        <div class="timeline-content">
                            <h5>March</h5>
                            <p><strong>Annual Examinations</strong></p>
                            <p>• Final examinations<br>• CBSE Board exams<br>• Session ends</p>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Footer -->
        <footer class="curriculum-footer">
            <div class="container">
                <div class="row">
                    <div class="col-md-6">
                        <h5>SAS School Curriculum</h5>
                        <p>Affiliated to Central Board of Secondary Education (CBSE), New Delhi</p>
                        <p>Follows National Education Policy 2020 guidelines</p>
                    </div>
                    <div class="col-md-6 text-md-end">
                        <div class="footer-links">
                            <a href="../home.html#home"><i class="fas fa-home"></i> Home</a>
                            <a href="../home.html#academics"><i class="fas fa-graduation-cap"></i> Academics</a>
                            <a href="../home.html#contact"><i class="fas fa-envelope"></i> Contact</a>
                        </div>
                        <div class="mt-3">
                            <p>© 2025 SAS School. All Rights Reserved.</p>
                        </div>
                    </div>
                </div>
            </div>
        </footer>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Smooth scrolling for navigation
        document.querySelectorAll('a[href^="#"]').forEach(anchor => {
            anchor.addEventListener('click', function(e) {
                e.preventDefault();
                
                const targetId = this.getAttribute('href');
                if (targetId === '#') return;
                
                const targetElement = document.querySelector(targetId);
                if (targetElement) {
                    window.scrollTo({
                        top: targetElement.offsetTop - 70,
                        behavior: 'smooth'
                    });
                    
                    // Update active nav link
                    document.querySelectorAll('.nav-link').forEach(link => {
                        link.classList.remove('active');
                    });
                    this.classList.add('active');
                }
            });
        });
        
        // Update active nav link on scroll
        window.addEventListener('scroll', function() {
            const sections = document.querySelectorAll('section[id]');
            const navLinks = document.querySelectorAll('.nav-link');
            
            let current = '';
            sections.forEach(section => {
                const sectionTop = section.offsetTop - 100;
                const sectionHeight = section.clientHeight;
                if (scrollY >= sectionTop && scrollY < sectionTop + sectionHeight) {
                    current = section.getAttribute('id');
                }
            });
            
            navLinks.forEach(link => {
                link.classList.remove('active');
                if (link.getAttribute('href') === '#' + current) {
                    link.classList.add('active');
                }
            });
        });
        
        // Add animation to cards on scroll
        function animateOnScroll() {
            const cards = document.querySelectorAll('.overview-card, .grade-card, .activity-card, .assessment-card');
            
            cards.forEach(card => {
                const cardTop = card.getBoundingClientRect().top;
                const windowHeight = window.innerHeight;
                
                if (cardTop < windowHeight * 0.8) {
                    card.style.opacity = '1';
                    card.style.transform = 'translateY(0)';
                }
            });
        }
        
        // Set initial state for animation
        document.querySelectorAll('.overview-card, .grade-card, .activity-card, .assessment-card').forEach(card => {
            card.style.opacity = '0';
            card.style.transform = 'translateY(20px)';
            card.style.transition = 'all 0.6s ease';
        });
        
        // Trigger animation on load and scroll
        window.addEventListener('load', animateOnScroll);
        window.addEventListener('scroll', animateOnScroll);
    </script>
</body>
</html>