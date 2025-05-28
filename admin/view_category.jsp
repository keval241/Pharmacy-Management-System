<%-- 
    Document   : view_category
    Created on : Jan 31, 2025, 7:53:45 AM
    Author     : VAIDEHI ENTERPRISE
--%>

<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="conn.jsp" %>
<%@include file="Headder.jsp" %>
<!-- Begin Page Content -->
<div class="container-fluid">
    <div class="card shadow mb-4">
<div class="card-header py-3 d-flex justify-content-between align-items-center">
            <h6 class="m-0 font-weight-bold text-primary">Category Details</h6>
            <div class="row g-2 align-items-center">
                <div class="col-md">
                <input type="text" id="searchInput" class="form-control mr-2" placeholder="Search categories...">
                </div>
                <div class="col-md-auto">
                
                    <button class="btn btn-primary" data-toggle="modal" data-target="#addCategoryModal">Add Category</button>
                    </div>
                </div>
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-bordered table-striped table-hover table-sm text-nowrap" id="dataTable" width="100%" cellspacing="0">
                    <thead class="thead-dark">
                        <tr class="text-center">
                            <th>#</th>
                            <th>Category Name</th>
                            <th>Status</th>
                            <th>Date & Time</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tfoot class="thead-dark">
                        <tr class="text-center">
                            <th>#</th>
                            <th>Category Name</th>
                            <th>Status</th>
                            <th>Date & Time</th>
                            <th>Action</th>
                        </tr>
                    </tfoot>
                    <tbody>
                        <%
                            PreparedStatement ps = null;
                            ResultSet rs = null;
                            int srNo = 1;

                            try {
                                String query = "SELECT * FROM category";  
                                ps = con.prepareStatement(query);
                                rs = ps.executeQuery();

                                if (!rs.isBeforeFirst()) {
                        %>
                                    <tr>
                                        <td colspan="5" class="text-center font-weight-bold text-danger">No categories found.</td>
                                    </tr>
                        <%
                                } else {
                                    while (rs.next()) {
                                        int catStatus = rs.getInt("cat_status");
                        %>
                                        <tr class="text-center">
                                            <td><%= srNo++ %></td>
                                            <td class="font-weight-bold"><%= rs.getString("cat_name") %></td>
                                            <td>
                                                <span class="badge <%= (catStatus == 1) ? "badge-success" : "badge-danger" %>">
                                                    <%= (catStatus == 1) ? "Active" : "Inactive" %>
                                                </span>
                                            </td>
                                            <td><%= rs.getTimestamp("created_at") != null ? rs.getTimestamp("created_at") : "N/A" %></td>
                                            <td>
                                                <a href="UpdateCategory.jsp?cat_id=<%= rs.getInt("cat_id") %>" class="mx-1">
                                                    <i class="fas fa-edit text-success fa-lg"></i>
                                                </a>
                                                <a href="../delete_category?cat_id=<%= rs.getInt("cat_id") %>" class="mx-1" onclick="return confirm('Are you sure you want to delete this category?');">
                                                    <i class="fas fa-trash text-danger fa-lg"></i>
                                                </a>
                                            </td>
                                        </tr>
                        <%
                                    }
                                }
                            } catch (Exception e) {
                                out.println("Error: " + e.getMessage());
                            } finally {
                                if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                                if (ps != null) try { ps.close(); } catch (SQLException e) { e.printStackTrace(); }
                                if (con != null) try { con.close(); } catch (SQLException e) { e.printStackTrace(); }
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<!-- Add Category Modal -->
<div class="modal fade" id="addCategoryModal" tabindex="-1" role="dialog" aria-labelledby="addCategoryModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title" id="addCategoryModalLabel">Add Category</h5>
                <button type="button" class="close text-white" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form id="categoryForm" method="post" action="../add_category">
                    <div class="form-group">
                        <label for="categoryName">Category Name</label>
                        <input type="text" class="form-control" name="category" id="categoryName" placeholder="Enter category name" required>
                    </div>
                    <button type="submit" class="btn btn-primary btn-block">Add Category</button>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Include Bootstrap JS (Make sure jQuery is included) -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    $(document).ready(function() {
        // Search bar functionality
        $("#searchInput").on("keyup", function() {
            var value = $(this).val().toLowerCase();
            $("#dataTable tbody tr").filter(function() {
                $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1);
            });
        });

        // Form submission handling
        $('#categoryForm').submit(function(event) {
            event.preventDefault();
            let categoryName = $('#categoryName').val().trim();
            if (categoryName) {
                alert('Category "' + categoryName + '" added successfully!');
                $('#addCategoryModal').modal('hide');
                $('#categoryName').val('');
            }
        });
    });
</script>

<!-- End of Main Content -->
<%@include file="Footer.jsp" %>
