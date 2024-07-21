<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Pay Button Example</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <style>
body {
    font-family: Arial, sans-serif;
    margin: 0;
    padding: 0;
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
    background-color: #f5f5f5;
    background-image: url("https://pixabay.com/photos/field-agriculture-track-mountains-5137778/"); 
    background-size: cover; 
    background-position: center; 
    background-repeat: no-repeat; 
}

        .container {
            max-width: 500px;
            margin: 50px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        h2 {
            margin-bottom: 30px;
            text-align: center;
            color: #007bff;
        }
        .pay-button {
            background-color: #007bff;
            color: #fff;
            border: none;
            padding: 15px 30px;
            border-radius: 5px;
            cursor: pointer;
            font-size: 18px;
            transition: background-color 0.3s ease;
            width: 100%;
        }
        .pay-button:hover {
            background-color: #0056b3;
        }
        
      .center{
      
      display:flex;
justify-content:center;
align-items:center;
  margin-top: 30px;

}
.center{
      
      display:flex;
justify-content:center;
align-items:center;
  margin-top: 30px;

}
.flex h1
{
color:white;
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
       
       .navbar
       {
          background-color: green;
        overflow: hidden;
        position: fixed;
        width: 100%;
        top: 0;
        z-index: 1000;
        justify-content:start;
       padding: -1.5rem 1rem;
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
    <div class="container">
        <h2>Complete Your Purchase</h2>
        <div class="row">
            <div class="col-md-6 offset-md-3">
                <div class="card text-center">
                    <div class="card-body">
                        <p class="card-text">Total Amount: <%= session.getAttribute("item_price") %></p>
                    </div>
                </div>
            </div>
        </div>
        <div class="row mt-4">
            <div class="col-md-6 offset-md-3">
                <button id="paybutton" onclick="CreateOrderID()" class="btn btn-primary btn-lg btn-block pay-button">Proceed to Payment</button>
            </div>
        </div>
    </div>
   
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
    
<script>
var xhttp = new XMLHttpRequest();
var RazorpayOrderId;
function CreateOrderID() {
    xhttp.open("GET", "http://localhost:8080/Agrii/payServlet", false);
    xhttp.send();
    RazorpayOrderId = xhttp.responseText;
    openCheckout();
}
</script>

<script src="https://checkout.razorpay.com/v1/checkout.js"></script>
<script>
function openCheckout() {
    var options = {
        "key": "rzp_test_BoOR2YfMncErQ2",
        "amount": "<%= session.getAttribute("item_price") %>",
        "currency": "INR",
        "name": "FARMTODOORHUB",
        "order_id": RazorpayOrderId,
        "callback_url": "http://localhost:8080/Agrii/payServlet",
        "prefill": {
            "name": "<%= session.getAttribute("customer_name") %>",
            "email": "harihares02@gmail.com",
        },
        "notes": {
            "address": "Razorpay corporate office"
        },
        "theme": {
            "color": "blue"
        }
    };
    var rzp1 = new Razorpay(options);
    rzp1.on('payment.failed', function(response) {
        alert(response.error.code);
        alert(response.error.description);
        alert(response.error.source);
        alert(response.error.step);
        alert(response.error.reason);
        alert(response.error.metadata.order_id);
        alert(response.error.metadata.payment_id);
    });
    rzp1.open();
    e.preventDefault();
}
</script>
