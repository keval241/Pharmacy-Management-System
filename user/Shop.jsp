<%-- 
    Document   : Shop
    Created on : Jan 20, 2025, 8:41:58 AM
    Author     : VAIDEHI ENTERPRISE
--%>

<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="Headder.jsp" %>
<%@include file="Admin/conn.jsp" %>
<style>
    /* Custom Styles for Centered Form and Animations */
body {
    font-family: Arial, sans-serif;
    background-color: #f8f9fa;
    margin: 0;
    padding: 0;
}

.site-section {
    padding: 60px 0;
}

/* Adjusting the product card container */
.container.py-5 {
    padding-top: 50px; /* Optional: add top padding */
    padding-bottom: 50px; /* Optional: add bottom padding */
}

.row.g-4 {
    display: flex;
    flex-wrap: wrap;
    gap: 30px; /* Added gap between cards */
    justify-content: space-between; /* Ensures that cards are spaced evenly */
}

/* Product Card Style */
.product-card {
    flex: 1 1 calc(33.3333% - 30px); /* This calculates each product card's width */
    margin-bottom: 30px;
    padding-top: 20px;
    padding-bottom: 20px;
    background-color: #fff; /* Optional: Adds background color */
    border: 1px solid #ddd; /* Optional: Adds border around each card */
    border-radius: 8px; /* Optional: Adds rounded corners to cards */
    box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1); /* Optional: Adds light shadow to the card */
}

/* Adjusting the image within the product card */
.product-card img {
    transition: transform 0.3s ease-in-out;
    margin-bottom: 15px;
    width: 100%;
    height: auto;
    border-bottom: 1px solid #ddd; /* Optional: Adds a border below the image */
}

.product-card img:hover {
    transform: scale(1.1);
}

/* Responsive Layout */
@media (max-width: 768px) {
    .product-card {
        flex: 1 1 calc(50% - 30px); /* 2 cards per row on medium screens */
    }
    .form-container select, .form-container button {
        width: 100%; /* Full width for the form elements on smaller screens */
    }
}

@media (max-width: 480px) {
    .product-card {
        flex: 1 1 100%; /* Single card per row on very small screens */
    }
}

.form-container form {
    display: flex;
    justify-content: center;
    align-items: center;
    gap: 15px;
    flex-wrap: wrap;
    padding: 0 15px;
}

.form-container select, .form-container button {
    padding: 12px 20px;
    font-size: 16px;
    border: 1px solid #ccc;
    border-radius: 5px;
    background-color: #fff;
    transition: all 0.3s ease-in-out;
    width: 200px;
}

.form-container select:focus, .form-container button:focus {
    outline: none;
    border-color: #007bff;
    box-shadow: 0 0 10px rgba(0, 123, 255, 0.5);
}

.form-container button {
    background-color: #007bff;
    color: white;
    cursor: pointer;
    font-weight: bold;
    transition: background-color 0.3s ease;
}

.form-container button:hover {
    background-color: #0056b3;
    transform: translateY(-3px);
}

/* Add bottom margin to each product card */
.product-card img {
    transition: transform 0.3s ease-in-out;
    margin-bottom: 15px; /* Space between image and product info */
}

/* Product card hover effect */
.product-card img:hover {
    transform: scale(1.1);
}

/* Responsive Layout for smaller devices */
@media (max-width: 768px) {
    .form-container select, .form-container button {
        width: 45%;
    }

    .product-card {
        flex: 1 1 calc(50% - 30px);
    }
}

@media (max-width: 480px) {
    .form-container select, .form-container button {
        width: 90%;
    }

    .product-card {
        flex: 1 1 100%;
    }
}
</style>

<!-- Breadcrumb Navigation -->
<div class="bg-light py-3">
    <div class="container">
        <div class="row">
            <div class="col-md-12 mb-0">
                <a href="Home.jsp">Home</a> <span class="mx-2 mb-0">/</span>
                <strong class="text-black">Store</strong>
            </div>
        </div>
    </div>
</div>

