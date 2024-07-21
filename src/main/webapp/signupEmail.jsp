<%@ page import="java.sql.*" %>
<%@ page import="com.Database.Dbconnection" %>
<%@ page import="java.io.PrintWriter" %>
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
        PreparedStatement pstmt = conn.prepareStatement("SELECT customer_email FROM userdetails WHERE customer_id = ?");
        pstmt.setInt(1, c_id);
        ResultSet rs = pstmt.executeQuery();

        if (rs.next()) {
            email = rs.getString("customer_email");
        }
    } catch(Exception ex) {
        ex.printStackTrace(); 
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
            emailjs.init("Y3yQa3n_pgAcD6enr"); // Replace with your EmailJS user ID

            document.getElementById('emailForm').addEventListener('submit', function(event) {
                event.preventDefault();

                var recipientEmail = document.getElementById('recipientEmail').value;

emailjs.send("service_qdzudjy", "template_jf3oicx", { to_email: recipientEmail }).then(function(response) {
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

