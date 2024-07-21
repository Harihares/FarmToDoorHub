<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.beans.Customizer"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import ="java.sql.Blob"%>
<%@page import="java.util.List"%>
<%@page import="java.util.*"%>
<%@page import="javax.xml.*"%>
<%@page import="com.Database.Dbconnection"%>
<!DOCTYPE html>
<html lang="en">
<head>
   <meta charset="UTF-8">
   <meta http-equiv="X-UA-Compatible" content="IE=edge">
   <meta name="viewport" content="width=device-width, initial-scale=1.0">
   
  
   <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

 
   <link rel="stylesheet" href="css/home.css">
<style>

.products-container {
  display: flex;
  flex-wrap: wrap;
  justify-content: space-around;
  margin-top: 20px;
}

.product {
  width: 250px;
  margin-bottom: 20px;
  background-color: #fff;
  border-radius: 8px;
  box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
  padding: 15px;
  text-align: center;
}

.product img {
  width: 100%;
  border-radius: 8px;
  margin-bottom: 10px;
}

.product h3 {
  font-size: 18px;
  margin-bottom: 8px;
}

.product .price {
  font-size: 16px;
  color: #333;
  margin-bottom: 15px;
}

.product button {
  background-color: #04AA6D;
  color: #fff;
  border: none;
  padding: 8px 16px;
  border-radius: 4px;
  cursor: pointer;
  transition: background-color 0.3s ease;
}

.product button:hover {
  background-color: #03a258;
}

.search-container {
  margin-top: 8px;
  margin-right: 20px;
}

.search-container input[type=text] {
  padding: 8px;
  font-size: 16px;
  border-radius: 4px;
  border: 1px solid #ccc;
}

.search-container button {
  padding: 8px 16px;
  font-size: 16px;
  border: none;
  background-color: #ddd;
  border-radius: 4px;
  cursor: pointer;
}

.search-container button:hover {
  background-color: #ccc;
}


      body {
        margin: 0;
        font-family: Arial, sans-serif;
                         background-image:linear-gradient(rgba(0,0,0,.2),rgba(0,0,0,.6)),url("bg-images/mini7.jpg");
        
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
    font-weight: 900;
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

      button {
        padding: 6px 10px;
        margin-top: 8px;
        background: #ddd;
        font-size: 17px;
        border: none;
        cursor: pointer;
      }
   </style>
</head>
<body>
<%
     Object user_id=session.getAttribute("cid");
     int customer_id=(Integer) user_id;
     ;
%>
<div class="navbar">
  <a class="active" href="#home">FarmToDoorHub</a>
  <a href="Home.jsp">Home</a>
  <a href="vcart.jsp?cid=<%=customer_id%>">cart</a>
  <a href="ch.html">Help</a>
    <a href="TransactionServlet?cid=<%=customer_id%>">MyOrders</a>
      <a href="lo.jsp">Logout</a>
    
    
  
  
</div>


<div class="container">
    <script src="js/jquery.min.js" defer></script>
   
   <%!
   String id=null;
   String Item_name=null;
   Blob imageBlob=null;  
   float price=0;
   byte[] imageBytes=null;
   String base64Image=null;
   %>
   <%
   String itemname=null;
    String search_button=request.getParameter("searchbtn");
      if(search_button!=null)
		   {
    	  itemname=request.getParameter("searchvalue");
    	  Connection connection=null;
          ResultSet resultset=null;
          try{
        	  PreparedStatement statement=Dbconnection.prepareStatement("select i_id,i_name,i_price,i_img,i_available from product_details where i_name='"+itemname+"'");
        	  ResultSet rs=statement.executeQuery();
        	  if(rs.next())
        	  {
        		 id=resultset.getString("i_id");
                 Item_name=resultset.getString("i_name");
                 imageBlob=resultset.getBlob("i_img");
                 imageBytes=imageBlob.getBytes(1,(int)imageBlob.length());
                 base64Image=javax.xml.bind.DatatypeConverter.printBase64Binary(imageBytes);
                 price=resultset.getFloat("i_price");
        	  }
          }
          catch(Exception ex)
          {
             out.print(ex);
          }
	   
		   }
   %>
   
    <% 
      Connection connection=null;
       ResultSet resultset=null;
       try{
          connection=Dbconnection.getConnection();
          resultset=Dbconnection.fetchallproduct();
       }
       catch(Exception ex)
       {
          out.print(ex);
       }
       while(resultset.next())
       {
            id=resultset.getString("i_id");
            Item_name=resultset.getString("i_name");
           imageBlob=resultset.getBlob("i_img");
           imageBytes=imageBlob.getBytes(1,(int)imageBlob.length());
           base64Image=javax.xml.bind.DatatypeConverter.printBase64Binary(imageBytes);
           price=resultset.getFloat("i_price");
           String reviewId = "p-" + id; 
    %>
    <div class="products-container">
        <div class="product" data-name="<%=reviewId%>"> 
            <img src="<%="data:image/jpeg;base64,"+base64Image+""%>" alt="">
            <h3><%=Item_name%></h3>
            <div class="price">Rs.<%=price%></div>
            <button><a href="showItem?sid=<%=id%>&c_id=<%=customer_id%>" class="add-to-cart-btn">Add to Cart</a></button>
        </div>
        
    </div> 
    <%}%>
</div>
</body>
</html>
