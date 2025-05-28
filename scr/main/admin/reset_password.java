/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.admin;

import com.connect.conn;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class reset_password extends HttpServlet {
   
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");

        if (username == null) {
            response.sendRedirect("Admin/loginForm.jsp");
            return;
        }

        String currentPassword = request.getParameter("current_password");
        String newPassword = request.getParameter("new_password");
        String confirmPassword = request.getParameter("confirm_password");

        if (!newPassword.equals(confirmPassword)) {
            session.setAttribute("alertType", "danger");
            session.setAttribute("alertMessage", "❌  New passwords do not match!");
            response.sendRedirect("Admin/profile.jsp");
            return;
        }

        try (Connection con = conn.getConnection()) {
            // Validate current password
            String checkQuery = "SELECT a_password FROM admin WHERE a_name=?";
            try (PreparedStatement ps = con.prepareStatement(checkQuery)) {
                ps.setString(1, username);
                ResultSet rs = ps.executeQuery();

                if (rs.next()) {
                    String dbPassword = rs.getString("a_password");
                    if (!dbPassword.equals(currentPassword)) {
                        session.setAttribute("alertType", "warning");
                        session.setAttribute("alertMessage", "⚠ Invalid current password!");
                        response.sendRedirect("Admin/profile.jsp");
                        return;
                    }
                } else {
                    session.setAttribute("alertType", "danger");
                    session.setAttribute("alertMessage", "❌ Admin not found!");
                    response.sendRedirect("Admin/profile.jsp");
                    return;
                }
            }

            // Update password
            String updateQuery = "UPDATE admin SET a_password=? WHERE a_name=?";
            try (PreparedStatement ps = con.prepareStatement(updateQuery)) {
                ps.setString(1, newPassword);
                ps.setString(2, username);
                int rowsUpdated = ps.executeUpdate();

                if (rowsUpdated > 0) {
                    session.setAttribute("alertType", "success");
                    session.setAttribute("alertMessage", "✅ Password updated successfully!");
                } else {
                    session.setAttribute("alertType", "danger");
                    session.setAttribute("alertMessage", "❌  Failed to update password!");
                }
            }
        } catch (Exception e) {
            session.setAttribute("alertType", "danger");
            session.setAttribute("alertMessage", "❌ Error: " + e.getMessage());
        }

        response.sendRedirect("Admin/profile.jsp");
    }
}
