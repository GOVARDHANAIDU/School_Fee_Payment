<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Add/Edit Questions</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
  
  <link rel="stylesheet" href="https://code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
  
  <link rel="icon" href="https://cdn-icons-png.flaticon.com/512/2132/2132732.png" type="image/x-icon">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"> 
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <style>
    body {
      background: linear-gradient(135deg, #e0f7fa, #e8f5e9);
      font-family: Arial, sans-serif;
      font-size: 12px;
      font-family: 'Segoe UI', sans-serif;
	  margin: 0;
	  padding-top: 70px;
	  padding-bottom: 0;
    }
     .navbar {
      position: fixed;
      top: 0;
      width: 100%;
      z-index: 1030;
    }
    .container-box {
      background: #ffffff;
      border: 1px solid #d0e2ec;
      border-radius: 6px;
      padding: 12px;
      margin-top: 15px;
      box-shadow: 0 2px 6px rgba(0,0,0,0.08);
    }
    h5 { font-size: 14px; font-weight: bold; color: #00796b; }
    label { font-size: 11px; font-weight: 600; margin-bottom: 2px; }
    .form-select, .form-control, .select2-container .select2-selection--single {
      width: 100% !important;
      font-size: 11px;
      height: 26px !important;
      padding: 0 4px;
      border-radius: 4px;
      background-color: #f4f9fc;
      text-align: center;
    }
    .select2-container--default .select2-selection--single {
      border: 1px solid #a9cfd6;
      background-color: #f4f9fc;
      height: 26px !important;
    }
    .select2-container--default .select2-selection--single .select2-selection__rendered {
      font-size: 11px;
      line-height: 24px !important;
      text-align: center;
      width: 100%;
    }
    .select2-container--default .select2-selection--single .select2-selection__arrow {
      height: 24px;
    }
    .editor-box { border: 1px solid #ccc; background: #fafafa; font-size: 12px; padding: 4px; }
    .questionBox {
      width: 100%;
      height: 60px;   /* increased height */
      border: 1px solid #888;
      border-radius: 3px;
      font-size: 12px;
      padding: 4px;
      text-align: left; /* left aligned */
      resize: vertical;
    }
    .upload-box {
      border: 1px dashed #bbb; text-align: center; padding: 10px; cursor: pointer;
      background: #fdfefe; font-size: 11px; border-radius: 4px; width: 100%;
    }
    .upload-box:hover { background: #f2f9f9; }
    .option-box {
      border: 1px solid #ddd;
      padding: 4px;
      border-radius: 4px;
      margin-bottom: 4px;
      background: #f9fafc;
      font-size: 11px;
      text-align: left; /* options aligned left */
    }
    .options-scroll { max-height: 200px; overflow-y: auto; border: 1px solid #ddd; padding: 6px; background: #fff; border-radius: 4px; }
    .switch { position: relative; display: inline-block; width: 32px; height: 16px; }
    .switch input { display: none; }
    .slider { position: absolute; cursor: pointer; top: 0; left: 0; right: 0; bottom: 0; background-color: #ccc; transition: .3s; border-radius: 20px; }
    .slider:before { position: absolute; content: ""; height: 12px; width: 12px; left: 2px; bottom: 2px; background-color: white; transition: .3s; border-radius: 50%; }
    input:checked + .slider { background-color: #26a69a; }
    input:checked + .slider:before { transform: translateX(16px); }
    .btn-sm { font-size: 11px; padding: 3px 8px; border-radius: 4px; }
    .question-table th { font-size: 12px; text-align: center; }
    .question-table td { font-size: 12px; vertical-align: top; }
    .qid-box { background:#26a69a; color:#fff; padding:3px 8px; border-radius:6px; font-weight:bold; }
    .diff-box, .type-box { background:#f0f0f0; padding:3px 8px; border-radius:4px; display:inline-block; }
    .option-view { border:1px solid #ddd; padding:4px; margin:2px; border-radius:4px; }
    .answer-box { border:2px solid #26a69a; background:#e0f7f5; font-weight:bold; }
    .action-btns button { margin:0 2px; font-size:11px; }
        .download-link {
      display: inline-block;
      margin-top: 15px;
      padding: 8px 16px;
      background: #007bff;
      color: #fff;
      text-decoration: none;
      border-radius: 6px;
      font-size: 14px;
      transition: background 0.3s;
    }

    .download-link:hover {
      background: #0056b3;
    }

  </style>
  <link href="./student-profile.css" rel="stylesheet">
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
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">Payments</a>
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
        <li class="nav-item"><a class="nav-link" href="fee-notifications.jsp">Send Notifications</a></li>
        <li class="nav-item"><a class="nav-link" href="#">Contact Us</a></li>
        
      </ul>

      <!-- Right Side -->
<%
    // Session validation: Redirect to login if not authenticated
    // Check for any login indicator (admin, student, or faculty)
    HttpSession sessio = request.getSession(false); // Don't create new session if none exists
    if (sessio == null || 
        (sessio.getAttribute("adminName") == null && 
        sessio.getAttribute("studentId") == null && 
        sessio.getAttribute("facultyId") == null)) {
        response.sendRedirect("AdminLogin.jsp");
        return;
    }

    // Prevent caching to avoid back/forward navigation issues after logout or session expiry
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

    // Get user name for display (prioritize adminName, fallback to others if needed)
    String displayName = (String) session.getAttribute("adminName");
    if (displayName == null) {
        // For student or faculty, you might set a "userName" attribute in servlet; adjust as needed
        displayName = "User"; // Fallback
    }
    String userName = "";
    for(int i = 0; i < displayName.length(); i++) {
        char ch = displayName.charAt(i);
        if(ch == ' ') break;
        else userName += ch;
    }
%>
      <div class="d-flex align-items-center ms-3">
        <p class="text-white mb-0 me-3">Hello, <%=userName%></p>

        <!-- Roles Dropdown -->
        <div class="dropdown me-3">
          <a class="btn btn-sm btn-outline-light dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">
            Roles
          </a>
          <ul class="dropdown-menu dropdown-menu-end">
            <li><a class="dropdown-item" href="home.jsp">Channel Admin</a></li>
            <li><a class="dropdown-item" href="#">Student</a></li>
            <li><a class="dropdown-item" href="./faculty/faculty.jsp">Faculty</a></li>
          </ul>
        </div>

        <!-- Auth Buttons -->
        <a class="btn btn-outline-light btn-sm me-2" href="AdminLogin.jsp">Logout</a>
        <a class="btn btn-outline-warning btn-sm" href="createaccount.jsp">Signup</a>
      </div>
    </div>
  </div>
</nav>

<div class="container">
  <h5 class="mt-2">Add/Edit Questions</h5>
  <div class="container-box">

    <!-- Top Filters -->
    <div class="row mb-2">
      <div class="col-md-3">
        <label>Course</label>
        <select id="course" class="form-select searchable"></select>
      </div>
      <div class="col-md-3">
        <label>Topic</label>
        <select id="topic" class="form-select searchable"></select>
      </div>
      <div class="col-md-3">
        <label>Section</label>
        <select id="section" class="form-select searchable">
          <option>Lab Programs</option>
          <option>Theory</option>
        </select>
      </div>
      <div class="col-md-3">
        <label>Question Type</label>
        <select id="qType" class="form-select searchable">
          <option>Multiple Choice - Single Answer</option>
          <option>Multiple Choice - Multiple Answer</option>
        </select>
      </div>
    </div>

    <div class="row mb-2">
      <div class="col-md-3">
        <label>Difficulty</label>
        <select id="difficulty" class="form-select searchable">
          <option>Very Easy</option>
          <option>Easy</option>
          <option>Medium</option>
          <option>Hard</option>
        </select>
      </div>
      <div class="col-md-3">
        <label>Knowledge Level</label>
        <select id="knowledge" class="form-select searchable">
          <option>K1.Remembering</option>
          <option>K2.Understanding</option>
        </select>
      </div>
      <div class="col-md-3">
        <label>Enabled</label><br>
        <label class="switch">
          <input type="checkbox" id="enabled" checked>
          <span class="slider"></span>
        </label>
      </div>
    </div>

    <!-- Tabs -->
    <ul class="nav nav-tabs tab-section" id="questionTabs">
      <li class="nav-item"><button class="nav-link active" data-bs-toggle="tab" data-bs-target="#text">Question</button></li>
      <li class="nav-item"><button class="nav-link" data-bs-toggle="tab" data-bs-target="#hints">Hints</button></li>
    </ul>

    <div class="tab-content border p-2">
      <div class="tab-pane fade show active" id="text">
        <div class="editor-box">
          <textarea id="questionText" class="questionBox" placeholder="Type question here..."></textarea>
        </div>
      </div>
      <div class="tab-pane fade" id="hints">
        <textarea id="hintsText" class="form-control" rows="2" placeholder="Hints..." style="text-align:left;"></textarea>
      </div>
    </div>

    <!-- Upload -->
    <div class="row mt-2">
      <div class="col-md-6">
        <div class="upload-box">Click to browse<br>or<br>[ Drop file ]</div>
       <a href="" download class="download-link">Download Sample</a>    
       </div>
      <div class="col-md-6">
        <label>Latex Expression</label>
        <input type="text" class="form-control">
      </div>
    </div>

    <!-- Options -->
    <h6 class="mt-3">Options</h6>
    <div class="options-scroll" id="options-container"></div>

    <!-- Save Buttons -->
    <div class="mt-2 text-end">
      <button id="saveBtn" class="btn btn-success btn-sm">Save</button>
      <button id="resetBtn" class="btn btn-warning btn-sm">Reset</button>
      <button class="btn btn-info btn-sm">History</button>
    </div>

    <!-- Dynamic Table -->
    <h6 class="mt-4">Saved Questions</h6>
    <div class="table-responsive">
      <table class="table table-bordered question-table" id="questionsTable">
        <thead class="table-light">
          <tr>
            <th><input type="checkbox" id="selectAll"></th>
            <th>Actions</th>
            <th>QID</th>
            <th>Difficulty</th>
            <th>Type</th>
            <th>Question & Options</th>
          </tr>
        </thead>
        <tbody id="sortableRows"></tbody>
      </table>
    </div>

  </div>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<script>
  $(document).ready(function() {
    $('.searchable').select2({ minimumResultsForSearch: 0, width: 'resolve', allowClear: false });
  });

  // Generate option inputs
  const optionsContainer = document.getElementById("options-container");
  for (let i = 1; i <= 5; i++) {
    const div = document.createElement("div");
    div.classList.add("option-box");
    div.innerHTML = `
      <div class="row">
        <div class="col-md-6">
          <input type="text" class="form-control form-control-sm mb-1 optionText" placeholder="Option ${i}">
        </div>
        <div class="col-md-3">
          <input type="text" class="form-control form-control-sm mb-1 optionReason" placeholder="Reason">
        </div>
        <div class="col-md-3 d-flex align-items-center">
          <input type="checkbox" class="form-check-input me-1 optionEnable" ${i <= 4 ? "checked" : ""}>
          <label class="mb-0 me-2">Enable</label>
          <input type="radio" name="answer" class="form-check-input me-1 optionAns">
          <label class="mb-0">Ans</label>
        </div>
      </div>
    `;
    optionsContainer.appendChild(div);
  }

  // Reset functionality
  document.getElementById("resetBtn").addEventListener("click", function() {
    document.getElementById("questionText").value = "";
    document.getElementById("hintsText").value = "";
    document.querySelectorAll(".optionText").forEach(el => el.value = "");
    document.querySelectorAll(".optionReason").forEach(el => el.value = "");
    document.querySelectorAll(".optionEnable").forEach((el, idx) => el.checked = idx < 4);
    document.querySelectorAll(".optionAns").forEach(el => el.checked = false);
  });

  // Save to DB
  document.getElementById("saveBtn").addEventListener("click", function() {
    const question = $("#questionText").val().trim();
    const hints = $("#hintsText").val().trim();
    const difficulty = $("#difficulty").val();
    const qType = $("#qType").val();

    let options = [];
    $(".option-box").each(function() {
      let text = $(this).find(".optionText").val().trim();
      let reason = $(this).find(".optionReason").val().trim();
      let enabled = $(this).find(".optionEnable").is(":checked");
      let isAnswer = $(this).find(".optionAns").is(":checked");
      if (enabled && text !== "") {
        options.push({ text, reason, isAnswer });
      }
    });

    if (question === "") {
      alert("Please enter a question.");
      return;
    }

    $.ajax({
      url: "save_question.jsp",
      type: "POST",
      data: {
        question: question,
        hints: hints,
        difficulty: difficulty,
        qType: qType,
        options: JSON.stringify(options)
      },
      success: function(res) {
        alert("✅ Question saved!");
      },
      error: function() {
        alert("❌ Error saving question");
      }
    });
  });

  // Select/Unselect all
  $("#selectAll").on("change", function(){ $("#questionsTable tbody input[type=checkbox]").prop("checked", this.checked); });

  // Sortable rows
  $("#sortableRows").sortable({ axis: "y", containment: "parent" });
</script>
</body>
</html>
