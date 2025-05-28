<%-- 
    Document   : Headder
    Created on : Jan 20, 2025, 8:39:17 AM
    Author     : VAIDEHI ENTERPRISE
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <style>
            .service-box:hover {
                background-color: #f8f9fa;
                transition: all 0.3s ease-in-out;
                transform: scale(1.05);
            }
         body {
            background-color: #f8f9fa;
        }

        .product-card {
            position: relative;
            overflow: hidden;
            border-radius: 15px;
            transition: transform 0.3s ease-in-out;
            background: #ffffff; /* White Background */
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            padding: 15px; /* Added padding for spacing inside the card */
            margin-bottom: 20px; /* Added margin for spacing between cards */
        }

        .product-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2);
        }

        .product-card img {
            width: 100%;
            height: auto;
            transition: transform 0.3s ease-in-out;
            border-radius: 15px 15px 0 0;
        }

        .product-card:hover img {
            transform: scale(1.1);
        }

        .product-card .tag {
            position: absolute;
            top: 10px;
            left: 10px;
            background: red;
            color: white;
            padding: 5px 10px;
            font-size: 14px;
            font-weight: bold;
            border-radius: 5px;
        }

        .product-card .product-info {
            text-align: center;
            padding: 15px;
        }

        .product-card h3 {
            font-size: 20px;
            color: #333;
            margin-bottom: 10px;
        }

        .product-card p.price {
            font-size: 18px;
            font-weight: bold;
            color: #2c3e50;
        }

        .product-card p.price del {
            color: #e74c3c;
            margin-right: 5px;
        }
        .office-card {
            transition: all 0.3s ease-in-out;
            border-radius: 10px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        .office-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 15px rgba(0, 0, 0, 0.2);
        }
        .star-rating {
        display: flex;
        flex-direction: row-reverse;
        justify-content: flex-start;
    }
    .star-rating input[type="radio"] {
        display: none;
    }
    .star-rating label.star {
        font-size: 2rem;
        color: #ddd;
        cursor: pointer;
        transition: color 0.2s;
    }
    .star-rating input[type="radio"]:checked ~ label.star,
    .star-rating label.star:hover,
    .star-rating label.star:hover ~ label.star {
        color: #ffc107;
    }
     .product-card {
        height: 100%; /* Card height adapts based on content */
        display: flex;
        flex-direction: column;
        justify-content: space-between;
        border-radius: 20px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        transition: transform 0.3s ease-in-out;
        background-color: #ffffff;
        padding: 15px;
    }

    .product-card:hover {
        transform: scale(1.03);
    }

    .product-card img {
        height: 150px; 
        object-fit: contain;
        border-radius: 10px;
        width: 100%;
    }

    .product-info {
        text-align: center;
        flex-grow: 1;
        margin-top: 10px;
    }

    .product-info h4 {
        font-size: 1.2rem;
        margin: 5px 0;
    }

    .product-info p {
        margin: 5px 0;
        font-size: 0.9rem;
    }

    .quantity-cart {
        display: flex;
        align-items: center;
        justify-content: space-between;
        margin-top: 10px;
    }

    .quantity-cart select, .quantity-cart button {
        width: 48%;
    }

    /* Responsive Design Tweaks */
    @media (max-width: 768px) {
        .product-card {
            padding: 10px;
        }

        .product-card img {
            height: 120px;
        }

        .product-info h4 {
            font-size: 1rem;
        }

        .product-info p {
            font-size: 0.85rem;
        }

        .quantity-cart select, .quantity-cart button {
            width: 48%;
            font-size: 0.85rem;
        }
    }

    @media (max-width: 576px) {
        .product-card {
            padding: 8px;
        }

        .product-card img {
            height: 100px;
        }

        .product-info h4 {
            font-size: 0.9rem;
        }

        .product-info p {
            font-size: 0.8rem;
        }
    }
        </style>
        <title>TrueHealth - Pharmacy Website</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/fontawesome.min.css" integrity="sha512-v8QQ0YQ3H4K6Ic3PJkym91KoeNT5S3PnDKvqnwqFD1oiqIl653crGZplPdU5KKtHjO0QKcQ2aUlQZYjHczkmGw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link href="https://fonts.googleapis.com/css?family=Rubik:400,700|Crimson+Text:400,400i" rel="stylesheet">
        <link rel="stylesheet" href="fonts/icomoon/style.css">
        <!--<link rel="icon" type="image/x-icon" href="Admin/img/favicon.png">-->
        <link rel="icon" type="image/x-icon" href="images/favicon.png">
        <link rel="stylesheet" href="css/bootstrap.min.css">
        <link rel="stylesheet" href="css/magnific-popup.css">
        <link rel="stylesheet" href="css/jquery-ui.css">
        <link rel="stylesheet" href="css/owl.carousel.min.css">
        <link rel="stylesheet" href="css/owl.theme.default.min.css">
        <script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
        <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
        <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/smoothness/jquery-ui.css">

        <!--<link rel="stylesheet" href="css/all.min.css">-->
        <link rel="stylesheet" href="css/aos.css">

        <link rel="stylesheet" href="css/style.css">

    </head>
