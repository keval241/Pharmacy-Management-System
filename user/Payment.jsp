<%-- 
    Document   : Payment
    Created on : Feb 14, 2025, 8:24:57 PM
    Author     : VAIDEHI ENTERPRISE
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="Admin/conn.jsp" %>
<%@ page import="java.sql.*, javax.servlet.http.*, javax.servlet.*" %>

<%
    HttpSession sessionObj = request.getSession();
    Integer userId = (Integer) sessionObj.getAttribute("userId");

    if (userId == null) {
        response.sendRedirect("loginForm.jsp");
        return;
    }

    int orderId = Integer.parseInt(request.getParameter("o_id"));
    PreparedStatement ps = null;
    ResultSet rs = null;
    double totalAmount = 0;

    try {
        con = com.connect.conn.getConnection();
        String orderQuery = "SELECT o_amount FROM orders WHERE o_id = ?";
        ps = con.prepareStatement(orderQuery);
        ps.setInt(1, orderId);
        rs = ps.executeQuery();

        if (rs.next()) {
            totalAmount = rs.getDouble("o_amount");
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) rs.close();
        if (ps != null) ps.close();
        if (con != null) con.close();
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Secure Payment</title>
     <link rel="icon" type="image/x-icon" href="Admin/img/favicon.png">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <style>
        body {
            background: #f8f9fa;
            font-family: 'Poppins', sans-serif;
        }
        .payment-container {
            max-width: 500px;
            margin: 50px auto;
            padding: 25px;
            background: white;
            border-radius: 12px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            animation: fadeIn 0.8s ease-in-out;
        }
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-15px); }
            to { opacity: 1; transform: translateY(0); }
        }
        .payment-option {
            padding: 12px;
            background: #6c757d;
            color: white;
            border-radius: 5px;
            margin: 8px 0;
            cursor: pointer;
            text-align: center;
            transition: 0.3s;
        }
        .payment-option:hover, .selected {
            background: #5a6268 !important;
        }
        .btn-pay {
            background: #6c757d;
            color: white;
            font-size: 18px;
            padding: 12px;
            border: none;
            width: 100%;
            transition: 0.3s;
        }
        .btn-pay:hover {
            background: #5a6268;
        }
        .hidden-section {
            display: none;
            padding: 10px;
            background: #f1f3f5;
            border-radius: 8px;
        }
        .form-control {
            background: white;
            color: black;
            border: 1px solid #ced4da;
        }
        .qr-container {
            text-align: center;
            margin-top: 10px;
            padding: 10px;
            background: white;
            border-radius: 10px;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="payment-container text-center">
        <h2 class="mb-3">Complete Your Payment</h2>
        <p><strong>Total Amount:</strong> ₹<%= totalAmount %></p>

        <form id="paymentForm" action="payment" method="post">
    <input type="hidden" name="orderId" value="<%= orderId %>">
    <input type="hidden" name="userId" value="<%= userId %>">
    <input type="hidden" name="totalAmount" value="<%= totalAmount %>">  <!-- ✅ Added this -->

    <label class="form-label mt-3">Select Payment Method:</label>

    <div class="payment-option" id="cashOption">
        <span>💰 Cash on Delivery</span>
    </div>

    <div class="payment-option" id="upiOption">
        <span>📲 UPI Payment</span>
    </div>

    <div class="hidden-section mt-3" id="upiBox">
        <label class="form-label">Enter UPI ID:</label>
        <input type="text" class="form-control" id="upiId" name="upiId" placeholder="example@upi">
        <div class="qr-container mt-3">
            <p>Scan to Pay:</p>
            <img src="images/qr.png" alt="UPI QR Code" width="150">
        </div>
    </div>

    <div class="payment-option" id="netBankingOption">
        <span>🏦 Net Banking</span>
    </div>

    <div class="hidden-section mt-3" id="netBankingBox">
        <label class="form-label">Select Your Bank:</label>
        <select class="form-control" id="bankName" name="bankName">
            <option value="">-- Select Bank --</option>
            <option value="HDFC">HDFC Bank</option>
            <option value="ICICI">ICICI Bank</option>
            <option value="SBI">State Bank of India</option>
            <option value="Axis">Axis Bank</option>
            <option value="Kotak">Kotak Mahindra Bank</option>
        </select>

        <div id="bankDetails" class="hidden-section">
            <label class="form-label mt-2">Enter Account Number:</label>
            <input type="text" class="form-control" name="accountNumber" placeholder="Enter your account number">
            <label class="form-label mt-2">Enter IFSC Code:</label>
            <input type="text" class="form-control" name="ifscCode" placeholder="Enter IFSC Code">
        </div>
    </div>

    <input type="hidden" name="paymentMethod" id="selectedPaymentMethod">

    <button type="submit" class="btn btn-pay mt-4">Proceed to Pay</button>
</form>

    </div>
</div>

<script>
    $(document).ready(function(){
        $('.payment-option').click(function(){
            $('.payment-option').removeClass('selected');
            $(this).addClass('selected');

            var selectedOption = $(this).attr('id');
            $('#selectedPaymentMethod').val(selectedOption);

            $('.hidden-section').slideUp();
            if (selectedOption === 'upiOption') {
                $('#upiBox').slideDown();
                $('#upiId').prop('required', true);
                $('#bankName, input[name=accountNumber], input[name=ifscCode]').prop('required', false);
            } else if (selectedOption === 'netBankingOption') {
                $('#netBankingBox').slideDown();
                $('#upiId').prop('required', false);
                $('#bankName, input[name=accountNumber], input[name=ifscCode]').prop('required', true);
            } else {
                $('#upiId, #bankName, input[name=accountNumber], input[name=ifscCode]').prop('required', false);
            }
        });

        $('#bankName').change(function(){
            $('#bankDetails').toggle($(this).val() !== "");
        });
    });
    document.addEventListener("DOMContentLoaded", function () {
    let selectedMethod = "";

    document.getElementById("cashOption").addEventListener("click", function () {
        selectedMethod = "cashOption";
        document.getElementById("selectedPaymentMethod").value = selectedMethod;
    });

    document.getElementById("upiOption").addEventListener("click", function () {
        selectedMethod = "upiOption";
        document.getElementById("selectedPaymentMethod").value = selectedMethod;
    });

    document.getElementById("netBankingOption").addEventListener("click", function () {
        selectedMethod = "netBankingOption";
        document.getElementById("selectedPaymentMethod").value = selectedMethod;
    });

    document.getElementById("paymentForm").addEventListener("submit", function (event) {
        if (!selectedMethod) {
            alert("Please select a payment method.");
            event.preventDefault();
        }
    });
});
</script>

</body>
</html>
