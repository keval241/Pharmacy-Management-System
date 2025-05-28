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

/**
 *
 * @author VAIDEHI ENTERPRISE
 */
public class AddContact extends HttpServlet {

protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get the user ID from the hidden input field
        PrintWriter out=response.getWriter();
        int u_id = Integer.parseInt(request.getParameter("u_id"));
        String c_subject = request.getParameter("c_subject");
        String c_message = request.getParameter("c_message");
        Connection con=null;
        PreparedStatement ps=null;
        try{
            con=conn.getConnection();
            String query="INSERT INTO contact(u_id,c_subject,c_message) VALUES(?,?,?)";
            ps=con.prepareStatement(query);
            ps.setInt(1,u_id);
            ps.setString(2,c_subject);
            ps.setString(3,c_message);
            int count=ps.executeUpdate();
            if(count>0){
                out.println("<script>alert('Contact added successfully!'); location='Contact.jsp';</script>");
            }
            else{
                out.println("<script>alert('Try Again'); location='Contact.jsp';</script>");
            }
        }
        catch(Exception e){
            
        }
    }

}
