<%-- 
    Document   : loginForm
    Created on : Jan 21, 2025, 9:16:33 AM
    Author     : VAIDEHI ENTERPRISE
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Admin - Login</title>

    <!-- Favicon -->
    <link rel="icon" type="image/x-icon" href="img/favicon.png">

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

    <!-- FontAwesome (Latest Version) -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css" integrity="sha512-REPLACE_WITH_CORRECT_HASH" crossorigin="anonymous" referrerpolicy="no-referrer" />

    <!-- Custom Styles -->
    <link href="css/sb-admin-2.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>

    <!-- SweetAlert2 -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>

<body class="bg-gradient-primary">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-xl-10 col-lg-12 col-md-9">
                <div class="card o-hidden border-0 shadow-lg my-5">
                    <div class="card-body p-0">
                        <div class="row">
                            <!-- Left Side Image -->
                            <div class="col-lg-6 d-none d-lg-block bg-login-image">
                                <img src="img/admin-sign-in.jpg" class="img-fluid" alt="Admin Sign In"/>
                            </div>

                            <!-- Right Side Form -->
                            <div class="col-lg-6">
                                <div class="p-5">
                                    <div class="text-center">
                                        <h1 class="h4 text-gray-900 mb-4">Admin Sign In!</h1>
                                    </div>

                                    <!-- SweetAlert Error Message -->
                                    <% String errorMessage = (String) request.getAttribute("errorMessage"); %>
                                    <script>
                                        document.addEventListener("DOMContentLoaded", function () {
                                            <% if (errorMessage != null) { %>
                                            Swal.fire({
                                                icon: 'error',
                                                title: 'Login Failed',
                                                text: "<%= errorMessage.replace("\"", "\\\"") %>"
                                            });
                                            <% } %>
                                        });
                                    </script>

                                    <!-- Login Form -->
                                    <form class="user" id="loginForm" method="post" action="../admin_login">
                                        <div class="form-group">
                                            <input type="email" class="form-control form-control-user" name="email" id="exampleInputEmail"
                                                   placeholder="Enter Email Address..." required>
                                        </div>
                                        <div class="form-group">
                                            <input type="password" class="form-control form-control-user" name="password" id="exampleInputPassword"
                                                   placeholder="Password" required>
                                        </div>

                                        <div class="text-right mb-4">
                                            <a class="small" href="forget-password.jsp">Forgot Password?</a>
                                        </div>

                                        <input type="submit" value="Login" class="btn btn-primary btn-user btn-block">
                                    </form>
                                </div>
                            </div> <!-- End Right Side -->
                        </div> <!-- End Row -->
                    </div> <!-- End Card Body -->
                </div> <!-- End Card -->
            </div> <!-- End Column -->
        </div> <!-- End Row -->
    </div> <!-- End Container -->

    <!-- jQuery (Updated) -->
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>

    <!-- Bootstrap -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <!-- Custom Scripts -->
    <script src="js/sb-admin-2.min.js"></script>
</body>
</html>

