<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>School Gallery</title>
  <link rel="icon" href="https://cdn-icons-png.flaticon.com/512/2132/2132732.png" type="image/x-icon">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" />

  <style>
    body {
      font-family: 'Segoe UI', sans-serif;
      margin: 0;
      padding-top: 70px; /* Adjusted space for smaller navbar */
      background-color: #f4f6f9;
    }

    /* Navbar */
    .navbar {
      position: fixed;
      top: 0;
      width: 100%;
      z-index: 1030;
      height: 50px; /* Smaller height as requested */
      font-size: 0.9rem;
    }
    .navbar-brand {
      font-size: 1rem;
      font-weight: 400;
    }
    .navbar-nav .nav-link {
      padding: 8px 12px;
    }

    /* Folder Grid */
    .folder-grid {
      display: grid;
      grid-template-columns: repeat(5, 1fr);
      gap: 20px;
      padding: 20px;
      max-width: 1200px;
      margin: 0 auto;
    }
    .folder {
      text-align: center;
      cursor: pointer;
      transition: transform 0.2s, box-shadow 0.2s;
      padding: 15px;
      border-radius: 8px;
      background-color: #fff;
      box-shadow: 0 2px 4px rgba(0,0,0,0.1);
      position: relative;
    }
    .folder:hover {
      transform: scale(1.05);
      box-shadow: 0 4px 8px rgba(0,0,0,0.2);
    }
    .folder i {
      color: #007bff;
      font-size: 4rem;
      opacity: 0.3; /* Semi-transparent icon for background */
      position: absolute;
      top: 50%;
      left: 50%;
      transform: translate(-50%, -50%);
    }
    .folder .thumbnail {
      width: 100%;
      height: 120px;
      object-fit: cover;
      border-radius: 6px;
      margin-bottom: 10px;
    }
    .folder p {
      margin: 0;
      font-weight: 500;
      color: #333;
    }

    /* Gallery Grid in Popup */
    .gallery {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
      gap: 15px;
      padding: 10px;
    }
    .gallery img {
      width: 100%;
      height: 180px;
      object-fit: cover;
      border-radius: 6px;
      cursor: pointer;
      transition: transform 0.2s;
      box-shadow: 0 1px 3px rgba(0,0,0,0.1);
    }
    .gallery img:hover {
      transform: scale(1.03);
    }

    /* Popup Overlay */
    .popup-overlay {
      position: fixed;
      top: 0;
      left: 0;
      width: 100vw;
      height: 100vh;
      background: rgba(0,0,0,0.85);
      display: none;
      align-items: center;
      justify-content: center;
      z-index: 2000;
    }
    .popup-content {
      position: relative;
      width: 90%;
      max-width: 90vw;
      background: #fff;
      padding: 20px;
      border-radius: 10px;
      max-height: 90vh;
      overflow-y: auto;
    }
    .popup-close {
      position: absolute;
      top: 10px;
      right: 15px;
      font-size: 28px;
      color: #333;
      cursor: pointer;
      font-weight: bold;
    }
    .popup-close:hover {
      color: #007bff;
    }
    #popupTitle {
      margin: 0 0 20px;
      text-align: center;
      color: #333;
      font-size: 1.5rem;
      font-weight: 600;
    }
    #backToGallery {
      margin-bottom: 15px;
    }

    /* Image View */
    #imageView {
      text-align: center;
    }
    #imageContainer {
      width: 100%;
      max-height: 80vh; /* Ensure image fits without scrolling */
      overflow: hidden;
      display: flex;
      justify-content: center;
      align-items: center;
    }
    #largeImage {
      max-width: 100%;
      max-height: 80vh;
      object-fit: contain; /* Ensure entire image is visible */
      border-radius: 6px;
      transition: transform 0.3s ease;
    }
    .zoom-controls {
      margin-top: 10px;
      display: flex;
      justify-content: center;
      gap: 10px;
    }
    .zoom-controls button {
      font-size: 1rem;
      padding: 5px 15px;
    }

    /* Responsive Adjustments */
    @media (max-width: 992px) {
      .folder-grid {
        grid-template-columns: repeat(3, 1fr);
      }
    }
    @media (max-width: 576px) {
      .folder-grid {
        grid-template-columns: repeat(2, 1fr);
      }
      .gallery img {
        height: 150px;
      }
      #imageContainer {
        max-height: 70vh;
      }
      .folder .thumbnail {
        height: 100px;
      }
    }
  </style>
