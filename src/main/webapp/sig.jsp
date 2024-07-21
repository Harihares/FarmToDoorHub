<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign Up - FarmToDoorHub</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f5f5f5;
            background-image: linear-gradient(rgba(0,0,0,.2),rgba(0,0,0,.6)), url("bg-images/mini9.jpg");
            background-position: center;
            background-repeat: no-repeat;
            background-size: cover;
            background-attachment: fixed;
        }
        header {
            background-color: #333;
            color: #fff;
            padding: 20px;
            text-align: center;
        }
        nav {
            background-color: #4CAF50;
            overflow: hidden;
            text-align: center;
            padding: 10px 0;
        }
        nav a {
            display: inline-block;
            color: #fff;
            text-align: center;
            padding: 10px 15px;
            text-decoration: none;
            transition: background-color 0.3s;
        }
        nav a:hover {
            background-color: #45a049;
        }
        .container {
            width: 70%;
            height: auto;
            max-width: 400px;
            margin: 50px auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        label {
            display: block;
            margin-bottom: 10px;
            font-weight: bold;
            color: #333;
        }
        input[type="text"],
        input[type="number"],
        input[type="password"],
        input[type="email"] {
            width: calc(100% - 10px);
            padding: 10px;
            margin: 5px 0 15px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 14px;
            color: #4CAF50;
        }
        input[type="submit"] {
            background-color: #4CAF50;
            color: white;
            padding: 12px 20px;
            margin-top: 10px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            width: 100%;
            transition: background-color 0.3s;
        }
        input[type="submit"]:hover {
            background-color: #45a049;
        }
        .logo {
            color: #fff;
            font-size: 24px;
            font-weight: bold;
            text-decoration: none;
        }
        .error-msg {
            color: red;
            font-weight: bold;
            margin-top: 5px;
        }
    </style>
    <script>
        function validateForm() {
            const phone = document.getElementById("phone").value;
            const pincode = document.getElementById("pincode").value;
            const password = document.getElementById("password").value;
            const phonePattern = /^\d{10}$/;
            const pincodePattern = /^\d{6}$/;
            const passwordPattern = /^(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{6,}$/;

            let isValid = true;

            if (!phonePattern.test(phone)) {
                document.getElementById("phone-error").innerText = "Phone number must be 10 digits.";
                isValid = false;
            } else {
                document.getElementById("phone-error").innerText = "";
            }

            if (!pincodePattern.test(pincode)) {
                document.getElementById("pincode-error").innerText = "Pincode must be 6 digits.";
                isValid = false;
            } else {
                document.getElementById("pincode-error").innerText = "";
            }

            if (!passwordPattern.test(password)) {
                document.getElementById("password-error").innerText = "Password must be at least 6 characters long and include at least one lowercase letter, one number, and one special character.";
                isValid = false;
            } else {
                document.getElementById("password-error").innerText = "";
            }

            return isValid;
        }
    </script>
</head>
<body>
    ...
<body>
    <header>
        <a href="#" class="logo">FarmToDoorHub</a>
    </header>
    <nav>
        <a href="lo.jsp">Login</a>
        <a href="ch.html">Help</a>
        <a href="contact.html">Contact</a>
    </nav>
    <div class="container">
        <form class="form-signup" action="Signupservlet" method="get" onsubmit="return validateForm()">
            <label for="name"><i class="fas fa-user"></i> Name:</label>
            <input type="text" id="name" name="name" required>
            <label for="email"><i class="fas fa-envelope"></i> Email:</label>
            <input type="email" id="email" name="email" required>
            <span id="email-error" class="error-msg">${requestScope.email_error}</span>
            <label for="age"><i class="fas fa-calendar-alt"></i> Age:</label>
            <input type="number" id="age" name="age" required>
            <label for="address"><i class="fas fa-map-marker-alt"></i> Address:</label>
            <input type="text" id="address" name="Address" required>
            <label for="phone"><i class="fas fa-phone"></i> Phone Number:</label>
            <input type="text" id="phone" name="phoneno" required>
            <span id="phone-error" class="error-msg">${requestScope.phone_error}</span>
            <label for="pincode"><i class="fas fa-map-pin"></i> Pincode:</label>
            <input type="text" id="pincode" name="pincode" required>
            <span id="pincode-error" class="error-msg">${requestScope.pincode_error}</span>
            <label for="password"><i class="fas fa-lock"></i> Password:</label>
            <input type="password" id="password" name="password" required>
            <span id="password-error" class="error-msg">${requestScope.password_error}</span>
            <input type="submit" value="Sign Up">
            <% 
                String btn = request.getParameter("btn_submit");
                if (btn != null) {
                    String valid = (String) request.getAttribute("msg");
                    if (valid != null) {
                        out.println(valid);
                    }
                }
            %>
        </form>
    </div>
</body>