<%@include file="navbar.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Register Page</title>
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/bootstrap.css">
    <style type="text/css">
        body {
            background-image: linear-gradient(rgba(0,0,0,.5),rgba(0,0,0,.5)), url("bg-images/mini6.jpg");
            background-repeat: no-repeat;
            background-attachment: fixed;
            background-size: cover;
        }
        .form-signup {
            width: 300px;
            margin: 0 30px;
        }
        h1 {
            text-align: center;
            font-family: Sans-serif;
            font-weight: bold;
            color: Black;
        }
        i {
            color: #080808;
        }
        label {
            color: white;
        }
        .container {
            padding-right: 123px;
            padding-left: 0px;
            margin-right: auto;
            margin-left: auto;
        }
    </style>
</head>
<body>
    <script src="js/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <center>
        <div class="container">
            <form class="form-signup" action="Signupservlet" method="get">
                <h1>SignUp</h1>
                <div class="form-group">
                    <div class="row">
                        <div class="col-md-6 col-xs-6">
                            <div class="input-group">
                                <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
                                <input type="text" class="form-control" name="name" placeholder="Name">
                            </div>
                        </div>
                        <div class="col-md-6 col-xs-6">
                            <div class="input-group">
                                <span class="input-group-addon"><i class="glyphicon glyphicon-heart"></i></span>
                                <input type="number" class="form-control" name="age" placeholder="Age">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <div class="input-group">
                        <span class="input-group-addon"><i class="glyphicon glyphicon-envelope"></i></span>
                        <input type="email" class="form-control" name="email" placeholder="Email">
                    </div>
                </div>
                <div class="form-group">
                    <div class="input-group">
                        <span class="input-group-addon"><i class="glyphicon glyphicon-phone-alt"></i></span>
                        <input type="text" class="form-control" name="phoneno" placeholder="Phone Number">
                    </div>
                </div>
                <div class="form-group">
                    <div class="input-group">
                        <span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
                        <input type="password" class="form-control" name="password" placeholder="Password">
                    </div>
                </div>
                <div class="form-group">
                    <div class="input-group">
                        <span class="input-group-addon"><i class="glyphicon glyphicon-map-marker"></i></span>
                        <input type="text" class="form-control" name="address" placeholder="Address">
                    </div>
                </div>
                <div class="form-group">
                    <div class="input-group">
                        <span class="input-group-addon"><i class="glyphicon glyphicon-map-marker"></i></span>
                        <input type="text" class="form-control" name="pincode" placeholder="Pincode">
                    </div>
                </div>
                <div class="form-group">
                    <input type="submit" class="btn btn-success btn-block" name="btn_submit">
                    <%
                        String btn = request.getParameter("btn_submit");
                        if (btn != null) {
                            String valid = (String) request.getAttribute("msg");
                            if (valid != null) {
                                out.println(valid);
                            }
                        }
                    %>
                </div>
            </form>
        </div>
    </center>
</body>
</html>
