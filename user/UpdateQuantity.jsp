<%-- 
    Document   : UpdateQuantity
    Created on : Feb 12, 2025, 5:42:07 AM
    Author     : VAIDEHI ENTERPRISE
--%>

<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.SQLException"%>
<%@include file="Admin/conn.jsp" %>

<%@ page import="java.sql.*, javax.servlet.http.*, javax.servlet.*" %>
<%
    
    session = request.getSession(false);  // Retrieve the session
    Integer userId = (Integer) session.getAttribute("userId");  // Get userId from session

    if (userId == null) {
        response.getWriter().write("{\"error\": \"User is not logged in\"}");
        return;
    }


    // Fetch the parameters sent by the AJAX request
    String cartIdParam = request.getParameter("cart_id");
    String newQuantityParam = request.getParameter("new_quantity");
    double updatedTotal = 0.0;
    double cartTotal = 0.0; // To calculate the total for the cart

    if (cartIdParam != null && newQuantityParam != null) {
        int cartId = Integer.parseInt(cartIdParam);
        int newQuantity = Integer.parseInt(newQuantityParam);
        
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            // Ensure you have a valid connection here (example: Connection con = ...)

            // Update the cart quantity in the database
            String updateQuery = "UPDATE cart SET quantity = ? WHERE cart_id = ?";
            ps = con.prepareStatement(updateQuery);
            ps.setInt(1, newQuantity);
            ps.setInt(2, cartId);
            ps.executeUpdate();

            // Fetch the updated total price for the cart item
            String selectQuery = "SELECT m.m_price FROM cart c JOIN medicine m ON c.m_id = m.m_id WHERE c.cart_id = ?";
            ps = con.prepareStatement(selectQuery);
            ps.setInt(1, cartId);
            rs = ps.executeQuery();

            if (rs.next()) {
                double price = rs.getDouble("m_price");
                updatedTotal = price * newQuantity; // Calculate updated item total
            }

            // Calculate the total cart price
            String cartTotalQuery = "SELECT m.m_price, c.quantity FROM cart c JOIN medicine m ON c.m_id = m.m_id WHERE c.u_id = ?";
            ps = con.prepareStatement(cartTotalQuery);
            ps.setInt(1, userId); // Assuming userId is available in the session
            rs = ps.executeQuery();

            while (rs.next()) {
                double price = rs.getDouble("m_price");
                int quantity = rs.getInt("quantity");
                cartTotal += price * quantity;  // Calculate cart total
            }

            // Return a JSON response with both the updated item total and cart total
            response.setContentType("application/json");
            response.getWriter().write("{\"itemTotal\": \"" + String.format("%.2f", updatedTotal) + "\", \"cartTotal\": \"" + String.format("%.2f", cartTotal) + "\"}");

        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().write("{\"error\": \"Error updating quantity\"}");
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    } else {
        response.getWriter().write("{\"error\": \"Invalid parameters\"}");
    }
%>
