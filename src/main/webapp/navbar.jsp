<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Navbar for cart</title>
<style>
body {
  margin: 0;
  font-family: Arial, sans-serif;
}

.navbar {
  background-color:green;
  overflow: hidden;
}

.navbar a {
  float: left;
  display: block;
  color: #f2f2f2;
  text-align: center;
  padding: 14px 16px;
  text-decoration: none;
}

.navbar a:hover {
  background-color: #ddd;
  color: black;
}

.navbar a.active {
  background-color: #04AA6D;
  color: white;
}

.search-container {
  float: right;
}

input[type=text] {
  padding: 6px;
  margin-top: 8px;
  font-size: 17px;
  border: none;
}

button {
  padding: 6px 10px;
  margin-top: 8px;
  background: #ddd;
  font-size: 17px;
  border: none;
  cursor: pointer;
}
</style>
</head>
<body>

<div class="navbar">
  <a class="active" href="#home">FarmToDoorHub</a>
    <a href="vcart.jsp">cart</a>

  <a href="ch.html">Help</a>
  <a href="lo.jsp">Login</a>
  <div class="search-container">
    <input type="text" placeholder="Search...">
    <button type="submit">Search</button>
  </div>
</div>

</body>
</html>
