
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@page import="java.util.Set"%>
<%@page import="com.mysql.cj.Session"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">   
    <title>Forgot Password - SAS BANK</title>
    <link rel="icon" href="https://cdn-icons-png.flaticon.com/512/2132/2132732.png" type="image/x-icon">
    <style>
        body {
            font-family: Arial, sans-serif;
           background: linear-gradient(135deg, #dff6ff, #b6e3f9);;
            height: 710px;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .container {
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
            width: 350px;
            text-align: center;
        }
        .container h2 {
            margin-bottom: 15px;
            color: #333;
        }
        .input-group {
            margin-bottom: 15px;
            text-align: left;
        }
        .input-group label {
            font-weight: bold;
            font-size: 14px;
        }
        .input-group input {
            width: 90%;
            padding: 8px;
            border: 2px solid #8e44ad;
            border-radius: 5px;
            font-size: 14px;
            outline: none;
        }
         .input-group input:hover{
        background: #f0f2f5;
         }
        .btn {
            background: #8e44ad;
            color: white;
            padding: 10px;
            width: 85%;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            
            
        }
        .btn:hover {
            background: #732d91;
        }
        .output {
            margin-top: 15px;
            font-size: 16px;
            font-weight: bold;
        }
        .error{
        color:red;
        }
        .note-point {
	    margin-top:2%;
	    font-size: 11.5px;
	    color:red;
	    align-content:stretch;
	    }
	    .spinner {
      border: 5px solid #f3f3f3;
      border-top: 5px solid teal;
      border-radius: 50%;
      width: 60px;
      height: 60px;
      animation: spin 1s linear infinite;
      margin-top:-35%;
      margin-left:42%;
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
    <div class="container">
        <h3>Forgot Password - SAS School</h3>
        
        <!-- Form for Email Input -->
        <form  action="forgotPasswordOTP">
            <div class="input-group">
                <label>Email ID</label>
                <input type="email" name="emailid" required>
            </div>
            
            <input type="submit" class="btn" Value="Submit" onclick="submitForm()">
        </form>        
         <p class="note-point">Note: OTP will be sent exclusively to your registered email. Please enter it correctly. </p>
         
         <div id="loading" style="display: none;">
             <div class="spinner">
             </div>
         
    </div>
    
        <script>
    function submitForm() {
        // Show loading spinner
        document.getElementById("loading").style.display = "block";

        // Submit the form
        document.getElementById("balanceForm").submit();
       
      }
</script>
</body>
</html>
