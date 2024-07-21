package com.cart;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.Database.Dbconnection;

@WebServlet("/totalPrice")
public class totalprice extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            Connection conn = Dbconnection.getConnection();
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT SUM(item_quantity * item_price) AS total_price FROM cart");

            int totalPrice = 0;
            if (rs.next()) {
                totalPrice = rs.getInt("total_price");
            }

            PrintWriter out = response.getWriter();
            out.println(totalPrice);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }
}
