package com.user;

import com.connect.conn;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.http.*;

public class CheckOut extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        if (userId == null) {
            response.sendRedirect("loginForm.jsp");
            return;
        }

        String address = request.getParameter("address");

        Connection con = null;
        PreparedStatement psOrder = null, psCart = null, psClearCart = null, psUpdateStock = null;
        ResultSet rs = null;
        int orderId = -1;

        try {
            con = conn.getConnection();
            con.setAutoCommit(false); // Start transaction

            // Fetch cart items with available stock
            String cartQuery = "SELECT c.m_id, c.quantity, m.m_name, m.m_price, m.m_quentity FROM cart c "
                    + "INNER JOIN medicine m ON c.m_id = m.m_id WHERE c.u_id = ?";
            psCart = con.prepareStatement(cartQuery);
            psCart.setInt(1, userId);
            rs = psCart.executeQuery();

            StringBuilder medicineNames = new StringBuilder();
            StringBuilder medicineQuantities = new StringBuilder();
            StringBuilder medicinePrices = new StringBuilder();
            double grandTotal = 0;

            while (rs.next()) {
                int medicineId = rs.getInt("m_id");
                String medicineName = rs.getString("m_name");
                int quantity = rs.getInt("quantity");
                double pricePerUnit = rs.getDouble("m_price");
                int availableStock = rs.getInt("m_quentity");

                if (quantity > availableStock) {
                    throw new Exception("Not enough stock for " + medicineName);
                }

                double totalAmount = pricePerUnit * quantity;

                // Append medicine details as comma-separated values
                if (medicineNames.length() > 0) {
                    medicineNames.append(", ");
                    medicineQuantities.append(", ");
                    medicinePrices.append(", ");
                }
                medicineNames.append(medicineName);
                medicineQuantities.append(quantity);
                medicinePrices.append(pricePerUnit);

                grandTotal += totalAmount;

                // Deduct stock
                String updateStockQuery = "UPDATE medicine SET m_quentity = m_quentity - ? WHERE m_id = ?";
                psUpdateStock = con.prepareStatement(updateStockQuery);
                psUpdateStock.setInt(1, quantity);
                psUpdateStock.setInt(2, medicineId);
                psUpdateStock.executeUpdate();
            }

            // Insert order
            String orderQuery = "INSERT INTO orders (u_id, m_name, o_address, m_price_per_unit, o_quantity, o_amount, o_status, o_date) "
                    + "VALUES (?, ?, ?, ?, ?, ?, ?, NOW())";
            psOrder = con.prepareStatement(orderQuery, Statement.RETURN_GENERATED_KEYS);
            psOrder.setInt(1, userId);
            psOrder.setString(2, medicineNames.toString());
            psOrder.setString(3, address);
            psOrder.setString(4, medicinePrices.toString());
            psOrder.setString(5, medicineQuantities.toString());
            psOrder.setDouble(6, grandTotal);
            psOrder.setInt(7, 0); // Order status: Pending
            psOrder.executeUpdate();

            ResultSet generatedKeys = psOrder.getGeneratedKeys();
            if (generatedKeys.next()) {
                orderId = generatedKeys.getInt(1);
            }

            psClearCart = con.prepareStatement("DELETE FROM cart WHERE u_id = ?");
            psClearCart.setInt(1, userId);
            psClearCart.executeUpdate();

            con.commit(); // Commit transaction

            // Redirect to payment
            response.sendRedirect("Payment.jsp?o_id=" + orderId);

        } catch (Exception e) {
            e.printStackTrace();
            if (con != null) {
                try {
                    con.rollback(); // Rollback on error
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
        } finally {
            try {
                if (rs != null) rs.close();
                if (psCart != null) psCart.close();
                if (psOrder != null) psOrder.close();
                if (psClearCart != null) psClearCart.close();
                if (psUpdateStock != null) psUpdateStock.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
