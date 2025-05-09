<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Admin Registration</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600&display=swap" rel="stylesheet" />
  <style>
    body {
      font-family: 'Inter', sans-serif;
      background: linear-gradient(135deg, #f3f4f6, #e5e7eb);
    }

    .form-container {
      max-width: 900px;
      margin: 2rem auto;
      padding: 2rem;
      background: white;
      border-radius: 1rem;
      box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
      animation: fadeIn 1s ease-in-out;
    }

    .form-title {
      text-align: center;
      font-size: 2rem;
      font-weight: 600;
      color: #1f2937;
      margin-bottom: 1.5rem;
    }

    .error-message {
      font-size: 0.875rem;
      color: #dc2626;
      margin-top: 0.25rem;
    }

    .floating-input {
      position: relative;
      margin-bottom: 1.5rem;
    }

    .floating-input input,
    .floating-input textarea {
      width: 100%;
      padding: 1rem 1rem 0.5rem;
      font-size: 1rem;
      border: 1px solid #d1d5db;
      border-radius: 0.5rem;
      outline: none;
      background: transparent;
      transition: all 0.3s ease;
    }

    .floating-input label {
      position: absolute;
      top: 1rem;
      left: 1rem;
      font-size: 1rem;
      color: #6b7280;
      background: white;
      padding: 0 0.25rem;
      pointer-events: none;
      transition: 0.3s ease;
    }

    .floating-input input:focus + label,
    .floating-input input:not(:placeholder-shown) + label,
    .floating-input textarea:focus + label,
    .floating-input textarea:not(:placeholder-shown) + label {
      top: -0.6rem;
      left: 0.8rem;
      font-size: 0.8rem;
      color: #2563eb;
    }

    button {
      background-color: #3b82f6;
      color: white;
      padding: 0.75rem 1.5rem;
      font-weight: 600;
      border-radius: 0.5rem;
      transition: background-color 0.3s ease, transform 0.2s ease;
    }

    button:hover {
      background-color: #2563eb;
      transform: scale(1.03);
    }

    button:active {
      transform: scale(0.97);
    }

    @media (min-width: 768px) {
      .form-grid {
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 1.5rem;
      }
    }

    @keyframes slideDown {
      from { transform: translate(-50%, -100%); opacity: 0; }
      to { transform: translate(-50%, 0); opacity: 1; }
    }

    @keyframes slideUp {
      from { transform: translate(-50%, 0); opacity: 1; }
      to { transform: translate(-50%, -100%); opacity: 0; }
    }
  </style>
</head>
<body>

<%
    if(request.getParameter("name") != null) {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String aadhar = request.getParameter("aadhar");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String dob = request.getParameter("dob");
        String address = request.getParameter("address");
        String pincode = request.getParameter("pincode");

        if (!password.equals(confirmPassword)) {
            out.println("<script>alert('Passwords do not match. Please try again.');</script>");
        } else {
            Connection con = null;
            PreparedStatement ps = null;
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/school_data", "root", "W7301@jqir#");

                String sql = "INSERT INTO admin_registration(name, email, phone_number, aadhar_number, password, confirm_password, dob, address, pincode) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
                ps = con.prepareStatement(sql);
                ps.setString(1, name);
                ps.setString(2, email);
                ps.setString(3, phone);
                ps.setString(4, aadhar);
                ps.setString(5, password);
                ps.setString(6, confirmPassword);
                ps.setString(7, dob);
                ps.setString(8, address);
                ps.setString(9, pincode);

                int i = ps.executeUpdate();
                if (i > 0) {
                    out.println("<script>" +
                        "function showPopup(message, isSuccess) {" +
                        "    const popup = document.createElement('div');" +
                        "    popup.style.position = 'fixed';" +
                        "    popup.style.top = '20px';" +
                        "    popup.style.left = '50%';" +
                        "    popup.style.transform = 'translateX(-50%)';" +
                        "    popup.style.padding = '15px 30px';" +
                        "    popup.style.borderRadius = '5px';" +
                        "    popup.style.color = 'white';" +
                        "    popup.style.fontWeight = 'bold';" +
                        "    popup.style.zIndex = '1000';" +
                        "    popup.style.boxShadow = '0 4px 6px rgba(0, 0, 0, 0.1)';" +
                        "    popup.style.animation = 'slideDown 0.5s ease-out';" +
                        "    popup.style.backgroundColor = isSuccess ? '#4CAF50' : '#f44336';" +
                        "    popup.textContent = message;" +
                        "    document.body.appendChild(popup);" +
                        "    setTimeout(() => {" +
                        "        popup.style.animation = 'slideUp 0.5s ease-out';" +
                        "        setTimeout(() => {" +
                        "            document.body.removeChild(popup);" +
                        "            if(isSuccess) window.location.href='AdminLogin.jsp';" +
                        "        }, 500);" +
                        "    }, 2000);" +
                        "}" +
                        "showPopup('Admin Registered Successfully!', true);" +
                        "</script>");
                } else {
                    out.println("<script>showPopup('Registration Failed!', false);</script>");
                }
            } catch(Exception e) {
                if (e.getMessage().contains("Duplicate entry")) {
                    out.println("<script>showPopup('Error: Email or Aadhar number already exists!', false);</script>");
                } else {
                    out.println("<script>showPopup('Database error: " + e.getMessage().replace("'", "\\'") + "', false);</script>");
                }
            } finally {
                try { if(ps != null) ps.close(); } catch(Exception e) {}
                try { if(con != null) con.close(); } catch(Exception e) {}
            }
        }
    }
