/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.admin;

import com.connect.conn;
import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

public class admin_forget extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        HttpSession session = request.getSession();

        try {
            Connection con =conn.getConnection();
            PreparedStatement ps = con.prepareStatement("SELECT a_id FROM admin WHERE a_email=?");
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                session.setAttribute("resetEmail", email);
                response.sendRedirect("Admin/ReSet.jsp");
            } else {
                response.getWriter().println("<script>alert('Email not found!');window.location='Admin/forget-password.jsp';</script>");
            }
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
