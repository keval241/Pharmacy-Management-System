<%-- 
    Document   : order_history
    Created on : Feb 21, 2025, 4:38:04 AM
    Author     : VAIDEHI ENTERPRISE
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="Admin/conn.jsp" %>
<%@include file="Headder.jsp" %>
<%
    session = request.getSession(false);
    if (session == null || session.getAttribute("userId") == null) {
        response.sendRedirect("loginForm.jsp");
        return;
    }

//    int userId = (Integer) session.getAttribute("userId");
%>

<div class="container mt-5">
    <h3 class="text-center text-primary fw-bold">Order History</h3>
    <div class="table-responsive">
        <table class="table table-bordered text-center align-middle order-table">
            <thead>
                <tr>
                    <th>Order ID</th>
                    <th>Medicine</th>
                    <th>Address</th>
                    <th>Price</th>
                    <th>Quantity</th>
                    <th>Total</th>
                    <th>Status</th>
                    <th>Payment Method</th>
                    <th>Payment Status</th>
                    <th>Bill</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    PreparedStatement stmt = null;
                    ResultSet rs = null;
                    try {
                        stmt = con.prepareStatement(
                            "SELECT o.o_id, o.m_name, o.o_address, o.m_price_per_unit, o.o_quantity, o.o_amount, o.o_status, " +
                            "p.pay_method, p.pay_status " +
                            "FROM orders o LEFT JOIN payment p ON o.o_id = p.o_id " +
                            "WHERE o.u_id = ? ORDER BY o.o_date DESC"
                        );
                        stmt.setInt(1, userId);
                        rs = stmt.executeQuery();
                        
                        while (rs.next()) {
                            int orderId = rs.getInt("o_id");
                            String medicine = rs.getString("m_name");
                            String address = rs.getString("o_address");
                            String price = rs.getString("m_price_per_unit");
                            String quantity = rs.getString("o_quantity");
                            String total = rs.getString("o_amount");
                            int orderStatus = rs.getInt("o_status");
                            String paymentMethod = rs.getString("pay_method");
                            int paymentStatus = rs.getInt("pay_status");
                            boolean canCancel = !(orderStatus == 3 || orderStatus == 4);
                            
                            String billStatus = orderStatus == 4 || paymentStatus == 2 
                                ? "<span class='text-danger'>Not Generated</span>" 
                                : "<a href='bill.jsp?orderId=" + orderId + "' class='text-success'>View Bill</a>";
                %>
                <tr>
                    <td class="fw-bold"><%= orderId %></td>
                    <td><%= medicine %></td>
                    <td><%= address %></td>
                    <td class="fw-bold text-primary">₹<%= price %></td>
                    <td class="fw-bold"><%= quantity %></td>
                    <td class="fw-bold text-success">₹<%= total %></td>
                    <td class="<%= orderStatus == 4 ? "status-canceled" : "" %>">
                        <%= orderStatus == 0 ? "Pending" : orderStatus == 1 ? "Processing" : orderStatus == 2 ? "Shipped" : orderStatus == 3 ? "Delivered" : "Canceled" %>
                    </td>
                    <td><%= paymentMethod != null ? paymentMethod : "N/A" %></td>
                    <td class="<%= paymentStatus == 1 ? "status-completed" : paymentStatus == 2 ? "status-failed" : "status-pending" %>">
                        <%= paymentStatus == 0 ? "Pending" : paymentStatus == 1 ? "Completed" : "Failed" %>
                    </td>
                    <td><%= billStatus %></td>
                    <td>
                        <% if (canCancel) { %>
                            <button class="btn btn-danger cancel-order btn-sm" data-orderid="<%= orderId %>">Cancel</button>
                        <% } else { %>
                            <button class="btn btn-secondary btn-sm" disabled>Not Allowed</button>
                        <% } %>
                    </td>
                </tr>
                <% 
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    } finally {
                        if (rs != null) rs.close();
                        if (stmt != null) stmt.close();
                        if (con != null) con.close();
                    }
                %>
            </tbody>
        </table>
    </div>
</div>

<!-- CSS for Styling & Animations -->
<style>
    .order-table {
        width: 100%;
        border-collapse: collapse;
        overflow: hidden;
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        border-radius: 10px;
    }

    .order-table thead th {
        background: linear-gradient(to right, #4A00E0, #8E2DE2);
        color: white;
        padding: 10px;
        font-size: 16px;
    }

    .order-table tbody tr {
        transition: all 0.3s ease-in-out;
    }

    .order-table tbody tr:hover {
        background-color: rgba(0, 0, 0, 0.05);
        transform: scale(1.02);
    }

    .order-table td {
        padding: 12px;
        font-size: 14px;
        font-weight: 500;
    }

    /* Status Color Coding */
    .status-pending { color: orange; font-weight: bold; }
    .status-processing { color: blue; font-weight: bold; }
    .status-shipped { color: deepskyblue; font-weight: bold; }
    .status-delivered { color: green; font-weight: bold; }
    .status-canceled { color: red; font-weight: bold; }
    .status-completed { color: green; font-weight: bold; }
    .status-failed { color: red; font-weight: bold; }

    /* Responsive Design */
    @media screen and (max-width: 768px) {
        .order-table thead {
            display: none;
        }

        .order-table tbody tr {
            display: block;
            margin-bottom: 15px;
            border: 1px solid #ddd;
            border-radius: 10px;
            padding: 10px;
        }

        .order-table td {
            display: block;
            text-align: right;
            position: relative;
            padding-left: 50%;
        }

        .order-table td:before {
            content: attr(data-label);
            position: absolute;
            left: 10px;
            font-weight: bold;
            color: #333;
        }
    }
</style>

<!-- AJAX for Order Cancellation -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    $(".cancel-order").click(function () {
        let orderId = $(this).data("orderid");

        if (confirm("Are you sure you want to cancel this order?")) {
            $.ajax({
                type: "POST",
                url: "CancelOrder",
                data: { orderId: orderId },
                success: function (response) {
                    if (response.trim() === "success") {
                        alert("Order canceled successfully.");
                        location.reload();
                    } else {
                        alert("Error canceling order: " + response);
                    }
                }
            });
        }
    });
</script>
<%@include file="Footer.jsp" %>