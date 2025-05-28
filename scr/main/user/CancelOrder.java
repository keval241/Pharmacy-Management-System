/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.user;

import com.connect.conn;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class CancelOrder extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.getWriter().write("Session expired. Please log in again.");
            return;
        }

        int orderId = Integer.parseInt(request.getParameter("orderId"));
        int userId = (Integer) session.getAttribute("userId");

        try {
            Connection con = conn.getConnection();

            // Update order status
            PreparedStatement orderStmt = con.prepareStatement("UPDATE orders SET o_status = 4 WHERE o_id = ? AND u_id = ?");
            orderStmt.setInt(1, orderId);
            orderStmt.setInt(2, userId);
            int orderUpdated = orderStmt.executeUpdate();

            // Cancel payment if it exists
            PreparedStatement paymentStmt = con.prepareStatement("UPDATE payment SET pay_status = 2 WHERE o_id = ?");
            paymentStmt.setInt(1, orderId);
            int paymentUpdated = paymentStmt.executeUpdate();

            orderStmt.close();
            paymentStmt.close();
            con.close();

            if (orderUpdated > 0) {
                response.getWriter().write("success");
            } else {
                response.getWriter().write("Order not found or already processed.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("Error canceling order. Try again.");
        }
    }
}
