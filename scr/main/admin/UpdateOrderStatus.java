/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.admin;

import com.connect.conn;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class UpdateOrderStatus extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int orderId = Integer.parseInt(request.getParameter("o_id"));
        int newStatus = Integer.parseInt(request.getParameter("o_status"));

        Connection con = null;
        PreparedStatement ps = null;
        PreparedStatement psUpdatePayment = null;

        try {
            con = conn.getConnection();
            con.setAutoCommit(false); // Start transaction

            // Update order status
            String query = "UPDATE orders SET o_status = ? WHERE o_id = ?";
            ps = con.prepareStatement(query);
            ps.setInt(1, newStatus);
            ps.setInt(2, orderId);
            int result = ps.executeUpdate();

            // If order is delivered (o_status = 3), update payment status (pay_status = 1)
            if (newStatus == 3) {
                String updatePaymentQuery = "UPDATE payment SET pay_status = 1 WHERE o_id = ?";
                psUpdatePayment = con.prepareStatement(updatePaymentQuery);
                psUpdatePayment.setInt(1, orderId);
                psUpdatePayment.executeUpdate();
            }

            con.commit(); // Commit transaction
            response.getWriter().write(result > 0 ? "Success" : "Failed");

        } catch (Exception e) {
            try { if (con != null) con.rollback(); } catch (Exception ex) { ex.printStackTrace(); }
            e.printStackTrace();
            response.getWriter().write("Error: " + e.getMessage());
        } finally {
            try { if (ps != null) ps.close(); } catch (Exception e) { e.printStackTrace(); }
            try { if (psUpdatePayment != null) psUpdatePayment.close(); } catch (Exception e) { e.printStackTrace(); }
            try { if (con != null) con.close(); } catch (Exception e) { e.printStackTrace(); }
        }
    }
}
