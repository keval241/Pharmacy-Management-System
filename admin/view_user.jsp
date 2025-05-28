<%-- 
    Document   : view_user
    Created on : Jan 22, 2025, 8:44:56 AM
    Author     : VAIDEHI ENTERPRISE
--%>

<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="Headder.jsp" %>
<%@include file="conn.jsp" %>

<div class="container-fluid">
    <!-- User Details Table -->
    <div class="card shadow mb-4">
        <div class="card-header py-3 bg-primary text-white d-flex justify-content-between align-items-center">
            <h6 class="m-0 font-weight-bold">User Details</h6>
            <input type="text" id="searchInput" class="form-control w-25" placeholder="Search users...">
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-bordered table-striped table-hover text-center" id="dataTable" width="100%" cellspacing="0">
                    <thead class="table-dark">
                        <tr>
                            <th class="align-middle">#</th>
                            <th class="align-middle">Name</th>
                            <th class="align-middle">Mobile No.</th>
                            <th class="align-middle">Email</th>
                            <th class="align-middle">Pin Code</th>
                            <th class="align-middle">Action</th>
                        </tr>
                    </thead>
                    <tfoot class="table-dark">
                        <tr>
                            <th class="align-middle">#</th>
                            <th class="align-middle">Name</th>
                            <th class="align-middle">Mobile No.</th>
                            <th class="align-middle">Email</th>
                            <th class="align-middle">Pin Code</th>
                            <th class="align-middle">Action</th>
                        </tr>
                    </tfoot>
                    <tbody id="userTable">
                        <%  
                            PreparedStatement ps = null;
                            ResultSet rs = null;
                            int srNo = 1; // Serial number counter

                            try {
                                String query = "SELECT * FROM users";
                                ps = con.prepareStatement(query);
                                rs = ps.executeQuery();

                                if (!rs.isBeforeFirst()) { // Check if ResultSet is empty
                        %>
                        <tr>
                            <td colspan="6" class="text-center fw-bold text-danger">No users found.</td>
                        </tr>
                        <%
                                } else {
                                    while (rs.next()) {
                        %>
                        <tr>
                            <td class="align-middle"><%= srNo++ %></td>
                            <td class="align-middle"><%= rs.getString("u_name") %></td>
                            <td class="align-middle"><%= rs.getString("u_mobile") %></td>
                            <td class="align-middle"><%= rs.getString("u_email") %></td>
                            <td class="align-middle"><%= rs.getString("u_pincode") %></td>
                            <td class="align-middle">
                                <a href="UpdateUser.jsp?u_id=<%= rs.getInt("u_id") %>" class="mx-2">
                                    <i class="fas fa-edit text-success fa-lg"></i>
                                </a>
                                <a href="../delete_user?u_id=<%= rs.getInt("u_id") %>" class="mx-2" 
                                   onclick="return confirm('Are you sure you want to delete this user?');">
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

<!-- JavaScript for live search -->
<script>
    document.getElementById("searchInput").addEventListener("keyup", function() {
        let filter = this.value.toLowerCase();
        let rows = document.querySelectorAll("#userTable tr");

        rows.forEach(row => {
            let text = row.innerText.toLowerCase();
            row.style.display = text.includes(filter) ? "" : "none";
        });
    });
</script>
<!-- End of Main Content -->

<%@include file="Footer.jsp" %>
