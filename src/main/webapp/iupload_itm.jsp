<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>JSP Page</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-image: linear-gradient(rgba(0,0,0,.2),rgba(0,0,0,.6)), url("bg-images/mini9.jpg");
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
</body>
</html>
