/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.user;

import com.connect.conn;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class register extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String name1 = request.getParameter("name");
        String number1 = request.getParameter("mobile");
        String email1 = request.getParameter("email");
        String pass1 = request.getParameter("pass");

        int pincode1 = 0;
        try {
            pincode1 = Integer.parseInt(request.getParameter("pincode"));
        } catch (NumberFormatException e) {
            response.sendRedirect("registerForm.jsp?error=Invalid Pincode");
            return;
        }

        try (Connection con = conn.getConnection();
             PreparedStatement ps = con.prepareStatement(
                 "INSERT INTO users(u_name, u_mobile, u_email, u_password, u_pincode) VALUES(?, ?, ?, ?, ?)")) {

            ps.setString(1, name1);
            ps.setString(2, number1);
            ps.setString(3, email1);
            ps.setString(4, pass1);
            ps.setInt(5, pincode1);

            int count = ps.executeUpdate();
            if (count > 0) {
                response.sendRedirect("loginForm.jsp?success=Registration Successful");
            } else {
                response.sendRedirect("registerForm.jsp?error=Registration Failed");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("registerForm.jsp?error=Server Error");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}
