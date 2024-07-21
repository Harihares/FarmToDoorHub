<%@ page import="java.sql.*" %>
<%@ page import="com.Database.Dbconnection" %>
<%@ page import="java.util.List" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="java.util.Base64" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Email Sender</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-color: #f4f4f4;
        }
        .container {
            text-align: center;
        }
        input[type="email"] {
            padding: 10px;
            margin-bottom: 10px;
            width: 300px;
            font-size: 16px;
        }
        button {
            padding: 10px 20px;
            background-color: #007bff;
            color: #fff;
            border: none;
            cursor: pointer;
            font-size: 16px;
        }
        button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
<%
    String email = null;
    try {
        int c_id = Integer.parseInt(request.getParameter("customerId"));

        Connection conn = Dbconnection.getConnection();
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT customer_email FROM userdetails WHERE customer_id = " + c_id);

        if (rs.next()) {
            email = rs.getString("customer_email");
        }
    } catch(Exception ex) {
        PrintWriter pw = new PrintWriter(out);
        ex.printStackTrace(pw); // Print exception to JSP output for debugging
    }
%>
    <div class="container">
        <h2>Send Email</h2>
        <form id="emailForm">
            <input type="email" id="recipientEmail" placeholder="Recipient's Email" value="<%= email %>">
            <button type="submit">Send Email</button>
        </form>
    </div>
    
    <script src="https://cdn.emailjs.com/dist/email.min.js"></script>
    <script>
        (function() {
            emailjs.init("Y3yQa3n_pgAcD6enr"); // Initialize EmailJS with your public key

            document.getElementById('emailForm').addEventListener('submit', function(event) {
                event.preventDefault();

                // Get recipient email from input
                var recipientEmail = document.getElementById('recipientEmail').value;

                // Send email
                emailjs.send("service_qdzudjy", "template_zwxhqti", { to_email: recipientEmail })
                    .then(function(response) {
                        alert("Email sent successfully!");
                        console.log("Email sent:", response);
                    }, function(error) {
                        alert("Failed to send email. Please try again later.");
                        console.error("Email sending failed:", error);
                    });
            });
        })();
    </script>
</body>
</html>
