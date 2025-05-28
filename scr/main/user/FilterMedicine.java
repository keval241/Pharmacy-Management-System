package com.user;
import com.connect.conn;
import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class FilterMedicine extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get the selected company and category IDs from the form
        String companyId = request.getParameter("company");
        String categoryId = request.getParameter("category");

        // Database connection setup
        try (Connection con = conn.getConnection()) {
            String query = "SELECT m.m_id, m.m_name, m.m_price, m.m_quentity, m.m_image, " +
                           "c.cmp_name, cat.cat_name " +
                           "FROM medicine m " +
                           "JOIN company c ON m.cmp_id = c.cmp_id " +
                           "JOIN category cat ON m.cat_id = cat.cat_id " +
                           "WHERE c.cmp_status = 1 AND cat.cat_status = 1 ";

            boolean hasCompany = companyId != null && !companyId.isEmpty();
            boolean hasCategory = categoryId != null && !categoryId.isEmpty();

            if (hasCompany) {
                query += "AND m.cmp_id = ? ";
            }
            if (hasCategory) {
                query += "AND m.cat_id = ? ";
            }

            PreparedStatement stmt = con.prepareStatement(query);

            int paramIndex = 1;
            if (hasCompany) {
                stmt.setString(paramIndex++, companyId);
            }
            if (hasCategory) {
                stmt.setString(paramIndex++, categoryId);
            }

            ResultSet rs = stmt.executeQuery();
            request.setAttribute("resultSet", rs);

            RequestDispatcher dispatcher = request.getRequestDispatcher("Shop.jsp");
            dispatcher.forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp"); // Redirect to an error page if needed
        }
    }
}

