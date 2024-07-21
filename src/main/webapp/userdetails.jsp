
<%@ page import="java.sql.*" %>
<%@ page import="com.Database.Dbconnection" %>
<%@ page import="java.util.List"%>
<%@ page import ="java.sql.Blob"%>
<%@ page import="java.util.Base64"%>
<%@ page import="java.lang.*"%><%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Information</title>
    <link rel="stylesheet" href="userdetails.css">
</head>
<body>
    <div class="container">
        <h2>Customer Information</h2>
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
                <tr>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
                <!-- Add more rows here -->
            </tbody>
        </table>
    </div>

    
    <%
    try {
        Connection conn = Dbconnection.getConnection();
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT * FROM userdetails");
        
        while(rs.next())
        {
        int c_id=rs.getInt("customer_id");
        String c_name=rs.getString("customer_name");
        int c_age=rs.getInt("customer_age");
        String c_email=rs.getString("customer_email");
        String c_phno=rs.getString("customer_phno");
        int c_pwd=rs.getInt("customer_password");
        String c_add=rs.getString("customer_address");
        int c_pcd=rs.getInt("pincode");
        
       %>        <tr>
            <td><%=c_id %></td>
            <td><%=c_name %></td>
            <td><%=c_age %></td>
            <td><%=c_email %></td>
            <td><%=c_phno %></td>
            <td><%=c_pwd %></td>
            <td><%=c_add %></td>
            <td><%=c_pcd %></td>
        </tr>
        
   <%
          }
    }
        catch(Exception e)
        {
        	out.println(e);
        }

%>

</table>

    <script src="userdetails.js"></script>
</body>
</html>
    