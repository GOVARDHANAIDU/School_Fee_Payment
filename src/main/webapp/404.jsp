<%@ page isErrorPage="true" session="true" %>
<%
    String destinationPage;
    if (session.getAttribute("adminName") != null) {
        destinationPage = "home.jsp"; // user is logged in
    } else {
        destinationPage = "AdminLogin.jsp"; // user not logged in
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>404 - Page Not Found</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f2f2f2;
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
            margin: 0;
        }
        .box {
            background-color: #fff;
            padding: 40px;
            border-radius: 10px;
            text-align: center;
            box-shadow: 0px 4px 12px rgba(0, 0, 0, 0.1);
        }
        h1 {
            color: #c00;
            font-size: 36px;
        }
        p {
            font-size: 18px;
            color: #333;
        }
        .btn-container {
            margin-top: 30px;
            display: flex;
            justify-content: space-between;
        }
        .btn {
            padding: 10px 20px;
            text-decoration: none;
            font-size: 16px;
            background-color: #007BFF;
            color: white;
            border-radius: 5px;
            transition: background-color 0.3s;
        }
        .btn:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <div class="box">
        <h1>404 &#8212; Not Found</h1>
        <p>The page you're looking for doesn't exist or the URL is incorrect.</p>
        <div class="btn-container">
            <a href="javascript:history.back()" class="btn">&#8592; Back</a>
            <a href="<%= destinationPage %>" class="btn">&#8962; Dashboard</a>
        </div>
    </div>
</body>
</html>
