package com.cart;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.Database.Dbconnection;

@WebServlet("/removecartItem")
public class removecartItem extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int customer_id = Integer.parseInt(request.getParameter("c_id"));
        int cartitemid = Integer.parseInt(request.getParameter("item_name"));
        String item_name = null;
        int cartItem_quantity = 0;

        Connection connection = null;
        PreparedStatement selectStatement = null;
        PreparedStatement deleteStatement = null;

        try {
            connection = Dbconnection.getConnection();

            String selectqry = "SELECT item_name, item_quantity FROM cart WHERE cart_item_id = ? AND customer_id = ?";
            selectStatement = connection.prepareStatement(selectqry);
            selectStatement.setInt(1, cartitemid);
            selectStatement.setInt(2, customer_id);
            ResultSet rs = selectStatement.executeQuery();

            if (rs.next()) {
                item_name = rs.getString("item_name");
                cartItem_quantity = rs.getInt("item_quantity");
            }

            if (item_name != null) {
                updateProductDetails(connection, item_name, cartItem_quantity);

                String deleteqry = "DELETE FROM cart WHERE cart_item_id = ? AND customer_id = ?";
                deleteStatement = connection.prepareStatement(deleteqry);
                deleteStatement.setInt(1, cartitemid);
                deleteStatement.setInt(2, customer_id);
                int rowsAffected = deleteStatement.executeUpdate();

                if (rowsAffected > 0) {
                    response.sendRedirect("vcart.jsp?cid=" + customer_id);
                } else {
                    response.getWriter().println("Failed to remove item from cart.");
                }
            } else {
                response.getWriter().println("Item not found in cart.");
            }

        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            try {
                if (selectStatement != null) selectStatement.close();
                if (deleteStatement != null) deleteStatement.close();
                if (connection != null) connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    private void updateProductDetails(Connection connection, String item_name, int quantity) throws SQLException {
        int available = 0;
        String selectqry = "SELECT i_available FROM product_details WHERE i_name = ?";
        PreparedStatement selectStatement = connection.prepareStatement(selectqry);
        selectStatement.setString(1, item_name);
        ResultSet rs = selectStatement.executeQuery();

        if (rs.next()) {
            available = rs.getInt("i_available");
        }
        rs.close();
        selectStatement.close();

        available += quantity;
        String updateqry = "UPDATE product_details SET i_available = ? WHERE i_name = ?";
        PreparedStatement updateStatement = connection.prepareStatement(updateqry);
        updateStatement.setInt(1, available);
        updateStatement.setString(2, item_name);
        updateStatement.executeUpdate();
        updateStatement.close();
    }
}
