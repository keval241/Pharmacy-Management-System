<%-- 
    Document   : forget-password
    Created on : Feb 22, 2025, 8:45:00 PM
    Author     : VAIDEHI ENTERPRISE
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Forgot Password - TrueHealth</title>
    <link href="Admin/vendor/fontawesome-free/css/all.min.css" rel="stylesheet">
     <link rel="icon" type="image/x-icon" href="Admin/img/favicon.png">
    <link href="Admin/css/sb-admin-2.min.css" rel="stylesheet">
    <script>
        function validateForm() {
            let email = document.getElementById("email").value;
            let emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
            if (!emailRegex.test(email)) {
                alert("Please enter a valid email.");
                return false;
            }
            return true;
        }
    </script>
</head>
<body class="bg-gradient-primary">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-6">
                <div class="card o-hidden border-0 shadow-lg my-5">
                    <div class="card-body p-5">
                        <div class="text-center">
                            <h1 class="h4 text-gray-900 mb-2">Forgot Your Password?</h1>
                            <p class="mb-4">Enter your email to reset your password.</p>
                        </div>
                        <form class="user" action="ForgotPassword" method="post" onsubmit="return validateForm();">
                            <div class="form-group">
                                <input type="email" class="form-control form-control-user" id="email" name="email" placeholder="Enter Email Address..." required>
                            </div>
                            <button type="submit" class="btn btn-primary btn-user btn-block">
                                Reset Password
                            </button>
                        </form>
                        <hr>
                        <div class="text-center">
                            <a class="small" href="registerForm.jsp">Create an Account!</a>
                        </div>
                        <div class="text-center">
                            <a class="small" href="loginForm.jsp">Already have an account? Login!</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="Admin/vendor/jquery/jquery.min.js"></script>
    <script src="Admin/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
</body>
</html>
