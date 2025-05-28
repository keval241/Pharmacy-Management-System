<%-- 
    Document   : ReSet
    Created on : Feb 22, 2025, 9:12:04 PM
    Author     : VAIDEHI ENTERPRISE
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Reset Password - TrueHealth</title>
    <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet">
    <link href="css/sb-admin-2.min.css" rel="stylesheet">
    <link rel="icon" type="image/x-icon" href="img/favicon.png">
    <script>
        function validatePassword() {
            let password = document.getElementById("password").value;
            let confirmPassword = document.getElementById("confirmPassword").value;
            if (password.length < 8) {
                alert("Password must be at least 8 characters.");
                return false;
            }
            if (password !== confirmPassword) {
                alert("Passwords do not match.");
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
                            <h1 class="h4 text-gray-900 mb-2">Reset Your Password</h1>
                        </div>
                        <form class="user" action="../admin_reset" method="post" onsubmit="return validatePassword();">
                            <div class="form-group">
                                <input type="password" class="form-control form-control-user" id="password" name="password" placeholder="Enter New Password" required>
                            </div>
                            <div class="form-group">
                                <input type="password" class="form-control form-control-user" id="confirmPassword" name="confirmPassword" placeholder="Confirm Password" required>
                            </div>
                            <button type="submit" class="btn btn-primary btn-user btn-block">
                                Update Password
                            </button>
                        </form>
                        <hr>
                        <div class="text-center">
                            <a class="small" href="loginForm.jsp">Back to Login</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>