%>

<div class="form-container">
  <h1 class="form-title">Admin Registration</h1>

  <form method="post" id="adminForm" onsubmit="return validateAdminForm(event)">
    <div class="form-grid">
      <div class="floating-input">
        <input type="text" id="name" name="name" required placeholder=" " />
        <label for="name">Name <span class="text-red-500">*</span></label>
      </div>

      <div class="floating-input">
        <input type="email" id="email" name="email" required placeholder=" " />
        <label for="email">Email <span class="text-red-500">*</span></label>
        <p id="email-error" class="error-message hidden"></p>
      </div>

      <div class="floating-input">
        <input type="text" id="phone" name="phone" required placeholder=" " />
        <label for="phone">Phone Number <span class="text-red-500">*</span></label>
      </div>

      <div class="floating-input">
        <input type="text" id="aadhar" name="aadhar" required placeholder=" " />
        <label for="aadhar">Aadhar Number <span class="text-red-500">*</span></label>
        <p id="aadhar-error" class="error-message hidden"></p>
      </div>

      <div class="floating-input">
        <input type="password" id="password" name="password" required placeholder=" " />
        <label for="password">Password <span class="text-red-500">*</span></label>
        <p id="password-error" class="error-message hidden"></p>
      </div>

      <div class="floating-input">
        <input type="password" id="confirmPassword" name="confirmPassword" required placeholder=" " />
        <label for="confirmPassword">Confirm Password <span class="text-red-500">*</span></label>
        <p id="confirm-password-error" class="error-message hidden"></p>
      </div>

      <div class="floating-input">
        <input type="date" id="dob" name="dob" required placeholder=" " />
        <label for="dob">Date of Birth <span class="text-red-500">*</span></label>
      </div>

      <div class="floating-input">
        <input type="text" id="pincode" name="pincode" required placeholder=" " />
        <label for="pincode">Pincode <span class="text-red-500">*</span></label>
        <p id="pincode-error" class="error-message hidden"></p>
      </div>
    </div>

    <div class="floating-input">
      <textarea id="address" name="address" required placeholder=" " rows="3"></textarea>
      <label for="address">Address <span class="text-red-500">*</span></label>
    </div>

    <div class="text-center mt-4">
      <button type="submit">Register</button>
    </div>
  </form>
</div>

<script>
  function showPopup(message, isSuccess) {
    const popup = document.createElement('div');
    popup.style.position = 'fixed';
    popup.style.top = '20px';
    popup.style.left = '50%';
    popup.style.transform = 'translateX(-50%)';
    popup.style.padding = '15px 30px';
    popup.style.borderRadius = '5px';
    popup.style.color = 'white';
    popup.style.fontWeight = 'bold';
    popup.style.zIndex = '1000';
    popup.style.boxShadow = '0 4px 6px rgba(0, 0, 0, 0.1)';
    popup.style.animation = 'slideDown 0.5s ease-out';
    
    if (isSuccess) {
      popup.style.backgroundColor = '#4CAF50';
    } else {
      popup.style.backgroundColor = '#f44336';
    }
    
    popup.textContent = message;
    document.body.appendChild(popup);
    
    setTimeout(() => {
      popup.style.animation = 'slideUp 0.5s ease-out';
      setTimeout(() => {
        document.body.removeChild(popup);
      }, 500);
    }, 3000);
  }

  function validateAdminForm(event) {
    event.preventDefault();
    let valid = true;

    const email = document.getElementById("email");
    const emailError = document.getElementById("email-error");
    const aadhar = document.getElementById("aadhar");
    const aadharError = document.getElementById("aadhar-error");
    const password = document.getElementById("password");
    const confirmPassword = document.getElementById("confirmPassword");
    const passwordError = document.getElementById("password-error");
    const confirmPasswordError = document.getElementById("confirm-password-error");
    const pincode = document.getElementById("pincode");
    const pincodeError = document.getElementById("pincode-error");

    emailError.textContent = aadharError.textContent = passwordError.textContent =
    confirmPasswordError.textContent = pincodeError.textContent = "";

    emailError.classList.add("hidden");
    aadharError.classList.add("hidden");
    passwordError.classList.add("hidden");
    confirmPasswordError.classList.add("hidden");
    pincodeError.classList.add("hidden");

    if (!email.value.match(/^[^ ]+@[^ ]+\.[a-z]{2,3}$/)) {
      emailError.textContent = "❌ Invalid email format.";
      emailError.classList.remove("hidden");
      valid = false;
    }

    if (!aadhar.value.match(/^\d{12}$/)) {
      aadharError.textContent = "❌ Aadhar number must be 12 digits.";
      aadharError.classList.remove("hidden");
      valid = false;
    }

    if (password.value.length < 6) {
      passwordError.textContent = "❌ Password must be at least 6 characters.";
      passwordError.classList.remove("hidden");
      valid = false;
    }

    if (confirmPassword.value !== password.value) {
      confirmPasswordError.textContent = "❌ Passwords do not match.";
      confirmPasswordError.classList.remove("hidden");
      valid = false;
    }

    if (!pincode.value.match(/^\d{6}$/)) {
      pincodeError.textContent = "❌ Pincode must be 6 digits.";
      pincodeError.classList.remove("hidden");
      valid = false;
    }

    if (valid) {
      event.target.submit();
    }
  }
</script>

</body>
</html> 