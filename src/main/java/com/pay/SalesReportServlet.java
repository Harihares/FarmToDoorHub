package com.pay;

import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.Database.Dbconnection;

@WebServlet("/SalesReportServlet")
public class SalesReportServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
	private ServletRequest session;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<SalesReport> salesReports = new ArrayList<>();

        System.out.println("sdfghjkl;./");
        String query ="SELECT transaction_date, item_name, SUM(item_quantity) AS total_quantity_sold, SUM(item_price * item_quantity) AS total_revenue "
                     + "FROM transactions "
                     + "GROUP BY transaction_date, item_name";

        try (Connection conn = Dbconnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                Date transactionDate = rs.getDate("transaction_date");
                String itemName = rs.getString("item_name");
                int totalQuantitySold = rs.getInt("total_quantity_sold");
                int totalRevenue = rs.getInt("total_revenue");
                
                SalesReport report = new SalesReport(transactionDate, itemName, totalQuantitySold, totalRevenue);
                salesReports.add(report);
                System.out.println("xfcgvbhjnkml,ddknffjkgndskj");
                System.out.println(report.getItemName());
                System.out.println(report.getTotalQuantitySold());
                System.out.println(report.getTotalRevenue());
            }

            if (salesReports.isEmpty()) {
                System.out.println("No sales data found.");
            } else {
                System.out.println("Sales data found: " + salesReports.size() + " records.");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        request.setAttribute("salesReports", salesReports);
        RequestDispatcher dispacther=request.getRequestDispatcher("salesReport.jsp");
        dispacther.forward(request, response);
    }

	public ServletRequest getSession() {
		return session;
	}

	public void setSession(ServletRequest session) {
		this.session = session;
	}
    }