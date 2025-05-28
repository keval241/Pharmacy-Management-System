<%-- 
    Document   : profile
    Created on : Feb 20, 2025, 8:36:50 AM
    Author     : VAIDEHI ENTERPRISE
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@include file="Admin/conn.jsp" %>
<%@include file="Headder.jsp" %>

<%
    // Retrieve session
    session = request.getSession(false);
    if (session == null || session.getAttribute("userId") == null) {
        response.sendRedirect("loginForm.jsp");
        return;
    }

//    Integer userId = (Integer) session.getAttribute("userId");
    String userName = "", userMobile = "", userEmail = "", userPincode = "";

    try {
        
        PreparedStatement stmt = con.prepareStatement("SELECT u_name, u_mobile, u_email, u_pincode FROM users WHERE u_id = ?");
        stmt.setInt(1, userId);
        ResultSet rs = stmt.executeQuery();

        if (rs.next()) {
            userName = rs.getString("u_name");
            userMobile = rs.getString("u_mobile");
            userEmail = rs.getString("u_email");
            userPincode = rs.getString("u_pincode");
        }

        rs.close();
        stmt.close();
        con.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Profile | TrueHealth</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
</head>
<body>
<div class="container mt-5">
    <div class="row">
        <div class="col-md-6 offset-md-3">
            <div class="card p-4 shadow-lg">
                <h3 class="text-center">User Profile</h3>
                <hr>
                <p><strong>Name:</strong> <%= userName %></p>
                <p><strong>Mobile:</strong> <%= userMobile %></p>
                <p><strong>Email:</strong> <%= userEmail %></p>
                <p><strong>Pincode:</strong> <%= userPincode %></p>
                <button class="btn btn-primary w-100 mt-3" data-bs-toggle="modal" data-bs-target="#editProfileModal">
                    Edit Profile
                </button>
                <button class="btn btn-danger w-100 mt-2" data-bs-toggle="modal" data-bs-target="#resetPasswordModal">
                    Reset Password
                </button>
            </div>
        </div>
    </div>
</div>

<!-- Edit Profile Modal -->
<div class="modal fade" id="editProfileModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Edit Profile</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <form action="EditProfile" method="post">
                <div class="modal-body">
                    <input type="hidden" name="userId" value="<%= userId %>">
                    <div class="mb-3">
                        <label>Name</label>
                        <input type="text" class="form-control" name="userName" value="<%= userName %>" required>
                    </div>
                    <div class="mb-3">
                        <label>Mobile</label>
                        <input type="text" class="form-control" name="userMobile" value="<%= userMobile %>" required>
                    </div>
                    <div class="mb-3">
                        <label>Email</label>
                        <input type="email" class="form-control" name="userEmail" value="<%= userEmail %>" required>
                    </div>
                    <div class="mb-3">
                        <label>Pincode</label>
                        <input type="text" class="form-control" name="userPincode" value="<%= userPincode %>" required>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-primary">Save Changes</button>
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Reset Password Modal -->
<div class="modal fade" id="resetPasswordModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Reset Password</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <form id="resetPasswordForm" action="user_reset_password" method="post">
                <div class="modal-body">
                    <input type="hidden" name="userId" value="<%= userId %>">
                    <div class="mb-3">
                        <label>Current Password</label>
                        <input type="password" class="form-control" name="currentPassword" required>
                    </div>
                    <div class="mb-3">
                        <label>New Password</label>
                        <input type="password" class="form-control" id="newPassword" name="newPassword" required>
                    </div>
                    <div class="mb-3">
                        <label>Re-enter New Password</label>
                        <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required>
                    </div>
                    <div id="passwordError" class="text-danger"></div>
                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-danger">Reset Password</button>
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- AJAX Script for Password Reset -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    $("#resetPasswordForm").submit(function (event) {
        event.preventDefault(); // Prevent default form submission

        let newPassword = $("#newPassword").val();
        let confirmPassword = $("#confirmPassword").val();

        // Client-side validation
        if (newPassword.length < 6) {
            $("#passwordError").text("New password must be at least 6 characters long.");
            return;
        }

        if (newPassword !== confirmPassword) {
            $("#passwordError").text("New password and confirm password do not match.");
            return;
        }

        $.ajax({
            type: "POST",
            url: "user_reset_password", // ✅ Fixed URL
            data: $(this).serialize(),
            success: function (response) {
                if (response.trim() === "success") {
                    alert("Password updated successfully!");
                    $("#resetPasswordModal").modal("hide");
                    $("#resetPasswordForm")[0].reset(); // Clear form after success
                } else {
                    $("#passwordError").text(response);
                }
            }
        });
    });
</script>
</body>
</html>
<%@include file="Footer.jsp" %>