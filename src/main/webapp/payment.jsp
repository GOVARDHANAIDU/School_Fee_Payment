<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment</title>
    <!-- Bootstrap CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Animate.css for animation -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">
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
            <li><a class="dropdown-item" href="#">Update Student Details</a></li>
          </ul>
        </li>
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">Payments</a>
          <ul class="dropdown-menu">
            <li><a class="dropdown-item" href="allpayments.jsp">All Payment Details</a></li>
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
        <a class="btn btn-outline-light me-2" href="AdminLogin.jsp">Login</a>
        <a class="btn btn-outline-warning" href="createaccount.jsp">Signup</a>
      </div>
    </div>
  </div>
</nav>

    <div class="container mt-5">
        <h2 class="text-center">Student Payment Form</h2>

        <form id="paymentForm" method="post" action="/createOrder">
            <!-- Name -->
            <div class="form-floating mb-3">
                <input type="text" id="name" name="name" class="form-control form-control-sm" required>
                <label for="name">Name</label>
            </div>

            <!-- Email -->
            <div class="form-floating mb-3">
                <input type="email" id="email" name="email" class="form-control form-control-sm" required>
                <label for="email">Email</label>
            </div>

            <!-- Phone Number -->
            <div class="form-floating mb-3">
                <input type="text" id="phoneNo" name="phoneNo" class="form-control form-control-sm" required>
                <label for="phoneNo">Phone Number</label>
            </div>

            <!-- Course -->
            <div class="form-floating mb-3">
                <input type="text" id="course" name="course" class="form-control form-control-sm" required>
                <label for="course">Course</label>
            </div>

            <!-- Amount -->
            <div class="form-floating mb-3">
                <input type="number" id="amount" name="amount" class="form-control form-control-sm" required>
                <label for="amount">Amount (in INR)</label>
            </div>

            <!-- Proceed to Payment Button -->
            <button type="button" id="payButton" class="btn btn-primary">Proceed to Payment</button>
        </form>

        <!-- Payment Success Message -->
        <div id="paymentSuccess" class="mt-4" style="display:none;">
            <div class="alert alert-success animate__animated animate__fadeIn" role="alert">
                <i class="bi bi-check-circle"></i> Payment Successful!
            </div>
        </div>
    </div>

    <!-- Bootstrap and Icon CDN -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js"></script>
    <script src="https://checkout.razorpay.com/v1/checkout.js"></script>

    <script>
        document.getElementById('payButton').onclick = function() {
            var form = document.getElementById('paymentForm');
            var name = document.getElementById('name').value;
            var email = document.getElementById('email').value;
            var phoneNo = document.getElementById('phoneNo').value;
            var course = document.getElementById('course').value;
            var amount = document.getElementById('amount').value;

            // Send data to the server to create the Razorpay order
            fetch('/createOrder', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ name: name, email: email, phoneNo: phoneNo, course: course, amount: amount })
            })
            .then(response => response.json())
            .then(data => {
                var options = {
                    key: 'rzp_test_Jmsp2zqLWnGnkA', // Your Razorpay API Key
                    amount: amount, // Amount to be paid
                    currency: 'INR',
                    name: 'Payment for Course',
                    description: 'Payment for ' + course,
                    image: 'https://example.com/logo.png',
                    order_id: data.razorpayOrderID, // Razorpay Order ID
                    handler: function(response) {
                        // Show success message instead of alert
                        document.getElementById('paymentSuccess').style.display = 'block';

                        // Redirect to the success page after 4 seconds
                        setTimeout(function() {
                            window.location.href = 'printreceipt.jsp'; // Redirect to the success page
                        }, 4000); // 4 seconds delay
                    },
                    prefill: {
                        name: name,
                        email: email,
                        contact: phoneNo
                    },
                    notes: {
                        course: course
                    }
                };

                var rzp1 = new Razorpay(options);
                rzp1.open();
            })
            .catch(error => console.error('Error:', error));
        }
    </script>
</body>
</html>
