package com.user;
import com.connect.conn;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class payment extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        if (userId == null) {
            response.sendRedirect("loginForm.jsp");
            return;
        }

        try {
            String orderIdParam = request.getParameter("orderId");
            String paymentMethod = request.getParameter("paymentMethod");
            String totalAmountParam = request.getParameter("totalAmount");

            if (orderIdParam == null || paymentMethod == null || totalAmountParam == null) {
                response.sendRedirect("errorPage.jsp");
                return;
            }

            int orderId = Integer.parseInt(orderIdParam);
            BigDecimal totalAmount = new BigDecimal(totalAmountParam.replaceAll(",", ""));

            int paymentStatus = ("upiOption".equals(paymentMethod) || "netBankingOption".equals(paymentMethod)) ? 1 : 0;

            String paymentMethodText;
            switch (paymentMethod) {
                case "cashOption": paymentMethodText = "Cash on Delivery"; break;
                case "upiOption": paymentMethodText = "UPI"; break;
                case "netBankingOption": paymentMethodText = "Net Banking"; break;
                default:
                    response.sendRedirect("errorPage.jsp");
                    return;
            }

            try (Connection con = conn.getConnection()) {
                con.setAutoCommit(false);

                try (PreparedStatement psPayment = con.prepareStatement(
                        "INSERT INTO payment (u_id, o_id, pay_amount, pay_method, pay_status, pay_date) VALUES (?, ?, ?, ?, ?, NOW())");
                     PreparedStatement psOrderUpdate = con.prepareStatement(
                        "UPDATE orders SET o_status = 1 WHERE o_id = ?")) {

                    psPayment.setInt(1, userId);
                    psPayment.setInt(2, orderId);
                    psPayment.setBigDecimal(3, totalAmount);
                    psPayment.setString(4, paymentMethodText);
                    psPayment.setInt(5, paymentStatus);
                    psPayment.executeUpdate();

                    psOrderUpdate.setInt(1, orderId);
                    psOrderUpdate.executeUpdate();

                    con.commit();
                } catch (SQLException e) {
                    con.rollback();
                    throw e;
                }
            }

            // ✅ Redirect to thank you page after successful payment
            response.sendRedirect("thank-you.jsp");

        } catch (NumberFormatException | SQLException e) {
            e.printStackTrace();
            response.sendRedirect("errorPage.jsp");
        }
    }
}

