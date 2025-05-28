<%-- 
    Document   : Check-out
    Created on : Jan 20, 2025, 9:19:36 AM
    Author     : VAIDEHI ENTERPRISE
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@include file="Admin/conn.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Checkout</title>
    <link rel="icon" type="image/x-icon" href="Admin/img/favicon.png">
    
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    
    <!-- External CSS -->
    <link rel="stylesheet" href="css/styles.css">
    
    <style>
        body {
            background-color: #f8f9fa;
        }
        .container {
            max-width: 800px;
            animation: fadeIn 1s ease-in;
        }
        .form-container {
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s;
        }
        .form-container:hover {
            transform: scale(1.02);
        }
        .table th, .table td {
            text-align: center;
        }
        .btn-lg {
            width: 48%;
        }
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-10px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>
<body>
    <div class="container mt-5">
        <h2 class="text-center">Checkout Page</h2>
        <%  
            HttpSession sess = request.getSession();
            Integer userId = (Integer) sess.getAttribute("userId");
            if (userId == null) {
                response.sendRedirect("login.jsp");
                return;
            }

            PreparedStatement ps = null;
            ResultSet rs = null;
            String name = "", mobile = "", email = "", pincode = "";
            try {
                String userQuery = "SELECT u_name, u_mobile, u_email, u_pincode FROM users WHERE u_id = ?";
                ps = con.prepareStatement(userQuery);
                ps.setInt(1, userId);
                rs = ps.executeQuery();
                if (rs.next()) {
                    name = rs.getString("u_name");
                    mobile = rs.getString("u_mobile");
                    email = rs.getString("u_email");
                    pincode = rs.getString("u_pincode");
                }
                rs.close();
                ps.close();
        %>
        <form action="CheckOut" method="post" class="form-container mt-4">
            <div class="form-group">
                <label>Name:</label>
                <input type="text" name="name" class="form-control" value="<%= name %>" required readonly>
            </div>
            <div class="form-group">
                <label>Mobile No.:</label>
                <input type="text" name="mobile" class="form-control" value="<%= mobile %>" required readonly>
            </div>
            <div class="form-group">
                <label>Email:</label>
                <input type="text" name="email" class="form-control" value="<%= email %>" required readonly>
            </div>
            <div class="form-group">
                <label>Address:</label>
                <textarea name="address" class="form-control" required></textarea>
            </div>
            <div class="form-group">
                <label>Pincode:</label>
                <input type="text" name="pincode" class="form-control" value="<%= pincode %>" required readonly>
            </div>

            <h3 class="mt-4">Order Summary</h3>
            <table class="table table-bordered mt-3">
                <thead>
                    <tr>
                        <th>Medicine Name</th>
                        <th>Quantity</th>
                        <th>Price</th>
                        <th>Total</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        double grandTotal = 0;
                        String cartQuery = "SELECT c.m_id, c.quantity, m.m_name, m.m_price FROM cart c INNER JOIN medicine m ON c.m_id = m.m_id WHERE c.u_id = ?";
                        ps = con.prepareStatement(cartQuery);
                        ps.setInt(1, userId);
                        rs = ps.executeQuery();
                        while (rs.next()) {
                            String medicineName = rs.getString("m_name");
                            int quantity = rs.getInt("quantity");
                            double price = rs.getDouble("m_price");
                            double totalAmount = price * quantity;
                            grandTotal += totalAmount;
                    %>
                    <tr>
                        <td><%= medicineName %></td>
                        <td><%= quantity %></td>
                        <td>₹<%= price %></td>
                        <td>₹<%= totalAmount %></td>
                    </tr>
                    <%
                        }
                        rs.close();
                        ps.close();
                        con.close();
                    %>
                </tbody>
            </table>
            <h4 class="text-right mr-2">Grand Total: ₹<%= grandTotal %></h4>

            <div class="d-flex justify-content-between mt-4">
                <a href="Cart.jsp" class="btn btn-primary btn-lg">Back to Cart</a>
                <input type="submit" class="btn btn-success btn-lg" value="Place Order">
            </div>
        </form>
        <%
            } catch (Exception e) {
                e.printStackTrace();
            }
        %>
    </div>

    <!-- JavaScript Libraries -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
