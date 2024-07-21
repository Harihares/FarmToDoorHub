package com.admin;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.Database.Dbconnection;

@WebServlet("/deleteproductservlet")
public class deleteproductservlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int productId = 0;
        try {
            productId = Integer.parseInt(request.getParameter("id"));
        } catch (NumberFormatException e) {
            response.getWriter().println("Invalid product ID.");
            return;
        }

        try (Connection conn = Dbconnection.getConnection()) {
            String sql = "DELETE FROM product_details WHERE i_id = ?";
            try (PreparedStatement statement = conn.prepareStatement(sql)) {
                statement.setInt(1, productId);
                int rowsDeleted = statement.executeUpdate();
                if (rowsDeleted > 0) {
                    response.sendRedirect("admindashboard.jsp");
                } else {
                    response.getWriter().println("No product found with the given ID.");
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
            response.getWriter().println("SQL error: " + ex.getMessage());
        } catch (Exception ex) {
            ex.printStackTrace();
            response.getWriter().println("Error deleting product: " + ex.getMessage());
        }
    }
}
