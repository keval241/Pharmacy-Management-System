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
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class user_reset_password extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.getWriter().write("Session expired. Please log in again.");
            return;
        }

        int userId = (Integer) session.getAttribute("userId");
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        // Validate password length
        if (newPassword.length() < 8) {
            response.getWriter().write("New password must be at least 8 characters long.");
            return;
        }

        // Check if new passwords match
        if (!newPassword.equals(confirmPassword)) {
            response.getWriter().write("New password and confirm password do not match.");
            return;
        }

        Connection con = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        PreparedStatement updateStmt = null;

        try {
            con = conn.getConnection();
            
            // Step 1: Verify current password
            stmt = con.prepareStatement("SELECT u_password FROM users WHERE u_id = ?");
            stmt.setInt(1, userId);
            rs = stmt.executeQuery();

            if (rs.next()) {
                String storedPassword = rs.getString("u_password");
                if (!storedPassword.equals(currentPassword)) { // Consider hashing check instead of plain-text
                    response.getWriter().write("Current password is incorrect.");
                    return;
                }
            } else {
                response.getWriter().write("User not found.");
                return;
            }

            // Step 2: Update new password in the database
            updateStmt = con.prepareStatement("UPDATE users SET u_password = ? WHERE u_id = ?");
            updateStmt.setString(1, newPassword); // Hash it before storing in production
            updateStmt.setInt(2, userId);
            int updatedRows = updateStmt.executeUpdate();

            if (updatedRows > 0) {
                response.getWriter().write("success");
            } else {
                response.getWriter().write("Password update failed. Try again.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("Error updating password. Try again.");
        } finally {
            // Close resources properly
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (updateStmt != null) updateStmt.close();
                if (con != null) con.close();
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
    }
}
