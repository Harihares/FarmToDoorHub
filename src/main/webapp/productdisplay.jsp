<%@ page import="java.sql.*" %>
<%@ page import="com.Database.Dbconnection" %>
<%@ page import="java.util.List"%>
<%@ page import ="java.sql.Blob"%>
<%@ page import="java.util.Base64"%>
<%@ page import="java.lang.*"%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.io.*, javax.sql.*, javax.naming.*, java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Product List</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #f9f9f9;
        }
        h2 {
            text-align: center;
            margin-bottom: 20px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        table, th, td {
            border: 1px solid #ddd;
        }
        th, td {
            padding: 12px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        .action-buttons a {
            display: inline-block;
            margin-right: 10px;
            padding: 6px 12px;
            text-decoration: none;
            color: white;
            border-radius: 4px;
        }
        .update-button {
            background-color: #4CAF50;
        }
        .delete-button {
            background-color: #f44336;
        }
        .delete-button:hover {
            background-color: #e53935;
        }
        .update-button:hover {
            background-color: #43a047;
        }
    </style>
</head>
<body>
    <h2>Product List</h2>
    <table>
        <thead>
            <tr>
                <th>Product ID</th>
                <th>Product Name</th>
                <th>Price</th>
                <th>Image</th>
                <th>Available</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <%
                Connection conn = null;
                Statement stmt = null;
                ResultSet rs = null;
                
                try {
                    conn = Dbconnection.getConnection();
                    stmt = conn.createStatement();
                    rs = stmt.executeQuery("SELECT * FROM product_details");

                    while (rs.next()) {
                        int p_id = rs.getInt("i_id");
                        String p_name = rs.getString("i_name");
                        int price = rs.getInt("i_price");
                        
                        Blob imageBlob = rs.getBlob("i_img");
                        byte[] imageBytes = imageBlob.getBytes(1, (int) imageBlob.length());
                        String base64Image = Base64.getEncoder().encodeToString(imageBytes);
                        
                        int avail = rs.getInt("i_available");
                        
            %>
            <tr>
                <td><%= p_id %></td>
                <td><%= p_name %></td>
                <td>Rs.<%= price %></td>
                <td><img src="data:image/jpeg;base64,<%= base64Image %>" alt="<%= p_name %>" style="width: 50px; height: 50px;"></td>
                <td><%= avail %></td>
                <td class="action-buttons">
                    <a href="editproduct.jsp?id=<%= p_id %>" class="update-button">Update</a>
                    <a href="deleteproductservlet?id=<%=p_id %>" class="delete-button" onclick="return confirm('Are you sure you want to delete this product?');">Delete</a>
                </td>
            </tr>
            <%
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
                    if (stmt != null) try { stmt.close(); } catch (SQLException ignore) {}
                    if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
                }
            %>
        </tbody>
    </table>
</body>
</html>
