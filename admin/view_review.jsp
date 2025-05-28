<%-- 
    Document   : view_review
    Created on : Feb 11, 2025, 9:35:21 AM
    Author     : VAIDEHI ENTERPRISE
--%>

<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="Headder.jsp" %>
<%@include file="conn.jsp" %>
<%@ page import="java.sql.*, java.util.*" %>

<div class="container-fluid">
    <!-- Review Details Table -->
    <div class="card shadow mb-4">
        <div class="card-header py-3 d-flex justify-content-between align-items-center bg-primary text-white">
            <h6 class="m-0 font-weight-bold">Review Details</h6>
            <div class="col-md-4">
                <input type="text" id="searchInput" class="form-control" placeholder="Search reviews...">
            </div>
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-bordered table-striped table-hover text-center" id="dataTable" width="100%" cellspacing="0">
                    <thead class="table-dark">
                        <tr>
                            <th class="align-middle">#</th>
                            <th class="align-middle">Name</th>
                            <th class="align-middle">Medicine Name</th>
                            <th class="align-middle">Rating</th>
                            <th class="align-middle">Comment</th>
                            <th class="align-middle">Review Date</th>
                        </tr>
                    </thead>
                    <tfoot class="table-dark">
                        <tr>
                            <th class="align-middle">#</th>
                            <th class="align-middle">Name</th>
                            <th class="align-middle">Medicine Name</th>
                            <th class="align-middle">Rating</th>
                            <th class="align-middle">Comment</th>
                            <th class="align-middle">Review Date</th>
                        </tr>
                    </tfoot>
                    <tbody>
                        <%
                            Statement statement = null;
                            ResultSet rs = null;
                            int counter = 1;

                            try {
                                // SQL query
                                String query = "SELECT r.r_id, u.u_name AS user_name, m.m_name AS medicine_name, r.rating, r.r_comment, r.review_date " +
                                                "FROM review r " +
                                                "JOIN users u ON r.u_id = u.u_id " +
                                                "JOIN medicine m ON r.m_id = m.m_id";
                                
                                statement = con.createStatement();
                                rs = statement.executeQuery(query);

                                // Check if data exists
                                if (!rs.isBeforeFirst()) {
                        %>
                        <tr>
                            <td colspan="6" class="text-center fw-bold text-danger">No reviews found.</td>
                        </tr>
                        <%
                                } else {
                                    while (rs.next()) {
                                        String u_name = rs.getString("user_name");
                                        String m_name = rs.getString("medicine_name");
                                        int rating = rs.getInt("rating");
                                        String comment = rs.getString("r_comment");
                                        String reviewDate = rs.getString("review_date");
                        %>
                        <tr>
                            <td class="align-middle"><%= counter++ %></td>
                            <td class="align-middle"><%= u_name %></td>
                            <td class="align-middle"><%= m_name %></td>
                            <td class="align-middle">
                                <!-- Display stars based on rating -->
                                <% for (int i = 0; i < 5; i++) { %>
                                    <i class="<%= (i < rating) ? "fas fa-star text-warning" : "far fa-star text-warning" %>"></i>
                                <% } %>
                            </td>
                            <td class="align-middle">
                                <%= comment.length() > 20 ? comment.substring(0, 10) + "..." : comment %>
                            </td>
                            <td class="align-middle"><%= reviewDate %></td>
                        </tr>
                        <%
                                    }
                                }
                            } catch (Exception e) {
                                out.println("Error: " + e.getMessage());
                                e.printStackTrace();
                            } finally {
                                // Close resources
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
<%@include file="Footer.jsp" %>
