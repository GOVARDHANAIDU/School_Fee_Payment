<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Registration Form</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600&display=swap" rel="stylesheet">
    <link rel="icon" href="https://cdn-icons-png.flaticon.com/512/2132/2132732.png" type="image/x-icon">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"> 
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        /* General Body and Background Styling */
        body {
            font-family: 'Inter', sans-serif;
            background-color: #f0f4f8;
            background-image: url('https://images.unsplash.com/photo-1484807352949-98de50075d68?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            animation: fadeInBackground 2s ease forwards;
            margin: 0;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }

        @keyframes fadeInBackground {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        .max-w-2xl {
            width: 75%;
            margin-left: auto;
            margin-right: auto;
            background-color: rgba(255, 255, 255, 0.9);
            padding: 2rem;
            border-radius: 0.5rem;
            box-shadow: 0 0.25rem 1rem rgba(0, 0, 0, 0.1);
            animation: fadeIn 1s ease forwards, slideIn 1s ease forwards;
            transform: translateY(20px);
            opacity: 0;
        }

        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        @keyframes slideIn {
            from { transform: translateY(20px); }
            to { transform: translateY(0); }
        }

        h2 {
            color: #2c3e50;
            text-align: center;
            transition: transform 0.3s ease, color 0.3s ease;
            font-size: 2rem;
            font-weight: bold;
            letter-spacing: 0.1rem;
            text-shadow: 0 0.125rem 0.25rem rgba(0, 0, 0, 0.2);
            font-family: 'Poppins', sans-serif;
        }

        h2:hover {
            transform: scale(1.05);
            color: #3498db;
        }

        .placeholder-float {
            position: relative;
            margin-bottom: 1.5rem;
        }

        .placeholder-float input,
        .placeholder-float textarea,
        .placeholder-float select {
            width: 100%;
            padding: 0.75rem;
            border-radius: 0.375rem;
            border: 1px solid #d1d5db;
            font-size: 1rem;
            line-height: 1.5rem;
            transition: all 0.3s ease-in-out;
            outline: none;
            background-color: transparent;
            font-family: 'Roboto', sans-serif;
        }

        .placeholder-float input:hover,
        .placeholder-float textarea:hover,
        .placeholder-float select:hover {
            border-color: #3498db;
            box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.25);
        }

        .placeholder-float input:focus,
        .placeholder-float textarea:focus,
        .placeholder-float select:focus {
            border-color: #4CAF50;
            box-shadow: 0 0 0 3px rgba(76, 175, 80, 0.25);
        }

        .placeholder-float label {
            position: absolute;
            top: 0.875rem;
            left: 0.75rem;
            font-size: 1rem;
            line-height: 1.5rem;
            color: #6b7280;
            transition: all 0.3s ease-in-out;
            padding: 0 0.25rem;
            background-color: transparent;
            pointer-events: none;
        }

        .placeholder-float input:focus + label,
        .placeholder-float input:not(:placeholder-shown) + label,
        .placeholder-float textarea:focus + label,
        .placeholder-float textarea:not(:placeholder-shown) + label,
        .placeholder-float select:focus + label,
        .placeholder-float select:not(:placeholder-shown) + label {
            transform: translateY(-1.75rem) scale(0.75);
            color: #4CAF50;
        }

        .form-row {
            display: flex;
            justify-content: space-between;
            gap: 2rem;
            flex-wrap: wrap;
        }

        .form-row .placeholder-float {
            width: calc(50% - 1rem);
            margin-bottom: 1.5rem;
        }

        @media (max-width: 600px) {
            .form-row .placeholder-float {
                width: 100%;
            }
            .form-row {
                gap: 1rem;
            }
        }

        button {
            background-color: #4CAF50;
            color: white;
            font-weight: bold;
            padding: 0.75rem 1.5rem;
            border-radius: 0.375rem;
            border: none;
            cursor: pointer;
            transition: background-color 0.3s ease-in-out, transform 0.2s ease;
            box-shadow: 0 0.125rem 0.25rem rgba(0, 0, 0, 0.2);
            display: block;
            margin-left: auto;
            margin-right: auto;
            width: fit-content;
        }

        button:hover {
            background-color: #45a049;
            transform: translateY(-2px);
            box-shadow: 0 0.25rem 0.375rem rgba(0, 0, 0, 0.3);
        }

        button:active {
            transform: translateY(0);
            box-shadow: 0 0.0625rem 0.125rem rgba(0, 0, 0, 0.3);
        }

        .text-red-500 {
            color: #FF0000;
        }

        .error-message {
            font-size: 0.875rem;
            color: #dc2626;
            margin-top: 0.25rem;
        }

        /* Popup Notification Styles */
        .popup {
            position: fixed;
            top: 20px;
            right: 20px;
            padding: 20px 30px;
            border-radius: 10px;
            color: white;
            display: flex;
            align-items: center;
            gap: 15px;
            transform: translateX(120%);
            transition: transform 0.5s cubic-bezier(0.68, -0.55, 0.265, 1.55);
            z-index: 1000;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
        }

        .popup.show {
            transform: translateX(0);
        }

        .popup.success {
            background: linear-gradient(135deg, #4CAF50, #45a049);
        }

        .popup.error {
            background: linear-gradient(135deg, #ff4444, #cc0000);
        }

        .popup .icon {
            font-size: 24px;
            animation: bounce 1s infinite;
        }

        .popup .message {
            font-size: 16px;
            font-weight: 500;
        }

        @keyframes bounce {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-5px); }
        }

        .popup::before {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 100%;
            height: 4px;
            background: rgba(255, 255, 255, 0.3);
            animation: progress 3s linear forwards;
        }

        @keyframes progress {
            from { width: 100%; }
            to { width: 0%; }
        }

        /* Toast Animation */
        @keyframes slideIn {
            from { transform: translateX(100%); }
            to { transform: translateX(0); }
        }

        @keyframes slideOut {
            from { transform: translateX(0); }
            to { transform: translateX(100%); }
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark px-4">
        <div class="container-fluid">
            <a class="navbar-brand" href="#">SAS School</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item"><a class="nav-link active" href="home.jsp">Home</a></li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">Students</a>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href="allStudents.jsp">All Student Info</a></li>
                            <li><a class="dropdown-item" href="BillingPage.jsp">Student Fee Payment</a></li>
                            <li><a class="dropdown-item" href="studentreg.jsp">Create Student Details</a></li>
                            <li><a class="dropdown-item" href="bulkimporting.jsp">Create Bulk</a></li>
                            <li><a class="dropdown-item" href="#">Update Student Details</a></li>
                        </ul>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">Payments</a>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href="#">All Payment Details</a></li>
                            <li><a class="dropdown-item" href="apbme.jsp">Admin Payment</a></li>
                        </ul>
                    </li>
                    <li class="nav-item"><a class="nav-link" href="#">Contact Us</a></li>
                    <li class="nav-item"><a class="nav-link" href="#">About Us</a></li>
                </ul>

                <%
                HttpSession session2 = request.getSession();
                String name = (String) session2.getAttribute("adminName");
                String userName = "";
                for(int i= 0 ; i<=name.length()-1 ; i++) {
                    char ch = name.charAt(i);
                    if(ch == ' ' ) {
                        break;
                    } else {
                        userName = userName+ch;
                    }
                }
                %>
                <div style="display: flex; align-items: center; margin-left: 20px; gap: 10px;">
                    <p style="color: white; margin-right: 40px; padding-top: 10px;">Hello, <%=userName%></p>
                </div>

                <div class="d-flex">
                    <a class="btn btn-outline-light me-2" href="#">Login</a>
                    <a class="btn btn-outline-warning" href="#">Signup</a>
                </div>
            </div>
        </div>
    </nav>

    <div class="max-w-2xl mx-auto bg-white p-8 rounded-md shadow-md">
        <h2 class="text-2xl font-semibold text-gray-800 mb-6 text-center">Student Registration Form</h2>
        <form action="studentregbackend.jsp" method="POST" class="space-y-6" id="registrationForm" onsubmit="return handleSubmit(event)">
            <div class="form-row">
                <div class="placeholder-float">
                    <input type="text" id="adminNo" name="adminNo" placeholder=" " required>
                    <label for="adminNo">Admin. No <span class="text-red-500">*</span></label>
                </div>
                <div class="placeholder-float">
                    <input type="text" id="studentName" name="studentName" placeholder=" " required>
                    <label for="studentName">Student Name <span class="text-red-500">*</span></label>
                </div>
            </div>

            <div class="form-row">
                <div class="placeholder-float">
                    <input type="text" id="fatherName" name="fatherName" placeholder=" " required>
                    <label for="fatherName">Father Name <span class="text-red-500">*</span></label>
                </div>
                <div class="placeholder-float">
                    <input type="text" id="motherName" name="motherName" placeholder=" " required>
                    <label for="motherName">Mother Name <span class="text-red-500">*</span></label>
                </div>
            </div>

            <div class="form-row">
                <div class="placeholder-float">
                    <input type="text" id="mobileNumber" name="mobileNumber" placeholder=" " required>
                    <label for="mobileNumber">Father Number <span class="text-red-500">*</span></label>
                    <p id="mobile-error" class="error-message" style="display: none;"></p>
                </div>
                <div class="placeholder-float">
                    <input type="email" id="email" name="email" placeholder=" ">
                    <label for="email">Email</label>
                    <p id="email-error" class="error-message" style="display: none;"></p>
                </div>
            </div>

            <div class="form-row">
                <div class="placeholder-float">
                    <input type="text" id="motherNumber" name="motherNumber" placeholder=" " class="placeholder-float__input">
                    <label for="motherNumber" class="placeholder-float__label">Mother Number</label>
                </div>
                <div class="placeholder-float">
                    <input type="text" id="aadharNumber" name="aadharNumber" placeholder=" " required class="placeholder-float__input">
                    <label for="aadharNumber" class="placeholder-float__label">Aadhar Number <span class="text-red-500">*</span></label>
                    <p id="aadhar-error" class="text-red-500 text-xs italic" style="display: none;"></p>
                    <small class="note-text" style="color: #666; font-size: 0.8rem; margin-top: 0.25rem;">Note: If you don't have an Aadhar number, you can enter your parent's Aadhar number.</small>
                </div>
            </div>

            <div class="form-row">
                <div class="placeholder-float">
                    <input type="text" id="guardian" name="guardian" placeholder=" ">
                    <label for="guardian">Guardian Name</label>
                </div>
                <div class="placeholder-float">
                    <input type="text" id="guardianNumber" name="guardianNumber" placeholder=" ">
                    <label for="guardianNumber">Guardian Number</label>
                </div>
            </div>

            <div class="placeholder-float">
                <textarea id="address" name="address" placeholder=" " required></textarea>
                <label for="address">Address <span class="text-red-500">*</span></label>
            </div>

            <div class="form-row">
                <div class="placeholder-float">
                    <input type="text" id="class" name="class" placeholder=" " required>
                    <label for="class">Class <span class="text-red-500">*</span></label>
                </div>
                <div class="placeholder-float">
                    <select id="gender" name="gender" required>
                        <option value="" disabled selected></option>
                        <option value="male">Male</option>
                        <option value="female">Female</option>
                        <option value="other">Other</option>
                    </select>
                    <label for="gender">Gender <span class="text-red-500">*</span></label>
                </div>
            </div>

            <div class="form-row">
                <div class="placeholder-float">
                    <input type="number" id="totalFee" name="totalFee" placeholder=" " required>
                    <label for="totalFee">Total Fee <span class="text-red-500">*</span></label>
                </div>
                <div class="placeholder-float">
                    <input type="number" id="paidFee" name="paidFee" placeholder=" " required>
                    <label for="paidFee">Paid Fee <span class="text-red-500">*</span></label>
                </div>
            </div>

            <div class="form-row">
                <div class="placeholder-float">
                    <input type="number" id="age" name="age" placeholder=" " required>
                    <label for="age">Age <span class="text-red-500">*</span></label>
                </div>
                <div class="placeholder-float">
                    <input type="date" id="dob" name="dob" placeholder=" " required>
                    <label for="dob">Date of Birth <span class="text-red-500">*</span></label>
                </div>
            </div>

            <div class="placeholder-float">
                <input type="text" id="pincode" name="pincode" placeholder=" " required>
                <label for="pincode">Pincode <span class="text-red-500">*</span></label>
                <p id="pincode-error" class="error-message" style="display: none;"></p>
            </div>

            <button type="submit">Register</button>
        </form>
        <div class="mt-6 text-gray-700 text-sm">
            <p><span class="text-red-500">*</span> Required fields</p>
        </div>
    </div>

    <!-- Success Popup -->
    <div class="popup success" id="successPopup">
        <div class="icon">✓</div>
        <div class="message">Student Registered Successfully!</div>
    </div>

    <!-- Error Popup -->
    <div class="popup error" id="errorPopup">
        <div class="icon">✕</div>
        <div class="message">Registration Failed!</div>
    </div>

    <script>
        const emailInput = document.getElementById('email');
        const emailError = document.getElementById('email-error');
        const mobileInput = document.getElementById('mobileNumber');
        const mobileError = document.getElementById('mobile-error');
        const aadharInput = document.getElementById('aadharNumber');
        const aadharError = document.getElementById('aadhar-error');
        const pincodeInput = document.getElementById('pincode');
        const pincodeError = document.getElementById('pincode-error');

        function toggleLabelActive(input) {
            const label = input.nextElementSibling;
            if (input.value.trim()) {
                label.classList.add('active');
            } else {
                label.classList.remove('active');
            }
        }

        emailInput.addEventListener('input', () => {
            const emailValue = emailInput.value.trim();
            const emailRegex = /^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$/;
            toggleLabelActive(emailInput);

            if (emailValue && !emailRegex.test(emailValue)) {
                emailError.textContent = "Invalid email format";
                emailError.style.display = "block";
            } else {
                emailError.style.display = "none";
            }
        });

        mobileInput.addEventListener('input', () => {
            const mobileValue = mobileInput.value.trim();
            const mobileRegex = /^[0-9]{10}$/;
            toggleLabelActive(mobileInput);

            if (!mobileRegex.test(mobileValue)) {
                mobileError.textContent = "Mobile number must be 10 digits";
                mobileError.style.display = "block";
            } else {
                mobileError.style.display = "none";
            }
        });

        aadharInput.addEventListener('input', () => {
            const aadharValue = aadharInput.value.trim();
            const aadharRegex = /^[0-9]{12}$/;
            toggleLabelActive(aadharInput);

            if (!aadharValue) {
                aadharError.textContent = "Aadhar number is required";
                aadharError.style.display = "block";
            } else if (!aadharRegex.test(aadharValue)) {
                aadharError.textContent = "Aadhar number must be 12 digits";
                aadharError.style.display = "block";
            } else {
                aadharError.style.display = "none";
            }
        });

        pincodeInput.addEventListener('input', () => {
            const pincodeValue = pincodeInput.value.trim();
            const pincodeRegex = /^[0-9]{6}$/;
            toggleLabelActive(pincodeInput);

            if (!pincodeRegex.test(pincodeValue)) {
                pincodeError.textContent = "Pincode must be 6 digits";
                pincodeError.style.display = "block";
            } else {
                pincodeError.style.display = "none";
            }
        });

        const selectElements = document.querySelectorAll('select');
        selectElements.forEach(selectElement => {
            selectElement.addEventListener('change', () => {
                toggleLabelActive(selectElement);
            });
        });

        function showPopup(type, message) {
            const popup = document.getElementById(type === 'success' ? 'successPopup' : 'errorPopup');
            const messageElement = popup.querySelector('.message');
            messageElement.textContent = message;
            
            popup.classList.add('show');
            
            // Hide popup after 3 seconds
            setTimeout(() => {
                popup.classList.remove('show');
            }, 3000);
        }

        function handleSubmit(event) {
            event.preventDefault();
            
            let isValid = true;
            const requiredFields = document.querySelectorAll('[required]');
            
            requiredFields.forEach(field => {
                if (!field.value.trim()) {
                    isValid = false;
                    field.style.borderColor = '#dc2626';
                } else {
                    field.style.borderColor = '#d1d5db';
                }
            });

            // Validate email if provided
            const emailValue = emailInput.value.trim();
            if (emailValue && !/^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$/.test(emailValue)) {
                isValid = false;
                showPopup('error', 'Invalid email format');
                return false;
            }

            // Validate mobile number
            const mobileValue = mobileInput.value.trim();
            if (!/^[0-9]{10}$/.test(mobileValue)) {
                isValid = false;
                showPopup('error', 'Mobile number must be 10 digits');
                return false;
            }

            // Validate Aadhar if provided
            const aadharValue = aadharInput.value.trim();
            if (aadharValue && !/^[0-9]{12}$/.test(aadharValue)) {
                isValid = false;
                showPopup('error', 'Aadhar number must be 12 digits');
                return false;
            }

            // Validate pincode
            const pincodeValue = pincodeInput.value.trim();
            if (!/^[0-9]{6}$/.test(pincodeValue)) {
                isValid = false;
                showPopup('error', 'Pincode must be 6 digits');
                return false;
            }

            if (!isValid) {
                showPopup('error', 'Please fill all required fields correctly');
                return false;
            }

            // Show success popup
            showPopup('success', 'Student Registered Successfully!');

            // Submit form after a short delay
            setTimeout(() => {
                event.target.submit();
            }, 1000);

            return false;
        }

        // Add form submit event listener
        document.getElementById('registrationForm').addEventListener('submit', handleSubmit);
    </script>
</body>
</html>