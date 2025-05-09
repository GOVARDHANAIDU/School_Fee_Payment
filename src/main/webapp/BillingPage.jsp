
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Student Info Lookup</title>

  <!-- Select2 CSS -->
  <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
  
  <!-- Fonts and custom CSS -->
  <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

  <style>
    body {
      font-family: 'Roboto', sans-serif;
      background: linear-gradient(135deg, #dff6ff, #b6e3f9);
      margin: 0;
      padding-top: 70px;
    }

    nav.navbar {
      position: fixed;
      top: 0;
      width: 100%;
      z-index: 1000;
    }

    footer {
      position: fixed;
      bottom: 0;
      width: 100%;
      background-color: #343a40;
      color: white;
      text-align: center;
      padding: 8px 0;
      font-size: 14px;
    }

    .maincontainer {
      background: white;
      padding: 30px 40px;
      border-radius: 12px;
      box-shadow: 0 4px 20px rgba(0, 0, 0, 0.15);
      width: 900px;
      margin: auto;
      margin-bottom: 100px;
    }

    .leftcontainer, .rightcontainer {
      width: 45%;
      display: inline-block;
      vertical-align: top;
      margin: 0 2%;
    }

    h2 {
      text-align: center;
      color: #2b6cb0;
      margin-bottom: 30px;
    }

    label {
      font-weight: bold;
      margin-top: 15px;
      display: block;
      color: #2a4365;
    }

    input, select {
      width: 100%;
      padding: 10px;
      margin-top: 5px;
      margin-bottom: 20px;
      border: 1px solid #cbd5e0;
      border-radius: 6px;
      font-size: 16px;
    }

    input[readonly] {
      background-color: #f1f5f9;
      cursor: not-allowed;
    }

    .select2-container .select2-selection--single {
      height: 42px;
      padding: 5px 10px;
    }
    .rightcontainer {
    margin-top: -3% ;
    }
    .preview {
      width: 28%;
      margin-left: 35%;
      height: 40px;
      border-radius: 30px;
      background: linear-gradient(135deg, #dff6ff, #b6e3f9);
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
            <li><a class="dropdown-item" href="studentreg.jsp">Create Student Details</a></li>
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
        String userName = "";
        
        if (name == null) {
            // Redirect if not logged in
            response.sendRedirect("AdminLogin.jsp");
            return;
        }
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

	

  <div class="maincontainer">
    <h2>Search Student Info</h2>
    <div class="leftcontainer">
      <label for="studentDropdown">Select Student:</label>
      <select id="studentDropdown" name="studentName" style="width: 100%">
        <option></option>
          
      </select>
          <% 
        session2.setAttribute("studentName", request.getParameter("studentName"));
          System.out.println(request.getParameter("studentName"));
        %>
      <label for="email">Email:</label>
      <input type="text" id="email" readonly name="email" />

      <label for="amount">Total Fee:</label>
      <input type="text" id="amount" readonly name="amount" />

      <label for="paidfee">Paid Fee:</label>
      <input type="text" id="paidfee" readonly name="paidfee" />

      <label for="class1">Class:</label>
      <input type="text" id="class1" placeholder="Class 1 to 10" name="class1" />
    </div>

    <div class="rightcontainer">
      <label for="admissionnumber">Admission.no:</label>
      <input type="text" id="admissionnumber" readonly name="admissionnumber" />

      <label for="phone">Phone Number:</label>
      <input type="text" id="phone" readonly name="phone" />

      <label for="payingfee">Paying fee:</label>
      <input type="number" id="payingfee" name="payingfee" />

      <label for="modeOfPayment">Mode of payment:</label>
      <select name="paymentMode" id="paymentMode" required="required">
        <option value="Cash">Cash</option>
        <option value="Online">Online</option>
      </select>

      <label>Billed By:</label>
      <input type="text" value="<%=name%>" readonly>
    </div>

    <button id="proceedBtn" class="preview" disabled>Proceed</button>

  </div>




<!-- jQuery and JS -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<script>
  let studentData = [];

  $(document).ready(function () {
    const $payingFee = $('#payingfee');
    const $proceedBtn = $('.preview');
    
    document.getElementById("proceedBtn").addEventListener("click", function () {
    	  const formData = new URLSearchParams();

    	  formData.append("studentName", document.getElementById("studentDropdown").value);
    	  formData.append("email", document.getElementById("email").value);
    	  formData.append("amount", document.getElementById("amount").value);
    	  formData.append("paidfee", document.getElementById("paidfee").value);
    	  formData.append("class1", document.getElementById("class1").value);
    	  formData.append("admissionnumber", document.getElementById("admissionnumber").value);
    	  formData.append("phone", document.getElementById("phone").value);
    	  formData.append("payingfee", document.getElementById("payingfee").value);
    	  formData.append("paymentMode", document.querySelector("select[name='paymentMode']").value);
          
    	  fetch("previewthebill", {
    	    method: "POST", // Switch to POST for better practice
    	    headers: {
    	      "Content-Type": "application/x-www-form-urlencoded"
    	    },
    	    body: formData.toString()
    	  })
    	  .then(response => response.text())
    	  .then(html => {
    	    if (html.includes("<!--payment-page-->")) {
    	      window.location.href = "PreviewPage.jsp"; // fallback if servlet doesn't redirect
    	    } else {
    	      document.open();
    	      document.write(html);
    	      document.close();
    	    }
    	  })
    	  .catch(error => {
    	    console.error("Error:", error);
    	  });
    	});
    
    function toggleProceedButton() {
      const value = parseFloat($payingFee.val());
      if (!value || value <= 0) {
        $proceedBtn.prop('disabled', true);
      } else {
        $proceedBtn.prop('disabled', false);
      }
    }

    // Initially disable the button
    toggleProceedButton();

    // Run on input change
    $payingFee.on('input', toggleProceedButton);

    $.ajax({
      url: 'SearchServlet',
      method: 'GET',
      success: function (data) {
        studentData = data;

        data.forEach(function (student) {
          $('#studentDropdown').append(new Option(student.name, student.name));
        });

        $('#studentDropdown').select2({
          placeholder: 'Search or select a student',
          allowClear: true
        });

        const defaultStudent = studentData.find(s => s.name === "Alice Johnson");
        if (defaultStudent) {
          $('#studentDropdown').val(defaultStudent.name).trigger('change');
          $('#email').val(defaultStudent.email);
          $('#phone').val(defaultStudent.phone);
          $('#amount').val(defaultStudent.amount);
          $('#paidfee').val(defaultStudent.paidfee);
          $('#admissionnumber').val(defaultStudent.admissionnumber);
          $('#class1').val(defaultStudent.class1);
          $('#payingfee').val(defaultStudent.payingfee);
          toggleProceedButton(); // update button state based on default student
        }

        $('#studentDropdown').on('select2:select', function (e) {
          const selectedName = e.params.data.text;
          const selectedStudent = studentData.find(s => s.name === selectedName);

          if (selectedStudent) {
            $('#email').val(selectedStudent.email);
            $('#phone').val(selectedStudent.phone);
            $('#amount').val(selectedStudent.amount);
            $('#paidfee').val(selectedStudent.paidfee);
            $('#admissionnumber').val(selectedStudent.admissionnumber);
            $('#class1').val(selectedStudent.class1);
            $('#payingfee').val(selectedStudent.payingfee);
            toggleProceedButton(); // update button state when selecting new student
          }
        });
      }
    });
  });
  
</script>


</body>
</html>
