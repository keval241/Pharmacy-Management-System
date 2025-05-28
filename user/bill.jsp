<%-- 
    Document   : bill
    Created on : Feb 22, 2025, 4:58:59 AM
    Author     : VAIDEHI ENTERPRISE
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, javax.servlet.http.*, javax.servlet.*" %>
<%@include file="Admin/conn.jsp" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.sql.*" %>
<%
    HttpSession userSession = request.getSession();
    Integer userId = (Integer) userSession.getAttribute("userId");
    if (userId == null) {
        response.sendRedirect("loginForm.jsp");
        return;
    }

    PreparedStatement psUser = null, psOrders = null, psPayment = null;
    ResultSet rsUser = null, rsOrders = null, rsPayment = null;
    
    String orderIdParam = request.getParameter("orderId");
    int orderId = (orderIdParam != null) ? Integer.parseInt(orderIdParam) : 0;

    try {
        con = com.connect.conn.getConnection();

        // Fetch user details
        psUser = con.prepareStatement("SELECT * FROM users WHERE u_id = ?");
        psUser.setInt(1, userId);
        rsUser = psUser.executeQuery();
        rsUser.next();

        // Fetch all medicines for an order
        psOrders = con.prepareStatement(
            "SELECT o.o_id, o.o_address, " +
            "GROUP_CONCAT(o.m_name SEPARATOR '<br>') AS medicines, " +
            "GROUP_CONCAT(o.o_quantity SEPARATOR '<br>') AS quantities, " +
            "GROUP_CONCAT(o.m_price_per_unit SEPARATOR '<br>') AS prices, " +
            "o.o_amount FROM orders o WHERE o.o_id = ? AND o.u_id = ? GROUP BY o.o_id"
        );
        psOrders.setInt(1, orderId);
        psOrders.setInt(2, userId);
        rsOrders = psOrders.executeQuery();

        // Fetch payment details
        psPayment = con.prepareStatement("SELECT * FROM payment WHERE o_id = ?");
        psPayment.setInt(1, orderId);
        rsPayment = psPayment.executeQuery();

        boolean isPaid = false;
        String paymentMethod = "N/A";
        int transactionId = 0;
        if (rsPayment.next()) {
            isPaid = rsPayment.getInt("pay_status") == 1;
            paymentMethod = rsPayment.getString("pay_method");
            transactionId = rsPayment.getInt("pay_id");
        }

        if (!isPaid) {
            out.println("<h3 class='text-danger text-center'>Invoice is not available for unpaid orders.</h3>");
        } else if (rsOrders.next()) {
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Invoice - TrueHealth Pharmacy</title>
     <link rel="icon" type="image/x-icon" href="Admin/img/favicon.png">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <style>
        body { background-color: #f8f9fa; font-family: 'Poppins', sans-serif; }
        .invoice { max-width: 850px; margin: 50px auto; background: #fff; padding: 25px; border-radius: 10px; box-shadow: 0px 10px 20px rgba(0, 0, 0, 0.2); animation: fadeIn 1s ease-in-out; }
        @keyframes fadeIn { from { opacity: 0; transform: translateY(-20px); } to { opacity: 1; transform: translateY(0); } }
        .invoice-header { text-align: center; margin-bottom: 20px; animation: fadeIn 1.2s ease-in-out; }
        .invoice-header h2 { font-weight: bold; color: #007bff; text-transform: uppercase; }
        .invoice-table th { background: #007bff; color: #fff; padding: 12px; text-transform: uppercase; }
        .invoice-table td { text-align: center; padding: 10px; font-size: 16px; }
        .total { font-weight: bold; color: #28a745; text-align: right; font-size: 18px; }
        .payment-status { font-size: 18px; font-weight: bold; color: #28a745; text-transform: uppercase; }
        .btn-container { display: flex; justify-content: space-between; }
        .print-btn, .back-btn { font-size: 18px; border: none; padding: 10px 20px; border-radius: 5px; color: #fff; cursor: pointer; transition: 0.3s ease; }
        .print-btn { background: linear-gradient(45deg, #007bff, #0056b3); }
        .print-btn:hover { transform: scale(1.05); }
        .back-btn { background: linear-gradient(45deg, #dc3545, #b32d2d); }
        .back-btn:hover { transform: scale(1.05); }
        @media print { .print-btn, .back-btn { display: none; } }
    </style>
</head>
<body>
    <div class="invoice container">
        <div class="invoice-header">
            <h2>TrueHealth Pharmacy</h2>
            <p>Main Road, Derdi, Gondal, Rajkot, Gujarat, India</p>
            <p>Email: kevalbagathliya2401@gmail.com | Phone: +91 96649 48895</p>
        </div>
        
        <h5>User Details</h5>
        <p><strong>Name:</strong> <%= rsUser.getString("u_name") %></p>
        <p><strong>Mobile:</strong> <%= rsUser.getString("u_mobile") %></p>
        <p><strong>Email:</strong> <%= rsUser.getString("u_email") %></p>
        <p><strong>Address:</strong> <%= rsOrders.getString("o_address") %></p>

        <h5>Order Details (Order ID: <%= orderId %>)</h5>
        <table class="table table-bordered invoice-table">
            <thead>
                <tr><th>Medicine</th><th>Quantity</th><th>Price per Unit</th><th>Total</th></tr>
            </thead>
            <tbody>
                <tr>
                    <td><%= rsOrders.getString("medicines") %></td>
                    <td><%= rsOrders.getString("quantities") %></td>
                    <td>₹<%= rsOrders.getString("prices") %></td>
                    <td class="fw-bold text-success">₹<%= rsOrders.getDouble("o_amount") %></td>
                </tr>
            </tbody>
        </table>
        <p class="total">Grand Total: ₹<%= rsOrders.getDouble("o_amount") %></p>
        <h5>Payment Details</h5>
        <p><strong>Payment Method:</strong> <%= paymentMethod %></p>
        <p><strong>Transaction ID:</strong> <%= transactionId %></p>
        <p class="payment-status">Paid</p>
        
        <div class="btn-container">
            <button class="btn back-btn" onclick="window.location.href='order_history.jsp'"><i class="fa fa-arrow-left"></i> Back</button>
            <button class="btn print-btn" onclick="window.print()"><i class="fa fa-print"></i> Print Invoice</button>
        </div>
    </div>
</body>
</html>
<% } } catch (Exception e) { e.printStackTrace(); } %>
