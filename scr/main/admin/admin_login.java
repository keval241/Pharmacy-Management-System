
package com.admin;

import com.connect.conn;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class admin_login extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password"); // Updated to match JSP field name
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            con = conn.getConnection();
            String query = "SELECT a_id, a_name, a_password FROM admin WHERE a_email=?";
            ps = con.prepareStatement(query);
            ps.setString(1, email);
            rs = ps.executeQuery();

            if (rs.next()) {
                String dbPassword = rs.getString("a_password");

                // Compare plaintext passwords (Replace with hashing check in production)
                if (password.equals(dbPassword)) {
                    HttpSession session = request.getSession();
                    session.setAttribute("aid", rs.getInt("a_id"));
                    session.setAttribute("username", rs.getString("a_name"));
                    response.sendRedirect("Admin/Home.jsp");
                } else {
                    request.setAttribute("errorMessage", "Incorrect password. Please try again.");
                    request.getRequestDispatcher("Admin/loginForm.jsp").forward(request, response);
                }
            } else {
                request.setAttribute("errorMessage", "Email does not match any account.");
                request.getRequestDispatcher("Admin/loginForm.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Something went wrong. Please try again.");
            request.getRequestDispatcher("Admin/loginForm.jsp").forward(request, response);
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
    }
}
