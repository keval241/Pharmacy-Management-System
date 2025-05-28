<%-- 
    Document   : view_medicine
    Created on : Jan 31, 2025, 8:40:15 AM
    Author     : VAIDEHI ENTERPRISE
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@include file="conn.jsp" %>
<%@include file="Headder.jsp" %>
<div class="container-fluid">

    <!-- DataTales Example -->
    <div class="card shadow mb-4">
        <div class="card-header py-3 d-flex justify-content-between">
            <h6 class="m-0 font-weight-bold text-primary">Medicines Details</h6>
            <div class="row g-2 align-items-center">
                <!-- Search Bar -->
                <div class="col-md">
                    <input type="text" id="searchInput" class="form-control" placeholder="Search Medicine...">
                </div>

                <!-- Add Company Button -->
                <div class="col-md-auto">
                    <!-- Button to trigger modal for adding new medicine -->
                    <button class="btn btn-primary" data-toggle="modal" data-target="#addMedicineModal">Add Medicine</button>
                </div>   
            </div>
        </div>

        <!-- Modal for adding new medicine -->
        <div class="modal fade" id="addMedicineModal" tabindex="-1" role="dialog" aria-labelledby="addMedicineModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="addMedicineModalLabel">Add New Medicine</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <!-- Form to add new medicine -->
                        <form id="medicineForm" method="post" action="../AddMedicine" enctype="multipart/form-data"> <!-- AddMedicineServlet handles form submission -->
                            <div class="form-group">
                                <label for="medicineName">Medicine Name</label>
                                <input type="text" class="form-control" id="medicineName" name="medicineName" placeholder="Enter medicine name" required>
                            </div>
                            <div class="form-group">
                                <label for="medicineCompany">Medicine Company</label>
                                <select class="form-control" id="medicineCompany" name="medicineCompany" required>
                                    <option value="">Select Company</option>
                                    <!-- Dynamic options for company, populate with actual values from DB -->
                                    <%                                        String companyQuery = "SELECT cmp_id, cmp_name FROM company WHERE cmp_status = 1";
                                        Statement stmt = con.createStatement();
                                        ResultSet companyRs = stmt.executeQuery(companyQuery);
                                        while (companyRs.next()) {
                                    %>
                                    <option value="<%= companyRs.getInt("cmp_id")%>"><%= companyRs.getString("cmp_name")%></option>
                                    <% } %>
                                </select>
                            </div>

                            <div class="form-group">
                                <label for="medicineCategory">Medicine Category</label>
                                <select class="form-control" id="medicineCategory" name="medicineCategory" required>
                                    <option value="">Select Category</option>
                                    <!-- Dynamic options for category -->
                                    <%
                                        String categoryQuery = "SELECT cat_id, cat_name FROM category WHERE cat_status = 1";
                                        ResultSet categoryRs = stmt.executeQuery(categoryQuery);
                                        while (categoryRs.next()) {
                                    %>
                                    <option value="<%= categoryRs.getInt("cat_id")%>"><%= categoryRs.getString("cat_name")%></option>
                                    <% } %>
                                </select>
                            </div>

                            <div class="form-group">
                                <label for="medicinePrice">Price</label>
                                <input type="number" class="form-control" id="medicinePrice" name="medicinePrice" placeholder="Enter price" required>
                            </div>
                            <div class="form-group">
                                <label for="medicineQuantity">Quantity</label>
                                <input type="number" class="form-control" id="medicineQuantity" name="medicineQuantity" placeholder="Enter quantity" required>
                            </div>
                            <div class="form-group">
                                <label for="medicineExpireDate">Expiry Date</label>
                                <input type="date" class="form-control" id="medicineExpireDate" name="medicineExpireDate" required>
                            </div>
                            <div class="form-group">
                                <label for="medicineDescription">Description</label>
                                <textarea class="form-control" id="medicineDescription" name="medicineDescription" placeholder="Enter description" required></textarea>
                            </div>
                            <div class="form-group">
                                <label for="medicineImage" class="font-weight-bold">Upload Image</label>
                                <div class="custom-file">
                                    <input type="file" class="custom-file-input" id="medicineImage" name="medicineImage" required accept="image/*" onchange="previewImage(event)">
                                    <label class="custom-file-label" for="medicineImage">Choose file</label>
                                    <div class="invalid-feedback">Please upload an image.</div>
                                </div>
                                <div class="mt-3 text-center">
                                    <img id="imagePreview" class="img-fluid rounded-lg shadow-sm d-none" style="max-height: 150px;" />
                                </div>
                            </div>

                            <button type="submit" class="btn btn-primary">Add Medicine</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <%
            //        Statement stmt = null;
            ResultSet rs = null;

            try {
                // Establish database connection
                stmt = con.createStatement();

                // SQL query to fetch medicines with company and category names
                String sql = "SELECT m.m_id, m.m_name, c.cmp_name, ca.cat_name, m.m_price, m.m_quentity, m.m_expire_date, m.m_description, m.m_image "
                        + "FROM medicine m "
                        + "JOIN company c ON m.cmp_id = c.cmp_id "
                        + "JOIN category ca ON m.cat_id = ca.cat_id";
                rs = stmt.executeQuery(sql);
        %>
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-bordered table-hover table-striped table-sm text-nowrap" id="dataTable">
                    <thead class="thead-dark">
                        <tr>
                            <th class="text-center w-auto">#</th>
                            <th class="w-auto">Medicine Name</th>
                            <th class="w-auto">Company Name</th>
                            <th class="w-auto">Category Name</th>
                            <th class="text-center w-auto">Price</th>
                            <th class="text-center w-auto">Quantity</th>
                            <th class="text-center w-auto">Expire Date</th>
                            <th class="w-auto">Description</th>
                            <th class="text-center w-auto">Image</th>
                            <th class="text-center w-auto">Action</th>
                        </tr>
                    </thead>
                    <tfoot class="thead-dark">
                        <tr>
                            <th class="text-center w-auto">#</th>
                            <th class="w-auto">Medicine Name</th>
                            <th class="w-auto">Company Name</th>
                            <th class="w-auto">Category Name</th>
                            <th class="text-center w-auto">Price</th>
                            <th class="text-center w-auto">Quantity</th>
                            <th class="text-center w-auto">Expire Date</th>
                            <th class="w-auto">Description</th>
                            <th class="text-center w-auto">Image</th>
                            <th class="text-center w-auto">Action</th>
                        </tr>
                    </tfoot>
                    <tbody>
                        <%
                            int srNo = 1;
                            while (rs.next()) {
                        %>
                        <tr>
                            <td class="text-center"><%= srNo++%></td>
                            <td><%= rs.getString("m_name")%></td>
                            <td><%= rs.getString("cmp_name")%></td>
                            <td><%= rs.getString("cat_name")%></td>
                            <td class="text-center"><%= rs.getBigDecimal("m_price")%></td>
                            <td class="text-center"><%= rs.getInt("m_quentity")%></td>
                            <td class="text-center"><%= rs.getDate("m_expire_date")%></td>
                            <td>
                                <%= rs.getString("m_description").length() > 20 ? rs.getString("m_description").substring(0, 20) + "..." : rs.getString("m_description")%>
                            </td>
                            <td class="text-center">
                                <img src="img/<%= rs.getString("m_image")%>" alt="Medicine Image" class="img-thumbnail" width="50">
                            </td>
                            <td class="text-center">
                                <a href="UpdateMedicine.jsp?m_id=<%= rs.getInt("m_id")%>" class="btn btn-success btn-sm mx-1"><i class="fas fa-edit"></i></a>
                                <a href="../delete_medicine?m_id=<%= rs.getInt("m_id")%>" class="btn btn-danger btn-sm mx-1" onclick="return confirm('Are you sure you want to delete this medicine?');">
                                    <i class="fas fa-trash"></i>
                                </a>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>

        </div>
        <%
            } catch (SQLException e) {
                e.printStackTrace();
            } finally {
                try {
                    if (rs != null) {
                        rs.close();
                    }
                    if (stmt != null) {
                        stmt.close();
                    }
                    if (con != null) {
                        con.close();
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        %>
    </div>
</div>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>

<script>
                                    $(document).ready(function() {
                                        // Search functionality
                                        $("#searchInput").on("keyup", function() {
                                            var value = $(this).val().toLowerCase();
                                            $("#dataTable tbody tr").filter(function() {
                                                $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1);
                                            });
                                        });
                                    });
</script>
<%@include file="Footer.jsp" %>
