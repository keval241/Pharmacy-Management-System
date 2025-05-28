/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.admin;

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
public class edit_user extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        int u_id=Integer.parseInt(request.getParameter("u_id"));
        String name1=request.getParameter("name");
        String mobile1=request.getParameter("mobile");
        String email1=request.getParameter("email");
        int pincode1=Integer.parseInt(request.getParameter("pincode"));
        Connection con=null;
        PreparedStatement ps=null;
        try  {
           con=conn.getConnection();
           String query="UPDATE users SET u_name=?, u_mobile=?, u_email=?, u_pincode=? WHERE u_id=?";
           ps=con.prepareStatement(query);
           ps.setString(1, name1);
           ps.setString(2, mobile1);
           ps.setString(3, email1);
           ps.setInt(4, pincode1);
           ps.setInt(5, u_id);
           int count=ps.executeUpdate();
           if(count>0){
               response.sendRedirect("Admin/view_user.jsp");
           }else{
               out.println("<script>alert('Not Edit'); location='Admin/view_user.jsp';</script>");
           }
           
        }
        catch(Exception e){
            out.println("Error Message : "+e.getMessage());
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
