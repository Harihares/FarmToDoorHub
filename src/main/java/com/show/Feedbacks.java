package com.show;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;

import com.Database.Dbconnection;
import com.twilio.http.Response;

import okhttp3.Request;

/**
 * Servlet implementation class Feedbacks
 */
@WebServlet("/Feedbacks")
public class Feedbacks extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final int Customer_id = 0;
	public List<Feedback> getProductFeedback(int productId) {
        List<Feedback> feedbackList = new ArrayList<>();
        try {
            Connection conn = Dbconnection.getConnection();    
            String sql = "SELECT customer_name, feedback FROM feedback WHERE product_id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, productId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                String customerName = rs.getString("customer_name");
                String feedbackText = rs.getString("feedback");
                Feedback feedback = new Feedback(Customer_id, customerName, feedbackText);
                feedbackList.add(feedback);
            }
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return feedbackList;
    }
}