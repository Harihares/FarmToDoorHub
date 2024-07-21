

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>navbar Page</title>
        <link rel="Stylesheet" href="css/bootstrap.min.css">
        <style>
            body
            {
                height:100px;
                padding-top:70px;
             }
            #navbar
            {
                position:fixed;
                top:0;
                left:0;
                right:0;
                z-index:100;
                padding:.5rem 5rem;
                box-shadow:15px 10px 20px rgba(0,1,0,0.1)
            }
            #n-b
            {
               color:green;
               font-weight:800;
               font-family:san-serif;
               font-size:40px;
               text-align:center;
               align-content:center;
                   position: relative;
    bottom: 58px;
    right: 27px;
            }
            #cos
            {
                font-size:1px;
                margin:0 140px;
                font-family:fantasy;
                color:blue;
                font-size:20px
            }
            #cos a
            {
                color:white;
                border-bottom:3px solid transparent;
                font-size:25px;
                font-family:initial;
                font-weight:bold;
            }
            #cos a:hover
            {
            background-color: transparent;
                border-bottom:3px solid white;
                border-color:green;
                border-radius:5px 5px 5px 5px;
            }
            li
            {
              font-size:30px;  
            }
            h4
            {
             font-size:60px;
             
            }
            </style>
            
            
            <script>
            function isempty()
            {
               var input_username=document.getElementById("username").value;
               var input_password=document.getElementById("password").value;
               
               if(input_username=="")
            	   {
            	   alert("Enter userename");
            	   return false;
            	   }
               else if(input_password=="")
            	   {
            	   alert("Enter password");
            	   return false;
            	   }
               else
            	   {
            	   return true;
            	   }
            	   }
               </script>
               
            
            
            
    </head>
    <body>
        <script src="js/jquery.min.js" ></script>
        <script src="js/bootstrap.min.js"></script>
  <div class="container-fluid" id="c-f">
    <div class="navbar-header navbar-left" id="n-h">
     <center> <p class="navbar-brand" id="n-b">FarmToDoorHub</p></center>	
    </div>
      <ul class="nav navbar-nav" id="cos">
          <li><a class=" active" href="home.jsp"><h4> 	</h4></a></li>
      <li><a href="register.jsp"><h4>Sign up</h4></a></li>
      <li><a href="login.jsp"><h4>login</h4></a></li>
      <li><a href="contact.jsp"><h4>Contact</h4></a></li>
      <li><a href="chat.html"><h4>Help</h4></a></li>
            <li><a href="admin.jsp"><h4>Admin</h4></a></li>
      
           
      
    </ul>
    
        
    </form>
  </div>
</nav>   
    </body>
</html>