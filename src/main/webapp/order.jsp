<%@ page import="java.sql.*"%>
<%@ page import="com.Database.Dbconnection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Page</title>
    <style>
       body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
        }

        header {
            background-color: #333;
            color: white;
            text-align: center;
            padding: 1px;
        }

        main {
            padding: 20px;
        }

        form {
            width: 50%;
            margin: 0 auto;
            text-align: center;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        table, th, td {
            border: 1px solid #ccc;
        }

        th, td {
            padding: 8px;
            text-align: left;
        }

        tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        input[type="text"],
        input[type="tel"],
        textarea,
        input[type="number"] {
            background-color: #f9f9f9;
            border: 1px solid #ccc;
            padding: 6px;
            width: 100%;
            box-sizing: border-box;
        }

        button {
            background-color: #333;
            color: #fff;
            border: none;
            padding: 10px 20px;
            cursor: pointer;
        }

        button:hover {
            background-color: #555;
        }

        footer {
            background-color: #333;
            color: #fff;
            text-align: center;
            padding: 20px 0;
            }
     .navbar {
	  background-color:green;
	  overflow: hidden;
	}
	
	.navbar a {
	  float: left;
	  display: block;
	  color: #f2f2f2;
	  text-align: center;
	  padding: 14px 16px;
	  text-decoration: none;
	}
	
	.navbar a:hover {
	  background-color: #ddd;
	  color: black;
	}
	
	.navbar a.active {
	  background-color: #04AA6D;
	  color: white;
	}
      
    </style>
</head>

<body>
<div class="navbar">
	  <a class="active" href="#home">FarmToDoorHub</a>
	  <a href="Home.jsp">Home</a>
	  <a href="ch.html">Help</a>-
	  <a href="lo.jsp">Logout</a>
	  <div class="search-container">
	    
	  </div>
	</div>
<header>
    <h1>Order Page</h1>
</header>

<%
    String name = null;
    String phonenumber = null;
    int quantity = 0;
    String itemName = null;
    int price = 0;
    int pincode = 0;
    String address = null;

    int customer_id = Integer.parseInt(request.getParameter("c_id"));
    int cart_item_id = Integer.parseInt(request.getParameter("item_name"));

    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        con = Dbconnection.getConnection();

        ps = con.prepareStatement("SELECT customer_name, customer_phno, customer_address, pincode FROM userdetails WHERE customer_id = ?");
        ps.setInt(1, customer_id);
        rs = ps.executeQuery();
        if (rs.next()) {
            name = rs.getString("customer_name");
            phonenumber = rs.getString("customer_phno");
            pincode = rs.getInt("pincode");
            address = rs.getString("customer_address");
        }

        ps = con.prepareStatement("SELECT item_name, item_price, item_quantity FROM cart WHERE cart_item_id = ?");
        ps.setInt(1, cart_item_id);
        rs = ps.executeQuery();
        if (rs.next()) {
            itemName = rs.getString("item_name");
            price = rs.getInt("item_price");
            quantity = rs.getInt("item_quantity");
        }

        session.setAttribute("quantity", quantity);
        session.setAttribute("itemName", itemName);
        session.setAttribute("item_price", price);
        session.setAttribute("c_id", customer_id);

    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (ps != null) try { ps.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (con != null) try { con.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>

<main>
    <form action="pay.jsp?customer_id=<%=customer_id%>" method="post">
        <table>
            <tr>
                <td><label for="customerName">Customer Name:</label></td>
                <td><input type="text" id="customerName" name="customerName" value="<%=name%>" required></td>
            </tr>
            <tr>
                <td><label for="phoneNumber">Phone Number:</label></td>
                <td><input type="tel" id="phoneNumber" name="phoneNumber" value="<%=phonenumber%>" required></td>
            </tr>
            <tr>
                <td><label for="itemName">Item Name:</label></td>
                <td><input type="text" id="itemName" name="itemName" value="<%=itemName%>" required readonly></td>
            </tr>
            <tr>
                <td><label for="itemPrice">Item Price:</label></td>
                <td><input type="text" id="itemPrice" name="itemPrice" value="<%=price%>" required readonly></td>
            </tr>
            <tr>
                <td><label for="quantity">Quantity:</label></td>
                <td><input type="number" id="quantity" name="quantity" min="1" value="<%=quantity%>" required readonly></td>
            </tr>
            <tr>
                <td><label for="pinCode">Pin Code:</label></td>
                <td><input type="text" id="pinCode" name="pinCode" value="<%=pincode%>" required></td>
            </tr>
            <tr>
                <td><label for="shippingAddress">Shipping Address:</label></td>
                <td><textarea id="shippingAddress" name="shippingAddress" required><%=address%></textarea></td>
            </tr>
        </table>
        <button type="submit">Buy now</button>
    </form>
</main>

<footer>
    <p>&copy; 2024 FARMTODOORHUB</p>
</footer>

</body>
</html>
