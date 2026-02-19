<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Student Info Lookup</title>
  <link rel="icon" href="https://cdn-icons-png.flaticon.com/512/2132/2132732.png" type="image/x-icon">
  <!-- Select2 CSS -->
  <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
 
  <!-- Fonts and custom CSS -->
  <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <style>
 
    .dropdown-menu {
      font-size: 0.8rem; /* Smaller dropdown font */
    }
 
    .dropdown-item {
      padding: 6px 12px;
    }
 
    /* Footer */
    .footer {
      margin-bottom: 0;
      padding-bottom: 0;
    }
 
    .footer a {
      color: #ffc107;
      text-decoration: none;
    }
 
    .maincontainer {
      background: white;
      padding: 30px 40px;
      border-radius: 12px;
      box-shadow: 0 4px 20px rgba(0, 0, 0, 0.15);
      width: 100%;
      max-width: 900px; /* Responsive max-width */
      margin: auto;
      margin-bottom: 50px; /* Adjusted for better spacing */
    }
 
    /* Desktop: Side-by-side layout */
    @media (min-width: 768px) {
      .leftcontainer, .rightcontainer {
        width: 45%;
        display: inline-block;
        vertical-align: top;
        margin: 0 2%;
      }
 
      .rightcontainer {
        margin-top: -3%;
      }
 
      .preview {
        width: 28%;
        margin-left: 35%;
        height: 40px;
        border-radius: 30px;
        background: linear-gradient(135deg, #dff6ff, #b6e3f9);
        border: none;
        font-size: 0.9rem;
        font-weight: 500;
        transition: transform 0.2s ease; /* Hover effect for attractiveness */
      }
    }
 
    /* Mobile: Stacked layout */
    @media (max-width: 767.98px) {
      .leftcontainer, .rightcontainer {
        width: 100%;
        display: block;
        margin: 0 0 20px 0; /* Vertical spacing */
      }
 
      .preview {
        width: 100%; /* Full width on mobile */
        margin-left: 0;
        height: 45px; /* Slightly taller for touch */
        border-radius: 8px;
        font-size: 1rem;
      }
 
      h2 {
        font-size: 1.3rem; /* Smaller header on mobile */
      }
 
      label {
        font-size: 0.95rem;
      }
 
      input, select {
        padding: 12px; /* Larger padding for touch */
        font-size: 16px; /* Prevent zoom on iOS */
      }
 
      .maincontainer {
        padding: 20px 15px; /* Less padding on mobile */
        margin-bottom: 20px;
      }
    }
 
    h2 {
      text-align: center;
      color: #2b6cb0;
      margin-bottom: 30px;
      font-size: 1.5rem; /* Smaller header font */
      font-weight: 600;
    }
 
    label {
      font-weight: bold;
      margin-top: 15px;
      display: block;
      color: #2a4365;
      font-size: 0.9rem; /* Smaller label font */
    }
 
    input, select {
      width: 100%;
      padding: 8px; /* Slightly smaller padding */
      margin-top: 5px;
      margin-bottom: 15px; /* Tighter spacing */
      border: 1px solid #cbd5e0;
      border-radius: 6px;
      font-size: 14px; /* Smaller input font */
      box-sizing: border-box; /* Ensure padding is included in width */
    }
 
    input[readonly] {
      background-color: #f1f5f9;
      cursor: not-allowed;
    }
 
    .select2-container .select2-selection--single {
      height: 38px; /* Adjusted height for smaller font */
      padding: 4px 8px;
    }
 
    .select2-container--default .select2-selection--single .select2-selection__rendered {
      font-size: 14px;
    }
 
    .preview {
      height: 40px;
      border-radius: 30px;
      background: linear-gradient(135deg, #dff6ff, #b6e3f9);
      border: none;
      font-size: 0.9rem;
      font-weight: 500;
      transition: transform 0.2s ease; /* Hover effect for attractiveness */
    }
 
    .preview:hover:not(:disabled) {
      transform: scale(1.02);
    }
 
    .preview:disabled {
      opacity: 0.6;
      cursor: not-allowed;
    }
   .proceed-btn {
  background: #000000; /* Pure black */
  color: white;
  border: none;
  border-radius: 12px;
  padding: 0.8rem 2.5rem;
  font-size: 0.95rem;
  font-weight: 600;
  width: 100%;
  max-width: 320px;
  margin: 2.5rem auto 0 auto;
  display: block;
  transition: all 0.3s ease;
  box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
  letter-spacing: 0.5px;
}

.proceed-btn:hover:not(:disabled) {
  background: #1a1a1a; /* Slightly lighter black on hover for depth */
  transform: translateY(-3px);
  box-shadow: 0 12px 25px rgba(0, 0, 0, 0.3);
}

.proceed-btn:active:not(:disabled) {
  transform: translateY(-1px);
}

.proceed-btn:disabled {
  background: #4a4a4a; /* Dark gray for disabled – still matches black theme */
  color: #aaaaaa;
  cursor: not-allowed;
  transform: none;
  box-shadow: none;
  opacity: 0.7;
}
  </style>
  <link href="./student-profile.css" rel="stylesheet">
 
</head>
<body>
 
  <jsp:include page="includes/navbar.jsp" />

  <div class="maincontainer">
  <br><br>
<h2>Student Fee Billing</h2>
    <!-- Responsive Row for Left and Right Containers -->
    <div class="row">
      <div class="col-md-6 leftcontainer">
        <label for="studentDropdown">Select Student:</label>
        <select id="studentDropdown" name="studentName" style="width: 100%">
          <option></option>
        </select>
        
        <%
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setDateHeader("Expires", 0);
        String displayName = (String) session.getAttribute("adminName");

        String role = (String) session.getAttribute("Roles");
        String admissionNo = (String) session.getAttribute("admissionNo");

          HttpSession session2 = request.getSession();
          session2.setAttribute("studentName", request.getParameter("studentName"));
          System.out.println(request.getParameter("studentName"));
        %>
        
        <label for="email">Email:</label>
        <input type="text" id="email" readonly name="email" />
 
        <label for="totalFee">Total Fee:</label>
        <input type="text" id="totalFee" readonly name="totalFee">
 
 
        <label for="paidfee">Paid Fee:</label>
        <input type="text" id="paidfee" readonly name="paidfee" />
 
        <label for="class1">Class:</label>
        <input type="text" id="class1" placeholder="Class 1 to 10" name="class1" readonly />
      </div>
 	
 	
      <div class="col-md-6 rightcontainer">
      <br>
        <label for="admissionnumber">Admission.no:</label>
        <input type="text" id="admissionnumber" readonly name="admissionnumber" />
 
        <label for="phone">Phone Number:</label>
        <input type="text" id="phone" readonly name="phone" />
 
        <label for="payingfee">Paying fee:</label>
        <input type="number" id="payingfee" name="payingfee">
 
        <label for="modeOfPayment">Mode of payment:</label>
        <select name="paymentMode" id="paymentMode" required="required">
          <option value="Cash">Cash</option>
          <option value="Online">Online</option>
        </select>
 
        <label hidden="true">Billed By:</label>
        <input type="text" hidden="true" value="<%=displayName%>" readonly>
      </div>
    </div>
 	
    <button id="proceedBtn" class="preview btn btn-primary mt-3" disabled>Proceed</button>
 	
  </div>
 	
 	 	<!-- Loading Overlay -->

 
<!-- jQuery and JS -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
 
<script>

  window.userRole = "<%= role.replace("\"", "\\\"") %>";
  window.admissionNo = "<%= admissionNo.replace("\"", "\\\"") %>";
  console.log("User role:", window.userRole);
 
  document.addEventListener("DOMContentLoaded", function () {
      const role = window.userRole;
 
      if (role && role.toLowerCase() === "student") {
          const cashOption = document.querySelector('#paymentMode option[value="Cash"]');
          const paymentMode = document.getElementById("paymentMode");
 
          // Disable and hide Cash option
          if (cashOption) cashOption.hidden = true;
 
          // Force Online as selected for students
          paymentMode.value = "Online";
      }
  });
 
  
  // Add this script at the end of your JSP
  $(document).ready(function() {
      $('#debugBtn').click(function() {
          console.log("=== DEBUG INFO ===");
          console.log("Class field value:", $('#class1').val());
          console.log("Class field HTML:", $('#class1')[0].outerHTML);
          console.log("All form values:", {
              email: $('#email').val(),
              phone: $('#phone').val(),
              totalFee: $('#totalFee').val(),
              paidFee: $('#paidfee').val(),
              payingFee: $('#payingfee').val(),
              admissionNo: $('#admissionnumber').val(),
              class: $('#class1').val(),
              paymentMode: $('#paymentMode').val()
          });
      });
      
      // Also log when the page loads
      console.log("=== PAGE LOADED ===");
      console.log("Initial class field value:", $('#class1').val());
  });  
</script>
<script src="js/billing.js"></script>
 <script src="js/roleControl.js"></script>
 
<!-- Footer (added to match home.jsp structure for consistency) -->
<footer class="footer bg-dark text-white py-3 mt-4">
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