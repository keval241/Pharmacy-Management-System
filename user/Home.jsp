<%-- 
    Document   : Home
    Created on : Jan 20, 2025, 8:40:09 AM
    Author     : VAIDEHI ENTERPRISE
--%>

<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="Headder.jsp" %>
<%@ page import="java.util.*" %>
<%@include file="Admin/conn.jsp" %>

<div class="site-blocks-cover" style="background-image: url('images/88.jpg');">
    <div class="container">
        <div class="row">
            <div class="col-lg-7 mx-auto order-lg-2 align-self-center">
<!--                <div class="site-block-cover-content text-center">
                    <h2 class="sub-title text-dark">Effective Medicine, New Medicine Everyday</h2>
                    <h1 class="text-dark">Welcome To TrueHealth</h1>
                    <p>
                        <a href="Shop.jsp" class="btn btn-primary px-5 py-3">Shop Now</a>
                    </p>
                </div>-->
            </div>
        </div>
    </div>
</div>

<div class="site-section">
    <div class="container">
        <div class="row align-items-stretch section-overlap">

            <div class="col-md-6 col-lg-4 mb-4 mb-lg-0">
                <div class="banner-wrap bg-primary h-100">
                    <a href="#" class="h-100">
                        <h5>Free <br> Shipping</h5>
                        <p>
                            Amet sit amet dolor
                            <strong>Lorem, ipsum dolor sit amet consectetur adipisicing.</strong>
                        </p>
                    </a>
                </div>
            </div>
            <div class="col-md-6 col-lg-4 mb-4 mb-lg-0">
                <div class="banner-wrap h-100">
                    <a href="#" class="h-100">
                        <h5>Season <br> Sale 50% Off</h5>
                        <p>
                            Amet sit amet dolor
                            <strong>Lorem, ipsum dolor sit amet consectetur adipisicing.</strong>
                        </p>
                    </a>
                </div>
            </div> 
            <div class="col-md-6 col-lg-4 mb-4 mb-lg-0">
                <div class="banner-wrap bg-warning h-100">
                    <a href="#" class="h-100">
                        <h5>Buy <br> A Gift Card</h5>
                        <p>
                            Amet sit amet dolor
                            <strong>Lorem, ipsum dolor sit amet consectetur adipisicing.</strong>
                        </p>
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="site-section">
    <div class="container">
        <div class="row">
            <div class="title-section text-center col-12">
                <h2 class="text-uppercase">Our Services</h2>
            </div>
        </div>
        <div class="row">
            <div class="col-md-4 text-center">
                <div class="service-box p-4 border rounded shadow">
                    <i class="fas fa-store fa-3x text-primary mb-3"></i>
                    <h3 class="text-dark">Retail Pharmacy</h3>
                    <p>We provide high-quality medicines and healthcare products for retailers.</p>
                </div>
            </div>
            <div class="col-md-4 text-center">
                <div class="service-box p-4 border rounded shadow">
                    <i class="fas fa-user-md fa-3x text-danger mb-3"></i>
                    <h3 class="text-dark">Human Medicines</h3>
                    <p>Get the best medicines prescribed by healthcare professionals.</p>
                </div>
            </div>
            <div class="col-md-4 text-center">
                <div class="service-box p-4 border rounded shadow">
                    <i class="fas fa-truck-medical fa-3x text-success mb-3"></i>
                    <h3 class="text-dark">Home Delivery</h3>
                    <p>Fast and secure medicine delivery to your doorstep.</p>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="site-section">
    <div class="container">
        <div class="row">
            <div class="title-section text-center col-12">
                <h2 class="text-uppercase">Popular Products</h2>
            </div>
        </div>

        <div class="row">
            <% 
                // Query to get popular products with cmp_status = 1 and cat_status = 1 (limiting to 6)
                String query = "SELECT m.m_id, m.m_name, m.m_price, m.m_quentity, m.m_image " +
                               "FROM medicine m " +
                               "JOIN company c ON m.cmp_id = c.cmp_id " +
                               "JOIN category cat ON m.cat_id = cat.cat_id " +
                               "WHERE c.cmp_status = 1 AND cat.cat_status = 1 " +
                               "LIMIT 6"; // Get only 6 products
                try {
                    Statement stmt = con.createStatement();
                    ResultSet rs = stmt.executeQuery(query);
                    while (rs.next()) {
            %>
            <div class="col-sm-6 col-lg-4 text-center item mb-4">
<!--                <span class="tag">Sale</span>-->
                <a href="Shop-single.jsp?m_id=<%= rs.getInt("m_id") %>">
                    <!-- Use img-fluid to make the image responsive -->
                    <img src="Admin/img/<%= rs.getString("m_image") %>" alt="<%= rs.getString("m_name") %>" class="img-fluid" style="max-height: 300px; object-fit: contain;">
                </a>
                <h3 class="text-dark"><a href="Shop-single.jsp?m_id=<%= rs.getInt("m_id") %>"><%= rs.getString("m_name") %></a></h3>
                <p class="price">$<%= rs.getDouble("m_price") %></p>
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
        <div class="row mt-5">
            <div class="col-12 text-center">
                <a href="Shop.jsp" class="btn btn-primary px-4 py-3">View All Products</a>
            </div>
        </div>
    </div>
</div>

<!-- New Products Section -->
<div class="site-section bg-light">
    <div class="container">
        <div class="row">
            <div class="title-section text-center col-12">
                <h2 class="text-uppercase">New Products</h2>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12 block-3 products-wrap">
                <div class="nonloop-block-3 owl-carousel">
                    <% 
                        // Query to get all new products with cmp_status = 1 and cat_status = 1
                        String newProductQuery = "SELECT m.m_id, m.m_name, m.m_price, m.m_quentity, m.m_image " +
                                                 "FROM medicine m " +
                                                 "JOIN company c ON m.cmp_id = c.cmp_id " +
                                                 "JOIN category cat ON m.cat_id = cat.cat_id " +
                                                 "WHERE c.cmp_status = 1 AND cat.cat_status = 1";
                        try {
                            Statement stmtNew = con.createStatement();
                            ResultSet rsNew = stmtNew.executeQuery(newProductQuery);
                            while (rsNew.next()) {
                    %>
                    <div class="text-center item mb-4">
                        <a href="Shop-single.jsp?m_id=<%= rsNew.getInt("m_id") %>">
                            <img src="Admin/img/<%= rsNew.getString("m_image") %>" alt="<%= rsNew.getString("m_name") %>">
                        </a>
                        <h3 class="text-dark"><a href="Shop-single.jsp?m_id=<%= rsNew.getInt("m_id") %>"><%= rsNew.getString("m_name") %></a></h3>
                        <p class="price">$<%= rsNew.getDouble("m_price") %></p>
                    </div>
                    <% 
                            }
                            rsNew.close();
                            stmtNew.close();
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                    %>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="site-section bg-secondary bg-image" style="background-image: url('images/bg_2.jpg');">
    <div class="container">
        <div class="row align-items-stretch">
            <div class="col-lg-6 mb-5 mb-lg-0">
                <a href="#" class="banner-1 h-100 d-flex" style="background-image: url('images/bg_1.jpg');">
                    <div class="banner-1-inner align-self-center">
                        <h2>TrueHealth Products</h2>
                        <p>TrueHealth provides premium, all-natural wellness products designed to enhance your vitality and support overall well-being
                        </p>
                    </div>
                </a>
            </div>
            <div class="col-lg-6 mb-5 mb-lg-0">
                <a href="#" class="banner-1 h-100 d-flex" style="background-image: url('images/bg_2.jpg');">
                    <div class="banner-1-inner ml-auto  align-self-center">
                        <h2>Rated by Experts</h2>
                        <p>TrueHealth: Expert-approved wellness solutions crafted with premium, all-natural ingredients for optimal health.
                        </p>
                    </div>
                </a>
            </div>
        </div>
    </div>
</div>
<%@include file="Footer.jsp" %>
