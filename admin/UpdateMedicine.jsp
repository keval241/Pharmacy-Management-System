<%-- 
    Document   : UpdateMedicine
    Created on : Feb 6, 2025, 6:19:37 AM
    Author     : VAIDEHI ENTERPRISE
--%>

<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="Headder.jsp" %>
<%@include file="conn.jsp" %>
<div class="container-fluid d-flex justify-content-center align-items-center" style="min-height: 100vh;">
    <div class="card shadow-sm" style="width: 500px;">
        <div class="card-header">
            <div class="d-flex justify-content-between align-items-center">
                <h4>Edit Medicine Details</h4>
                <!-- Back Button -->
                <a href="view_medicine.jsp" class="btn btn-secondary btn-sm">
                    <i class="fas fa-arrow-left"></i> Back
                </a>
            </div>
        </div>
        <div class="card-body">
        <%
            int m_id = Integer.parseInt(request.getParameter("m_id"));
            PreparedStatement ps = null;
            ResultSet rs = null;
            String que = "SELECT * FROM medicine WHERE m_id=?";
            ps = con.prepareStatement(que);
            ps.setInt(1, m_id);
            rs = ps.executeQuery();
            if (rs.next()) {
        %>
            <form action="../edit_medicine" method="post" enctype="multipart/form-data">
                <input type="hidden" name="m_id" value="<%= rs.getInt("m_id") %>">
                <input type="hidden" name="oldImage" value="<%= rs.getString("m_image") %>">

                <div class="form-group">
                    <label for="medicineName">Medicine Name</label>
                    <input type="text" class="form-control" id="medicineName" name="medicineName" value="<%= rs.getString("m_name") %>" required>
                </div>
                <div class="form-group">
                    <label for="medicineCompany">Medicine Company</label>
                    <select class="form-control" id="medicineCompany" name="medicineCompany" required>
                        <option value="">Select Company</option>
                        <% 
                            String companyQuery = "SELECT cmp_id, cmp_name FROM company WHERE cmp_status = 1";
                            Statement stmt = con.createStatement();
                            ResultSet companyRs = stmt.executeQuery(companyQuery);
                            while (companyRs.next()) {
                                int cmpId = companyRs.getInt("cmp_id");
                                // Assuming 'rs' contains the existing record for editing
                                String selected = (cmpId == rs.getInt("cmp_id")) ? "selected" : ""; 
                        %>
                            <option value="<%= cmpId %>" <%= selected %>><%= companyRs.getString("cmp_name") %></option>
                        <% } %>
                    </select>
                </div>

                <div class="form-group">
                    <label for="medicineCategory">Medicine Category</label>
                    <select class="form-control" id="medicineCategory" name="medicineCategory" required>
                        <option value="">Select Category</option>
                        <% 
                            String categoryQuery = "SELECT cat_id, cat_name FROM category WHERE cat_status = 1";
                            ResultSet categoryRs = stmt.executeQuery(categoryQuery);
                            while (categoryRs.next()) {
                                int catId = categoryRs.getInt("cat_id");
                                // Assuming 'rs' contains the existing record for editing
                                String selected = (catId == rs.getInt("cat_id")) ? "selected" : ""; 
                        %>
                            <option value="<%= catId %>" <%= selected %>><%= categoryRs.getString("cat_name") %></option>
                        <% } %>
                    </select>
                </div>

                <div class="form-group">
                    <label for="medicinePrice">Price</label>
                    <input type="number" class="form-control" id="medicinePrice" name="medicinePrice" value="<%= rs.getDouble("m_price") %>" required>
                </div>
                <div class="form-group">
                    <label for="medicineQuantity">Quantity</label>
                    <input type="number" class="form-control" id="medicineQuantity" name="medicineQuantity" value="<%= rs.getInt("m_quentity") %>" required>
                </div>
                <div class="form-group">
                    <label for="medicineExpireDate">Expiry Date</label>
                    <input type="date" class="form-control" id="medicineExpireDate" name="medicineExpireDate" value="<%= rs.getString("m_expire_date") %>" required>
                </div>
                <div class="form-group">
                    <label for="medicineDescription">Description</label>
                    <textarea class="form-control" id="medicineDescription" name="medicineDescription" required><%= rs.getString("m_description") %></textarea>
                </div>
                <div class="form-group">
                    <label>Current Image:</label><br>
                    <img src="img/<%= rs.getString("m_image") %>" alt="Medicine Image" style="width: 100px; height: auto; margin-bottom: 10px;"><br>
                    <label for="medicineImage">Upload New Image (optional)</label>
                    <input type="file" class="form-control" id="medicineImage" name="medicineImage">
                </div>

                <!-- Submit Button -->
                <div class="form-group text-center">
                    <input type="submit" value="Save Changes" class="btn btn-primary btn-lg"> 
                </div>
            </form>
        <% 
            } else {
                out.println("<p>Medicine not found!</p>");
            } 
        %>
        </div>
    </div>
</div>

<%@include file="Footer.jsp" %>
