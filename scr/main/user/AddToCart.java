package com.user;
import com.connect.conn;
import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class AddToCart extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get the user ID from the session
        HttpSession session = request.getSession();
        Integer uId = (Integer) session.getAttribute("userId");

        // Get the medicine ID and quantity from the request parameters
        String mIdParam = request.getParameter("m_id");
        String mQuantityParam = request.getParameter("m_quantity");

        if (uId == null) {
            response.getWriter().println("<p>You need to log in first to add items to your cart.</p>");
            return;
        }

        // Database connection setup (adjust connection details)
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            con = conn.getConnection();
            if (mIdParam != null && mQuantityParam != null) {
                int mId = Integer.parseInt(mIdParam); // Medicine ID
                int mQuantity = Integer.parseInt(mQuantityParam); // Quantity to add

                // Fetch the available stock quantity from the database
                String query = "SELECT m_quentity, m_price, m_name FROM medicine WHERE m_id = ?";
                ps = con.prepareStatement(query);
                ps.setInt(1, mId);
                rs = ps.executeQuery();

                if (rs.next()) {
                    int availableQuantity = rs.getInt("m_quentity");
                    double price = rs.getDouble("m_price");
                    String mName = rs.getString("m_name");

                    // Check if the requested quantity is available
                    if (mQuantity <= availableQuantity) {
                        // Check if the item already exists in the cart for this user
                        String checkCartQuery = "SELECT * FROM cart WHERE u_id = ? AND m_id = ?";
                        ps = con.prepareStatement(checkCartQuery);
                        ps.setInt(1, uId);
                        ps.setInt(2, mId);
                        rs = ps.executeQuery();

                        if (rs.next()) {
                            // If the item is already in the cart, update the quantity
                            int existingQuantity = rs.getInt("quantity");
                            int newQuantity = existingQuantity + mQuantity;

                            String updateCartQuery = "UPDATE cart SET quantity = ? WHERE u_id = ? AND m_id = ?";
                            ps = con.prepareStatement(updateCartQuery);
                            ps.setInt(1, newQuantity);
                            ps.setInt(2, uId);
                            ps.setInt(3, mId);
                            ps.executeUpdate();
                        } else {
                            // If the item is not in the cart, insert a new record
                            String addToCartQuery = "INSERT INTO cart (u_id, m_id, quantity) VALUES (?, ?, ?)";
                            ps = con.prepareStatement(addToCartQuery);
                            ps.setInt(1, uId);
                            ps.setInt(2, mId);
                            ps.setInt(3, mQuantity);
                            ps.executeUpdate();
                        }

                        // Redirect to the cart page after successful addition
                        response.sendRedirect("Cart.jsp");

                    } else {
                        // Quantity exceeds available stock, show an alert message
                        response.getWriter().println("<script type='text/javascript'>");
                        response.getWriter().println("alert('Quantity exceeds available stock!');");
                        response.getWriter().println("window.history.back();");
                        response.getWriter().println("</script>");
                    }
                } else {
                    response.getWriter().println("<p>Medicine not found!</p>");
                }
            } else {
                response.getWriter().println("<p>Invalid product or quantity!</p>");
            }

        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().println("<p>Error accessing the database!</p>");
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);  // Delegate GET requests to the doPost method
    }
}
