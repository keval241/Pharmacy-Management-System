<%-- 
    Document   : view_company
    Created on : Jan 31, 2025, 7:54:07 AM
    Author     : VAIDEHI ENTERPRISE
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.SQLException"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="Headder.jsp" %>
<%@include file="conn.jsp" %>

<!-- Begin Page Content -->
<div class="container-fluid">
    <div class="card shadow mb-4">
        <div class="card-header py-3 d-flex justify-content-between align-items-center">
            <h6 class="m-0 font-weight-bold text-primary">Company Details</h6>
            <div class="row g-2 align-items-center">
    <!-- Search Bar -->
    <div class="col-md">
        <input type="text" id="searchInput" class="form-control" placeholder="Search company...">
    </div>
    
    <!-- Add Company Button -->
    <div class="col-md-auto">
        <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addCompanyModal">
            Add Company
        </button>
    </div>
</div>

        </div>
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-bordered table-hover table-striped table-sm text-nowrap" id="dataTable">
                    <thead class="thead-dark">
                        <tr>
                            <th class="text-center">#</th>
                            <th class="w-50">Company Name</th>
                            <th class="text-center">Status</th>
                            <th class="text-center">Date & Time</th>
                            <th class="text-center">Action</th>
                        </tr>
                    </thead>
                    <tfoot class="table-dark">
                        <tr>
                            <th class="text-center">#</th>
                            <th class="w-50">Company Name</th>
                            <th class="text-center">Status</th>
                            <th class="text-center">Date & Time</th>
                            <th class="text-center">Action</th>
                        </tr>
                    </tfoot>
                    <tbody id="companyTable">
                        <%
                            PreparedStatement ps = null;
                            ResultSet rs = null;
                            int srNo = 1; 

                            try {
                                String query = "SELECT * FROM company"; 
                                ps = con.prepareStatement(query);
                                rs = ps.executeQuery();

                                if (!rs.isBeforeFirst()) { 
                        %>
                                    <tr>
                                        <td colspan="5" class="text-center">No companies found.</td>
                                    </tr>
                        <%
                                } else {
                                    while (rs.next()) {
                        %>
                                        <tr>
                                            <td class="text-center"><%= srNo++ %></td>
                                            <td class="text-truncate" style="max-width: 300px;"><%= rs.getString("cmp_name") %></td>
                                            <td class="text-center">
                                                <span class="badge <%= rs.getInt("cmp_status") == 1 ? "badge-success" : "badge-danger" %>">
                                                    <%= rs.getInt("cmp_status") == 1 ? "Active" : "UnActive" %>
                                                </span>
                                            </td>
                                            <td class="text-center"><%= rs.getTimestamp("created_at") %></td>
                                            <td class="text-center">
                                                <a href="UpdateCompany.jsp?cmp_id=<%= rs.getInt("cmp_id") %>" class="mx-1">
                                                    <i class="fas fa-edit text-success fa-lg"></i>
                                                </a>
                                                <a href="../delete_company?cmp_id=<%= rs.getInt("cmp_id") %>" class="mx-1" onclick="return confirm('Are you sure you want to delete this company?');">
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

<!-- Add Company Modal -->
<!-- Add Company Modal -->
<div class="modal fade" id="addCompanyModal" tabindex="-1" aria-labelledby="addCompanyModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title" id="addCompanyModalLabel">Add Company</h5>
                <button type="button" class="close text-white" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body px-4 py-3">
                <form id="companyForm" method="post" action="../add_company" class="needs-validation" novalidate>
                    <!-- Company Name Field -->
                    <div class="mb-3">
                        <label for="companyName" class="form-label fw-bold">Company Name</label>
                        <input type="text" name="company" class="form-control" id="companyName" placeholder="Enter company name" required>
                        <div class="invalid-feedback">
                            Please enter a company name.
                        </div>
                    </div>

                    <!-- Status Selection -->
<!--                    <div class="mb-3">
                        <label for="companyStatus" class="form-label fw-bold">Status</label>
                        <select name="status" id="companyStatus" class="form-control" required>
                            <option value="" selected disabled>Select Status</option>
                            <option value="1">Active</option>
                            <option value="0">Inactive</option>
                        </select>
                        <div class="invalid-feedback">
                            Please select a status.
                        </div>
                    </div>-->

                    <!-- Submit Button -->
                    <div class="d-grid">
                        <button type="submit" class="btn btn-primary">Add Company</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- JavaScript for Bootstrap Form Validation -->
<script>
    (function() {
        'use strict';
        window.addEventListener('load', function() {
            let forms = document.getElementsByClassName('needs-validation');
            Array.prototype.filter.call(forms, function(form) {
                form.addEventListener('submit', function(event) {
                    if (form.checkValidity() === false) {
                        event.preventDefault();
                        event.stopPropagation();
                    }
                    form.classList.add('was-validated');
                }, false);
            });
        }, false);
    })();
</script>

<%@include file="Footer.jsp" %>
