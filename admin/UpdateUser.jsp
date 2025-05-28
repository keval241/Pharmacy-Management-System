<%-- 
    Document   : UpdateUser
    Created on : Feb 3, 2025, 7:08:51 AM
    Author     : VAIDEHI ENTERPRISE
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="Headder.jsp" %>
<%@include file="conn.jsp" %>
<div class="container-fluid d-flex justify-content-center align-items-center" style="min-height: 100vh;">
    <div class="card shadow-sm" style="width: 500px;">
        <div class="card-header">
            <div class="d-flex justify-content-between align-items-center">
                <h4>Edit User Details</h4>
                <!-- Back Button -->
                <a href="view_user.jsp" class="btn btn-secondary btn-sm">
                    <i class="fas fa-arrow-left"></i> Back
                </a>
            </div>
        </div>
        <div class="card-body">
        <%
            int u_id = Integer.parseInt(request.getParameter("u_id"));
            PreparedStatement ps=null;
            ResultSet rs=null;
            String que = "SELECT * FROM users WHERE u_id=?";
            ps=con.prepareStatement(que);
            ps.setInt(1, u_id);
            rs=ps.executeQuery();
            if (rs.next()) {
        %>
            <form action="../edit_user" method="post">
                <input type="hidden" name="u_id" value="<%= rs.getInt("u_id") %>">
                
                <!-- Name Field (optional if you want to use it) -->
                <div class="form-group">
                    <label for="editUserName">Name</label>
                    <input type="text" class="form-control" id="editUserName" name="name" value="<%= rs.getString("u_name") %>" required>
                </div>
                
                <!-- Mobile Field -->
                <div class="form-group">
                    <label for="editUserMobile">Mobile No.</label>
                    <input type="text" class="form-control" id="editUserMobile" name="mobile" value="<%= rs.getString("u_mobile") %>" required>
                </div>
                
                <!-- Email Field -->
                <div class="form-group">
                    <label for="editUserEmail">Email</label>
                    <input type="email" class="form-control" id="editUserEmail" name="email" value="<%= rs.getString("u_email") %>" required>
                </div>
                <!-- Pin Code Field -->
                <div class="form-group">
                    <label for="editUserPincode">Pin Code</label>
                    <input type="number" class="form-control" id="editUserPincode" name="pincode" value="<%= rs.getString("u_pincode") %>" required>
                </div>
                
                <!-- Submit Button -->
                <div class="form-group text-center">
                    <input type="submit" value="Save Changes" class="btn btn-primary btn-lg"> 
                    <!--<button type="submit" >Save Changes</button>-->
                </div>
            </form>
                 <% 
        } else {
            out.println("<p>User not found!</p>");
        } 
        %>
        </div>
    </div>
</div>
<%@include file="Footer.jsp" %>
