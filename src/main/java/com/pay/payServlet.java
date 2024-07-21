package com.pay;

import java.sql.Date;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.Database.Dbconnection;
import com.razorpay.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;

@SuppressWarnings("unused")
@WebServlet("/payServlet")
public class payServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RazorpayClient client = null;
        String orderId = null;

        HttpSession session = request.getSession();
        Object c_id = session.getAttribute("c_id");
        int customerid = Integer.parseInt(c_id.toString());

        System.out.println("Processing payment for customer: " + customerid);

        Object item_price = session.getAttribute("item_price");
        int price = (Integer) item_price;

        try {
            int amount = price * 100;
            client = new RazorpayClient("rzp_test_BoOR2YfMncErQ2", "tV00TDxy0DtdcvvdQ2aGycFz");

            JSONObject options = new JSONObject();
            options.put("amount", amount);
            options.put("currency", "INR");
            options.put("receipt", "zxr456");
            options.put("payment_capture", true);

            Order order = client.orders.create(options);
            orderId = order.get("id");
        } catch (RazorpayException e) {
            e.printStackTrace();
        }
        response.setContentType("text/plain");
        response.getWriter().append(orderId);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RazorpayClient client = null;
        try {
            client = new RazorpayClient("rzp_test_BoOR2YfMncErQ2", "tV00TDxy0DtdcvvdQ2aGycFz");

            JSONObject options = new JSONObject();
            options.put("razorpay_payment_id", request.getParameter("razorpay_payment_id"));
            options.put("razorpay_order_id", request.getParameter("razorpay_order_id"));
            options.put("razorpay_signature", request.getParameter("razorpay_signature"));

            boolean SigRes = Utils.verifyPaymentSignature(options, "tV00TDxy0DtdcvvdQ2aGycFz");

            if (SigRes) {
                saveTransactionToDatabase(request, response);
                updateCartAndProductDetails(request);
                response.getWriter().append("Payment successful, details saved, and cart updated");
            } else {
                response.getWriter().append("Payment verification failed");
            }
        } catch (RazorpayException e) {
            e.printStackTrace();
            response.getWriter().append("Payment failed due to server error");
        }
    }

    private void saveTransactionToDatabase(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        int customerid = Integer.parseInt(session.getAttribute("c_id").toString());
        int price = (Integer) session.getAttribute("item_price");
        int quantity = (Integer) session.getAttribute("quantity");
        String itemName = (String) session.getAttribute("itemName");
        String paymentId = request.getParameter("razorpay_payment_id");
        Date transactionDate = new Date(System.currentTimeMillis()); 

        String query = "INSERT INTO transactions (customer_id, item_price, item_quantity, item_name, payment_id, transaction_date) VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection conn = Dbconnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {

            pstmt.setInt(1, customerid);
            pstmt.setInt(2, price);
            pstmt.setInt(3, quantity);
            pstmt.setString(4, itemName);
            pstmt.setString(5, paymentId);
            pstmt.setDate(6, transactionDate); 

            int rowsAffected = pstmt.executeUpdate();
            if (rowsAffected > 0) {
                System.out.println("Transaction details saved successfully.");
                response.sendRedirect("thankyou.jsp");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }


    private void updateCartAndProductDetails(HttpServletRequest request) {
        HttpSession session = request.getSession();
        int customerid = Integer.parseInt(session.getAttribute("c_id").toString());
        String itemName = (String) session.getAttribute("itemName");
        int quantity = (Integer) session.getAttribute("quantity");

        String deleteCartQuery = "DELETE FROM cart WHERE customer_id = ? AND item_name = ?";
        String updateProductQuery = "UPDATE products SET quantity = quantity - ? WHERE item_name = ?";

        try (Connection conn = Dbconnection.getConnection();
             PreparedStatement deleteCartStmt = conn.prepareStatement(deleteCartQuery);
             PreparedStatement updateProductStmt = conn.prepareStatement(updateProductQuery)) {

           
            deleteCartStmt.setInt(1, customerid);
            deleteCartStmt.setString(2, itemName);
            deleteCartStmt.executeUpdate();

            
            updateProductStmt.setInt(1, quantity);
            updateProductStmt.setString(2, itemName);
            updateProductStmt.executeUpdate();

            System.out.println("Cart and product details updated successfully.");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
