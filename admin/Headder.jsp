<%-- 
    Document   : Headder
    Created on : Jan 21, 2025, 8:07:42 AM
    Author     : VAIDEHI ENTERPRISE
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.io.*"%>
<%@page import="javax.servlet.*"%>
<%@page import="javax.servlet.http.*"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="">
        <meta name="author" content="">
        <title>TrueHealth - Admin</title>
        <link rel="icon" type="image/x-icon" href="img/favicon.png">
        <!-- Custom fonts for this template-->
        <link rel="stylesheet" href="css/all.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/fontawesome.min.css" 
              integrity="sha512-v8QQ0YQ3H4K6Ic3PJkym91KoeNT5S3PnDKvqnwqFD1oiqIl653crGZplPdU5KKtHjO0QKcQ2aUlQZYjHczkmGw==" 
              crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
        <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
              rel="stylesheet">
        <!-- Custom styles for this template-->
        <link href="css/sb-admin-2.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>
    </head>

    <body id="page-top">
        <%-- Session validation --%>
        <%
            String userName = (String) session.getAttribute("username");
            if (userName == null) {
                response.sendRedirect("loginForm.jsp"); // Redirect to login page if session is invalid
                return;
            }
        %>

        <!-- Page Wrapper -->
        <div id="wrapper">

            <!-- Sidebar -->
            <ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">

                <!-- Sidebar - Brand -->
                <a class="sidebar-brand d-flex align-items-center justify-content-start" href="Home.jsp">
                    <!-- Logo Image -->
                    <img src="../images/logo.png" alt="TrueHealth Logo" class="img-fluid" style="max-width: 40px; height: auto;"/>
                    <!-- TrueHealth Text -->
                    <div class="sidebar-brand-text mx-3 ml-2">TrueHealth</div>
                </a>


                <!-- Divider -->
                <hr class="sidebar-divider my-0">

                <!-- Nav Item - Dashboard -->
                <li class="nav-item active">
                    <a class="nav-link" href="Home.jsp">
                        <i class="fas fa-fw fa-tachometer-alt"></i>
                        <span>Dashboard</span></a>
                </li>

                <!-- Divider -->
                <hr class="sidebar-divider">
                <div class="sidebar-heading">Users</div>
                <li class="nav-item">
                    <a class="nav-link" href="view_user.jsp">
                        <i class="fas fa-fw fa-users"></i>
                        <span>Users</span></a>
                </li>

                <!-- Divider -->
                <hr class="sidebar-divider">
                <div class="sidebar-heading">Orders</div>
                <li class="nav-item">
                    <a class="nav-link" href="view_order.jsp">
                        <i class="fas fa-fw fa-bag-shopping"></i>
                        <span>Order</span></a>
                </li>
                 <hr class="sidebar-divider">
                <div class="sidebar-heading">Payment</div>
                <li class="nav-item">
                    <a class="nav-link" href="view_payment.jsp">
                        <i class="fas fa-credit-card"></i>
                        <span>Payment</span>
                    </a>
                </li>

                <!-- Divider -->
                <hr class="sidebar-divider">
                <div class="sidebar-heading">Categories</div>
                <li class="nav-item">
                    <a class="nav-link" href="view_category.jsp">
                        <i class="fas fa-fw fa-boxes"></i>
                        <span>Categories</span></a>
                </li>

                <!-- Divider -->
                <hr class="sidebar-divider">
                <div class="sidebar-heading">Companies</div>
                <li class="nav-item">
                    <a class="nav-link" href="view_company.jsp">
                        <i class="fas fa-fw fa-building"></i>
                        <span>Companies</span></a>
                </li>

                <!-- Divider -->
                <hr class="sidebar-divider">
                <div class="sidebar-heading">Medicines</div>
                <li class="nav-item">
                    <a class="nav-link" href="view_medicine.jsp">
                        <i class="fas fa-fw fa-pills"></i>
                        <span>Medicines</span></a>
                </li>

                <hr class="sidebar-divider">
                    <div class="sidebar-heading">Review</div>
                    <li class="nav-item">
                        <a class="nav-link" href="view_review.jsp">
                            <!-- Correct FontAwesome Icon for a star -->
                            <i class="fas fa-star"></i> <!-- You can change to fa-regular for an empty star -->
                            <span>Review</span>
                        </a>
                    </li>
                <!-- Divider -->
                <hr class="sidebar-divider">
                <div class="sidebar-heading">Contact</div>
                <li class="nav-item">
                    <a class="nav-link" href="view_contact.jsp">
                        <i class="fas fa-fw fa-phone-alt"></i>
                        <span>Contact</span></a>
                </li>
               

                <!-- Divider -->
                <hr class="sidebar-divider d-none d-md-block">
                <div class="text-center d-none d-md-inline">
                    <button class="rounded-circle border-0" id="sidebarToggle"></button>
                </div>
            </ul>
            <!-- End of Sidebar -->

            <!-- Content Wrapper -->
            <div id="content-wrapper" class="d-flex flex-column">

                <!-- Main Content -->
                <div id="content">

                    <!-- Topbar -->
                    <nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">
                        <button id="sidebarToggleTop" class="btn btn-link d-md-none rounded-circle mr-3">
                            <i class="fa fa-bars"></i>
                        </button>

                        <!-- Topbar Navbar -->
                        <ul class="navbar-nav ml-auto">
                            <!-- Nav Item - User Information -->
                            <li class="nav-item dropdown no-arrow">
                                <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button"
                                   data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    <span class="mr-2 d-none d-lg-inline text-gray-600 small"><%= userName%></span>
                                    <img class="img-profile rounded-circle" src="img/profile.jpg">
                                </a>
                                <div class="dropdown-menu dropdown-menu-right shadow animated--grow-in"
     aria-labelledby="userDropdown">
    <a class="dropdown-item" href="profile.jsp">
        <i class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i>
        Profile
    </a>
                                     <div class="dropdown-divider"></div>
    <a class="dropdown-item" href="licenses.jsp">
        <i class="fas fa-file-alt fa-sm fa-fw mr-2 text-gray-400"></i>
        Pharmacy Licenses
    </a>
    <div class="dropdown-divider"></div>
    <a class="dropdown-item" href="../admin_logout">
        <i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
        Logout
    </a>
</div>

                            </li>
                        </ul>
                    </nav>
                    <!-- End of Topbar -->