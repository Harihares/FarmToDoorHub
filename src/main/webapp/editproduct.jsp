<%@ page import="java.sql.*" %>
<%@ page import="com.Database.Dbconnection" %>
<%@ page import="java.util.Base64"%>
<%@ page import="java.lang.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Product Entry Form</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f2f2f2;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .form-container {
            background-color: #fff;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 300px;
        }
        .form-container h2 {
            margin-bottom: 20px;
        }
        .form-container label {
            display: block;
            margin-bottom: 5px;
        }
        .form-container input[type="text"],
        .form-container input[type="number"],
        .form-container input[type="file"] {
            width: 100%;
            padding: 8px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        .form-container input[type="submit"] {
            background-color: #4CAF50;
            color: white;
            padding: 10px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .form-container input[type="submit"]:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
    <div class="form-container">
        <h2>Product Entry Form</h2>
        <%
        int productid = Integer.parseInt(request.getParameter("id"));
        try {
            Connection conn = Dbconnection.getConnection();
            String query = "SELECT * FROM product_details WHERE i_id=?";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setInt(1, productid);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                String p_name = rs.getString("i_name");
                int price = rs.getInt("i_price");

                Blob imageBlob = rs.getBlob("i_img");
                byte[] imageBytes = imageBlob.getBytes(1, (int) imageBlob.length());
                String base64Image = Base64.getEncoder().encodeToString(imageBytes);

                int avail = rs.getInt("i_available");
        %>
        
        <form action="editproductservlet" method="get" enctype="multipart/form-data">
            <label for="productName">Product Name:</label>
            <input type="text" id="productName" name="productName" value="<%= p_name %>" required>

            <label for="productPrice">Price:</label>
            <input type="number" id="productPrice" name="productPrice" step="0.01" value="<%= price %>" required>

            <label for="productQuantity">Quantity:</label>
            <input type="number" id="productQuantity" name="productQuantity" value="<%= avail %>" required>

            <input type="submit" value="Submit">
        </form>
        <%
            }
            rs.close();
            stmt.close();
            conn.close();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        %>
    </div>
</body>
</html>