</head>
<body>

<!-- Navbar (Unchanged structure, height adjusted to 60px) -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark px-4">
  <div class="container-fluid">
    <a class="navbar-brand" href="home.jsp">SAS School</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav me-auto">
        <li class="nav-item"><a class="nav-link" href="home.jsp">Home</a></li>
        <li class="nav-item"><a class="nav-link" href="studentdetails.jsp">Students</a></li>
        <li class="nav-item"><a class="nav-link" href="allpayments.jsp">Payments</a></li>
        <li class="nav-item"><a class="nav-link active" href="gallery.jsp">Gallery</a></li>
        <li class="nav-item"><a class="nav-link" href="aboutus.jsp">About Us</a></li>
      </ul>
      <a class="btn btn-outline-light btn-sm me-2" href="AdminLogin.jsp">Logout</a>
      <a class="btn btn-outline-warning btn-sm" href="createaccount.jsp">Signup</a>
    </div>
  </div>
</nav>

<!-- Main Content -->
<div class="container my-5">
  <h2 class="text-center mb-4">School Gallery by Academic Year</h2>

  <!-- Folder Grid -->
  <div class="folder-grid">
    <% 
      String[] years = {
        "2016-17", "2017-18", "2018-19", "2019-20", "2020-21",
        "2021-22", "2022-23", "2023-24", "2024-25", "2025-26"
      };
      // Demo thumbnail URLs (one per year for folder preview)
      String[] thumbnails = {
        "https://images.unsplash.com/photo-1523050854058-8df90110c9f1?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=60",
        "https://images.unsplash.com/photo-1503676260728-1c00da094a0b?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=60",
        "https://images.unsplash.com/photo-1497636577773-f1231844b336?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=60",
        "https://images.unsplash.com/photo-1580582932707-520aed937b7b?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=60",
        "https://images.unsplash.com/photo-1544531586-f17a1c8d6d3a?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=60",
        "https://images.unsplash.com/photo-1516979187457-637abb4f2be7?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=60",
        "https://images.unsplash.com/photo-1522071820081-5a05c400f035?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=60",
        "https://images.unsplash.com/photo-1588072432836-e10032774350?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=60",
        "https://images.unsplash.com/photo-1535982330050-f1c2fb6d420b?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=60",
        "https://images.unsplash.com/photo-1498243691581-b145c3f54a5a?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=60"
      };
      for (int i = 0; i < years.length; i++) {
        String year = years[i];
        String thumbnail = thumbnails[i];
    %>
      <div class="folder" data-year="<%= year %>">
        <img class="thumbnail" src="<%= thumbnail %>" alt="Preview for <%= year %>">
        <i class="fas fa-folder"></i>
        <p><%= year %></p>
      </div>
    <% } %>
  </div>
</div>

<!-- Popup Overlay -->
<div class="popup-overlay" id="popupOverlay">
  <div class="popup-content" id="popupContent">
    <span class="popup-close" onclick="closePopup()">&times;</span>
    <h4 id="popupTitle"></h4>
    <div id="galleryView" class="gallery"></div>
    <div id="imageView" style="display: none;">
      <button id="backToGallery" class="btn btn-secondary mb-3" onclick="backToGallery()">Back to Gallery</button>
      <div id="imageContainer">
        <img id="largeImage" src="" alt="Large View">
      </div>
      <div class="zoom-controls">
        <button class="btn btn-primary" onclick="zoomIn()">Zoom In</button>
        <button class="btn btn-primary" onclick="zoomOut()">Zoom Out</button>
      </div>
    </div>
  </div>
</div>

