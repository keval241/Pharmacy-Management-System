<%-- 
    Document   : UpdateCategory
    Created on : Feb 3, 2025, 8:42:29 AM
    Author     : VAIDEHI ENTERPRISE
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="Headder.jsp" %>
<%@include file="conn.jsp" %>
<div class="container-fluid d-flex justify-content-center align-items-center" style="min-height: 50vh;">
    <div class="card shadow-sm" style="width: 500px; margin: 50px auto 50px;">
        <div class="card-header">
            <div class="d-flex justify-content-between align-items-center">
                <h4>Edit Category Details</h4>
                <!-- Back Button -->
                <a href="view_category.jsp" class="btn btn-secondary btn-sm">
                    <i class="fas fa-arrow-left"></i> Back
                </a>
            </div>
        </div>
        <div class="card-body">
        <%
            int cat_id = Integer.parseInt(request.getParameter("cat_id"));
            PreparedStatement ps=null;
            ResultSet rs=null;
            String que = "SELECT * FROM category WHERE cat_id=?";
            ps=con.prepareStatement(que);
            ps.setInt(1, cat_id);
            rs=ps.executeQuery();
            if (rs.next()) {
        %>
            <form action="../edit_category" method="post">
                <input type="hidden" name="cat_id" value="<%= rs.getInt("cat_id") %>">
                
                <!-- Company Name Field -->
                <div class="form-group">
                    <label for="editCompanyName">Company Name</label>
                    <input type="text" class="form-control" id="editCompanyName" name="name" value="<%= rs.getString("cat_name") %>" required>
                </div>

                <!-- Company Status Field (Dropdown) -->
                <div class="form-group">
                    <label for="editCompanyStatus">Company Status</label>
                    <select class="form-control" id="editCompanyStatus" name="status" required>
                        <option value="1" <%= rs.getInt("cat_status") == 1 ? "selected" : "" %>>Active</option>
                        <option value="0" <%= rs.getInt("cat_status") == 0 ? "selected" : "" %>>Inactive</option>
                    </select>
                </div>

                <!-- Submit Button -->
                <div class="form-group text-center">
                    <input type="submit" value="Save Changes" class="btn btn-primary btn-lg"> 
                </div>
            </form>
        <% 
            } else {
                out.println("<p>Company not found!</p>");
            } 
        %>
        </div>
    </div>
</div>

<%@include file="Footer.jsp" %>

