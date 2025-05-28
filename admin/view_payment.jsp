<%-- 
    Document   : view_payment
    Created on : Feb 16, 2025, 9:30:03 AM
    Author     : VAIDEHI ENTERPRISE
--%>

<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="Headder.jsp" %>
<%@include file="conn.jsp" %>

<div class="container-fluid">
    <!-- Payment Details Table -->
    <div class="card shadow mb-4">
        <div class="card-header py-3 d-flex justify-content-between align-items-center bg-primary text-white">
            <h6 class="m-0 font-weight-bold">Payment Details</h6>
            <div class="col-md-4">
                <input type="text" id="searchInput" class="form-control" placeholder="Search payments...">
            </div>
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-bordered table-striped table-hover table-sm text-nowrap" id="dataTable" width="100%" cellspacing="0">
                    <thead class="table-dark">
                        <tr class="text-center">
                            <th class="align-middle">#</th>
                            <th class="align-middle">User Name</th>
                            <th class="align-middle">Mobile No.</th>
                            <th class="align-middle">Email</th>
                            <th class="align-middle">Medicine Name</th>
                            <th class="align-middle">Amount (₹)</th>
                            <th class="align-middle">Payment Method</th>
                            <th class="align-middle">Status</th>
                            <th class="align-middle">Date & Time</th>
                        </tr>
                    </thead>
                    <tfoot class="table-dark">
                        <tr class="text-center">
                            <th class="align-middle">#</th>
                            <th class="align-middle">User Name</th>
                            <th class="align-middle">Mobile No.</th>
                            <th class="align-middle">Email</th>
                            <th class="align-middle">Medicine Name</th>
                            <th class="align-middle">Amount (₹)</th>
                            <th class="align-middle">Payment Method</th>
                            <th class="align-middle">Status</th>
                            <th class="align-middle">Date & Time</th>
                        </tr>
                    </tfoot>
                    <tbody>
                        <%  
                            PreparedStatement ps = null;
                            ResultSet rs = null;
                            int srNo = 1; 

                            try {
                                String query = "SELECT p.pay_id, u.u_name, u.u_mobile, u.u_email, o.m_name, p.pay_amount, p.pay_method, p.pay_status, p.pay_date "
                                             + "FROM payment p "
                                             + "JOIN users u ON p.u_id = u.u_id "
                                             + "JOIN orders o ON p.o_id = o.o_id"; 
                                ps = con.prepareStatement(query);
                                rs = ps.executeQuery();

                                if (!rs.isBeforeFirst()) { 
                        %>
                        <tr>
                            <td colspan="9" class="text-center fw-bold text-danger">No payment records found.</td>
                        </tr>
                        <%
                                } else {
                                    while (rs.next()) {
                                        int payStatus = rs.getInt("pay_status");
                                        String statusClass = (payStatus == 1) ? "badge-success" : (payStatus == 0) ? "badge-warning" : "badge-danger";
                                        String statusText = (payStatus == 1) ? "Complete" : (payStatus == 0) ? "Pending" : "Failed";
                        %>
                        <tr class="text-center">
                            <td class="align-middle"><%= srNo++ %></td>
                            <td class="align-middle font-weight-bold"><%= rs.getString("u_name") %></td>
                            <td class="align-middle"><%= rs.getString("u_mobile") %></td>
                            <td class="align-middle"><%= rs.getString("u_email") %></td>
                            <td class="align-middle"><%= rs.getString("m_name") %></td>
                            <td class="align-middle">₹<%= rs.getBigDecimal("pay_amount") %></td>
                            <td class="align-middle"><%= rs.getString("pay_method") %></td>
                            <td class="align-middle">
                                <span class="badge <%= statusClass %> px-3 py-2"><%= statusText %></span>
                            </td>
                            <td class="align-middle"><%= rs.getTimestamp("pay_date") != null ? rs.getTimestamp("pay_date") : "N/A" %></td>
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
<!-- End of Main Content -->
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
