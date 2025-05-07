<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
		    /* reserve space for navbar */
		}
		
		.container {
		    background: white;
		    padding: 30px 40px;
		    border-radius: 12px;
		    box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
		    width: 100%;
		    max-width: 400px;
		    margin: 0 auto; /* center horizontally */
		    margin-top: 30px; /* space below navbar */
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

        @media (max-width: 480px) {
            .container {
                padding: 20px;
                width: 90%;
            }
        }
        
        
         .spinner {
	      border: 5px solid #f3f3f3;
	      border-top: 5px solid teal;
	      border-radius: 50%;
	      width: 60px;
	      height: 60px;
	      animation: spin 1s linear infinite;
	      margin-top:-19%;
	      margin-left:44%;
	      float: left;
	    }
	
	    @keyframes spin {
	      0% { transform: rotate(0deg); }
	      100% { transform: rotate(360deg); }
	    }
	
	    #loading {
	      display: none;
	      text-align: center;
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
            <li><a class="dropdown-item" href="payment.jsp">Online Payment</a></li>
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


    <div class="container">
        <h2>Student Payment</h2>
        <form id="paymentForm">
            <input type="text" id="name" value="<%=request.getParameter("studentName") %>" required>
            <input type="email" id="email" value="<%=request.getParameter("emailid") %>"placeholder="Email" >
            <input type="text" id="phone" placeholder="Phone" value="<%=request.getParameter("phoneNumber") %>"required>
            <input type="text" id="course" placeholder="Course" value="<%=request.getParameter("class1") %>" required>
            <input type="number" id="amount" placeholder="Amount (INR)" value="<%=request.getParameter("payingfee") %>" required>
            <button type="button" onclick="payNow()">Pay Now</button>
        </form>
    </div>

    <script>
        function payNow() {
            const data = {
                name: document.getElementById("name").value.trim(),
                email: document.getElementById("email").value.trim(),
                phone: document.getElementById("phone").value.trim(),
                course: document.getElementById("course").value.trim(),
                amount: parseInt(document.getElementById("amount").value.trim())
            };

            if (!data.name || !data.email || !data.phone || !data.course || isNaN(data.amount)) {
                alert("Please fill all fields correctly.");
                return;
            }

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
                        alert("Payment successful! Payment ID: " + response.razorpay_payment_id);
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
            })
            .catch(err => {
                console.error("Error creating order", err);
                alert("Failed to initiate payment.");
            });
            
            
         // Show loading spinner
            document.getElementById("loading").style.display = "block";

            // Submit the form
            document.getElementById("paymentForm").submit();
        }
    </script>
</body>
</html>
