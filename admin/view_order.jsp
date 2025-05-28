<%-- 
    Document   : view_order
    Created on : Feb 16, 2025, 8:37:18 AM
    Author     : VAIDEHI ENTERPRISE
--%>

<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="Headder.jsp" %>
<%@include file="conn.jsp" %>

<div class="container-fluid">
    <div class="card shadow mb-4">
        <div class="card-header py-3 d-flex justify-content-between align-items-center bg-primary text-white">
            <h6 class="m-0 font-weight-bold">Order Details</h6>
            <div class="col-md-4">
                <input type="text" id="searchInput" class="form-control" placeholder="Search orders...">
            </div>
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-bordered table-striped table-hover text-center" id="dataTable" width="100%" cellspacing="0">
                    <thead class="table-dark">
                        <tr>
                            <th class="align-middle">#</th>
                            <th class="align-middle">Customer Name</th>
                            <th class="align-middle">Mobile No.</th>
                            <th class="align-middle">Email</th>
                            <th class="align-middle">Medicine Name</th>
                            <th class="align-middle">Address</th>
                            <th class="align-middle">Price per Unit</th> <!-- New Column -->
                            <th class="align-middle">Quantity</th>
                            <th class="align-middle">Amount</th>
                            <th class="align-middle">Order Status</th>
                            <th class="align-middle">Order Date</th>
                        </tr>
                    </thead>
                    <tfoot class="table-dark">
                        <tr>
                            <th class="align-middle">#</th>
                            <th class="align-middle">Customer Name</th>
                            <th class="align-middle">Mobile No.</th>
                            <th class="align-middle">Email</th>
                            <th class="align-middle">Medicine Name</th>
                            <th class="align-middle">Address</th>
                            <th class="align-middle">Price per Unit</th> <!-- New Column -->
                            <th class="align-middle">Quantity</th>
                            <th class="align-middle">Amount</th>
                            <th class="align-middle">Order Status</th>
                            <th class="align-middle">Order Date</th>
                        </tr>
                    </tfoot>
                    <tbody>
                        <%  
                            PreparedStatement ps = null;
                            ResultSet rs = null;
                            int srNo = 1;

                            try {
                                // Fetch user and order data including price per unit
                                String query = "SELECT o.o_id, u.u_name, u.u_mobile, u.u_email, o.m_name, o.o_address, " +
                                               "o.m_price_per_unit, o.o_quantity, o.o_amount, o.o_status, o.o_date " +
                                               "FROM orders o " +
                                               "JOIN users u ON o.u_id = u.u_id"; 

                                ps = con.prepareStatement(query);
                                rs = ps.executeQuery();

                                if (!rs.isBeforeFirst()) { // Check if no orders found
                        %>
                        <tr>
                            <td colspan="11" class="text-center fw-bold text-danger">No orders found.</td>
                        </tr>
                        <%
                                } else {
                                    while (rs.next()) {
                                        int orderId = rs.getInt("o_id");
                                        int status = rs.getInt("o_status");
                        %>
                        <tr>
                            <td class="align-middle"><%= srNo++ %></td>
                            <td class="align-middle"><%= rs.getString("u_name") %></td>
                            <td class="align-middle"><%= rs.getString("u_mobile") %></td>
                            <td class="align-middle"><%= rs.getString("u_email") %></td>
                            <td class="align-middle"><%= rs.getString("m_name") %></td>
                            <td class="align-middle"><%= rs.getString("o_address") %></td>
                            <td class="align-middle fw-bold text-primary">₹<%= rs.getString("m_price_per_unit") %></td> <!-- New Data -->
                            <td class="align-middle"><%= rs.getString("o_quantity") %></td>
                            <td class="align-middle fw-bold text-success">₹<%= rs.getBigDecimal("o_amount") %></td>
                            <td class="align-middle">
                                <select class="form-select form-select-sm status-dropdown 
                                               <%= (status == 0) ? "text-warning" : 
                                                   (status == 1) ? "text-primary" : 
                                                   (status == 2) ? "text-info" : 
                                                   (status == 3) ? "text-success" : 
                                                   "text-danger" %>" 
                                        data-orderid="<%= orderId %>">
                                    <option value="0" <%= (status == 0) ? "selected" : "" %>>Pending</option>
                                    <option value="1" <%= (status == 1) ? "selected" : "" %>>Processing</option>
                                    <option value="2" <%= (status == 2) ? "selected" : "" %>>Shipped</option>
                                    <option value="3" <%= (status == 3) ? "selected" : "" %>>Delivered</option>
                                    <option value="4" <%= (status == 4) ? "selected" : "" %>>Canceled</option>
                                </select>
                            </td>
                            <td class="align-middle"><%= rs.getDate("o_date") %></td>
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

<%@include file="Footer.jsp" %>

<!-- AJAX Script to Update Order and Payment Status -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    $(document).ready(function() {
        $(".status-dropdown").change(function() {
            var orderId = $(this).data("orderid");
            var newStatus = $(this).val();

            $.ajax({
                url: "../UpdateOrderStatus",
                type: "POST",
                data: { o_id: orderId, o_status: newStatus },
                success: function(response) {
                    alert("Order status updated successfully!");
                },
                error: function() {
                    alert("Error updating order status.");
                }
            });
        });
    });
    $(document).ready(function() {
        $("#searchInput").on("keyup", function() {
            var value = $(this).val().toLowerCase();
            $("#dataTable tbody tr").filter(function() {
                $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1);
            });
        });
    });
</script>