<%-- 
    Document   : profile
    Created on : Feb 3, 2025, 9:34:15 AM
    Author     : VAIDEHI ENTERPRISE
--%>

<%@page import="com.connect.conn"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@include file="conn.jsp" %>
<%@ include file="Headder.jsp" %>
<% 
    String alertType = (String) session.getAttribute("alertType");
    String alertMessage = (String) session.getAttribute("alertMessage");

    if (alertMessage != null) {
%>
<div class="alert alert-<%= alertType %> alert-dismissible fade show text-center" role="alert">
    <%= alertMessage %>
    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
</div>
<%
        session.removeAttribute("alertType");
        session.removeAttribute("alertMessage");
    }
%>

<script>
// Auto-close alert after 5 seconds
setTimeout(function() {
    let alertBox = document.querySelector(".alert");
    if (alertBox) {
        alertBox.style.transition = "opacity 0.5s ease-out";
        alertBox.style.opacity = "0";
        setTimeout(() => alertBox.remove(), 500);
    }
}, 5000);
</script>

<%    
    // Check session for logged-in user
    String username = (String) session.getAttribute("username");
    if (username == null) {
        response.sendRedirect("login.jsp"); 
        return;
    }

    PreparedStatement ps = null;
    ResultSet rs = null;

    if (con == null) {
        out.println("<p class='text-danger text-center'>Database connection failed!</p>");
        return;
    }

    try {
        String query = "SELECT * FROM admin WHERE a_name=?";
        ps = con.prepareStatement(query);
        ps.setString(1, username);
        rs = ps.executeQuery();

        if (rs.next()) {
%>

<div class="container py-5 animate__animated animate__fadeIn">
    <div class="row justify-content-center">
        <div class="col-md-10 col-lg-8">
            <div class="card shadow-lg rounded border-0">
                <div class="card-header bg-gradient-primary text-white d-flex justify-content-between align-items-center">
                    <h3 class="mb-0">Admin Profile</h3>
                    <a href="Home.jsp" class="btn btn-light btn-sm">
                        <i class="fas fa-arrow-left"></i> Back
                    </a>
                </div>
                <div class="card-body">
                    <div class="row align-items-center">
                        <div class="col-md-4 text-center">
                            <img src="img/profile.jpg" alt="Admin Profile" class="img-fluid rounded-circle mb-3 shadow-lg border border-light" style="width: 120px; height: 120px;">
                            <h5><%= rs.getString("a_name")%></h5>
                            <p class="text-muted"><i class="fas fa-user-tie"></i> Java Developer</p>
                        </div>
                        <div class="col-md-8">
                            <p><strong>Email:</strong> <%= rs.getString("a_email")%></p>
                            <p><strong>Mobile:</strong> <%= rs.getString("a_mobile")%></p>
                            <p><strong>Pin Code:</strong> <%= rs.getString("a_pincode")%></p>
                        </div>
                    </div>
                    <div class="text-center mt-4">
                        <button type="button" class="btn btn-warning fw-bold shadow-lg" data-bs-toggle="modal" data-bs-target="#editProfileModal">Edit Profile</button>
                        <button type="button" class="btn btn-danger fw-bold shadow-lg" data-bs-toggle="modal" data-bs-target="#resetPasswordModal">Reset Password</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Edit Profile Modal -->
<div class="modal fade animate__animated animate__fadeInDown" id="editProfileModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content shadow-lg border-0">
            <div class="modal-header bg-info text-white">
                <h5 class="modal-title">Edit Profile</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <form action="../edit_profile" method="post" onsubmit="return validateProfileForm()">
                <input type="hidden" name="a_id" value="<%= rs.getInt("a_id")%>">
                <div class="modal-body">
                    <div class="form-group">
                        <label>Name</label>
                        <input type="text" class="form-control" name="a_name" value="<%= rs.getString("a_name")%>" required pattern="[A-Za-z\s]{3,50}" title="Only letters and spaces, min 3 characters.">
                    </div>
                    <div class="form-group">
                        <label>Email</label>
                        <input type="email" class="form-control" name="a_email" value="<%= rs.getString("a_email")%>" required>
                    </div>
                    <div class="form-group">
                        <label>Mobile</label>
                        <input type="text" class="form-control" name="a_mobile" value="<%= rs.getString("a_mobile")%>" required pattern="[0-9]{10}" title="Enter a valid 10-digit number.">
                    </div>
                    <div class="form-group">
                        <label>Pin Code</label>
                        <input type="text" class="form-control" name="a_pincode" value="<%= rs.getString("a_pincode")%>" required pattern="[0-9]{6}" title="Enter a valid 6-digit pin code.">
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <button type="submit" class="btn btn-primary">Save Changes</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Reset Password Modal -->
<div class="modal fade animate__animated animate__zoomIn" id="resetPasswordModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content shadow-lg border-0">
            <div class="modal-header bg-danger text-white">
                <h5 class="modal-title">Reset Password</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <form action="../reset_password" method="post" onsubmit="return validatePasswordForm()">
                <div class="modal-body">
                    <div class="form-group">
                        <label>Current Password</label>
                        <input type="password" class="form-control" name="current_password" required minlength="6">
                    </div>
                    <div class="form-group">
                        <label>New Password</label>
                        <input type="password" class="form-control" name="new_password" id="new_password" required minlength="6">
                    </div>
                    <div class="form-group">
                        <label>Re-enter New Password</label>
                        <input type="password" class="form-control" name="confirm_password" id="confirm_password" required minlength="6">
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <button type="submit" class="btn btn-success">Update Password</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
function validatePasswordForm() {
    let newPassword = document.getElementById("new_password").value;
    let confirmPassword = document.getElementById("confirm_password").value;
    let passwordRegex = /^(?=.*[A-Z])(?=.*\d).{6,}$/;

    if (!passwordRegex.test(newPassword)) {
        alert("Password must be at least 6 characters, contain 1 uppercase letter and 1 digit.");
        return false;
    }
    if (newPassword !== confirmPassword) {
        alert("New passwords do not match!");
        return false;
    }
    return true;
}
</script>

<%
        }
    } finally {
        if (rs != null) rs.close();
        if (ps != null) ps.close();
    }
%>
<!-- Chart.js Script -->
<%@ include file="Footer.jsp" %>

