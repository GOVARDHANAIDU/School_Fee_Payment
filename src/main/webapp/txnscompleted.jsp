<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment Confirmation</title>
    <link rel="icon" href="https://i.pinimg.com/736x/2a/31/61/2a3161135f001e58c563ef3103221dcd.jpg" type="image/x-icon">
    <style>
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background: white;
            font-family: Arial, sans-serif;
            overflow: hidden;
            position: relative;
        }
        .confirmation-container {
            text-align: center;
        }
        .checkmark {
            width: 120px;
            height: 120px;
            background: #4285F4;
            border-radius: 50%;
            display: flex;
            justify-content: center;
            align-items: center;
            font-size: 40px;
            color: white;
            animation: bounce 0.8s ease-in-out;
        }
        @keyframes bounce {
            0% { transform: scale(0); }
            50% { transform: scale(1.2); }
            100% { transform: scale(1); }
        }
        .confetti {
            position: absolute;
            width: 10px;
            height: 10px;
            background: red;
            border-radius: 50%;
            opacity: 0;
            animation: confetti-fall 1s linear forwards;
        }
        @keyframes confetti-fall {
            0% {
                transform: translateY(0) rotate(0deg);
                opacity: 1;
            }
            100% {
                transform: translateY(100px) rotate(720deg);
                opacity: 0;
            }
        }
        .home-btn {
            position: absolute;
            bottom: 20px;
            right: 20px;
            padding: 10px 20px;
            font-size: 18px;
            background: #4285F4;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
            transition: 0.3s;
        }
        .home-btn:hover {
            background: #357ae8;
        }
    </style>
</head>
<body>

    <div class="confirmation-container">
        <div class="checkmark"><p style="font-size: 50px">&#10004;</p></div>
    </div>

    <a href="home.jsp" class="home-btn">🏠 Home</a>

    <script>
        function createConfetti() {
            for (let i = 0; i < 15; i++) {
                let confetti = document.createElement("div");
                confetti.classList.add("confetti");
                document.body.appendChild(confetti);
                
                let colors = ["#4285F4", "#FBBC05", "#34A853", "#EA4335"];
                confetti.style.background = colors[Math.floor(Math.random() * colors.length)];
                
                let size = Math.random() * 8 + 5;
                confetti.style.width = `${size}px`;
                confetti.style.height = `${size}px`;
                
                confetti.style.left = `${Math.random() * window.innerWidth}px`;
                confetti.style.top = "50px";
                confetti.style.animationDuration = `${Math.random() * 1 + 0.5}s`;

                setTimeout(() => confetti.remove(), 1200);
            }
        }

        setTimeout(createConfetti, 200);
        
     
    </script>

</body>
</html>

