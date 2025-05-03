<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Registration Form</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600&display=swap" rel="stylesheet">
    <style>
        /* General Body and Background Styling */
body {
    font-family: 'Inter', sans-serif;
    background-color: #f0f4f8; /* Light background */
    background-image: url('https://images.unsplash.com/photo-1484807352949-98de50075d68?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'); /* Replace with your image URL */
    background-size: cover;
    background-position: center;
    background-repeat: no-repeat;
    animation: fadeInBackground 2s ease forwards;
    margin: 0; /* Reset default body margin */
    display: flex;
    flex-direction: column;
    min-height: 100vh; /* Ensure full viewport height */
}

/* Keyframe for background fade-in */
@keyframes fadeInBackground {
    from { opacity: 0; }
    to { opacity: 1; }
}

/* Container for the form */
.max-w-2xl {
    width: 75%;
    margin-left: auto;
    margin-right: auto;
    background-color: rgba(255, 255, 255, 0.9); /* Slightly transparent white */
    padding: 2rem;
    border-radius: 0.5rem;
    box-shadow: 0 0.25rem 1rem rgba(0, 0, 0, 0.1);
    animation: fadeIn 1s ease forwards, slideIn 1s ease forwards;
    transform: translateY(20px);
    opacity: 0;
}

/* Keyframes for fade-in and slide-in animations */
@keyframes fadeIn {
    from { opacity: 0; }
    to { opacity: 1; }
}

@keyframes slideIn {
    from { transform: translateY(20px); }
    to { transform: translateY(0); }
}

/* Heading Styling */
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

/* Placeholder floating effect for inputs */
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
    font-family: 'Roboto', sans-serif; /* New font style */
}

/* Hover and focus effects for input fields */
.placeholder-float input:hover,
.placeholder-float textarea:hover,
.placeholder-float select:hover {
    border-color: #3498db;
    box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.25); /* Subtle hover effect */
}

.placeholder-float input:focus,
.placeholder-float textarea:focus,
.placeholder-float select:focus {
    border-color: #4CAF50; /* Changed focus border color */
    box-shadow: 0 0 0 3px rgba(76, 175, 80, 0.25); /* Changed focus shadow */
}

/* Floating label style for inputs */
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

/* Floating label effect on focus or when input is not empty */
.placeholder-float input:focus + label,
.placeholder-float input:not(:placeholder-shown) + label,
.placeholder-float textarea:focus + label,
.placeholder-float textarea:not(:placeholder-shown) + label,
.placeholder-float select:focus + label,
.placeholder-float select:not(:placeholder-shown) + label {
    transform: translateY(-1.75rem) scale(0.75);
    color: #4CAF50; /* Green color for labels */
}

/* Background color when input or select is focused */
.placeholder-float input:focus + label,
.placeholder-float input:not(:placeholder-shown) + label {
    background-color: #fff;
}

.placeholder-float textarea:focus + label,
.placeholder-float textarea:not(:placeholder-shown) + label{
    background-color: #fff;
}

.placeholder-float select:focus + label,
.placeholder-float select:not(:placeholder-shown) + label {
    background-color: #fff;
}

/* Styling for Select Inputs (Dropdown) */
.select-wrapper {
    position: relative;
    display: inline-block;
    width: 100%;
}

.select-wrapper select {
    -webkit-appearance: none;
    -moz-appearance: none;
    appearance: none;
    width: 100%;
    padding: 0.75rem;
    border-radius: 0.375rem;
    border: 1px solid #d1d5db;
    font-size: 1rem;
    line-height: 1.5rem;
    transition: all 0.3s ease-in-out;
    outline: none;
    background-color: transparent;
}

/* Custom dropdown arrow for select */
.select-wrapper::after {
    content: "";
    position: absolute;
    top: 50%;
    right: 1rem;
    transform: translateY(-50%);
    width: 0.625rem;
    height: 0.625rem;
    border-left: 0.125rem solid #6b7280;
    border-bottom: 0.125rem solid #6b7280;
    transform: translateY(-50%) rotate(-45deg);
    pointer-events: none;
}

