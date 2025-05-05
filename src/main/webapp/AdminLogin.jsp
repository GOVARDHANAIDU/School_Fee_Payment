<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Login</title>
    <link rel="icon" href="https://cdn-icons-png.flaticon.com/512/2132/2132732.png" type="image/x-icon">

    <!-- Bootstrap 5 CSS CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
       body {
		     background: url('https://img.freepik.com/free-vector/education-pattern-background-doodle-style_53876-115373.jpg') no-repeat center center fixed;
		    background-size: cover;
		    height: 100vh;
		    display: flex;
		    align-items: center;
		    justify-content: center;
		}

        .login-card {
            background: rgba(255, 255, 255, 0.95);
            padding: 2rem;
            border-radius: 15px;
            box-shadow: 0 0 20px rgba(0,0,0,0.2);
            width: 100%;
            max-width: 400px;
            animation: fadeIn 0.8s ease-in-out;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .form-floating label {
            padding-left: 0.75rem;
        }

        .error-msg {
            color: red;
            font-size: 0.85rem;
        }

        #loadingSpinner {
            display: none;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="login-card mx-auto">
            <h3 class="text-center mb-4">Admin Login</h3>
            <form id="loginForm" action="loginpage" method="post" novalidate>
                <div class="form-floating mb-3">
                    <input type="email" class="form-control" id="email" name="emailid" placeholder="name@example.com" required>
                    <label for="email">Email ID</label>
                    <div class="error-msg" id="emailError"></div>
                </div>

                <div class="form-floating mb-3">
                    <input type="password" class="form-control" id="password" name="password" placeholder="Password" required>
                    <label for="password">Password</label>
                    <div class="error-msg" id="passwordError"></div>
                </div>

                <div id="loadingSpinner" class="text-center mb-3">
                    <div class="spinner-border text-info" role="status">
                        <span class="visually-hidden">Loading...</span>
                    </div>
                </div>

                <button type="button" class="btn btn-primary w-100" onclick="validateAndSubmit()">Login</button>
            </form>
            <div class="text-center mt-3">
                <a href="forgotpassword.jsp" class="text-decoration-none">Forgot Password?</a>
            </div>
        </div>
    </div>

    <!-- Bootstrap 5 JS Bundle CDN -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <script>
        function validateAndSubmit() {
            const email = document.getElementById('email');
            const password = document.getElementById('password');
            const emailError = document.getElementById('emailError');
            const passwordError = document.getElementById('passwordError');
            const loading = document.getElementById('loadingSpinner');

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
                loading.style.display = "block";
                setTimeout(() => {
                    document.getElementById('loginForm').submit();
                }, 800);
            }
        }
    </script>
</body>
</html>
