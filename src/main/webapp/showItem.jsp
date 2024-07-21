<!DOCTYPE html>
<%@page import="com.show.Feedback"%>
<%@page import="java.util.List"%>
<%@page import ="java.sql.Blob"%>
<%@page import="java.util.Base64"%>
<%@page import="java.lang.*"%>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>View Item</title>
<link rel="stylesheet" href="bootstrap-css/bootstrap.min.css">
<link rel="stylesheet" href="css/view_item.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
<style>
  body {
 
    font-family: Arial, sans-serif;
 
  }
  .product-container {
    background-color: white;
    border-radius:20px 0px 20px 0px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    padding: 50px;
    width:300px;
    margin: 20px;
    border:2px solid green;
  }
  .product-info {
    text-align: center;
    width: 300px;
    margin: 20px; 
    
  }
  .product-info h1 {
    color: #333; 
    font-size: 24px;
    margin-bottom: 10px;
  }
  .product-info p {
   color: #00ff05;
    font-size: 18px;
    /* margin-bottom: 15px; */
    font-weight: 700;
    text-align: left;
    margin-left: 103px;
  }
  .quantity {
    text-align: center; 
    margin-bottom: 20px;
  }
  .quantity input[type="number"] {
    border: 1px solid #ced4da; 
    border-radius: 5px;
    padding: 5px 10px;
    width: 60px;
    text-align: center;
    font-size: 16px;
    margin: 0 10px;
  }
  .action-buttons .btn-primary {
    background-color: green; 
    color: green;
    border: none;
    padding: 10px 20px;
    font-size: 18px;
    border-radius: 5px;
    cursor: pointer;
    transition: background-color 0.3s ease;
  }
  .action-buttons .btn-primary:hover {
    background-color: green; 
  }
  .product-image img {
   max-width: 300px;
    max-height:225px;
  
    
        border-radius: 10px;
    margin: 0 auto; 
    display: block; 
    padding:10px;
    box-shadow:4px 5px 12px black;
  
  }
   .action-buttons .btn-primary {
    background-color: green; 
    color: white;
    border: none;
    padding: 10px 20px;
    font-size: 18px;
    border-radius: 5px;
    cursor: pointer;
    transition: background-color 0.3s ease;
  }
  .action-buttons .btn-primary:hover {
    background-color: #0056b3; 
  }
  .cart-container {
  position: fixed;
  top: 20px; 
  right: 20px; 
  z-index: 999; 
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
      .center{
      
      display:flex;
justify-content:center;
align-items:center;
  margin-top: 30px;

}
.flex h1
{
color:green;
}

.flex{

    justify-content: center;
    display: flex;
    flex-direction: column;
    align-items: center;
width:1000px;
   background-color: white;
  box-shadow:-2px -4px 10px;
    border-radius:20px 0px 20px 0px;
  margin-top: 65px;
    background: rgb(0,255,33);
  
  background: linear-gradient(90deg, rgba(0,255,33,1) 0%, rgba(11,121,9,1) 35%, rgba(9,36,0,1) 67%);
  

}
#feedback{
    width: 300px;
    height: 112px;
    padding:20px;
    border:2px solid green;
    border-radius:20px 0px 20px 0px;
}

.btnn{
    margin-top: 30px;
    width: 165px;
    padding: 10px;
    border-radius: 10px;
    border: none;
    background-color: green;
    color: white;
    text-align:center;
    font-weight: 500;
    }
    .scroll{
   
    overflow: scroll;
    max-height: 600px;
    height: 100%;
    width: 400px;
        padding: 20px;
          
    border: 1px solid white;
}
    .feed{
    background-color: white;
    padding: 1px;
    border-radius: 40px;
    margin-top:10px;
    margin-bottom:10px;
      margin-left: -40px;
    overflow:scroll;
           height: 76px;
    }


