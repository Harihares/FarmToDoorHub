<%@page import="com.pay.Transaction" %>
<%@page import="java.util.List" %>
<%@page import="javax.servlet.http.HttpSession" %>
<%@page import="com.Database.Dbconnection" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Transaction History</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/5.1.3/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
            margin-top: 20px;
        }
        .container {
            background-color: #ffffff;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        h1 {
            color: #343a40;
        }
        table {
            width: 100%;
            margin-top: 20px;
        }
        th {
            background-color: green;
            color: white;
        }
        th, td {
            padding: 12px;
            text-align: left;
        }
        tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        tr:hover {
            background-color: #e9ecef;
        }
        .navbar {
        background-color: green;
        overflow: hidden;
        position: fixed;
        width: 100%;
        top: 0;
        z-index: 1000;
      }

      .navbar a {
        float: left;
        display: block;
        color: #f2f2f2;
        text-align: center;
        padding: 14px 16px;
        text-decoration: none;
        font-size: large;
      }

      .navbar a:hover {
        background-color: #ddd;
        color: black;
      }

      .navbar a.active {
        background-color: #04aa6d;
        color: white;
      }

      .search-container {
        float: right;
      }

      input[type=text] {
        padding: 6px;
        margin-top: 8px;
        font-size: 17px;
        border: none;
      }
    </style>
</head>
<body>
<%
    Integer customer_id = (Integer) session.getAttribute("customer_id"); 
%>
<div class="navbar">
  <a class="active" href="#home">FarmToDoorHub</a>
  <a href="Home.jsp">Home</a>
  <a href="vcart.jsp?cid=<%=customer_id%>">cart</a>
  <a href="lo.jsp">Logout</a>
  
  
</div>
<div class="container">
    <center><h1>My Orders</h1></center>
    <table class="table table-hover">
        <thead>
            <tr>
                <th>Item Name</th>
                <th>Item Price</th>
                <th>Quantity</th>
                <th>Payment ID</th>
                <th>Transaction Date</th>
            </tr>
        </thead>
        <tbody>
        <%
        List<Transaction> transactions = (List<Transaction>) request.getAttribute("transactions");
        if (transactions != null) {
            for (Transaction transaction : transactions) {
        %>
                <tr>
                    <td><%= transaction.getItemName() %></td>
                    <td>₹<%= transaction.getItemPrice() %></td>
                    <td><%= transaction.getItemQuantity() %></td>
                    <td><%= transaction.getPaymentId() %></td>
                    <td><%= transaction.getTransactionDate() %></td>
                </tr>
        <%
            }
        }
        %>
        </tbody>
    </table>
</div>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/5.1.3/js/bootstrap.bundle.min.js"></script>
</body>
</html>
