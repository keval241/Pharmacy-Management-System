package com.admin;

import com.connect.conn;
import java.io.*;
import java.math.BigDecimal;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.*;

@MultipartConfig
public class AddMedicine extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        // Get form data
        String medicineName = request.getParameter("medicineName");
        String medicineCompany = request.getParameter("medicineCompany");
        String medicineCategory = request.getParameter("medicineCategory");
        String medicinePrice = request.getParameter("medicinePrice");
        String medicineUnits = request.getParameter("medicineQuantity");
        String medicineExpireDate = request.getParameter("medicineExpireDate");
        String medicineDescription = request.getParameter("medicineDescription");

        // Handle file upload
        Part filePart = request.getPart("medicineImage");
        String fileName = getFileName(filePart);

        if (fileName == null || fileName.isEmpty()) {
            out.println("<script>alert('Please select an image file!'); location='Admin/view_medicine.jsp';</script>");
            return;
        }

        // Define the path to the Admin/img folder
        String uploadDirPath = "D:\\Main Project\\TrueHealth\\web\\Admin\\img"; // Hardcoded for testing
        File uploadDir = new File(uploadDirPath);
        if (!uploadDir.exists()) {
            boolean created = uploadDir.mkdirs();  // Create directory if it doesn't exist
            if (created) {
                System.out.println("Directory created: " + uploadDirPath);
            } else {
                System.out.println("Failed to create directory: " + uploadDirPath);
                out.println("<script>alert('Failed to create upload directory!'); location='Admin/view_medicine.jsp';</script>");
                return;
            }
        }

        // Ensure unique file name to avoid overwriting
        String uniqueFileName = System.currentTimeMillis() + "_" + fileName;
        String filePath = uploadDirPath + File.separator + uniqueFileName;

        // Save the file to the Admin/img directory
        try (FileOutputStream fos = new FileOutputStream(filePath);
             InputStream fileContent = filePart.getInputStream()) {

            byte[] buffer = new byte[1024];
            int bytesRead;
            while ((bytesRead = fileContent.read(buffer)) != -1) {
                fos.write(buffer, 0, bytesRead);
            }
            System.out.println("File saved successfully at: " + filePath);
        } catch (IOException e) {
            e.printStackTrace();
            out.println("<script>alert('Error saving the image!'); location='Admin/view_medicine.jsp';</script>");
            return;
        }

        // Save the relative path for the database
        String imagePath =  uniqueFileName;

        // Insert medicine details into the database
        try (Connection con = conn.getConnection();
             PreparedStatement ps = con.prepareStatement(
                 "INSERT INTO medicine (m_name, cmp_id, cat_id, m_price, m_quentity, m_expire_date, m_description, m_image) VALUES (?, ?, ?, ?, ?, ?, ?, ?)"
             )) {

            ps.setString(1, medicineName);
            ps.setInt(2, Integer.parseInt(medicineCompany));
            ps.setInt(3, Integer.parseInt(medicineCategory));
            ps.setBigDecimal(4, new BigDecimal(medicinePrice));
            ps.setInt(5, Integer.parseInt(medicineUnits));

            if (medicineExpireDate != null && !medicineExpireDate.isEmpty()) {
                ps.setDate(6, java.sql.Date.valueOf(medicineExpireDate));
            } else {
                ps.setNull(6, java.sql.Types.DATE);
            }

            ps.setString(7, medicineDescription);
            ps.setString(8, imagePath);

            int result = ps.executeUpdate();
            if (result > 0) {
                out.println("<script>alert('Medicine added successfully!'); location='Admin/view_medicine.jsp';</script>");
            } else {
                out.println("<script>alert('Failed to add medicine!'); location='Admin/view_medicine.jsp';</script>");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            out.println("<script>alert('Database error occurred!'); location='Admin/view_medicine.jsp';</script>");
        }
    }

    // Helper method to get the uploaded file name
    private String getFileName(Part part) {
        for (String cd : part.getHeader("content-disposition").split(";")) {
            if (cd.trim().startsWith("filename")) {
                return cd.substring(cd.indexOf('=') + 2, cd.length() - 1).replace("\\", "/");
            }
        }
        return null;
    }
}