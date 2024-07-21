<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Login Page</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
        <link rel="stylesheet" href="css/bootstrap.min.css">

<style>
  body {
    font-family: Arial, sans-serif;
    background-color: #f2f2f2;
    margin: 0;
    padding: 0;
        
    
  }

  .navbar {
    background-color: #333;
    overflow: hidden;
    padding: 10px;
                background-color: transparent;
        color:green;
    
  }

 

  
  .navbar-links {
    float: right;
    list-style-type: none;
    margin: 0;
    padding: 0;
        color:green;
    
  }

  .navbar-links li {
    display: inline;
    padding: 0 10px;
    color:green;
    font-size:20px;
  }

  .navbar-links li a {
    color:green;
    text-decoration: none;
  }

  .navbar-links li a:hover {
    background-color: #ddd;
    color: black;
                background-color: transparent;
    
  }

  .login-container {
    background-color: #fff;
    padding: 49px;
    border-radius: 5px;
    margin: 20px auto;
    max-width: 400px;
                background-color: transparent;
    
  }

  .login-container h2 {
    text-align: center;
    margin-bottom: 20px;
    
  }

  .input-group {
    margin-bottom: 15px;
    position: relative;
  }

  .input-group input {
    width: 100%;
    padding: 10px;
    border: 1px solid #ccc;
    border-radius: 3px;
    box-sizing: border-box;
  }

  .input-group .fa {
    position: absolute;
    padding: 10px;
    pointer-events: none;
  }

  .input-group .fa-envelope, .input-group .fa-lock {
    color: #999;
  }

  .btn-login {
    width: 100%;
    padding: 10px;
    border: none;
    border-radius: 3px;
    background-color: #4CAF50;
    color: white;
    cursor: pointer;
  }
  .h2
  {
  font-size:1000px;
  font-width:40px;

   
    color: green;
}
  h2, h3 {
    margin-top: -4px;
    margin-bottom: 10px;
    color:green;
    font-size:39px;
}

  .btn-login:hover {
    background-color: #45a049;
  }
   body
             {
                 background-image:linear-gradient(rgba(0,0,0,.2),rgba(0,0,0,.6)),url("bg-images/mini7.jpg");
                 background-position:center;
                 background-repeat:no-repeat;
                 background-size:cover;
                 background-attachment:fixed;
                 
             }
             body {
    font-family: "Helvetica Neue", Helvetica, Arial, sans-serif;
    font-size: 14px;
    line-height: 1.42857143;
    color: green;
</style>
<!-- Start Drift  -->
<script>
"use strict";

!function() {
  var t = window.driftt = window.drift = window.driftt || [];
  if (!t.init) {
    if (t.invoked) return void (window.console && console.error && console.error("Drift snippet included twice."));
    t.invoked = !0, t.methods = [ "identify", "config", "track", "reset", "debug", "show", "ping", "page", "hide", "off", "on" ], 
    t.factory = function(e) {
      return function() {
        var n = Array.prototype.slice.call(arguments);
        return n.unshift(e), t.push(n), t;
      };
    }, t.methods.forEach(function(e) {
      t[e] = t.factory(e);
    }), t.load = function(t) {
      var e = 3e5, n = Math.ceil(new Date() / e) * e, o = document.createElement("script");
      o.type = "text/javascript", o.async = !0, o.crossorigin = "anonymous", o.src = "https://js.driftt.com/include/" + n + "/" + t + ".js";
      var i = document.getElementsByTagName("script")[0];
      i.parentNode.insertBefore(o, i);
    };
  }
}();
drift.SNIPPET_VERSION = '0.3.1';
drift.load('9pv5firuf6hx');
</script>
<!-- End of Async Drift Code -->
</head>

<body>
<nav class="navbar">
  <a class="navbar-brand" href="#"><h2>FarmToDoorHub</h2></a>
  <ul class="navbar-links">
    <li><a href="Home.jsp"></a></li>
    <li><a href="sig.jsp">SignUp</a></li>
    <!--  <li><a href="ch.html">Help</a></li>-->
    <li><a href="admin.jsp">Admin</a></li>
    <li><a href="about.jsp">About</a></li>
    <li><a href="contact.jsp">Contact</a></li>
  </ul>
</nav>
<div class="login-container">
    <h2>Login</h2>
    <form action="Loginservlet" method="get" onsubmit="return isempty()">
        <div class="input-group">
            <span class="input-group-addon"><i class="glyphicon glyphicon-envelope"></i></span>
            <input type="email" name="email" class="form-control" placeholder="Email" id="email">
            
             <!-- Placeholder for email error message -->
        </div>
        <div>
            <span style="color:red"  id="email-error" class="error-msg">${requestScope.email_error}</span>
            </div>
        <div class="input-group">
            <span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
            <input type="password" name="password" class="form-control" placeholder="Password" id="pwd">
            
        </div>
        <div>
             <span  style="color:red" id="password-error" class="error-msg">${requestScope.password_error}</span>
            </div>
        <button type="submit" class="btn-login">Login</button>
    </form>
</div>

<script>
    function isempty() {
        var input_email = document.querySelector('input[name="email"]').value;
        var input_pwd = document.querySelector('input[name="password"]').value;
        if (input_email === "") {
            alert("Enter email");
            return false;
        } else if (input_pwd === "") {
            alert("Enter password");
            return false;
        } else {
            return true;
        }
    }
</script>

<%
    String valid_msg = (String) request.getAttribute("msg");
    if (valid_msg != null) {
        out.println(valid_msg);
    }
%>

</body>
</html>