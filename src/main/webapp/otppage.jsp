<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>OTP Verification - SAS School</title>
  <link rel="icon" href="https://cdn-icons-png.flaticon.com/512/2132/2132732.png" type="image/x-icon">
  <style>
    body {
      margin: 0;
      padding: 0;
      font-family: Arial, sans-serif;
     background: linear-gradient(135deg, #dff6ff, #b6e3f9);
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
    }

    .otp-container {
      background-color: white;
      padding: 30px 40px;
      border-radius: 12px;
      box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
      width: 300px;
      text-align: center;
      height: 240px;
    }

    .otp-container h2 {
      margin-bottom: 20px;
      color: #333;
    }

    .otp-input {
      display: flex;
      justify-content: space-between;
      gap: 4px;
      margin-bottom: 20px;
    }

    .otp-input input {
      width: 35px;
      height: 35px;
      text-align: center;
      font-size: 18px;
      border: 2px solid #111111;
      border-radius: 8px;
      outline: none;
      transition: border-color 0.3s;
    }

    .otp-input input:focus {
      border-color: #6d28d9;
    }

    button {
      background-color: #9333ea;
      color: white;
      padding: 10px 25px;
      font-size: 14px;
      border: none;
      border-radius: 8px;
      cursor: pointer;
      transition: background 0.3s ease;
      margin-top: 10px;
    }

    button:hover {
      background-color:teal;
    }

    #resendBtn {
      font-size: 12px;
      padding: 8px 20px;
      margin-top: 10px;
    }
    .note-point {
    font-size: 11.5px;
    color:red;
    align-content:stretch;
    }
  </style>
</head>
<body>
  <div class="otp-container">
    <h2>Enter OTP - SAS School</h2>
    <form action="otpVerification" >
      <div class="otp-input">
        <input type="text" maxlength="1" name="otp1" class="otp-box" required="required">
        <input type="text" maxlength="1" name="otp2" class="otp-box" required="required">
        <input type="text" maxlength="1" name="otp3" class="otp-box" required="required">
        <input type="text" maxlength="1" name="otp4" class="otp-box" required="required">
        <input type="text" maxlength="1" name="otp5" class="otp-box" required="required">
        <input type="text" maxlength="1" name="otp6" class="otp-box" required="required">
      </div>
      <button type="submit">Verify OTP</button>
    </form>
    <p class="note-point">Note: Please enter a valid OTP. For security reasons, the OTP can only be sent once. </p>
  </div>

  <script>
    const inputs = document.querySelectorAll('.otp-box');

    inputs.forEach((input, index) => {
      input.addEventListener('input', (e) => {
        const value = e.target.value.replace(/[^0-9]/g, '');
        e.target.value = value;

        if (value.length === 1 && index < inputs.length - 1) {
          inputs[index + 1].focus();
        }
      });

      input.addEventListener('keydown', (e) => {
        if (e.key === 'Backspace' && e.target.value === '' && index > 0) {
          inputs[index - 1].focus();
        }
      });
    });

  </script>
</body>
</html>
