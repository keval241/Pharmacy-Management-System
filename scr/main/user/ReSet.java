/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.user;

import com.connect.conn;
import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

public class ReSet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("resetEmail");
        String password = request.getParameter("password");

        try {
            Connection con = conn.getConnection();
            PreparedStatement ps = con.prepareStatement("UPDATE users SET u_password=? WHERE u_email=?");
            ps.setString(1, password);
            ps.setString(2, email);
            ps.executeUpdate();

            session.removeAttribute("resetEmail"); 
            response.getWriter().println("<script>alert('Password updated successfully!');window.location='loginForm.jsp';</script>");
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
