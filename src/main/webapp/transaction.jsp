<%@ page import="java.sql.*" %>
<%@ page import="com.Database.Dbconnection" %>
<%@ page import="java.util.Base64" %>
<%@ page import="java.lang.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Information</title>
    <link rel="stylesheet" href="userdetails.css">
    <style>
        body {
            font-family: Arial, sans-serif;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
        }
        h2 {
            text-align: center;
            color: #333;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
        }
        table, th, td {
            border: 1px solid #ddd;
        }
        th, td {
            padding: 8px;
            text-align: center;
        }
        th {
            background-color: #f2f2f2;
        }
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Customer Information</h2>
        <table id="customerTable">
            <thead>
                <tr>
                    <th>Transaction Id</th>
                    <th>Customer Id</th>
                    <th>Qunatity</th>
                    <th>Product Name</th>
                    <th>Item Price</th>
                    <th>Payment Id</th>

                </tr>
            </thead>
            <tbody>
                <%
                try {
                    Connection conn = Dbconnection.getConnection();
                    Statement stmt = conn.createStatement();
                    ResultSet rs = stmt.executeQuery("SELECT * FROM transactions");
                    
                    while(rs.next()) {
                        int t_id = rs.getInt("transaction_id");
                        int c_id = rs.getInt("customer_id");
                                                int quan = rs.getInt("item_quantity");
                                                String item= rs.getString("item_name");

                        String price = rs.getString("item_price");
                        String p_id = rs.getString("payment_id");

                %>
                <tr>
                    <td><%= t_id %></td>
                    <td><%= c_id %></td>
                                         <td><%= quan %></td>
                     <td><%= item %></td>
 
                    <td><%= price %></td>
                    <td><%= p_id %></td>

                </tr>
                <%
                    }
                } catch(Exception e) {
                    out.println("Error: " + e.getMessage());
                }
                %>
            </tbody>
        </table>
    </div>
    <script src="feedback.js"></script>
</body>
</html>
