<%-- 
    Document   : registerForm
    Created on : Jan 20, 2025, 9:28:14 AM
    Author     : VAIDEHI ENTERPRISE
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>TrueHealth - Register</title>
    <link rel="icon" type="image/x-icon" href="Admin/img/favicon.png">

    <!-- SweetAlert2 -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <!-- Custom fonts and styles -->
    <link href="Admin/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">
    <link href="Admin/css/sb-admin-2.min.css" rel="stylesheet">
</head>
<body class="bg-gradient-primary">
    <div class="container">
        <div class="card o-hidden border-0 shadow-lg my-5">
            <div class="card-body p-0">
                <div class="row">
                    <div class="col-lg-5 d-none d-lg-block">
                        <img src="images/sign-up.jpg" alt="register_images" height="500px" width="500px">
                    </div>
                    <div class="col-lg-7">
                        <div class="p-5">
                            <div class="text-center">
                                <h1 class="h4 text-gray-900 mb-4">Create an Account!</h1>
                            </div>
                            <form class="user" id="registerForm" action="register" method="post">
                                <div class="form-group">
                                    <input type="text" class="form-control form-control-user" id="exampleFullName"
                                        name="name" placeholder="Full Name">
                                </div>
                                <div class="form-group">
                                    <input type="number" class="form-control form-control-user"
                                         name="mobile"  id="exampleMobile" placeholder="Mobile No.">
                                </div>
                                <div class="form-group">
                                    <input type="email" class="form-control form-control-user" id="exampleInputEmail"
                                          name="email" placeholder="Email Address">
                                </div>
                                <div class="form-group">
                                    <input type="password" class="form-control form-control-user"
                                         name="pass" id="exampleInputPassword" placeholder="Password">
                                </div>
                                <div class="form-group">
                                    <input type="number" class="form-control form-control-user"
                                         name="pincode"  id="examplePincode" placeholder="Pincode">
                                </div>
                                <input type="submit" value="Register Account"  class="btn btn-primary btn-user btn-block">
                            </form>
                            <hr>
                            <div class="text-center">
                                <a class="small" href="loginForm.jsp">Already have an account? Login!</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap core JavaScript -->
    <script src="Admin/vendor/jquery/jquery.min.js"></script>
    <script src="Admin/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="Admin/vendor/jquery-easing/jquery.easing.min.js"></script>
    <script src="Admin/js/sb-admin-2.min.js"></script>

    <!-- SweetAlert Form Validation -->
    <script>
        document.getElementById('registerForm').addEventListener('submit', function (event) {
            event.preventDefault();

            const fullName = document.getElementById('exampleFullName').value.trim();
            const mobile = document.getElementById('exampleMobile').value.trim();
            const email = document.getElementById('exampleInputEmail').value.trim();
            const password = document.getElementById('exampleInputPassword').value.trim();
            const pincode = document.getElementById('examplePincode').value.trim();

            if (!fullName) {
                Swal.fire('Error', 'Please enter your full name.', 'error');
                return;
            }

            if (!/^[0-9]{10}$/.test(mobile)) {
                Swal.fire('Error', 'Mobile number must be exactly 10 digits.', 'error');
                return;
            }

            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailRegex.test(email)) {
                Swal.fire('Error', 'Please enter a valid email address.', 'error');
                return;
            }

            if (password.length < 8) {
                Swal.fire('Error', 'Password must be at least 8 characters long.', 'error');
                return;
            }

            if (!/^[0-9]{6}$/.test(pincode)) {
                Swal.fire('Error', 'Pincode must be exactly 6 digits.', 'error');
                return;
            }

            Swal.fire({
                title: 'Success!',
                text: 'Registration successful!',
                icon: 'success'
            }).then(() => {
                document.getElementById('registerForm').submit();
            });
        });
    </script>
</body>
</html>