.feed::-webkit-scrollbar {
    width: 0; /* Hide scrollbar */
}
.scroll::-webkit-scrollbar {
    width: 0; /* Hide scrollbar */
}
.b{
color:black;
text-transform:uppercase;

}
.tab{
    position: relative;
    left: 85px;
    bottom: 20px;
}
</style>
</head>
<body>








<div class="center">
<div class="flex">
<div class="container mt-5">
  <div class="row justify-content-center">
    <div class="col-md-8 product-container">
      <div class="row">
        <div class="col-md-12 product-image">
          <img src="data:image/jpeg;base64,<%= new String(java.util.Base64.getEncoder().encode((byte[]) request.getAttribute("imagedata"))) %>" alt="Product Image">
        </div>
        <div class="col-md-12 product-info">
          <%
          Object p_id=request.getAttribute("p_id");
          int product_id=(Integer)p_id;
          Object c_id=request.getAttribute("c_id");
          int customer_id=(Integer)c_id;
          session.setAttribute("p_id",p_id);
          session.setAttribute("c_id",c_id);
          %>
          <h1><%=request.getAttribute("namedata")%></h1>
          <p>Price: <%=request.getAttribute("pricedata")%></p>
          <div class="quantity">
            <button class="btn btn-sm btn-outline-dark minus"><i class="fas fa-minus"></i></button>
            <input type="number" min="1" max="99" step="1" value="1">
            <button class="btn btn-sm btn-outline-dark plus"><i class="fas fa-plus"></i></button>
          </div>
          <div class="action-buttons">
            <button type="button" class="btn  btn-primary add-to-cart">Add to Cart</button>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>



<div class="product-info">
  
  <form action="FeedbackServlet" method="get">
  <div>
  
  

  
  
  <h1>FEEDBACK FORM</h1>
  </div>
  <div>
    <textarea id="feedback" name="feedback" placeholder="Enter your feedback"></textarea> <br>
    </div>
    <div>
    <button type="submit" class="btn btnn btn-primary name="btn">Submit Feedback</button>
    </div>
    
  </form>
</div>



<div class="product-info scroll">
    <h1>FEEDBACK</h1>
    <ul>
        
        <% List<Feedback> feedbackList = (List<Feedback>) request.getAttribute("feedbackList"); %>
        <% for (Feedback feedback : feedbackList) { %>
            <div class="feed">
                <p > <span class="b"><%= feedback.getCustomerName() %></span></p>
                <p class="tab" > <%= feedback.getFeedback() %></p>
            </div>
        <% } %>

        
    </ul>
</div>

</div>

<div id="carouselExampleSlidesOnly" class="carousel slide" data-bs-ride="">
  
  <div class="carousel-inner">
   
  </div>

</div>
</div>
<div class="navbar">
  <a class="active" href="#home">FarmToDoorHub</a>
  <a href="Home.jsp">Home</a>
  <a href="vcart.jsp?cid=<%=customer_id%>">cart</a>
  <a href="ch.html">Help</a>
  <a href="lo.jsp">Logout</a>
 
</div>

<script src="js/jquery.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script>
$(document).ready(function() {
  $('.minus').click(function () {
    var $input = $(this).parent().find('input');
    var value = parseInt($input.val());
    if (value > 1) {
      value = value - 1;
    } else {
      value = 1;
    }
    $input.val(value);
  });

  $('.plus').click(function () {
    var $input = $(this).parent().find('input');
    var value = parseInt($input.val());
    if (value < 99) {
      value = value + 1;
    } else {
      value = 99;
    }
    $input.val(value);
  });

  $('.add-to-cart').click(function () {
    var quantity = parseInt($(this).parent().prev().find('input').val());
    $.ajax({
      type: "POST",
      url:"addToCart",
      data: {quantity: quantity},
      success: function(response) {
        alert(response);
      },
      error: function(xhr, status, error) {
       
      }
    });
  });
});





</script>


</html>