<%
    // Retrieve session
     session = request.getSession(false); // Prevent creating a new session if one doesn't exist
    Integer userId = (session != null) ? (Integer) session.getAttribute("userId") : null; // Use Integer to handle null values
    String username = (session != null) ? (String) session.getAttribute("username") : null;
    if (userId == null) {
        response.sendRedirect("loginForm.jsp");  // Redirect to login if session has expired or user not logged in
    }
%>

    <body>
        <div class="site-wrap">
            <div class="site-navbar py-2">
                <div class="search-wrap">
                    <div class="container">
                        <a href="#" class="search-close js-search-close"><span class="icon-close2"></span></a>
                        <form action="#" method="post">
                            <input type="text" class="form-control" placeholder="Search keyword and hit enter...">
                        </form>
                    </div>
                </div>
                <div class="container">
                    <div class="d-flex align-items-center justify-content-between">
                        <div class="logo">
                            <div class="site-logo d-flex align-items-center">
                                <!-- Logo Image with Bootstrap img-fluid class for responsiveness -->
                                <a href="Home.jsp" class="js-logo-clone">
                                    <img src="images/logo.png" alt="TrueHealth Logo" class="img-fluid" style="max-width: 50px; height: auto;" />
                                </a>

                                <!-- Company Name Text -->
                                <a href="Home.jsp" class="js-logo-clone ml-3">
                                    <span class="h4">TrueHealth</span> <!-- Company name with custom font size -->
                                </a>
                            </div>
                        </div>

                        <div class="main-nav d-none d-lg-block">
                            <nav class="site-navigation text-right text-md-center" role="navigation">
                                <ul class="site-menu js-clone-nav d-none d-lg-block">
                                    <li class="active">
                                        <a href="Home.jsp">
                                            <i class="fas fa-home"></i> Home
                                        </a>
                                    </li>
                                    <li>
                                        <a href="About.jsp">
                                            <i class="fas fa-info-circle"></i> About
                                        </a>
                                    </li>
                                    <li>
                                        <a href="Service.jsp">
                                            <i class="fas fa-concierge-bell"></i> Service
                                        </a>
                                    </li>
                                    <li>
                                        <a href="Shop.jsp">
                                            <i class="fas fa-store"></i> Store
                                        </a>
                                    </li>
                                    <li>
                                        <a href="Contact.jsp">
                                            <i class="fas fa-phone"></i> Contact
                                        </a>
                                    </li>
                                    <li class="has-children">
                                        <a href="#"><i class="fas fa-user"></i><%= (session.getAttribute("username") != null) ? session.getAttribute("username") : "Guest" %></a>
                                        <ul class="dropdown">
                                            <li><a href="profile.jsp"><i class="fas fa-user-circle"></i> Profile</a></li>
                                          <li><a href="order_history.jsp"><i class="fas fa-box"></i> View Orders</a></li>
                                          <!--<li><a href=""><i class="fas fa-key"></i> Reset Password</a></li>-->
                                          <li><a href="logout"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
                                        </ul>
                                    </li>
                                </ul>
                            </nav>
                        </div>

                        <div class="icons">
                            <a href="#" class="icons-btn d-inline-block js-search-open"><span class="icon-search"></span></a>
                            <a href="Cart.jsp" class="icons-btn d-inline-block bag">
                        <span class="icon-shopping-bag"></span>
                        <!--<span class="number" id="cartCount"></span>-->
                    </a>
                        </div>               
                    </div>
                    </div>
                </div>
            </div>
                                        <script>
    $(document).ready(function () {
        // Live Search Functionality
        $("#searchInput").on("keyup", function () {
            let query = $(this).val();
            if (query.length < 2) {
                $("#searchResults").hide();
                return;
            }

            $.ajax({
                url: "SearchServlet",
                type: "POST",
                data: {search: query},
                success: function (data) {
                    $("#searchResults").html(data).show();
                }
            });
        });

        // Hide search results when clicking outside
        $(document).on("click", function (e) {
            if (!$(e.target).closest("#searchForm").length) {
                $("#searchResults").hide();
            }
        });

        // Update Cart Count
        function updateCartCount() {
            $.ajax({
                url: "CartCount",
                type: "GET",
                success: function (response) {
                    $("#cartCount").text(response);
                }
            });
        }

        updateCartCount();
    });
</script>
                                        