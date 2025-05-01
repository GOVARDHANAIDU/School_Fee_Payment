<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Student Info Lookup</title>

  <!-- Select2 CSS -->
  <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />

  <!-- Fonts and custom CSS -->
  <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">

  <style>
    body {
      font-family: 'Roboto', sans-serif;
      background: linear-gradient(135deg, #dff6ff, #b6e3f9);
      min-height: 100vh;
      display: flex;
      justify-content: center;
      align-items: flex-start;
      padding-top: 60px;
      margin: 0;
    }

    .maincontainer{
      background: white;
      padding: 30px 40px;
      border-radius: 12px;
      box-shadow: 0 4px 20px rgba(0, 0, 0, 0.15);
      width: 900px;
      float: left;
    }
    .leftcontainer {
     margin-top: -20px;
      padding: 30px 40px;
      width: 370px;
      float: left;
    }
    .rightcontainer {
      margin-top: -40px;
      padding: 30px 30px;
      width: 370px;
      float: left;
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
     .btn {
      position: absolute;
      right: 20px;
      background: linear-gradient(135deg, #ebade9, #40344b);
      color: white;
      padding: 8px 20px;
      font-size: 14px;
      border: none;
      border-radius: 6px;
      cursor: pointer;
      transition: background-color 0.5s ease;
      width: 150px;
    }

    .btn:hover {
      background: linear-gradient(135deg, #dff6ff, #b6e3f9);
      color: black;
      transition: background-color 0.3s ease;
    }
    .preview {
    width: 30%;
    margin-left: 35%;
     background: linear-gradient(135deg, #dff6ff, #b6e3f9);
    }
  </style>

  <!-- jQuery and Select2 JS -->
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
</head>
<body>
<form action="previewthebill">
	  <div class="maincontainer">
	  <h2>Search Student Info</h2>
	  <div class="leftcontainer">
	    <label for="studentDropdown">Select Student:</label>
	    <select id="studentDropdown" name="studentName"></select>
	    
	     <label for="email">Email:</label>
	    <input type="text" id="email" readonly name="emailid"/>   
	    
	     <label for="amount">Total Fee:</label>
	    <input type="text" id="amount" readonly name="amount"/> 
	    
	    <label for="paidfee">Paid Fee:</label>
	    <input type="text" id="paidfee" readonly name="paidfee"/>
	     <%
	    HttpSession session2 = request.getSession();
	    String name = (String) session2.getAttribute("userName");
	    %>
	     <label >Billed By:</label>
	    <input type="text" value="<%=name%>" readonly>
	</div>
	
	 <div class="rightcontainer" style="float:right;">
	 
	    <label for="admissionnumber">Admission.no:</label>
	    <input type="text" id="admissionnumber" readonly name="admin.no" />
	   
	    <label for="phone">Phone Number:</label>
	    <input type="text" id="phone" readonly name="phoneNumber"/>
	    
	    
	    <label for="payingfee">Paying fee:</label>
	    <input type="number" id="payingfee" name="payingfee" />
	    
	</div>
	   <input type="submit" class="preview" value="Preview">
	</div>
	 
 </form>   

  <script>
    let studentData = [];

    $(document).ready(function () {
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

          $('#studentDropdown').on('select2:select', function (e) {
            const selectedName = e.params.data.text;
            const selectedStudent = studentData.find(s => s.name === selectedName);

            if (selectedStudent) {
              $('#email').val(selectedStudent.email);
              $('#phone').val(selectedStudent.phone);
              $('#amount').val(selectedStudent.amount);
              $('#paidfee').val(selectedStudent.paidfee);
              $('#admissionnumber').val(selectedStudent.admissionnumber);
            }
          });
        }
      });
    });
  </script>

 <button class="btn" onclick="location.href='AdminLogin.jsp'">🏡 Login</button>
</body>
</html>
