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
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f2f2f2;
            margin: 0;
           
            min-height: 100vh;
        }

        .container {
            background: white;
            padding: 30px 40px;
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
      <ul class="navbar-nav me-auto">
        <li class="nav-item"><a class="nav-link active" href="home.jsp">Home</a></li>
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">Students</a>
          <ul class="dropdown-menu">
            <li><a class="dropdown-item" href="allStudents.jsp">All Student Info</a></li>
            <li><a class="dropdown-item" href="BillingPage.jsp">Student Fee Payment</a></li>
            <li><a class="dropdown-item" href="studentreg.jsp">Create Student Details</a></li>
            <li><a class="dropdown-item" href="bulkimporting.jsp">Create Bulk</a></li>
            
            <li><a class="dropdown-item" href="updatedetails.jsp">Update Student Details</a></li>
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
        String Aname = (String) session2.getAttribute("adminName");
        String userName = "";
        
        if (Aname == null) {
            // Redirect if not logged in
            response.sendRedirect("AdminLogin.jsp");
            return;
        }
        
        for(int i= 0 ; i<=Aname.length()-1 ; i++)
        {
        	char ch = Aname.charAt(i);
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
      
      <div class="d-flex">
        <a class="btn btn-outline-light me-2" href="AdminLogin.jsp">Login</a>
        <a class="btn btn-outline-warning" href="createaccount.jsp">Signup</a>
      </div>
    </div>
  </div>
</nav>

    <div class="container">
        <h2>Student Payment</h2>
        <form id="paymentForm">
            <input type="text" id="name" value="<%=request.getParameter("studentName") %>" required>
            
            <input type="email" id="email" value="<%=request.getParameter("email") %>" placeholder="Email">
            <input type="text" id="phone" placeholder="Phone" value="<%=request.getParameter("phone") %>" required>
            <input type="text" id="course" placeholder="Class" value="<%=request.getParameter("class1") %>" required>
            <input type="number" id="amount" placeholder="Amount (INR)" value="<%=request.getParameter("payingfee") %>" required>
            <input type="text" id="admissionnumber" value="<%=request.getParameter("admissionnumber")%>" name="AdmissionNumber" readOnly hidden="true">
            <input type="number" id="totalamount" value="<%=request.getParameter("amount")%>" readOnly hidden="true">
            <input type="text" id="paidamount" value="<%=request.getParameter("paidfee")%>" readOnly hidden="true">
            <button type="button" onclick="payNow()">Pay Now</button>
        </form>
        
        <!-- Dot-Dots Spinner -->
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
                admissionnumber: document.getElementById("admissionnumber").value.trim(),
                email: document.getElementById("email").value.trim(),
                phone: document.getElementById("phone").value.trim(),
                course: document.getElementById("course").value.trim(),
                amount: parseFloat(document.getElementById("amount").value.trim()),
                totalamount: parseFloat(document.getElementById("totalamount").value.trim()),
                paidamount: parseFloat(document.getElementById("paidamount").value.trim())
            };

            if (!data.name || !data.email || !data.phone || !data.course || isNaN(data.amount)) {
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
                    name: "Course Payment",
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
                console.error("Error creating order", err);
                alert("Failed to initiate payment.");
                document.getElementById("spinner").style.display = "none"; // Hide spinner in case of error
            });
        }
</script>
</body>
</html>
