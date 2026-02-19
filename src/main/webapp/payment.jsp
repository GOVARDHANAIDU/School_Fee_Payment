<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Student Payment</title>
    <link rel="icon" href="https://cdn-icons-png.flaticon.com/512/2132/2132732.png" type="image/x-icon">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://checkout.razorpay.com/v1/checkout.js"></script>
    <style>
 
        .container {
            background: white;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 400px;
            margin: 0 auto;
        }

        h2 {
            text-align: center;
            margin-bottom: 20px;
            color: #333;
        }

        input[type="text"],
        input[type="email"],
        input[type="number"] {
            width: 100%;
            padding: 12px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-size: 16px;
        }

        button {
            width: 100%;
            padding: 12px;
            font-size: 16px;
            background-color: #0b5ed7;
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
        }

        button:hover {
            background-color: #084bb5;
        }

        /* Dot-Dots Spinner CSS */
        .dots-spinner {
            display: flex;
            justify-content: center;
            align-items: center;
            margin-top: 20px;
            display: none; /* Initially hidden */
        }

        .dot {
            width: 15px;
            height: 15px;
            margin: 0 5px;
            background-color: #0b5ed7;
            border-radius: 50%;
            animation: bounce 1.5s infinite ease-in-out;
        }

        .dot:nth-child(1) {
            animation-delay: 0s;
        }

        .dot:nth-child(2) {
            animation-delay: 0.3s;
        }

        .dot:nth-child(3) {
            animation-delay: 0.6s;
        }

        @keyframes bounce {
            0%, 100% {
                transform: translateY(0);
            }
            50% {
                transform: translateY(-15px);
            }
        }

        #loading {
            display: none;
            text-align: center;
        }

        @media (max-width: 480px) {
            .container {
                padding: 20px;
                width: 90%;
            }
        }
        
        * {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    background-color: #f4f7fa;
    padding: 20px;
    min-height: 100vh;
    display: flex;
    align-items: center;
    justify-content: center;
}

.container {
    background-color: white;
    padding: 30px 25px;
    border-radius: 12px;
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
    width: 100%;
    max-width: 500px;
}

h2 {
    text-align: center;
    margin-bottom: 24px;
    color: #2c3e50;
    font-size: 26px;
}

/* Form Grid with Labels */
#paymentForm {
    display: grid;
    grid-template-columns: 1fr;
    gap: 16px;
}

/* Label styling */
#paymentForm label {
    display: block;
    margin-bottom: 6px;
    font-weight: 600;
    color: #34495e;
    font-size: 14px;
}

/* Smaller, compact inputs */
input[type="text"],
input[type="email"],
input[type="number"] {
    padding: 10px 14px;           /* Smaller padding */
    border: 2px solid #ddd;
    border-radius: 8px;
    font-size: 15px;              /* Slightly smaller font */
    width: 100%;
    height: 44px;                 /* Consistent height */
    transition: border-color 0.3s ease;
}

input[type="text"]:focus,
input[type="email"]:focus,
input[type="number"]:focus {
    outline: none;
    border-color: #3498db;
    box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.2);
}

input[readonly] {
    background-color: #f8f9fa;
    color: #555;
    cursor: not-allowed;
}

button {
    padding: 12px;
    background-color: #3498db;
    color: white;
    font-size: 17px;
    font-weight: bold;
    border: none;
    border-radius: 8px;
    cursor: pointer;
    transition: background-color 0.3s ease;
    height: 48px;
    margin-top: 8px;
}

button:hover {
    background-color: #2980b9;
}

button:active {
    transform: translateY(1px);
}

/* Spinner */
.dots-spinner {
    display: none;
    justify-content: center;
    margin-top: 20px;
}

.dots-spinner.active {
    display: flex;
}

.dot {
    width: 10px;
    height: 10px;
    background-color: #3498db;
    border-radius: 50%;
    margin: 0 5px;
    animation: bounce 1.4s infinite ease-in-out;
}

.dot:nth-child(1) { animation-delay: -0.32s; }
.dot:nth-child(2) { animation-delay: -0.16s; }
.dot:nth-child(3) { animation-delay: 0s; }

@keyframes bounce {
    0%, 80%, 100% { transform: scale(0); }
    40% { transform: scale(1); }
}

/* Responsive: Two columns on tablets and desktops */
@media (min-width: 768px) {
    #paymentForm {
        grid-template-columns: 1fr 1fr;   /* Two columns */
        gap: 18px 20px;
    }

    /* Full width for button and name (optional) */
    #paymentForm .full-width {
        grid-column: 1 / -1;
    }

    .container {
        padding: 40px;
        max-width: 600px;
    }
}
    </style>
       <link href="./student-profile.css" rel="stylesheet">
    
