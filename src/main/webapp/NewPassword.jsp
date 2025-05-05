<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reset Password - SAS School</title>
    <link rel="icon" href="https://cdn-icons-png.flaticon.com/512/2132/2132732.png" type="image/x-icon">
    
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    
    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(135deg, #dff6ff, #b6e3f9);
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .container {
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
            width: 500px;
            text-align: center;
        }
        .container h2 {
            
            margin-bottom: 15px;
            color: #333;
        }
        .input-group {
            margin-left: 75px;
            margin-bottom: 15px;
            text-align: left;
            wdith: 300px;
        }
        .input-group label {
            font-weight: bold;
            font-size: 14px;
        }
        
         input:focus{
        border-color: #8e44ad;
         }
        .btn {
            background: #8e44ad;
            color: white;
            padding: 10px;
            width: 60%;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
        }

        .btn:hover {
            background: teal;
            color:white;
        }
        .password-field {
            width: 300px;
            height:33px;
            padding: 0px;
            border: 2px solid black;
            font-size: 15px;
            outline: none;
            margin-left:1%;
            margin-top:10px;
            border-left: none;
            border-top: none;
            border-right: none;
            border-radius: 0px;
        }
         .glyphicon {
	      position: inherit;
	      top: 100%;
	      right: 10px;	      
	      margin-left: 280px;
	      margin-top:-30px;
	      align-content:inherit;
	      margin-right:-70px;
	      cursor: pointer;
	      font-size: 18px;
	      color: black;
	      float: left;
	    }
	    
	   .note-point {
	    margin-top:2%;
	    font-size: 11.5px;
	    color:red;
	    align-content:stretch;
	    }
    </style>
</head>
<body>
    <div class="container">
        <h2>Reset Password - SAS School</h2>
        
        <!-- Form for New Password Input -->
        <form action ="newpassword" method="POST">
            <div class="input-group">
                <input type="password" id="newPass" name="newPassword" placeholder="New Password" required minlength="6" class="password-field">
                <span class="glyphicon glyphicon-eye-open" onclick="togglePassword('newPass', this)" id="eye-icon"></span> 
            </div>
            <div class="input-group">
                <input type="password" id="confirmPass" name="confirmPassword" placeholder="Confirm Password" required minlength="6" class="password-field">
                <span id="eye-icon" class="glyphicon glyphicon-eye-open" onclick="togglePassword('confirmPass', this)"></span>
            </div>
            <input type="submit" class="btn" Value="Reset Password">
                      
        </form>
        <p class="note-point">Note: make sure both password fields contain the same value.. </p>
       <script>
    function togglePassword(inputId, icon) {
      const input = document.getElementById(inputId);
      const isPassword = input.type === "password";
      input.type = isPassword ? "text" : "password";

      // Toggle icon classes
      icon.classList.toggle("glyphicon-eye-open", !isPassword);
      icon.classList.toggle("glyphicon-eye-close", isPassword);
    }
  </script>
</body>
</html>
