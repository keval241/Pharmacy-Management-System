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

public class EditProfile extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("loginForm.jsp");
            return;
        }

        int userId = Integer.parseInt(request.getParameter("userId"));
        String userName = request.getParameter("userName");
        String userMobile = request.getParameter("userMobile");
        String userEmail = request.getParameter("userEmail");
        String userPincode = request.getParameter("userPincode");

        try {
            Connection con = conn.getConnection();
            PreparedStatement stmt = con.prepareStatement("UPDATE users SET u_name=?, u_mobile=?, u_email=?, u_pincode=? WHERE u_id=?");
            stmt.setString(1, userName);
            stmt.setString(2, userMobile);
            stmt.setString(3, userEmail);
            stmt.setString(4, userPincode);
            stmt.setInt(5, userId);
            stmt.executeUpdate();

            session.setAttribute("username", userName);

            response.sendRedirect("profile.jsp?success=Profile updated successfully");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("profile.jsp?error=Error updating profile");
        }
    }
}