<script>
  // Demo image URLs (30 per year, different sets for each year)
  const imagesByYear = {
    "2016-17": [
      "https://images.unsplash.com/photo-1523050854058-8df90110c9f1?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=60",
      "https://images.unsplash.com/photo-1503676260728-1c00da094a0b?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=60",
      "https://images.unsplash.com/photo-1497636577773-f1231844b336?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=60",
      "https://images.unsplash.com/photo-1580582932707-520aed937b7b?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=60",
      "https://images.unsplash.com/photo-1544531586-f17a1c8d6d3a?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=60",
      "https://images.unsplash.com/photo-1516979187457-637abb4f2be7?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=60",
      "https://images.unsplash.com/photo-1522071820081-5a05c400f035?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=60",
      "https://images.unsplash.com/photo-1588072432836-e10032774350?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=60",
      "https://images.unsplash.com/photo-1535982330050-f1c2fb6d420b?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=60",
      "https://images.unsplash.com/photo-1498243691581-b145c3f54a5a?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=60",
      "https://images.unsplash.com/photo-1461896836934-ffe607ba5e93?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=60",
      "https://images.unsplash.com/photo-1552673597-e3e4edb8f5a5?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=60",
      "https://images.unsplash.com/photo-1517931524306-364c4e4f7263?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=60",
      "https://images.unsplash.com/photo-1517486808906-6ca8b3f04846?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=60",
      "https://images.unsplash.com/photo-1606760227091-3dd44d86e309?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=60",
      "https://images.unsplash.com/photo-1570545889512-8183a37d3cd7?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=60",
      "https://images.unsplash.com/photo-1577896851231-e30e4d0c90fe?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=60",
      "https://images.unsplash.com/photo-1536647388128-d34ca85a3e2b?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=60",
      "https://images.unsplash.com/photo-1523287566039-5c5b942d7e5e?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=60",
      "https://images.unsplash.com/photo-1509060106913-832cd846ae3c?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=60",
      "https://images.unsplash.com/photo-1590402494587-44bdd1a18c2f?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=60",
      "https://images.unsplash.com/photo-1564419320461-6870880221ad?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=60",
      "https://images.unsplash.com/photo-1588075592446-265f1e57e76f?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=60",
      "https://images.unsplash.com/photo-1515041219749-89347f83261a?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=60",
      "https://images.unsplash.com/photo-1498409785966-ab341407de6e?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=60",
      "https://images.unsplash.com/photo-1536329583941-14287ec6fc4e?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=60",
      "https://images.unsplash.com/photo-1491841573634-28140fc7ced7?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=60",
      "https://images.unsplash.com/photo-1540206395-68808572332f?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=60",
      "https://images.unsplash.com/photo-1505471767878-08e9b5c5b4a0?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=60",
      "https://images.unsplash.com/photo-1516321310766-66f1cc4a9b61?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=60"
    ],
    "2017-18": [
      "https://images.unsplash.com/photo-1509060106913-832cd846ae3c?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=60",
      "https://images.unsplash.com/photo-1590402494587-44bdd1a18c2f?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=60",
      "https://images.unsplash.com/photo-1564419320461-6870880221ad?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=60",
      "https://images.unsplash.com/photo-1588075592446-265f1e57e76f?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=60",
      "https://images.unsplash.com/photo-1515041219749-89347f83261a?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=60",
      "https://images.unsplash.com/photo-1498409785966-ab341407de6e?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=60",
      "https://images.unsplash.com/photo-1536329583941-14287ec6fc4e?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=60",
      "https://images.unsplash.com/photo-1491841573634-28140fc7ced7?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=60",
      "https://images.unsplash.com/photo-1540206395-68808572332f?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=60",
      "https://images.unsplash.com/photo-1505471767878-08e9b5c5b4a0?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=60",
      "https://images.unsplash.com/photo-1516321310766-66f1cc4a9b61?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=60",
      "https://images.unsplash.com/photo-1523050854058-8df90110c9f1?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=60",
      "https://images.unsplash.com/photo-1503676260728-1c00da094a0b?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=60",
      "https://images.unsplash.com/photo-1497636577773-f1231844b336?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=60",
      "https://images.unsplash.com/photo-1580582932707-520aed937b7b?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=60",
      "https://images.unsplash.com/photo-1544531586-f17a1c8d6d3a?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=60",
      "https://images.unsplash.com/photo-1516979187457-637abb4f2be7?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=60",
      "https://images.unsplash.com/photo-1522071820081-5a05c400f035?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=60",
      "https://images.unsplash.com/photo-1588072432836-e10032774350?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=60",
      "https://images.unsplash.com/photo-1535982330050-f1c2fb6d420b?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=60",
      "https://images.unsplash.com/photo-1498243691581-b145c3f54a5a?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=60",
      "https://images.unsplash.com/photo-1461896836934-ffe607ba5e93?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=60",
      "https://images.unsplash.com/photo-1552673597-e3e4edb8f5a5?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=60",
      "https://images.unsplash.com/photo-1517931524306-364c4e4f7263?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=60",
      "https://images.unsplash.com/photo-1517486808906-6ca8b3f04846?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=60",
      "https://images.unsplash.com/photo-1606760227091-3dd44d86e309?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=60",
      "https://images.unsplash.com/photo-1570545889512-8183a37d3cd7?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=60",
      "https://images.unsplash.com/photo-1577896851231-e30e4d0c90fe?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=60",
      "https://images.unsplash.com/photo-1536647388128-d34ca85a3e2b?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=60",
      "https://images.unsplash.com/photo-1523287566039-5c5b942d7e5e?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=60"
    ],
    // Repeat similar arrays for other years (2018-19 to 2025-26) with shuffled or unique URLs
    "2018-19": [
      "https://images.unsplash.com/photo-1497636577773-f1231844b336?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=60",
      "https://images.unsplash.com/photo-1580582932707-520aed937b7b?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=60",
      "https://images.unsplash.com/photo-1544531586-f17a1c8d6d3a?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=60",
      // ... Add 27 more unique or shuffled URLs
    ],
    "2019-20": [
      "https://images.unsplash.com/photo-1516979187457-637abb4f2be7?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=60",
      "https://images.unsplash.com/photo-1522071820081-5a05c400f035?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=60",
      "https://images.unsplash.com/photo-1588072432836-e10032774350?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=60",
      // ... Add 27 more
    ],
    // Add similar arrays for 2020-21 to 2025-26
  };

  // Current zoom level
  let zoomLevel = 1; // Default 100%

  // Open year gallery in popup
  document.querySelectorAll('.folder').forEach(folder => {
    folder.addEventListener('click', function() {
      const year = folder.getAttribute('data-year');
      document.getElementById('popupTitle').textContent = `${year} Gallery`;
      const galleryView = document.getElementById('galleryView');
      galleryView.innerHTML = '';
      const images = imagesByYear[year] || imagesByYear["2016-17"]; // Fallback to 2016-17 for demo
      images.forEach(src => {
        const img = document.createElement('img');
        img.src = src;
        img.alt = `${year} image`;
        img.onclick = function() { openImage(this); };
        galleryView.appendChild(img);
      });
      document.getElementById('galleryView').style.display = 'grid';
      document.getElementById('imageView').style.display = 'none';
      document.getElementById('popupOverlay').style.display = 'flex';
    });
  });

  function openImage(imgEl) {
    document.getElementById('galleryView').style.display = 'none';
    document.getElementById('imageView').style.display = 'block';
    const largeImg = document.getElementById('largeImage');
    largeImg.src = imgEl.src;
    largeImg.alt = imgEl.alt;
    zoomLevel = 1; // Reset zoom
    largeImg.style.transform = `scale(${zoomLevel})`;
  }

  function backToGallery() {
    document.getElementById('galleryView').style.display = 'grid';
    document.getElementById('imageView').style.display = 'none';
    zoomLevel = 1; // Reset zoom
    document.getElementById('largeImage').style.transform = `scale(${zoomLevel})`;
  }

  function closePopup() {
    document.getElementById('popupOverlay').style.display = 'none';
    zoomLevel = 1; // Reset zoom
    document.getElementById('largeImage').style.transform = `scale(${zoomLevel})`;
  }

  function zoomIn() {
    zoomLevel = Math.min(zoomLevel + 0.5, 2); // Max 200%
    document.getElementById('largeImage').style.transform = `scale(${zoomLevel})`;
  }

  function zoomOut() {
    zoomLevel = Math.max(zoomLevel - 0.5, 0.5); // Min 50%
    document.getElementById('largeImage').style.transform = `scale(${zoomLevel})`;
  }

  // Close popup when clicking outside content
  document.getElementById('popupOverlay').addEventListener('click', function(e) {
    if (e.target === this) {
      closePopup();
    }
  });
</script>

</body>
</html>