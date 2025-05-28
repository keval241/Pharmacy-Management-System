<%-- 
    Document   : Home
    Created on : Jan 21, 2025, 8:08:04 AM
    Author     : VAIDEHI ENTERPRISE
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="Headder.jsp" %>
<%@include file="conn.jsp" %>
<div class="container-fluid">
    

                    <!-- Page Heading -->
                    <div class="d-sm-flex align-items-center justify-content-between mb-4">
                        <h1 class="h3 mb-0 text-gray-800">Dashboard</h1>
<!--                        <a href="#" class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm"><i
                                class="fas fa-download fa-sm text-white-50"></i> Generate Report</a>-->
                    </div>

                    <!-- Content Row --> <%@ page import="java.sql.*" %>
<%
    // Initialize counters
    int totalOrders = 0, totalUsers = 0, totalPayments = 0, totalContacts = 0;
    int totalCategories = 0, totalCompanies = 0, totalMedicines = 0, totalReviews = 0;

    try {
        Statement stmt = con.createStatement();
        ResultSet rs;

        // Count Orders
        rs = stmt.executeQuery("SELECT COUNT(*) FROM orders");
        if (rs.next()) totalOrders = rs.getInt(1);
        rs.close();

        // Count Users
        rs = stmt.executeQuery("SELECT COUNT(*) FROM users");
        if (rs.next()) totalUsers = rs.getInt(1);
        rs.close();

        // Count Payments
        rs = stmt.executeQuery("SELECT COUNT(*) FROM payment");
        if (rs.next()) totalPayments = rs.getInt(1);
        rs.close();

        // Count Contacts
        rs = stmt.executeQuery("SELECT COUNT(*) FROM contact");
        if (rs.next()) totalContacts = rs.getInt(1);
        rs.close();

        // Count Categories
        rs = stmt.executeQuery("SELECT COUNT(*) FROM category");
        if (rs.next()) totalCategories = rs.getInt(1);
        rs.close();

        // Count Companies
        rs = stmt.executeQuery("SELECT COUNT(*) FROM company");
        if (rs.next()) totalCompanies = rs.getInt(1);
        rs.close();

        // Count Medicines
        rs = stmt.executeQuery("SELECT COUNT(*) FROM medicine");
        if (rs.next()) totalMedicines = rs.getInt(1);
        rs.close();

        // Count Reviews
        rs = stmt.executeQuery("SELECT COUNT(*) FROM review");
        if (rs.next()) totalReviews = rs.getInt(1);
        rs.close();

        // Close statement
        stmt.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<div class="row">
    <!-- Total Orders -->
    <div class="col-xl-3 col-md-6 mb-4">
        <div class="card border-left-primary shadow h-100 py-2">
            <div class="card-body">
                <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                        <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">Total Orders</div>
                        <div class="h5 mb-0 font-weight-bold text-gray-800"><%= totalOrders %></div>
                    </div>
                    <div class="col-auto">
                        <i class="fas fa-shopping-bag fa-2x text-gray-300"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Total Payments -->
    <div class="col-xl-3 col-md-6 mb-4">
        <div class="card border-left-success shadow h-100 py-2">
            <div class="card-body">
                <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                        <div class="text-xs font-weight-bold text-success text-uppercase mb-1">Total Payments</div>
                        <div class="h5 mb-0 font-weight-bold text-gray-800"><%= totalPayments %></div>
                    </div>
                    <div class="col-auto">
                        <i class="fas fa-dollar-sign fa-2x text-gray-300"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Total Users -->
    <div class="col-xl-3 col-md-6 mb-4">
        <div class="card border-left-info shadow h-100 py-2">
            <div class="card-body">
                <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                        <div class="text-xs font-weight-bold text-info text-uppercase mb-1">Total Users</div>
                        <div class="h5 mb-0 font-weight-bold text-gray-800"><%= totalUsers %></div>
                    </div>
                    <div class="col-auto">
                        <i class="fas fa-users fa-2x text-gray-300"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Total Contacts -->
    <div class="col-xl-3 col-md-6 mb-4">
        <div class="card border-left-warning shadow h-100 py-2">
            <div class="card-body">
                <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                        <div class="text-xs font-weight-bold text-warning text-uppercase mb-1">Total Contacts</div>
                        <div class="h5 mb-0 font-weight-bold text-gray-800"><%= totalContacts %></div>
                    </div>
                    <div class="col-auto">
                        <i class="fas fa-phone-alt fa-2x text-gray-300"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Total Categories -->
    <div class="col-xl-3 col-md-6 mb-4">
        <div class="card border-left-warning shadow h-100 py-2">
            <div class="card-body">
                <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                        <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">Total Categories</div>
                        <div class="h5 mb-0 font-weight-bold text-gray-800"><%= totalCategories %></div>
                    </div>
                    <div class="col-auto">
                        <i class="fas fa-fw fa-boxes fa-2x text-gray-300"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Total Companies -->
    <div class="col-xl-3 col-md-6 mb-4">
        <div class="card border-left-info shadow h-100 py-2">
            <div class="card-body">
                <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                        <div class="text-xs font-weight-bold text-success text-uppercase mb-1">Total Companies</div>
                        <div class="h5 mb-0 font-weight-bold text-gray-800"><%= totalCompanies %></div>
                    </div>
                    <div class="col-auto">
                        <i class="fas fa-building fa-2x text-gray-300"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Total Medicines -->
    <div class="col-xl-3 col-md-6 mb-4">
        <div class="card border-left-success shadow h-100 py-2">
            <div class="card-body">
                <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                        <div class="text-xs font-weight-bold text-info text-uppercase mb-1">Total Medicines</div>
                        <div class="h5 mb-0 font-weight-bold text-gray-800"><%= totalMedicines %></div>
                    </div>
                    <div class="col-auto">
                        <i class="fas fa-pills fa-2x text-gray-300"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Total Reviews -->
    <div class="col-xl-3 col-md-6 mb-4">
        <div class="card border-left-primary shadow h-100 py-2">
            <div class="card-body">
                <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                        <div class="text-xs font-weight-bold text-warning text-uppercase mb-1">Total Reviews</div>
                        <div class="h5 mb-0 font-weight-bold text-gray-800"><%= totalReviews %></div>
                    </div>
                    <div class="col-auto">
                        <i class="fas fa-star fa-2x text-gray-300"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<%@include file="Footer.jsp" %>