</head>
<body>
<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark px-4">
  <div class="container-fluid">
    <div class="d-flex align-items-center">
      <img src="https://img.pikbest.com/png-images/20241026/simple-useful-bright-sun-and-cloud-logo-a-clear-sky-icon-design-vector_11001223.png!sw800" alt="SAS Logo" 
      style="height: 40px; margin-right: 10px;" href="home.jsp">
      <a class="navbar-brand mb-0" href="home.jsp">SAS School</a>
    </div>
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
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" hidden="true">Students</a>
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
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" id="hideFunction()" hidden="true">Payments</a>
          <ul class="dropdown-menu">
            <li><a class="dropdown-item" href="allpayments.jsp">All Payment Details</a></li>
            <li><a class="dropdown-item" href="apbme.jsp">Payment By Admin</a></li>
            <li><a class="dropdown-item" href="paymentdetails.jsp">All Payment Status</a></li>
          </ul>
        </li>

        <!-- Explore Dropdown -->
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" hidden="true">Explore</a>
          <ul class="dropdown-menu">
            <li><a class="dropdown-item" href="#">360° View</a></li>
            <li><a class="dropdown-item" href="#">Videos</a></li>
            <li><a class="dropdown-item" href="images.jsp">Images</a></li>
          </ul>
        </li>

        <!-- Other Links -->
        <li class="nav-item"><a class="nav-link" href="fee-notifications.jsp" id="hideFunction()" hidden="true">Send Notifications</a></li>
        <li class="nav-item"><a class="nav-link" href="#">Contact Us</a></li>
      </ul>

      <!-- Right Side -->
<%
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

    String role = (String)session.getAttribute("Roles");
    String admissionNo = (String)session.getAttribute("admissionNo");
    //System.out.println(role);
%>
      <div class="ms-lg-auto mt-3 mt-lg-0
            d-flex flex-column flex-lg-row
            align-items-start align-items-lg-center
            gap-2">

    <!-- Hello Admin -->
    <span class="text-white fw-semibold">
        Hello, <%= userName %>
    </span>

    <!-- Roles Dropdown -->
    <div class="dropdown" hidden="true">
        <button class="btn btn-sm btn-outline-light dropdown-toggle"
                data-bs-toggle="dropdown">
            Roles
        </button>
        <ul class="dropdown-menu dropdown-menu-end">
            <li><a class="dropdown-item" href="home.jsp">Channel Admin</a></li>
            <li><a class="dropdown-item" href="home.jsp">Student</a></li>
            <li><a class="dropdown-item" href="./faculty/faculty.jsp">Faculty</a></li>
        </ul>
    </div>

    <!-- Auth Buttons (ALWAYS UNDER Roles in mobile) -->
    <div class="d-flex flex-column flex-lg-row gap-2 mt-2 mt-lg-0">
        <a class="btn btn-outline-light btn-sm" href="AdminLogin.jsp">Logout</a>
        <a class="btn btn-outline-warning btn-sm" href="createaccount.jsp" hidden="true">Signup</a>
    </div>

</div>

    </div>
  </div>
</nav>

<%
  String studentName = (String)session.getAttribute("studentName");
  String email = (String)session.getAttribute("email");
  String phone = (String)session.getAttribute("phone");
  String  class1 = (String)session.getAttribute("class1");
  double payingfee = (double)session.getAttribute("payingfee");
%>
<div class="container">
    <h2>Student Payment</h2>
    <form id="paymentForm">
        <div>
            <label for="name">Student Name</label>
            <input type="text" id="name" value="<%= studentName %>" readonly required>
        </div>

        <div>
            <label for="email">Email</label>
            <input type="email" id="email" value="<%= email %>" required readonly>
        </div>

        <div>
            <label for="phone">Phone</label>
            <input type="text" id="phone" value="<%= phone %>" required readonly>
        </div>

        <div>
            <label for="course">Class</label>
            <input type="text" id="course" value="<%= class1 %>" required >
        </div>

        <div>
            <label for="amount">Amount (INR)</label>
            <input type="number" id="amount" value="<%= payingfee %>" required readonly>
        </div>

        <div class="full-width">
            <button type="button" onclick="payNow()">Pay Now</button>
        </div>
    </form>

    <div class="dots-spinner" id="spinner">
        <div class="dot"></div>
        <div class="dot"></div>
        <div class="dot"></div>
    </div>
</div>
<script>
        function payNow() {
            const data = {
                name: document.getElementById("name").value.trim(),
                email: document.getElementById("email").value.trim(),
                phone: document.getElementById("phone").value.trim(),
                course: document.getElementById("course").value.trim(),
                amount: parseFloat(document.getElementById("amount").value.trim()),
                
            };
            
           
            
            if (!data.name || !data.phone || !data.course || isNaN(data.amount)) {
                alert("Please fill all fields correctly.");
                return;
            }

            // Show the spinner before making the API call
            document.getElementById("spinner").style.display = "flex";

            fetch('createOrder', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(data)
            })
            .then(res => res.json())
            .then(order => {
                var options = {
                    key: "rzp_test_Jmsp2zqLWnGnkA", // replace with your real test key or live key
                    amount: order.amount,
                    currency: "INR",
                    name: "School Payment",
                    description: "Payment for " + data.course,
                    order_id: order.razorpayOrderId,
                    handler: function (response) {
                        window.location.href = 'PreviewPage.jsp';
                    },
                    prefill: {
                        name: data.name,
                        email: data.email,
                        contact: data.phone
                    },
                    theme: {
                        color: "#0b5ed7"
                    },
                    modal: {
                        ondismiss: function () {
                            console.log("Checkout form closed.");
                        }
                    }
                };
                var rzp = new Razorpay(options);
                rzp.open();

                // Hide the spinner after Razorpay checkout is opened
                document.getElementById("spinner").style.display = "none";
            })
            .catch(err => {
                
                alert("Failed to initiate payment.");
                document.getElementById("spinner").style.display = "none"; // Hide spinner in case of error
            });
        }
</script>
<script src="js/roleControl.js"> </script>
</body>
</html>
