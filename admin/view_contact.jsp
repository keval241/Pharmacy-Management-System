<%-- 
    Document   : view_contact
    Created on : Jan 29, 2025, 4:33:05 AM
    Author     : VAIDEHI ENTERPRISE
--%>

<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="Headder.jsp" %>
<%@include file="conn.jsp" %>
<!-- Begin Page Content -->
<div class="container-fluid">
    <!-- Data Table Example -->
    <div class="card shadow mb-4">
        <div class="card-header py-3 d-flex justify-content-between align-items-center">
            <h6 class="m-0 font-weight-bold text-primary">Contact Details</h6>
            <div class="col-md-4">
                <input type="text" id="searchInput" class="form-control" placeholder="Search contacts...">
            </div>
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-bordered table-hover table-striped table-sm text-nowrap" id="dataTable">
                    <thead class="thead-dark">
                        <tr>
                            <th class="text-center w-auto">#</th>
                            <th class="w-auto">Name</th>
                            <th class="w-auto">Email</th>
                            <th class="w-auto">Subject</th>
                            <th class="w-auto">Message</th>
                        </tr>
                    </thead>
                    <tfoot class="table-dark">
                        <tr>
                            <th class="text-center w-auto">#</th>
                            <th class="w-auto">Name</th>
                            <th class="w-auto">Email</th>
                            <th class="w-auto">Subject</th>
                            <th class="w-auto">Message</th>
                        </tr>
                    </tfoot>
                    <tbody>
                        <%
                            Statement statement = null;
                            ResultSet rs = null;
                            int counter = 1;

                            try {
                                // SQL query to fetch contact details with user name and email
                                String query = "SELECT u.u_name, u.u_email, c.c_subject, c.c_message " +
                                               "FROM contact c " +
                                               "JOIN users u ON c.u_id = u.u_id";

                                statement = con.createStatement();
                                rs = statement.executeQuery(query);

                                // Loop through result set and display each row
                                while (rs.next()) {
                                    String u_name = rs.getString("u_name");
                                    String userEmail = rs.getString("u_email");
                                    String subject = rs.getString("c_subject");
                                    String message = rs.getString("c_message");
                        %>

                        <tr>
                            <td class="text-center"><%= counter++ %></td>
                            <td><%= u_name %></td>
                            <td><%= userEmail %></td>
                            <td><%= subject %></td>
                            <td class="text-truncate" style="max-width: 250px;">
                                <%= message.length() > 50 ? message.substring(0, 50) + "..." : message %>
                            </td>
                        </tr>

                        <%
                                }
                            } catch (Exception e) {
                                e.printStackTrace();
                            } finally {
                                try {
                                    if (rs != null) rs.close();
                                    if (statement != null) statement.close();
                                    if (con != null) con.close();
                                } catch (SQLException e) {
                                    e.printStackTrace();
                                }
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
                    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    $(document).ready(function() {
        $("#searchInput").on("keyup", function() {
            var value = $(this).val().toLowerCase();
            $("#dataTable tbody tr").filter(function() {
                $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1);
            });
        });
    });
</script>
<!-- End of Main Content -->
<%@include file="Footer.jsp" %>
