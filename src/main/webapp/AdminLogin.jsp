<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    // Prevent caching to avoid back/forward navigation issues after logout
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

    // Invalidate session if logout parameter is present (handle logout redirect)
    String logout = request.getParameter("logout");
    if (logout != null && "true".equals(logout)) {
        session.invalidate();
        response.sendRedirect(request.getRequestURI() + "?logout=true");
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Portal</title>
    <link rel="icon" href="https://cdn-icons-png.flaticon.com/512/2132/2132732.png" type="image/x-icon">

    <!-- Bootstrap 5 CSS CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background: url('https://img.pikbest.com/png-images/20241026/simple-useful-bright-sun-and-cloud-logo-a-clear-sky-icon-design-vector_11001223.png!sw800') no-repeat center center fixed;
            background-size: cover;
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .login-card {
            background: rgba(255, 255, 255, 0.95);
            padding: 3rem;
            border-radius: 15px;
            box-shadow: 0 0 20px rgba(0,0,0,0.2);
            width: 100%;
            max-width: 500px;
            animation: fadeIn 0.8s ease-in-out;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .form-floating label {
            padding-left: 0.75rem;
        }

        .form-floating > .form-control {
            padding: 1.25rem 0.75rem;
            font-size: 1rem;
        }

        .error-msg {
            color: red;
            font-size: 0.85rem;
        }

        .nav-tabs {
            border-bottom: none;
            justify-content: center;
        }

        .nav-tabs .nav-link {
            border-radius: 10px 10px 0 0;
            font-weight: 500;
            margin: 0 2px;
            flex: 1;
            min-width: 120px;
        }

        .nav-tabs .nav-link.active {
            background-color: #0d6efd;
            color: white;
            border-color: #0d6efd;
        }

        .tab-content {
            padding: 2.5rem;
            background: rgba(255, 255, 255, 0.8);
            border-radius: 0 0 15px 15px;
            border: 1px solid #dee2e6;
            border-top: none;
        }

        .loading-animation {
            display: none;
            text-align: center;
            margin: 1rem 0;
        }

        .loading-animation.show {
            display: block;
        }

        .dots {
            display: inline-flex;
            align-items: center;
        }

        .dot {
            width: 8px;
            height: 8px;
            border-radius: 50%;
            background-color: #0d6efd;
            margin: 0 2px;
            animation: bounce 1.4s infinite ease-in-out both;
        }

        .dot:nth-child(1) { animation-delay: -0.32s; }
        .dot:nth-child(2) { animation-delay: -0.16s; }
        .dot:nth-child(3) { animation-delay: 0s; }

        @keyframes bounce {
            0%, 80%, 100% { transform: scale(0); }
            40% { transform: scale(1); }
        }

        @media (max-width: 576px) {
            .login-card {
                margin: 1rem;
                padding: 2rem;
            }

            .nav-tabs .nav-link {
                min-width: auto;
                font-size: 0.9rem;
                margin: 0 1px;
            }

            /* Keep tabs in row but allow wrap if necessary */
            .nav-tabs {
                flex-wrap: wrap;
            }
        }

        /* Notification Styles */
        .notification {
            position: fixed;
            top: 20px;
            right: -350px;
            width: 300px;
            background-color: #f44336;
            color: white;
            padding: 15px;
            border-radius: 5px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.2);
            z-index: 1000;
            transition: right 0.3s ease-in-out;
            font-family: Arial, sans-serif;
            text-align: center;
        }
        .notification.show {
            right: 20px;
        }
        .notification .close {
            float: right;
            cursor: pointer;
            font-weight: bold;
            font-size: 18px;
            line-height: 1;
        }
        .notification .close:hover {
            opacity: 0.7;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="login-card mx-auto">
            <h3 class="text-center mb-4">Login Portal</h3>

            <!-- Tabs Navigation -->
            <ul class="nav nav-tabs" id="loginTabs" role="tablist">
                <li class="nav-item" role="presentation">
                    <button class="nav-link active" id="student-tab" data-bs-toggle="tab" data-bs-target="#student" type="button" role="tab">Student Login</button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link" id="faculty-tab" data-bs-toggle="tab" data-bs-target="#faculty" type="button" role="tab">Faculty Login</button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link" id="admin-tab" data-bs-toggle="tab" data-bs-target="#admin" type="button" role="tab">Admin Login</button>
                </li>
            </ul>

            <!-- Tab Content -->
            <div class="tab-content" id="loginTabContent">
                <!-- Student Tab -->
                <div class="tab-pane fade show active" id="student" role="tabpanel">
                    <form id="studentForm" action="loginpage" method="post" novalidate>
                        <input type="hidden" name="role" value="student">
                        <div class="form-floating mb-3">
                            <input type="text" class="form-control" id="loginid_student" name="studentid" placeholder="Enter Student ID" required>
                            <label for="loginid_student">Student ID</label>
                            <div class="error-msg" id="loginidError_student"></div>
                        </div>

                        <div class="form-floating mb-3">
                            <input type="password" class="form-control" id="password_student" name="studentpassword" placeholder="Password" required>
                            <label for="password_student">Password</label>
                            <div class="error-msg" id="passwordError_student"></div>
                        </div>

                        <div id="loadingSpinnerStudent" class="loading-animation">
                            <div class="dots">
                                <div class="dot"></div>
                                <div class="dot"></div>
                                <div class="dot"></div>
                            </div>
                            <p class="mt-2 mb-0 text-muted small">Logging in...</p>
                        </div>

                        <button type="button" class="btn btn-primary w-100" onclick="validateAndSubmitStudent()">Login</button>
                    </form>
                </div>

                <!-- Faculty Tab -->
                <div class="tab-pane fade" id="faculty" role="tabpanel">
                    <form id="facultyForm" action="loginpage" method="post" novalidate>
                        <input type="hidden" name="role" value="faculty">
                        <div class="form-floating mb-3">
                            <input type="text" class="form-control" id="loginid_faculty" name="facultyid" placeholder="Enter Faculty ID" required>
                            <label for="loginid_faculty">Faculty ID</label>
                            <div class="error-msg" id="loginidError_faculty"></div>
                        </div>

                        <div class="form-floating mb-3">
                            <input type="password" class="form-control" id="password_faculty" name="facultypassword" placeholder="Password" required>
                            <label for="password_faculty">Password</label>
                            <div class="error-msg" id="passwordError_faculty"></div>
                        </div>

                        <div id="loadingSpinnerFaculty" class="loading-animation">
                            <div class="dots">
                                <div class="dot"></div>
                                <div class="dot"></div>
                                <div class="dot"></div>
                            </div>
                            <p class="mt-2 mb-0 text-muted small">Logging in...</p>
                        </div>

                        <button type="button" class="btn btn-primary w-100" onclick="validateAndSubmitFaculty()">Login</button>
                    </form>
                    <div class="text-center mt-3">
                        <a href="forgotpassword.jsp" class="text-decoration-none">Forgot Password?</a>
                    </div>
                </div>

                <!-- Admin Tab -->
                <div class="tab-pane fade" id="admin" role="tabpanel">
                    <form id="adminForm" action="loginpage" method="post" novalidate>
                        <input type="hidden" name="role" value="admin">
                        <div class="form-floating mb-3">
                            <input type="email" class="form-control" id="email_admin" name="emailid" placeholder="name@example.com" required>
                            <label for="email_admin">Email ID</label>
                            <div class="error-msg" id="emailError_admin"></div>
                        </div>

                        <div class="form-floating mb-3">
                            <input type="password" class="form-control" id="password_admin" name="password" placeholder="Password" required>
                            <label for="password_admin">Password</label>
                            <div class="error-msg" id="passwordError_admin"></div>
                        </div>

                        <div id="loadingSpinnerAdmin" class="loading-animation">
                            <div class="dots">
                                <div class="dot"></div>
                                <div class="dot"></div>
                                <div class="dot"></div>
                            </div>
                            <p class="mt-2 mb-0 text-muted small">Logging in...</p>
                        </div>

                        <button type="button" class="btn btn-primary w-100" onclick="validateAndSubmitAdmin()">Login</button>
                    </form>
                    <div class="text-center mt-3">
                        <a href="forgotpassword.jsp" class="text-decoration-none">Forgot Password?</a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Notification Div -->
    <div id="errorNotification" class="notification" style="display: none;">
        <span class="close" onclick="hideNotification()">&times;</span>
        <div id="notificationMessage"></div>
    </div>

    <!-- Bootstrap 5 JS Bundle CDN -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <script>
        // Student Validation
        function validateAndSubmitStudent() {
            const loginid = document.getElementById('loginid_student');
            const password = document.getElementById('password_student');
            const loginidError = document.getElementById('loginidError_student');
            const passwordError = document.getElementById('passwordError_student');
            const loading = document.getElementById('loadingSpinnerStudent');

            let isValid = true;
            loginidError.textContent = '';
            passwordError.textContent = '';
            loginid.classList.remove('is-invalid');
            password.classList.remove('is-invalid');

            if (!loginid.value.trim()) {
                loginidError.textContent = 'Please enter your Student ID.';
                loginid.classList.add('is-invalid');
                isValid = false;
            }

            if (password.value.length < 6) {
                passwordError.textContent = 'Password must be at least 6 characters.';
                password.classList.add('is-invalid');
                isValid = false;
            }

            if (isValid) {
                console.log('Logging in as: student');
                loading.classList.add('show');
                setTimeout(() => {
                    document.getElementById('studentForm').submit();
                }, 800);
            }
        }

        // Faculty Validation
        function validateAndSubmitFaculty() {
            const loginid = document.getElementById('loginid_faculty');
            const password = document.getElementById('password_faculty');
            const loginidError = document.getElementById('loginidError_faculty');
            const passwordError = document.getElementById('passwordError_faculty');
            const loading = document.getElementById('loadingSpinnerFaculty');

            let isValid = true;
            loginidError.textContent = '';
            passwordError.textContent = '';
            loginid.classList.remove('is-invalid');
            password.classList.remove('is-invalid');

            if (!loginid.value.trim()) {
                loginidError.textContent = 'Please enter your Faculty ID.';
                loginid.classList.add('is-invalid');
                isValid = false;
            }

            if (password.value.length < 6) {
                passwordError.textContent = 'Password must be at least 6 characters.';
                password.classList.add('is-invalid');
                isValid = false;
            }

            if (isValid) {
                console.log('Logging in as: faculty');
                loading.classList.add('show');
                setTimeout(() => {
                    document.getElementById('facultyForm').submit();
                }, 800);
            }
        }

        // Admin Validation
        function validateAndSubmitAdmin() {
            const email = document.getElementById('email_admin');
            const password = document.getElementById('password_admin');
            const emailError = document.getElementById('emailError_admin');
            const passwordError = document.getElementById('passwordError_admin');
            const loading = document.getElementById('loadingSpinnerAdmin');

            let isValid = true;
            emailError.textContent = '';
            passwordError.textContent = '';
            email.classList.remove('is-invalid');
            password.classList.remove('is-invalid');

            const emailPattern = /^[^ ]+@[^ ]+\.[a-z]{2,3}$/;

            if (!email.value.match(emailPattern)) {
                emailError.textContent = 'Please enter a valid email address.';
                email.classList.add('is-invalid');
                isValid = false;
            }

            if (password.value.length < 6) {
                passwordError.textContent = 'Password must be at least 6 characters.';
                password.classList.add('is-invalid');
                isValid = false;
            }

            if (isValid) {
                console.log('Logging in as: admin');
                loading.classList.add('show');
                setTimeout(() => {
                    document.getElementById('adminForm').submit();
                }, 800);
            }
        }

        // Notification Functions
        function showNotification(message) {
            const notification = document.getElementById('errorNotification');
            const messageDiv = document.getElementById('notificationMessage');
            messageDiv.innerHTML = message;
            notification.style.display = 'block';
            notification.classList.add('show');
            setTimeout(hideNotification, 3000); // Auto-hide after 3 seconds
        }

        function hideNotification() {
            const notification = document.getElementById('errorNotification');
            notification.classList.remove('show');
            setTimeout(() => {
                notification.style.display = 'none';
            }, 300);
        }

        // Check for error message on page load
        window.onload = function() {
            <%
                if (request.getAttribute("errorMessage") != null) {
            %>
                showNotification("<%= request.getAttribute("errorMessage") %>");
            <%
                }
            %>
        };
    </script>
</body>
</html>