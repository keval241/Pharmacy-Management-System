<%-- 
    Document   : thank-you
    Created on : Feb 19, 2025, 9:12:09 AM
    Author     : VAIDEHI ENTERPRISE
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="Headder.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Order Success</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <script>
        // Auto redirect after 10 seconds
        setTimeout(function () {
            window.location.href = "Home.jsp";
        }, 5000);
    </script>
    <style>
        .thank-you-container {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            background: linear-gradient(135deg, #f8f9fa, #e9ecef);
        }
        .thank-you-box {
            background: white;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
            text-align: center;
            max-width: 500px;
        }
        .thank-you-box .icon-check {
            font-size: 60px;
            color: #28a745;
        }
    </style>
</head>
<body>

<div class="thank-you-container">
    <div class="thank-you-box">
        <span class="icon-check display-3 text-success">&#10004;</span>
        <h2 class="display-5 text-black">Thank you!</h2>
        <p class="lead mb-4">Your order was successfully completed.</p>
        <p>You will be redirected to the home page in <span id="countdown">10</span> seconds.</p>
        <a href="Shop.jsp" class="btn btn-primary px-4 py-2 mt-3">Back to Store</a>
    </div>
</div>

<script>
    // Countdown timer
    let countdown = 10;
    const countdownElement = document.getElementById("countdown");
    setInterval(function () {
        countdown--;
        countdownElement.innerText = countdown;
        if (countdown <= 0) {
            clearInterval();
        }
    }, 1000);
</script>

</body>
</html>

<%@include file="Footer.jsp" %>
