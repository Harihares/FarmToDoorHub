

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Page</title>
    <link rel="stylesheet" href="styles.css">
</head>
<center><h2></h2></center>
<body>

<div class="login-container">
    <form id="loginForm" action="admindashboard.jsp" method="post" class="login-form" onsubmit="return validateForm()">
        <h2>Login</h2>
        <div class="input-group">
            <label for="username">Username:</label>
            <input type="text" id="username" name="username" required>
        </div>
        <div class="input-group">
            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required>
        </div>
        <button type="submit">Login</button>
        
        <p id="notadmin" style="color: red;"> </p>
    </form>
</div>

<script>
function validateForm() {
    var username = document.getElementById("username").value;
    var password = document.getElementById("password").value;
    
    if (username === "hari" && password === "hari@2002") {
        return true;
    } else {
        document.getElementById("notadmin").innerHTML = "You are not the admin";
        return false; 
    }
}
</script>


</body>
<style>
body {
  font-family: Arial, sans-serif;
  margin: 0;
  padding: 0;
  display: flex;
  justify-content: center;
  align-items: center;
  height: 100vh;
  background-color: #f0f0f0;
  
             
                 background-image:linear-gradient(rgba(0,0,0,.2),rgba(0,0,0,.6)),url("bg-images/pest.jpeg");
                 background-position:center;
                 background-repeat:no-repeat;
                 background-size:cover;
                 background-attachment:fixed;
             
}

.login-container {
  background-color: #fff;
  padding: 20px;
  border-radius: 5px;
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

.login-form {
  max-width: 300px;
  margin: 0 auto;
}

.login-form h2 {
  margin-bottom: 20px;
  text-align: center;
}

.input-group {
  margin-bottom: 15px;
}

.input-group label {
  display: block;
  margin-bottom: 5px;
}

.input-group input {
  width: 100%;
  padding: 10px;
  border: 1px solid #ccc;
  border-radius: 5px;
  box-sizing: border-box;
}

button[type="submit"] {
  width: 100%;
  background-color: #4caf50;
  color: #fff;
  padding: 10px;
  border: none;
  border-radius: 5px;
  cursor: pointer;
}

button[type="submit"]:hover {
  background-color: #45a049;
}
</style>



</html>
