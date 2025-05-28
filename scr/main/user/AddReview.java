package com.user;
import com.connect.conn;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/AddReviewServlet")
public class AddReview extends HttpServlet {
    private static final long serialVersionUID = 1L;
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve form data
        PrintWriter out=response.getWriter();
        Connection con=conn.getConnection();
        int rating = Integer.parseInt(request.getParameter("rating"));
        out.println(rating);
        String reviewComment = request.getParameter("r_comment");
        out.println(reviewComment);
        String medicineIdParam = request.getParameter("m_id");
String userIdParam = request.getParameter("u_id");

if (medicineIdParam == null || userIdParam == null) {
    out.println("Error: m_id or u_id is null.");
    response.sendRedirect("error.jsp");
    return;
}

int medicineId = Integer.parseInt(medicineIdParam);
int userId = Integer.parseInt(userIdParam);

        PreparedStatement pstmt = null;
        con=conn.getConnection();
        try {
            // SQL query to insert review
            String sql = "INSERT INTO review(u_id , m_id, rating, r_comment) VALUES(?, ?, ?, ?)";
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, userId);
            pstmt.setInt(2, medicineId);
            pstmt.setInt(3, rating);
            pstmt.setString(4, reviewComment);

            // Execute the query
            int rowsInserted = pstmt.executeUpdate();
            if (rowsInserted > 0) {
                response.sendRedirect("Shop-single.jsp?m_id="+medicineId);  // Redirect to success page
            } else {
                response.sendRedirect("error.jsp");    // Redirect to error page
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        } finally {
            try {
                if (pstmt != null) pstmt.close();
                if (con != null) con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
//        con = conn.getConnection();
    }
}