.select-wrapper select:focus {
    border-color: #4CAF50; /* Changed focus border color */
    box-shadow: 0 0 0 3px rgba(76, 175, 80, 0.25); /* Changed focus shadow */
}

/* Floating label for select inputs */
.select-wrapper select + label {
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

.select-wrapper select:focus + label,
.select-wrapper select:not(:placeholder-shown) + label {
    transform: translateY(-1.75rem) scale(0.75);
    color: #4CAF50; /* Changed label color */
}

/* Two-column layout for form fields */
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

/* Button Styling */
button {
    background-color: #4CAF50; /* Green button */
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

/* Hover and active states for button */
button:hover {
    background-color: #45a049; /* Darker shade on hover */
    transform: translateY(-2px);
    box-shadow: 0 0.25rem 0.375rem rgba(0, 0, 0, 0.3);
}

button:active {
    transform: translateY(0);
    box-shadow: 0 0.0625rem 0.125rem rgba(0, 0, 0, 0.3);
}

/* Margin for footer or additional text */
.mt-6 {
    margin-top: 1.5rem;
    color: #555;
    font-size: 0.875rem;
    text-align: center;
}

.text-red-500 {
    color: #FF0000;
}

    </style>
</head>
<body class="bg-gray-100 p-6 rounded-lg">
    <div class="max-w-2xl mx-auto bg-white p-8 rounded-md shadow-md">
        <h2 class="text-2xl font-semibold text-gray-800 mb-6 text-center">Student Registration Form</h2>
        <form action="Register.jsp" method="POST" class="space-y-6" id="registrationForm">
            <div class="form-row">
                <div class="placeholder-float">
                    <input type="text" id="adminNo" name="adminNo" placeholder=" " required class="placeholder-float__input">
                    <label for="adminNo" class="placeholder-float__label">Admin. No <span class="text-red-500">*</span></label>
                </div>
                <div class="placeholder-float">
                    <input type="text" id="studentName" name="studentName" placeholder=" " required class="placeholder-float__input">
                    <label for="studentName" class="placeholder-float__label">Student Name <span class="text-red-500">*</span></label>
                </div>
            </div>
            <div class="form-row">
                <div class="placeholder-float">
                    <input type="text" id="fatherName" name="fatherName" placeholder=" " required class="placeholder-float__input">
                    <label for="fatherName" class="placeholder-float__label">Father Name <span class="text-red-500">*</span></label>
                </div>
                <div class="placeholder-float">
                    <input type="email" id="email" name="email" placeholder=" " class="placeholder-float__input">
                    <label for="email" class="placeholder-float__label">Email</label>
                    <p id="email-error" class="text-red-500 text-xs italic" style="display: none;"></p>
                </div>
            </div>
            <div class="form-row">
                <div class="placeholder-float">
                    <input type="text" id="mobileNumber" name="mobileNumber" placeholder=" " required class="placeholder-float__input">
                    <label for="fatherNumber" class="placeholder-float__label">Father Number <span class="text-red-500">*</span></label>
                	<p id="mobile-error" class="text-red-500 text-xs italic" style="display: none;"></p>
                </div>
            </div>
            <div class="form-row">
                <div class="placeholder-float">
                    <input type="text" id="motherName" name="motherName" placeholder=" " required class="placeholder-float__input">
                    <label for="motherName" class="placeholder-float__label">Mother Name <span class="text-red-500">*</span></label>
                </div>
                <div class="placeholder-float">
                    <input type="text" id="motherNumber" name="motherNumber" placeholder=" " class="placeholder-float__input">
                    <label for="motherNumber" class="placeholder-float__label">Mother Number</label>
                </div>
            </div>
            <div class="form-row">
                <div class="placeholder-float">
                    <input type="text" id="guardian" name="guardian" placeholder=" " class="placeholder-float__input">
                    <label for="guardian" class="placeholder-float__label">Guardian Name</label>
                </div>
                <div class="placeholder-float">
                    <input type="text" id="guardianNumber" name="guardianNumber" placeholder=" " class="placeholder-float__input">
                    <label for="guardianNumber" class="placeholder-float__label">Guardian Number</label>
                </div>
            </div>
            <div class="placeholder-float">
                <textarea id="address" name="address" placeholder=" " required class="placeholder-float__input"></textarea>
                <label for="address" class="placeholder-float__label">Address <span class="text-red-500">*</span></label>
            </div>
             <div class="form-row">
                <div class="placeholder-float">
                    <input type="text" id="class" name="class" placeholder=" " required class="placeholder-float__input">
                    <label for="class" class="placeholder-float__label">Class <span class="text-red-500">*</span></label>
                </div>
                <div class="placeholder-float">
                    <input type="text" id="aadharNumber" name="aadharNumber" placeholder=" " class="placeholder-float__input">
                    <label for="aadharNumber" class="placeholder-float__label">Aadhar Number</label>
                    <p id="aadhar-error" class="text-red-500 text-xs italic" style="display: none;"></p>
                </div>
            </div>
            <div class="form-row">
                <div class="placeholder-float">
                    <input type="number" id="totalFee" name="totalFee" placeholder=" " required class="placeholder-float__input">
                    <label for="totalFee" class="placeholder-float__label">Total Fee <span class="text-red-500">*</span></label>
                </div>
                <div class="placeholder-float select-wrapper">
                    <select id="gender" name="gender" required class="placeholder-float__input">
                        <option value="" disabled selected></option>
                        <option value="male">Male</option>
                        <option value="female">Female</option>
                        <option value="other">Other</option>
                    </select>
                    <label for="gender" class="placeholder-float__label">Gender <span class="text-red-500">*</span></label>
                </div>
            </div>
            <div class="form-row">
                <div class="placeholder-float">
                    <input type="number" id="age" name="age" placeholder=" " required class="placeholder-float__input">
                    <label for="age" class="placeholder-float__label">Age <span class="text-red-500">*</span></label>
                </div>
                <div class="placeholder-float">
                    <input type="date" id="dob" name="dob" placeholder=" " required class="placeholder-float__input">
                    <label for="dob" class="placeholder-float__label">Date of Birth <span class="text-red-500">*</span></label>
                </div>
            </div>
            <div class="placeholder-float">
                <input type="text" id="pincode" name="pincode" placeholder=" " required class="placeholder-float__input">
                <label for="pincode" class="placeholder-float__label">Pincode <span class="text-red-500">*</span></label>
                <p id="pincode-error" class="text-red-500 text-xs italic" style="display: none;"></p>
            </div>

            <button type="submit" onclick="validateForm()" class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline">Register</button>
        </form>
        <div class="mt-6 text-gray-700 text-sm">
            <p><span class="text-red-500">*</span> Required fields</p>
        </div>
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

// Utility: Floating label
function toggleLabelActive(input) {
    const label = input.nextElementSibling;
    if (input.value.trim()) {
        label.classList.add('active');
    } else {
        label.classList.remove('active');
    }
}

// Email validation
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

// Mobile number validation
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

// Aadhar number validation
aadharInput.addEventListener('input', () => {
    const aadharValue = aadharInput.value.trim();
    const aadharRegex = /^[0-9]{12}$/;
    toggleLabelActive(aadharInput);

    if (aadharValue && !aadharRegex.test(aadharValue)) {
        aadharError.textContent = "Aadhar number must be 12 digits";
        aadharError.style.display = "block";
    } else {
        aadharError.style.display = "none";
    }
});

// Pincode validation
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

// Floating label for selects
const selectElements = document.querySelectorAll('select');
selectElements.forEach(selectElement => {
    selectElement.addEventListener('change', () => {
        toggleLabelActive(selectElement);
    });
});

    </script>
</body>
</html>
