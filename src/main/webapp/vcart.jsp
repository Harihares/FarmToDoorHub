<%@ page import="java.sql.*" %>
<%@ page import="com.Database.Dbconnection" %>
<%@ page import="java.util.List"%>
<%@ page import ="java.sql.Blob"%>
<%@ page import="java.util.Base64"%>
<%@ page import="java.lang.*"%>

	<!DOCTYPE html>
	<html>
	<head>
	    <title>View Cart</title>
	    <style>
	    body {
	  margin: 0;
	  font-family: Arial, sans-serif;
	}
	        table {
	            width: 100%;
	            border-collapse: collapse;
	        }
	        th, td {
	            border: 1px solid black;
	            padding: 8px;
	            text-align: left;
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
	
	.search-container {
	  float: right;
	}
	
	input[type=text] {
	  padding: 6px;
	  margin-top: 8px;
	  font-size: 17px;
	  border: none;
	}
	
	button {
	  padding: 6px 10px;
	  margin-top: 8px;
	  background: #ddd;
	  font-size: 17px;
	  border: none;
	  cursor: pointer;
	}
	  .btn-buy {
            background-color: #28a745;
            color: white;
            padding: 5px 10px;
            border: none;
            cursor: pointer;
        }
        .btn-buy:hover {
            background-color: #218838;
        }
        .btn-delete {
            background-color: #6c757d;
            color: white;
            padding: 5px 10px;
            border: none;
            cursor: pointer;
        }
        .btn-delete:hover {
            background-color: #5a6268;
        }
	 table {
            width: 100%;
            border-collapse: collapse;
            border: 1px solid #dee2e6;
            margin-top: 20px;
            background-color: #d4edda;           
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); 
        
        }
	    </style>
	    
	</head>
	<body>
	    <%
	    int priceitem;
	    Object customer_id=session.getAttribute("c_id");
	    int c_id=(Integer)customer_id;
	     
	    out.println("customer_id:"+c_id);
	  
	    Object product_id=session.getAttribute("p_id");
	    int p_id=(Integer)product_id;
	    out.println("product_id:"+p_id);
	    %>
	 <div class="navbar">
	  <a class="active" href="#home">FarmToDoorHub</a>
	  <a href="Home.jsp">Home</a>
	  <a href="ch.html">Help</a>-
	  <a href="lo.jsp">Logout</a>
	  <div class="search-container">
	    
	  </div>
	</div>
	 
	<center><h2>Cart Items</h2></center>
	
	
	<% 
	 int total_price=0;

	try
	{
	String query="select item_price from cart ";
	PreparedStatement s=Dbconnection.prepareStatement(query);
	ResultSet rsd=s.executeQuery();
	while(rsd.next())
	{
		int totalprice=rsd.getInt("item_price");
		total_price=totalprice+total_price;
	}
	}
	catch(Exception ex)
	{
		out.println(ex);
	}
	//out.println("Totalprice:"+total_price);
	
	%>
	<table>
	    <tr>
	        <th>Item Name</th>
	        <th>Quantity</th>
	        <th>Price</th>
	        <th>Image</th>
	        <th>Buy/Delete</th>
	    </tr>
	    <% 
	        try {
	            Connection conn = Dbconnection.getConnection();
	            Statement stmt = conn.createStatement();
	            ResultSet rs = stmt.executeQuery("SELECT * FROM cart where customer_id="+c_id+"");
	
	            while (rs.next()) {
	                int id= rs.getInt("cart_item_id");
	                String itemName = rs.getString("item_name");
	                int quantity = rs.getInt("item_quantity");
	                int price = rs.getInt("item_price");
	                Blob imageBlob = rs.getBlob("item_image");
	                byte[] imageBytes = imageBlob.getBytes(1, (int) imageBlob.length());
	                String base64Image = javax.xml.bind.DatatypeConverter.printBase64Binary(imageBytes);
	    %>
	    <tr>
	        <td><%= itemName %></td>
	        <td><%= quantity %></td>
	        <td>Rs.<%= price %></td>
	        <td><img src="data:image/jpeg;base64,<%= base64Image %>" width="100" height="100"></td>
	        <td>
	            <div style="display: flex; align-items: center;">
	                            <form action="order.jsp?c_id=<%=c_id%>" method="post">
	                                                <input type="hidden" name="item_name" value="<%=id%>">
	                 <button style="margin-right: 10px; background-color: green; color: white; padding: 5px 10px;" onclick="buyItem">Buy</button>
	                 
	                                                
	                   </form>         
	                   
	            
	                <form action="removecartItem?c_id=<%=c_id%>" method="post">
	                    <input type="hidden" name="item_name" value="<%=id%>">
	                    <button type="submit" style="background-color:grey; color: white; padding: 5px 10px;">Delete</button>
	                </form>
	                <form action="pay.jsp?c_id=<%=c_id%>" method="post"></form>                
	            </div>
	        </td>
	    </tr>
	    
	    <% 
	            }
	        }
	        catch(Exception ex) {
	            out.println(ex);
	        }

	   %> 

	
</body>
</html>
	
	</body>
	</html>