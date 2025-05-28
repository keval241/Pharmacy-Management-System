package com.admin;

import com.connect.conn;
import java.io.*;
import java.math.BigDecimal;
import java.nio.file.Paths;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.*;

@MultipartConfig
public class edit_medicine extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    int m_id = Integer.parseInt(request.getParameter("m_id"));
    String medicineName = request.getParameter("medicineName");
    int medicineCompany = Integer.parseInt(request.getParameter("medicineCompany"));
    int medicineCategory = Integer.parseInt(request.getParameter("medicineCategory"));
    double medicinePrice = Double.parseDouble(request.getParameter("medicinePrice"));
    int medicineQuantity = Integer.parseInt(request.getParameter("medicineQuantity"));
    String medicineExpireDate = request.getParameter("medicineExpireDate");
    String medicineDescription = request.getParameter("medicineDescription");

    // Handle image
    Part filePart = request.getPart("medicineImage");
    String oldImage = request.getParameter("oldImage");
    String imageFileName = oldImage;  // Default to old image if no new image uploaded

    // Directory to save uploaded images
    String uploadDirPath = "D:\\Main Project\\TrueHealth\\web\\Admin\\img";
    File uploadDir = new File(uploadDirPath);
    if (!uploadDir.exists()) {
        uploadDir.mkdirs();  // Create directory if it doesn't exist
    }

    if (filePart != null && filePart.getSize() > 0) {
        // New image uploaded
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        String filePath = uploadDirPath + File.separator + fileName;

        // Save the file to the specified directory
        filePart.write(filePath);

        // Update imageFileName to the new file name for database storage
        imageFileName = fileName;
    }

    // Update the medicine details in the database
    try {
        Connection con=conn.getConnection();
        String query = "UPDATE medicine SET m_name=?, cmp_id=?, cat_id=?, m_price=?, m_quentity=?, m_expire_date=?, m_description=?, m_image=? WHERE m_id=?";
        PreparedStatement ps = con.prepareStatement(query);
        ps.setString(1, medicineName);
        ps.setInt(2, medicineCompany);
        ps.setInt(3, medicineCategory);
        ps.setDouble(4, medicinePrice);
        ps.setInt(5, medicineQuantity);
        ps.setString(6, medicineExpireDate);
        ps.setString(7, medicineDescription);
        ps.setString(8, imageFileName);  // Store only the filename in the database
        ps.setInt(9, m_id);

        int rowsUpdated = ps.executeUpdate();
        if (rowsUpdated > 0) {
            response.sendRedirect("Admin/view_medicine.jsp");
        } else {
            response.sendRedirect("Admin/edit_medicine.jsp?m_id=" + m_id + "&error=1");
        }
    } catch (SQLException e) {
        e.printStackTrace();
        response.sendRedirect("Admin/edit_medicine.jsp?m_id=" + m_id + "&error=1");
    }
}

}
