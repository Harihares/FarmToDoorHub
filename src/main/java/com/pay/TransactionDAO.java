package com.pay;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.Database.Dbconnection;


public class TransactionDAO {
    public List<Transaction> getTransactionsByCustomerId(int customerId) {
        List<Transaction> transactions = new ArrayList<>();
        String query = "SELECT * FROM transactions WHERE customer_id = ?";

        try (Connection conn = Dbconnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setInt(1, customerId);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                Transaction transaction = new Transaction();
                transaction.setCustomerId(rs.getInt("customer_id"));
                transaction.setItemPrice(rs.getInt("item_price"));
                transaction.setItemQuantity(rs.getInt("item_quantity"));
                transaction.setItemName(rs.getString("item_name"));
                transaction.setPaymentId(rs.getString("payment_id"));
                transaction.setTransactionDate(rs.getDate("transaction_date"));
                transactions.add(transaction);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return transactions;
    }
}