<!-- Filtering Form -->
<div class="site-section">
    <div class="container">
        <div class="row">
            <div class="form-container">
                <form action="FilterMedicine" method="POST">
                    <!-- Company Dropdown -->
                    <select name="company" id="company">
                        <option value="all">All Company</option>
                        <% 
                            try {
                                String query = "SELECT cmp_id, cmp_name FROM company WHERE cmp_status = 1";
                                Statement stmt = con.createStatement();
                                ResultSet rs = stmt.executeQuery(query);
                                while (rs.next()) {
                        %>
                            <option value="<%= rs.getString("cmp_id") %>"><%= rs.getString("cmp_name") %></option>
                        <% 
                                }
                                rs.close();
                                stmt.close();
                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                        %>
                    </select>
                    
                    <!-- Category Dropdown -->
                    <select name="category" id="category">
                        <option value="all">All Category</option>
                        <% 
                            try {
                                String query = "SELECT cat_id, cat_name FROM category WHERE cat_status = 1";
                                Statement stmt = con.createStatement();
                                ResultSet rs = stmt.executeQuery(query);
                                while (rs.next()) {
                        %>
                            <option value="<%= rs.getString("cat_id") %>"><%= rs.getString("cat_name") %></option>
                        <% 
                                }
                                rs.close();
                                stmt.close();
                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                        %>
                    </select>
                    
                    <!-- Filter Button -->
                    <button type="submit" name="filter" class="filter-button">Filter</button>
                </form>
            </div>
        </div>

        <!-- Display Medicines -->
        <div class="container py-5">
            <div class="row g-4 justify-content-center">
                <% 
                    String companyId = request.getParameter("company");
                    String categoryId = request.getParameter("category");

                    // Base query
                    String query = "SELECT m.m_id, m.m_name, m.m_price, m.m_quentity, m.m_image, " +
                                   "c.cmp_name, cat.cat_name " +
                                   "FROM medicine m " +
                                   "JOIN company c ON m.cmp_id = c.cmp_id " +
                                   "JOIN category cat ON m.cat_id = cat.cat_id " +
                                   "WHERE c.cmp_status = 1 AND cat.cat_status = 1 ";

                    boolean hasCompany = companyId != null && !"all".equals(companyId);
                    boolean hasCategory = categoryId != null && !"all".equals(categoryId);

                    if (hasCompany) {
                        query += "AND m.cmp_id = ? ";
                    }
                    if (hasCategory) {
                        query += "AND m.cat_id = ? ";
                    }

                    try {
                        PreparedStatement stmt = con.prepareStatement(query);
                        int paramIndex = 1;

                        if (hasCompany) {
                            stmt.setString(paramIndex++, companyId);
                        }
                        if (hasCategory) {
                            stmt.setString(paramIndex++, categoryId);
                        }

                        ResultSet rs = stmt.executeQuery();
                        while (rs.next()) {
                %>
                            <div class="col-12 col-sm-6 col-md-4 mb-5 product-card">
                                <div class="product-card p-3 border rounded shadow-sm h-100 d-flex flex-column justify-content-between">
                                    <a href="Shop-single.jsp?m_id=<%= rs.getInt("m_id") %>" class="text-center mb-3">
                                        <img src="Admin/img/<%= rs.getString("m_image") %>" alt="<%= rs.getString("m_name") %>" 
                                             class="img-fluid rounded" 
                                             style="height: 200px; width: 100%; object-fit: contain;">
                                    </a>
                                    
                                    <div class="product-info text-center">
                                        <h4 class="mb-1"><%= rs.getString("m_name") %></h4>
                                        <p class="text-muted mb-1"><%= rs.getString("cmp_name") %> - <%= rs.getString("cat_name") %></p>
                                        <p class="text-success fw-bold">$<%= rs.getDouble("m_price") %></p>
                                    </div>
                                </div>
                            </div>
                <% 
                        }
                        rs.close();
                        stmt.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                %>
            </div>
        </div>
    </div>
</div>

            <%@include file="Footer.jsp" %>