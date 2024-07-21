<%@ page import="java.sql.*" %>
<%@ page import="com.Database.Dbconnection" %>
<%@ page import="java.util.Base64" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="admindashboard.css">
    <style>
         <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f5f5f5;
        }
        h2
        {
        color:green;
        }
        .sidebar {
            height: 100vh;
            width: 200px;
            position: fixed;
            top: 0;
            left: 0;
            background-color: #333;
            padding-top: 20px;
        }
        .sidebar h2 {
            color: #fff;
            text-align: center;
            margin-bottom: 30px;
        }
        .sidebar ul {
            list-style-type: none;
            padding: 0;
        }
        .sidebar ul li {
            padding: 15px;
            text-align: center;
        }
        .sidebar ul li a {
            color: #fff;
            text-decoration: none;
            display: block;
        }
        .sidebar ul li a:hover, .sidebar ul li a.active {
            background-color: #575757;
        }
        .content, .content2 {
            margin-left: -16px;
            padding: 20px;
        }
        .container {
            margin-left: 200px;
            background-color: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        table, th, td {
            border: 1px solid #ddd;
        }
        th, td {
            padding: 12px;
            text-align: left;
        }
        th {
            background-color: #4CAF50;
            color: white;
            text-align: center;
        }
        .action-buttons a {
            display: inline-block;
            margin-right: 10px;
            padding: 6px 12px;
            text-decoration: none;
            color: white;
            border-radius: 4px;
        }
        .update-button {
            background-color: #4CAF50;
        }
        .delete-button {
            background-color: #f44336;
        }
        .delete-button:hover {
            background-color: #e53935;
        }
        .update-button:hover {
            background-color: #43a047;
        }
        .home-link {
            text-align: center;
            margin-top: 50px;
        }
        .home-link a {
            color: #007bff;
            font-size: 20px;
            text-decoration: none;
            border: 2px solid #007bff;
            padding: 10px 20px;
            border-radius: 5px;
            transition: background-color 0.3s, color 0.3s;
        }
        .home-link a:hover {
            background-color: #007bff;
            color: #fff;
        }
    </style>
</head>
    </style>
</head>
<body>
    <div class="sidebar">
        <h2>Admin Dashboard</h2>
        <ul>
            <li><a href="#" class="active">Dashboard</a></li>
            <li><a href="javascript:void(0);" onclick="display('productInfo')">Products Update</a></li>
            <li><a href="javascript:void(0);" onclick="display('customerInfo')">Customers</a></li>
            <li><a href="javascript:void(0);" onclick="display('feedbackInfo')">Feedback</a></li>
            <li><a href="javascript:void(0);" onclick="display('addInfo')">Add Product</a></li>
            <li><a href="javascript:void(0);" onclick="display('transactionInfo')">Order Information</a></li>
            <li><a href="javascript:void(0);" onclick="redirectToSalesReport()">Sales Report</a></li>
        </ul>
    </div>
    

    <div id="customerInfo" class="content2" style="display: none;">
        <div class="container">
            <center><h2>FarmToDoorHub</h2></center>
            <center><h2>Customer Information</h2></center>
            <table id="customerTable">
                <thead>
                    <tr>
                        <th>Customer ID</th>
                        <th>Name</th>
                        <th>Age</th>
                        <th>Email</th>
                        <th>Phone Number</th>
                        <th>Password</th>
                        <th>Address</th>
                        <th>Pincode</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        Connection conn = null;
                        Statement stmt = null;
                        ResultSet rs = null;
                        try {
                            conn = Dbconnection.getConnection();
                            stmt = conn.createStatement();
                            rs = stmt.executeQuery("SELECT * FROM userdetails");

                            while (rs.next()) {
                                int c_id = rs.getInt("customer_id");
                                String c_name = rs.getString("customer_name");
                                int c_age = rs.getInt("customer_age");
                                String c_email = rs.getString("customer_email");
                                String c_phno = rs.getString("customer_phno");
                                String c_pwd = rs.getString("customer_password");
                                String c_add = rs.getString("customer_address");
                                int c_pcd = rs.getInt("pincode");
                    %>
                    <tr>
                        <td><%= c_id %></td>
                        <td><%= c_name %></td>
                        <td><%= c_age %></td>
                        <td><%= c_email %></td>
                        <td><%= c_phno %></td>
                        <td><%= c_pwd %></td>
                        <td><%= c_add %></td>
                        <td><%= c_pcd %></td>
                    </tr>
                    <%
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                        } finally {
                            try {
                                if (rs != null) rs.close();
                                if (stmt != null) stmt.close();
                                if (conn != null) conn.close();
                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                        }
                    %>
                </tbody>
            </table>
        </div>
    </div>

    <div id="feedbackInfo" class="content2" style="display: none;">
        <div class="container">
        <center><h2>FarmTODoorHub</h2></center>
            <center><h2>Feedback Information</h2></center>
            <table id="customerTable">
                <thead>
                    <tr>
                        <th>Customer Name</th>
                        <th>Product Name</th>
                        <th>Feedback</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        try {
                            conn = Dbconnection.getConnection();
                            stmt = conn.createStatement();
                            String query = "SELECT feedback, c.customer_name, p.i_name, f.customer_id " +
                                           "FROM feedbacck f " +
                                           "JOIN userdetails c ON f.customer_id = c.customer_id " +
                                           "JOIN product_details p ON f.product_id = p.i_id";
                            rs = stmt.executeQuery(query);

                            while (rs.next()) {
                                String customerName = rs.getString("customer_name");
                                String productName = rs.getString("i_name");
                                String feedback = rs.getString("feedback");
                                int customerId = rs.getInt("customer_id");
                    %>
                    <tr>
                        <td><%= customerName %></td>
                        <td><%= productName %></td>
                        <td><%= feedback %></td>
                        <td><button onclick="sendFeedback('<%= customerId %>')">Send Feedback</button></td>
                    </tr>
                    <%
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                        } finally {
                            try {
                                if (rs != null) rs.close();
                                if (stmt != null) stmt.close();
                                if (conn != null) conn.close();
                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                        }
                    %>
                </tbody>
            </table>
        </div>
    </div>

    <div id="productInfo" class="content2" style="display: none;">
        <div class="container">
        <center><h2>FarmToDoorHub</h2></center>
            <center><h2>Product List</h2></center>
            <table>
                <thead>
                    <tr>
                        <th>Product ID</th>
                        <th>Product Name</th>
                        <th>Price</th>
                        <th>Image</th>
                        <th>Available</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        try {
                            conn = Dbconnection.getConnection();
                            stmt = conn.createStatement();
                            rs = stmt.executeQuery("SELECT * FROM product_details WHERE is_active = TRUE");

                            while (rs.next()) {
                                int p_id = rs.getInt("i_id");
                                String p_name = rs.getString("i_name");
                                int price = rs.getInt("i_price");

                                Blob imageBlob = rs.getBlob("i_img");
                                byte[] imageBytes = imageBlob.getBytes(1, (int) imageBlob.length());
                                String base64Image = Base64.getEncoder().encodeToString(imageBytes);

                                int avail = rs.getInt("i_available");
                    %>
                    <tr>
                        <td><%= p_id %></td>
                        <td><%= p_name %></td>
                        <td>Rs.<%= price %></td>
                        <td><img src="data:image/jpeg;base64,<%= base64Image %>" alt="<%= p_name %>" style="width: 50px; height: 50px;"></td>
                        <td><%= avail %></td>
                        <td class="action-buttons">
                            <a href="editproduct.jsp?id=<%= p_id %>" class="update-button">Update</a>
                            <a href="deleteproductservlet?id=<%= p_id %>" class="delete-button" onclick="return confirm('Are you sure you want to delete this product?');">Delete</a>
                        </td>
                    </tr>
                    <%
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                        } finally {
                            try {
                                if (rs != null) rs.close();
                                if (stmt != null) stmt.close();
                                if (conn != null) conn.close();
                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                        }
                    %>
                </tbody>
            </table>
        </div>
    </div>

    <div id="addInfo" class="content2" style="display: none;">
        <div class="container">
        <center><h2>FarmToDoorHub</h2></center>
            <center><h2>Add Product</h2></center>
           <style>
        body {
            font-family: Arial, sans-serif;
            background-position: center;
            background-repeat: no-repeat;
            background-size: cover;
            background-attachment: fixed;
            margin: 0;
            padding: 0;
        }
        form {
            background-color: #fff;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 400px;
            max-width: 80%;
            margin: 50px auto;
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            padding: 10px;
            border: 1px solid #ccc;
            text-align: left;
        }
        input[type="text"], input[type="file"] {
            width: calc(100% - 20px);
            padding: 8px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        input[type="submit"] {
            width: calc(100% - 20px);
            background-color: #4CAF50;
            color: white;
            padding: 10px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s;
        }
        input[type="submit"]:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
    <form action="uploadservlet" method="post" enctype="multipart/form-data">
        <table>
            <tr>
                <td>Itemname:</td>
                <td><input type="text" name="itemname"></td>
            </tr>
            <tr>
                <td>Price:</td>
                <td><input type="text" name="price"></td>
            </tr>
            <tr>
                <td>Quantity:</td>
                <td><input type="text" name="item"></td>
            </tr>
            <tr>
                <td>Filename:</td>
                <td><input type="file" name="img"></td>
            </tr>
            <tr>
                <td colspan="2"><input type="submit" name="btnsubmit"></td>
            </tr>
        </table>
    </form>
        </div>
    </div>

    <div id="transactionInfo" class="content2" style="display: none;">
        <div class="container">
        <center><h2>FarmToDoorHub</h2></center>
            <center><h2>Order Information</h2></center>
            <table id="customerTable">
                <thead>
                    <tr>
                        <th>Transaction Id</th>
                        <th>Customer Id</th>
                        <th>Quantity</th>
                        <th>Product Name</th>
                        <th>Item Price</th>
                        <th>Payment Id</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        try {
                            conn = Dbconnection.getConnection();
                            stmt = conn.createStatement();
                            rs = stmt.executeQuery("SELECT * FROM transactions");

                            while (rs.next()) {
                                int t_id = rs.getInt("transaction_id");
                                int c_id = rs.getInt("customer_id");
                                int quan = rs.getInt("item_quantity");
                                String item = rs.getString("item_name");
                                String price = rs.getString("item_price");
                                String p_id = rs.getString("payment_id");
                    %>
                    <tr>
                        <td><%= t_id %></td>
                        <td><%= c_id %></td>
                        <td><%= quan %></td>
                        <td><%= item %></td>
                        <td><%= price %></td>
                        <td><%= p_id %></td>
                    </tr>
                    <%
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                        } finally {
                            try {
                                if (rs != null) rs.close();
                                if (stmt != null) stmt.close();
                                if (conn != null) conn.close();
                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                        }
                    %>
                </tbody>
            </table>
        </div>
    </div>

    <script>
        function display(contentId) {
            var contents = document.querySelectorAll('.content2');
            contents.forEach(function(content) {
                content.style.display = 'none';
            });
            var content = document.getElementById(contentId);
            content.style.display = 'block';
        }

        function redirectToSalesReport() {
            window.location.href = "SalesReportServlet";
        }

        function sendFeedback(customerId) {
            window.location.href = "email.jsp?customerId=" + encodeURIComponent(customerId);
        }
    </script>
</body>
</html>
