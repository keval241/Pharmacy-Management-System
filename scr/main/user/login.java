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

public class login extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String email = request.getParameter("email");
        String password = request.getParameter("pass");
        
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            con = conn.getConnection();
            
            // Check if email exists
            String emailQuery = "SELECT * FROM users WHERE u_email=?";
            ps = con.prepareStatement(emailQuery);
            ps.setString(1, email);
            rs = ps.executeQuery();
            
            if (!rs.next()) {
                request.setAttribute("errorMessage", "Email does not match any account.");
                request.getRequestDispatcher("loginForm.jsp").forward(request, response);
                return;
            }

            // Check if password matches
            String passwordQuery = "SELECT * FROM users WHERE u_email=? AND u_password=?";
            ps = con.prepareStatement(passwordQuery);
            ps.setString(1, email);
            ps.setString(2, password);
            rs = ps.executeQuery();

            if (rs.next()) {
                HttpSession session = request.getSession();
                session.setAttribute("username", rs.getString("u_name"));
                session.setAttribute("userId", rs.getInt("u_id"));
                session.setAttribute("userEmail", rs.getString("u_email"));

                response.sendRedirect("Home.jsp");
            } else {
                request.setAttribute("errorMessage", "Incorrect password. Please try again.");
                request.getRequestDispatcher("loginForm.jsp").forward(request, response);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
