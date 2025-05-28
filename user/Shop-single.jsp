<%-- 
    Document   : Shop-single
    Created on : Jan 20, 2025, 8:41:28 AM
    Author     : VAIDEHI ENTERPRISE
--%>

<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="Admin/conn.jsp" %>
<%@include file="Headder.jsp" %>
<%    PreparedStatement ps = null;
    ResultSet rs = null;
    try {
        String m_id = request.getParameter("m_id");
        String query = "SELECT m.*, c.cmp_name, cat.cat_name FROM medicine m "
                + "JOIN company c ON m.cmp_id = c.cmp_id "
                + "JOIN category cat ON m.cat_id = cat.cat_id "
                + "WHERE m.m_id = ?";
        ps = con.prepareStatement(query);
        ps.setInt(1, Integer.parseInt(m_id));
        rs = ps.executeQuery();

        if (rs.next()) {
%>
<div class="bg-light py-3">
    <div class="container">
        <div class="row">
            <div class="col-md-12 mb-0">
                <a href="Home.jsp">Home</a> <span class="mx-2 mb-0">/</span>
                <a href="Shop.jsp">Store</a> <span class="mx-2 mb-0">/</span>
                <strong class="text-black"><%= rs.getString("m_name")%></strong>
            </div>
        </div>
    </div>
</div>


<div class="site-section">
    <div class="container">
        <!-- Back button positioned at top-right -->
        <div class="row">
            <div class="col-md-12" style="position: relative;">
                <a href="Shop.jsp" class="btn btn-secondary" style="position: absolute; top: 10px; right: 10px;">Back</a>
            </div>
        </div>

        <div class="row">
            <div class="col-md-5 mr-auto">
                <div class="border text-center">
                    <img src="Admin/img/<%= rs.getString("m_image")%>" alt="<%= rs.getString("m_name")%>" class="img-fluid p-5">
                </div>
            </div>
            <div class="col-md-6">
                <h2 class="text-black mb-3"><%= rs.getString("m_name")%></h2>
                <h4 class="text-black mb-3"><%= rs.getString("cmp_name")%></h4>
                <h5 class="text-black mb-3"><%= rs.getString("cat_name")%></h5>
                <p><strong class="text-secondary">Expire Date:</strong> <%= rs.getDate("m_expire_date")%></p>
                <p>
                    <del class="text-muted">$<%= rs.getDouble("m_price") + 40%></del>
                    <strong class="text-primary h4 ml-2">$<%= rs.getDouble("m_price")%></strong>
                </p>
                <div class="mb-4">
                    <h5 class="text-dark">Description</h5>
                    <p class="text-muted" style="line-height: 1.6;">
                        <%= rs.getString("m_description")%>
                    </p>
                </div>

                <!-- Quantity Selector -->
                <div class="mb-4">
                    <h5 class="text-dark">Quantity</h5>
                    <div class="input-group" style="max-width: 220px;">
                        <!-- Decrease button -->
                        <button class="btn btn-outline-primary" type="button" onclick="adjustQuantity(-1)">−</button>

                        <!-- Quantity input field -->
                        <input type="number" class="form-control text-center" id="quantity" name="m_quantity" value="1" min="1" aria-label="Quantity" oninput="validateQuantity()" />

                        <!-- Increase button -->
                        <button class="btn btn-outline-primary" type="button" onclick="adjustQuantity(1)">+</button>
                    </div>



                </div>
                <!-- Add to Cart Button -->
                <form method="POST" action="AddToCart">
                    <input type="hidden" name="m_id" value="<%= rs.getInt("m_id")%>" />
                    <input type="number" name="m_quantity" value="1" id="hiddenQuantity" style="display:none;" />
                    <button type="submit" class="btn btn-primary">Add to Cart</button>
                </form>
            </div>
                    

            <script>
                // Function to adjust the quantity based on button clicks
                function adjustQuantity(change) {
                    var quantityField = document.getElementById('quantity');
                    var currentQuantity = parseInt(quantityField.value);

                    // Increment or decrement the quantity
                    var newQuantity = currentQuantity + change;

                    // Prevent negative or zero values
                    if (newQuantity < 1) {
                        newQuantity = 1;
                    }

                    // Update the visible quantity input field
                    quantityField.value = newQuantity;

                    // Update the hidden field value as well
                    document.getElementById('hiddenQuantity').value = newQuantity;
                }

                // Function to validate quantity input
                function validateQuantity() {
                    var quantityField = document.getElementById('quantity');
                    var quantity = parseInt(quantityField.value);

                    // If the value is less than 1, set it to 1 (min quantity)
                    if (quantity < 1) {
                        quantityField.value = 1;
                    }

                    // Update the hidden field value to match
                    document.getElementById('hiddenQuantity').value = quantityField.value;
                }
            </script>
            <!-- Reviews and Add Review Tabs -->

            <%
                // Initialize the connection variables

                try {
                    String mIdParam = request.getParameter("m_id");
                    int mId = 0; // Default value

                    // If m_id exists in the request, parse it to an integer
                    if (mIdParam != null && !mIdParam.isEmpty()) {
                        try {
                            mId = Integer.parseInt(mIdParam);
                        } catch (NumberFormatException e) {
                            out.println("<p>Invalid medicine ID format!</p>");
                        }
                    }

                    if (mId > 0) {
                        // SQL query to fetch reviews for the specific medicine
                        String sql = "SELECT  rating, r_comment FROM review WHERE m_id = ? ORDER BY review_date DESC";
                        ps = con.prepareStatement(sql);
                        ps.setInt(1, mId);  // Bind the medicine ID to the query

                        // Execute the query
                        rs = ps.executeQuery();

            %>
            <div class="col-md-6 align-self-center">
                <div class="mt-5">
                    <ul class="nav nav-pills mb-3" id="pills-tab" role="tablist">
                        <li class="nav-item">
                            <a class="nav-link active" id="pills-reviews-tab" data-toggle="pill" href="#pills-reviews" role="tab" aria-controls="pills-reviews" aria-selected="true">
                                Reviews
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" id="pills-add-review-tab" data-toggle="pill" href="#pills-add-review" role="tab" aria-controls="pills-add-review" aria-selected="false">
                                Add a Review
                            </a>
                        </li>
                    </ul>

                    <div class="tab-content" id="pills-tabContent">
                        <!-- Display Dynamic Reviews -->
                        <div class="tab-pane fade show active" id="pills-reviews" role="tabpanel" aria-labelledby="pills-reviews-tab">
                            <div id="reviews-list">
                                <%                    // Check if there are reviews
                                    if (!rs.isBeforeFirst()) {
                                        out.println("<p>No reviews yet. Be the first to review!</p>");
                                    } else {
                                        // Loop through the result set and display reviews
                                        while (rs.next()) {

                                            int rating = rs.getInt("rating");
                                            String comment = rs.getString("r_comment");

                                            // Manually create the repeated stars for the rating
                                            StringBuilder ratingStars = new StringBuilder();
                                            for (int i = 0; i < rating; i++) {
                                                ratingStars.append("★");  // Filled stars
                                            }
                                            for (int i = rating; i < 5; i++) {
                                                ratingStars.append("☆");  // Empty stars
                                            }
                                %>
                                <div class="review mb-3">
                                    <div class="d-flex justify-content-between">
                                        <span class="font-weight-bold"><%= username%></span>
                                        <span class="text-warning"><%= ratingStars.toString()%></span>
                                    </div>
                                    <p><%= comment%></p>
                                </div>
                                <%
                                        }
                                    }
                                %>
                            </div>
                        </div>

                        <!-- Add Review Form -->
                        <div class="tab-pane fade" id="pills-add-review" role="tabpanel" aria-labelledby="pills-add-review-tab">
                            <form method="post" class="border p-4 rounded shadow-sm" action="AddReview">
                                <!-- Hidden fields for medicine ID and user ID -->
                                <input type="hidden" name="m_id" value="<%= request.getParameter("m_id")%>">
                                <input type="hidden" name="u_id" value="<%= session.getAttribute("userId")%>">

                                <!-- Rating -->
                                <div class="form-group">
                                    <label for="rating" class="font-weight-bold">Rating:</label>
                                    <div class="star-rating d-flex">
                                        <!-- Radio buttons for star ratings -->
                                        <input type="radio" id="5-stars" name="rating" value="5" required>
                                        <label for="5-stars" class="star">&#9733;</label>

                                        <input type="radio" id="4-stars" name="rating" value="4">
                                        <label for="4-stars" class="star">&#9733;</label>

                                        <input type="radio" id="3-stars" name="rating" value="3">
                                        <label for="3-stars" class="star">&#9733;</label>

                                        <input type="radio" id="2-stars" name="rating" value="2">
                                        <label for="2-stars" class="star">&#9733;</label>

                                        <input type="radio" id="1-star" name="rating" value="1">
                                        <label for="1-star" class="star">&#9733;</label>
                                    </div>
                                </div>

                                <!-- Review Comment -->
                                <div class="form-group">
                                    <label for="r_comment" class="font-weight-bold">Your Review:</label>
                                    <textarea name="r_comment" id="r_comment" rows="4" class="form-control" placeholder="Write your review here..." required></textarea>
                                </div>

                                <!-- Submit Button -->
                                <button type="submit" class="btn btn-success btn-block">Submit Review</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <%
                    } else {
                        out.println("<p>Invalid medicine ID!</p>");
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                    out.println("<p>Error fetching reviews: " + e.getMessage() + "</p>");
                } finally {
                    // Close database resources
                    try {
                        if (rs != null) {
                            rs.close();
                        }
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                    try {
                        if (ps != null) {
                            ps.close();
                        }
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                    try {
                        if (con != null) {
                            con.close();
                        }
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            %>
        </div>
    </div>
    <%
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (con != null) {
                con.close();
            }
        }
    %>

    <style>
        .star-rating {
            display: flex;
            justify-content: space-around;
            font-size: 30px;
        }

        .star {
            cursor: pointer;
            transition: color 0.3s ease;
        }

        input[type="radio"]:checked ~ label {
            color: #f39c12; /* Highlight color for selected stars */
        }

        input[type="radio"]:checked ~ label ~ label {
            color: #f39c12; /* Highlight subsequent stars */
        }

        input[type="radio"]:not(:checked) ~ label {
            color: #ccc; /* Unselected stars */
        }
    </style>

    <div class="site-section bg-secondary bg-image" style="background-image: url('images/bg_2.jpg');">
        <div class="container">
            <div class="row align-items-stretch">
                <div class="col-lg-6 mb-5 mb-lg-0">
                    <a href="#" class="banner-1 h-100 d-flex" style="background-image: url('images/bg_1.jpg');">
                        <div class="banner-1-inner align-self-center">
                            <h2>TrueHealth Products</h2>
                            <p>TrueHealth provides premium, all-natural wellness products designed to enhance your vitality and support overall well-being
                            </p>
                        </div>
                    </a>
                </div>
                <div class="col-lg-6 mb-5 mb-lg-0">
                    <a href="#" class="banner-1 h-100 d-flex" style="background-image: url('images/bg_2.jpg');">
                        <div class="banner-1-inner ml-auto  align-self-center">
                            <h2>Rated by Experts</h2>
                            <p>TrueHealth: Expert-approved wellness solutions crafted with premium, all-natural ingredients for optimal health.
                            </p>
                        </div>
                    </a>
                </div>
            </div>
        </div>
    </div>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
                $(document).ready(function() {
                    // Handle form submission via AJAX
                    $("#addReviewForm").submit(function(event) {
                        event.preventDefault(); // Prevent the default form submission

                        // Collect form data
                        var formData = $(this).serialize();

                        $.ajax({
                            type: "POST",
                            url: "AddReview", // Servlet that will handle the form submission
                            data: formData,
                            success: function(response) {
                                if (response.status && response.status === "error") {
                                    alert(response.message); // Show error if any
                                } else {
                                    // Assuming the response is the updated list of reviews in JSON format
                                    var reviews = JSON.parse(response);
                                    var reviewsHtml = "";

                                    // Loop through the reviews and display them
                                    reviews.forEach(function(review) {
                                        var stars = "";
                                        for (var i = 0; i < review.rating; i++) {
                                            stars += "★"; // Filled stars
                                        }
                                        for (var i = review.rating; i < 5; i++) {
                                            stars += "☆"; // Empty stars
                                        }

                                        reviewsHtml += "<div class='review mb-3'>" +
                                                "<div class='d-flex justify-content-between'>" +
                                                "<span class='font-weight-bold'>User</span>" +
                                                "<span class='text-warning'>" + stars + "</span>" +
                                                "</div>" +
                                                "<p>" + review.comment + "</p>" +
                                                "</div>";
                                    });

                                    // Insert the updated reviews into the reviews section
                                    $("#reviews-list").html(reviewsHtml);

                                    // Clear the form after submission
                                    $("#addReviewForm")[0].reset();
                                }
                            },
                            error: function() {
                                alert("An error occurred while submitting the review.");
                            }
                        });
                    });
                });
    </script>
    <%@include file="Footer.jsp" %>
    <!-- <div class="mb-4">
            <h5 class="text-dark">Quantity</h5>
            <div class="input-group" style="max-width: 220px;">
                <button class="btn btn-outline-primary js-btn-minus" type="button">&minus;</button>
                <input type="text" class="form-control text-center" value="1" aria-label="Quantity">
                <button class="btn btn-outline-primary js-btn-plus" type="button">&plus;</button>
            </div> -->