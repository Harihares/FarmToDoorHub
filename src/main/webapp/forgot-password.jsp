<!DOCTYPE html>
<html>
<head>
    <title>Forgot Password</title>
</head>
<body>
    <h2>Forgot Password</h2>
    <form action="ForgotPasswordServlet" method="post">
        <label for="phone">Phone Number:</label>
        <input type="text" id="phone" name="phone" required>
        <input type="submit" value="Submit">
    </form>
    <p>${message}</p>
</body>
</html>
