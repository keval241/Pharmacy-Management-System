<%-- 
    Document   : Contact
    Created on : Jan 20, 2025, 8:40:32 AM
    Author     : VAIDEHI ENTERPRISE
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="Headder.jsp" %>
<div class="bg-light py-3">
    <div class="container">
        <div class="row">
            <div class="col-md-12 mb-0">
                <a href="Home.jsp">Home</a> <span class="mx-2 mb-0">/</span>
                <strong class="text-black">Contact</strong>
            </div>
        </div>
    </div>
</div>

<div class="site-section">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <h2 class="h3 mb-5 text-black">Get In Touch</h2>
            </div>
            <div class="col-md-12">

                <form action="AddContact" method="post">

    <div class="p-3 p-lg-5 border">
        <div class="form-group row">
            <div class="col-md-12">
                <label for="c_name" class="text-black">Name <span class="text-danger">*</span></label>
                <!-- Name field read-only -->
                <input type="text" class="form-control" id="c_name" name="c_name" value="<%= session.getAttribute("username")%>" readonly required>
            </div>
        </div>
        <div class="form-group row">
            <div class="col-md-12">
                <label for="c_email" class="text-black">Email <span class="text-danger">*</span></label>
                <!-- Email field read-only -->
                <input type="email" class="form-control" id="c_email" name="c_email" value="<%= session.getAttribute("userEmail") %>" readonly required>
            </div>
        </div>
        <div class="form-group row">
            <div class="col-md-12">
                <label for="c_subject" class="text-black">Subject</label>
                <input type="text" class="form-control" id="c_subject" name="c_subject" required placeholder="Subject">
            </div>
        </div>

        <div class="form-group row">
            <div class="col-md-12">
                <label for="c_message" class="text-black">Message</label>
                <textarea name="c_message" id="c_message" cols="30" rows="7" class="form-control" required placeholder="Message.."></textarea>
            </div>
        </div>

        <!-- Hidden field for u_id -->
        <input type="hidden" name="u_id" value="<%= session.getAttribute("userId") %>">

        <div class="form-group row">
            <div class="col-lg-12">
                <input type="submit" class="btn btn-primary btn-lg btn-block" value="Send Message">
            </div>
        </div>
    </div>
</form>

            </div>

        </div>
    </div>
</div>
<div class="site-section bg-primary py-5">
    <div class="container">
        <div class="row">
            <div class="col-12">
                <h2 class="text-white mb-4">Offices</h2>
            </div>
            <div class="col-lg-4">
                <div class="p-4 bg-white mb-3 office-card">
                    <span class="d-block text-black h6 text-uppercase">New York</span>
                    <p class="mb-0">203 Fake St. Mountain View, San Francisco, California, USA</p>
                </div>
            </div>
            <div class="col-lg-4">
                <div class="p-4 bg-white mb-3 office-card">
                    <span class="d-block text-black h6 text-uppercase">London</span>
                    <p class="mb-0">203 Fake St. Mountain View, San Francisco, California, USA</p>
                </div>
            </div>
            <div class="col-lg-4">
                <div class="p-4 bg-white mb-3 office-card">
                    <span class="d-block text-black h6 text-uppercase">Canada</span>
                    <p class="mb-0">203 Fake St. Mountain View, San Francisco, California, USA</p>
                </div>
            </div>
        </div>
    </div>     
</div>
<%@include file="Footer.jsp" %>
