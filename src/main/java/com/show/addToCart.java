package com.show;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.Database.Dbconnection;

@WebServlet("/addToCart")
public class addToCart extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        int product_id = Integer.parseInt(session.getAttribute("p_id").toString());
        int customer_id = Integer.parseInt(session.getAttribute("c_id").toString());

        if (customer_id == 0 || product_id == 0) {
            response.sendRedirect("login.jsp");
            return;
        }

        int quantity = Integer.parseInt(request.getParameter("quantity"));
        try {
            handleAddToCart(response, product_id, customer_id, quantity);
        } catch (SQLException e) {
            e.printStackTrace();
            sendErrorResponse(response, "An error occurred while processing your request. Please try again later.");
        }
    }

    private void handleAddToCart(HttpServletResponse response, int product_id, int customer_id, int quantity) throws SQLException, IOException {
        int originalPrice = fetchOriginalPrice(product_id);
        int originalQuantity = fetchOriginalQuantity(product_id);
        String productName = fetchProductName(product_id);

        if (quantity > originalQuantity) {
            sendErrorResponse(response, "Sorry, only " + originalQuantity + " available");
            return;
        }

        int totalPrice = originalPrice * quantity;
        int updatedQuantity = originalQuantity - quantity;

        if (checkIfItemExists(productName, customer_id)) {
            updateProductDetails(updatedQuantity, product_id);
            updateCartItem(productName, customer_id, quantity, totalPrice);
        } else {
            updateProductDetails(updatedQuantity, product_id);
            addToCartItem(productName, quantity, totalPrice, customer_id, product_id);
        }

        sendSuccessResponse(response, "Item added to cart!");
    }

    private boolean checkIfItemExists(String productName, int customer_id) throws SQLException {
        String query = "SELECT item_name FROM cart WHERE customer_id = ? AND item_name = ?";
        try (PreparedStatement statement = Dbconnection.prepareStatement(query)) {
            statement.setInt(1, customer_id);
            statement.setString(2, productName);
            ResultSet resultSet = statement.executeQuery();
            return resultSet.next();
        }
    }

    private int fetchOriginalPrice(int productId) throws SQLException {
        String query = "SELECT i_price FROM product_details WHERE i_id=?";
        try (PreparedStatement statement = Dbconnection.prepareStatement(query)) {
            statement.setInt(1, productId);
            ResultSet resultSet = statement.executeQuery();
            if (resultSet.next()) {
                return resultSet.getInt("i_price");
            }
            return 0;
        }
    }

    private int fetchOriginalQuantity(int productId) throws SQLException {
        String query = "SELECT i_available FROM product_details WHERE i_id=?";
        try (PreparedStatement statement = Dbconnection.prepareStatement(query)) {
            statement.setInt(1, productId);
            ResultSet resultSet = statement.executeQuery();
            if (resultSet.next()) {
                return resultSet.getInt("i_available");
            }
            return 0;
        }
    }

    private String fetchProductName(int productId) throws SQLException {
        String query = "SELECT i_name FROM product_details WHERE i_id=?";
        try (PreparedStatement statement = Dbconnection.prepareStatement(query)) {
            statement.setInt(1, productId);
            ResultSet resultSet = statement.executeQuery();
            if (resultSet.next()) {
                return resultSet.getString("i_name");
            }
            return null;
        }
    }

    private void updateProductDetails(int updatedQuantity, int productId) throws SQLException {
        String query = "UPDATE product_details SET i_available=? WHERE i_id=?";
        try (PreparedStatement statement = Dbconnection.prepareStatement(query)) {
            statement.setInt(1, updatedQuantity);
            statement.setInt(2, productId);
            statement.executeUpdate();
        }
    }

    private void updateCartItem(String productName, int customerId, int quantity, int totalPrice) throws SQLException {
        String selectQuery = "SELECT cart_item_id, item_quantity, item_price FROM cart WHERE item_name=? AND customer_id=?";
        try (PreparedStatement selectStmt = Dbconnection.prepareStatement(selectQuery)) {
            selectStmt.setString(1, productName);
            selectStmt.setInt(2, customerId);
            ResultSet rs = selectStmt.executeQuery();
            if (rs.next()) {
                int cartId = rs.getInt("cart_item_id");
                int currentQuantity = rs.getInt("item_quantity");
                int currentPrice = rs.getInt("item_price");

                int updatedQuantity = currentQuantity + quantity;
                int updatedPrice = currentPrice + totalPrice;

                String updateQuery = "UPDATE cart SET item_quantity=?, item_price=? WHERE cart_item_id=?";
                try (PreparedStatement updateStmt = Dbconnection.prepareStatement(updateQuery)) {
                    updateStmt.setInt(1, updatedQuantity);
                    updateStmt.setInt(2, updatedPrice);
                    updateStmt.setInt(3, cartId);
                    updateStmt.executeUpdate();
                }
            }
        }
    }

    private void addToCartItem(String productName, int quantity, int price, int customerId, int productId) throws SQLException {
        String selectImgQuery = "SELECT i_img FROM product_details WHERE i_id=?";
        try (PreparedStatement selectStmt = Dbconnection.prepareStatement(selectImgQuery)) {
            selectStmt.setInt(1, productId);
            ResultSet rs = selectStmt.executeQuery();
            if (rs.next()) {
                InputStream imageStream = rs.getBinaryStream("i_img");
                String insertQuery = "INSERT INTO cart (item_name, item_quantity, item_price, customer_id, item_image) VALUES (?, ?, ?, ?, ?)";
                try (PreparedStatement insertStmt = Dbconnection.prepareStatement(insertQuery)) {
                    insertStmt.setString(1, productName);
                    insertStmt.setInt(2, quantity);
                    insertStmt.setInt(3, price);
                    insertStmt.setInt(4, customerId);
                    insertStmt.setBinaryStream(5, imageStream);
                    insertStmt.executeUpdate();
                }
            }
        }
    }

    private int fetchCartItemQuantity(int customerId, int productId) throws SQLException {
        String query = "SELECT item_quantity FROM cart WHERE customer_id = ? AND item_name = (SELECT i_name FROM product_details WHERE i_id=?)";
        try (PreparedStatement statement = Dbconnection.prepareStatement(query)) {
            statement.setInt(1, customerId);
            statement.setInt(2, productId);
            ResultSet resultSet = statement.executeQuery();
            if (resultSet.next()) {
                return resultSet.getInt("item_quantity");
            }
            return 0;
        }
    }

    private void removeItemFromCart(int customerId, int productId) throws SQLException {
        String query = "DELETE FROM cart WHERE customer_id = ? AND item_name = (SELECT i_name FROM product_details WHERE i_id=?)";
        try (PreparedStatement statement = Dbconnection.prepareStatement(query)) {
            statement.setInt(1, customerId);
            statement.setInt(2, productId);
            statement.executeUpdate();
        }
    }

    private void incrementProductQuantity(int productId, int quantity) throws SQLException {
        String query = "UPDATE product_details SET i_available = i_available + ? WHERE i_id = ?";
        try (PreparedStatement statement = Dbconnection.prepareStatement(query)) {
            statement.setInt(1, quantity);
            statement.setInt(2, productId);
            statement.executeUpdate();
        }
    }

    private void sendSuccessResponse(HttpServletResponse response, String message) throws IOException {
        response.setContentType("text/plain");
        PrintWriter out = response.getWriter();
        out.print(message);
        out.close();
    }

    private void sendErrorResponse(HttpServletResponse response, String message) throws IOException {
        response.setContentType("text/plain");
        PrintWriter out = response.getWriter();
        out.print(message);
        out.close();
    }

    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        int product_id = Integer.parseInt(session.getAttribute("p_id").toString());
        int customer_id = Integer.parseInt(session.getAttribute("c_id").toString());

        if (customer_id == 0 || product_id == 0) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            int quantity = fetchCartItemQuantity(customer_id, product_id); // Retrieve quantity of deleted product from cart
            removeItemFromCart(customer_id, product_id); // Remove product from cart
            incrementProductQuantity(product_id, quantity); // Increment product quantity in product details

            response.setContentType("text/plain");
            PrintWriter out = response.getWriter();
            out.print("Item removed from cart and product details updated!");
            out.close();
        } catch (SQLException e) {
            e.printStackTrace();
            response.setContentType("text/plain");
            PrintWriter out = response.getWriter();
            out.print("An error occurred while processing your request. Please try again later.");
            out.close();
        }
    }
}
