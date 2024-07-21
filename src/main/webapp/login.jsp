<%@include file="navbar.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/bootstrap.min.css">
        <link rel="stylesheet" href="css/login.css">
      //  <style>
             body
             {
                 background-image:linear-gradient(rgba(0,0,0,.2),rgba(0,0,0,.6)),url("bg-images/mini7.jpg");
                 background-position:center;
                 background-repeat:no-repeat;
                 background-size:cover;
                 background-attachment:fixed;
             }
             container
             {
                 justify-content:center;
                 align-items:center;
                 text-align:center;
                 text-align-last:center;
             }
             table
             {
               justify-content:center;
               text-align:center;
               text-justify:auto;
             }
             h1
             {
                 font-family:serif;
                 font-weight:bold;
                 font-size:50px;
                 color:whitesmoke;
                 text-shadow:5px 5px 5px rgba(0,0,0,.6)
             }
             label
             {
                 font-weight:bold;
                 color:lightyellow;
                 font-size:20px
             }
             i
             {
                 color:black;
             }
             
             .abi{
             margin-top:35px 
             
             }
             .container-fluid {
    padding-right: 40px;
    padding-left: 48px;
    margin-right: auto;
    margin-left: auto;
}


<div class="col-md-4 col-xs-12 abi">
                 
                    
                <div class="col-md-3">
                </div>
            </div>
  
            </style>
            <script>
             function isempty()
             {
            	 var input_email=document.getElementById("email").value;
            	 var input_pwd=document.getElementById("pwd").value;
            	if(input_email=="")
            	 {
            		 alert("Enter email");
            		 return false;
            	 }
            	else if(input_pwd=="")
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
        <div class="container">
            <div class="row">
                <div class="col-md-4">
            </div>
                <div class="col-md-4">
                    <h1 style="text-align:center;color:red"></h1>
                </div>
                <div class="col-md-4">
                </div>
            </div>
            <br>
            <div class="row">
                <div class="col-md-4">
                </div>
                <div class="col-md-4 col-xs-12 abi">
                    <form class="form" action="Loginservlet" method="get">
                        <label>Email:</label>
                            <div class="input-group">
                                <span class="input-group-addon"><i class="glyphicon glyphicon-envelope"></i></span>
                                <input type="Email" name="email" class="form-control" placeholder="email" id="email">
                            </div>
                    <label>Password:</label>         
                            <div class="input-group">
                                <span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>         
                                <input type="password" name="password" class="form-control" placeholder="password" id="pwd">
                            </div>
                             <br>
                           
                           
                             <div>
                            <input type="submit" name="btnsubmit" class="btn btn-success" onclick="return isempty()">
                </div>
                    </form>
                    <%
                    String btn=request.getParameter("btnsubmit");
                    if(btn!=null)
                    {
                    	String valid_msg=(String)request.getAttribute("msg");
                      if(valid_msg!=null)
                    {
                    	  out.println(valid_msg);
                     }
                    }
                   
                    %>
                <div class="col-md-3">
                </div>
            </div>
        </div>
    </body>
</html>
