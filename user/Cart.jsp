<%-- 
    Document   : Cart
    Created on : Jan 20, 2025, 8:40:58 AM
    Author     : VAIDEHI ENTERPRISE
--%>

<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@include file="Admin/conn.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="Headder.jsp" %>
<style>
.product-thumbnail, .product-name, .product-price, .product-quantity, .product-total, .product-remove {
    width: 120px; /* Adjust the width as necessary */
}

.product-quantity input {
    width: 60px; /* Make sure the input field for quantity does not cause resizing */
    text-align: center; /* Align text to center */
}

.product-total {
    width: 120px; /* Ensure total price column has a consistent width */
}
</style>
<div class="bg-light py-3">
    <div class="container">
        <div class="row">
            <div class="col-md-12 mb-0">
                <a href="Home.jsp">Home</a> <span class="mx-2 mb-0">/</span>
                <strong class="text-black">Cart</strong>
            </div>
        </div>
    </div>
</div>

<div class="container py-5">
    <div class="row mb-5">
        <form class="col-md-12" method="post" action="UpdateCart.jsp">
            <div class="table-responsive">
                <table class="table table-hover">
                    <thead class="bg-info text-white">
                        <tr>
                            <th class="product-thumbnail">Image</th>
                            <th class="product-name">Product</th>
                            <th class="product-price">Price</th>
                            <th class="product-quantity">Quantity</th>
                            <th class="product-total">Total</th>
                            <th class="product-remove">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% 
                            PreparedStatement ps = null;
                            ResultSet rs = null;
                            
                            double cartTotal = 0.0; // Variable to store the cart total
//                            Integer userId = (Integer) session.getAttribute("userId");  // Get userId from session

                            if (userId == null) {
                                out.println("<p>User is not logged in. Cannot fetch cart items.</p>");
                                return;
                            }

                            try {
                                // Query to fetch cart details
                                String query = "SELECT c.cart_id, m.m_name, m.m_price, c.quantity, m.m_image " +
                                               "FROM cart c " +
                                               "JOIN medicine m ON c.m_id = m.m_id " +
                                               "WHERE c.u_id = ?";
                                ps = con.prepareStatement(query);
                                ps.setInt(1, userId);  // Set the userId parameter
                                rs = ps.executeQuery();

                                // Step 4: Iterate over the result set and display cart items
                                while (rs.next()) {
                                    String productName = rs.getString("m_name");
                                    double price = rs.getDouble("m_price");
                                    int quantity = rs.getInt("quantity");
                                    String image = rs.getString("m_image");
                                    double total = price * quantity;
                                    cartTotal += total; // Add to total
                        %>
                                    <tr>
                                        <td class="product-thumbnail">
                                            <img src="Admin/img/<%= image %>" alt="<%= productName %>" class="img-fluid rounded shadow-sm" style="width: 100px; height: 100px; object-fit: cover;">
                                        </td>
                                        <td class="product-name">
                                            <h5 class="text-black"><%= productName %></h5>
                                        </td>
                                        <td>₹<%= price %></td>
                                        <td>
                                            <div class="input-group mb-3" style="max-width: 120px;">
                                                <div class="input-group-prepend">
                                                    <button class="btn btn-outline-info" type="button" onclick="updateQuantity('<%= rs.getInt("cart_id") %>', -1)">&minus;</button>
                                                </div>
                                                <input type="text" class="form-control text-center" value="<%= quantity %>" id="quantity_<%= rs.getInt("cart_id") %>">
                                                <div class="input-group-append">
                                                    <button class="btn btn-outline-info" type="button" onclick="updateQuantity('<%= rs.getInt("cart_id") %>', 1)">&plus;</button>
                                                </div>
                                            </div>
                                        </td>
                                        <td id="total_<%= rs.getInt("cart_id") %>">₹<%= total %></td>
                                        <td>
                                            <a href="RemoveCart?cart_id=<%= rs.getInt("cart_id") %>" class="mx-1" onclick="return confirm('Are you sure you want to delete this cart Item?');"><i class="fas fa-trash text-danger fa-2x"></i></a>
                                        </td>
                                    </tr>
                        <% 
                                }
                            } catch (SQLException e) {
                                e.printStackTrace();
                                out.println("<p>Something went wrong while fetching cart items.</p>");
                            } finally {
                                try {
                                    if (rs != null) rs.close();
                                    if (ps != null) ps.close();
                                    if (con != null) con.close();
                                } catch (SQLException e) {
                                    e.printStackTrace();
                                }
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </form>
    </div>

    <div class="row">
        <div class="col-md-6">
            <div class="d-flex justify-content-between">
                <a href="Shop.jsp" class="btn btn-outline-primary btn-md">Continue Shopping</a>
            </div>
        </div>
        <div class="col-md-6">
            <div class="d-flex justify-content-end">
                <div class="col-md-7">
                    <h3 class="text-black h4">Cart Totals</h3>
<!--                    <div class="row mb-3">
                        <div class="col-md-6">Subtotal</div>
                        <div class="col-md-6 text-end" id="cartSubtotal">₹<%= cartTotal %></div>
                    </div>-->

                    <div class="row mb-3">
                        <div class="col-md-6">Total</div>
                        <div class="col-md-6 text-end" id="cartTotal"><strong>₹<%= cartTotal %></strong></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="d-flex justify-content-end mt-4 mr-5">
        <a href="Check-out.jsp" class="btn btn-success btn-lg w-20">Proceed To Checkout</a>
     
    </div>
</div>
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
<script>
function updateQuantity(cartId, change) {
    var quantityInput = document.getElementById('quantity_' + cartId);
    var newQuantity = parseInt(quantityInput.value) + change;

    if (newQuantity < 1) {
        newQuantity = 1; // Prevent negative quantities
    }

    quantityInput.value = newQuantity;

    // Use AJAX to send the new quantity to the server
    var xhr = new XMLHttpRequest();
    xhr.open('POST', 'UpdateQuantity.jsp', true);
    xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
    xhr.onreadystatechange = function () {
        if (xhr.readyState == 4 && xhr.status == 200) {
            // Get the updated item total and cart subtotal from the server response
            var response = JSON.parse(xhr.responseText);

            // Update the total for the current item
            var totalCell = document.getElementById('total_' + cartId);
            totalCell.innerHTML = '₹' + response.itemTotal; // Update item total

            // Update the cart subtotal (total of all items)
            var cartTotalElement = document.getElementById('cartTotal');
            cartTotalElement.innerHTML = '₹' + response.cartTotal; // Update cart total

            // Update the cart subtotal
            var cartSubtotalElement = document.getElementById('cartSubtotal');
            cartSubtotalElement.innerHTML = '₹' + response.cartSubtotal; // Update cart subtotal
        }
    };
    xhr.send('cart_id=' + cartId + '&new_quantity=' + newQuantity);
}

</script>


<%@include file="Footer.jsp" %>

