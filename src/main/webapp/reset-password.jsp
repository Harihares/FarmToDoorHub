<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Verify Code</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/5.1.3/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h2>Verify Code</h2>
    <form action="VerifyCodeServlet" method="post">
        <div class="mb-3">
            <label for="code" class="form-label">Reset Code</label>
            <input type="text" class="form-control" id="code" name="code" required>
        </div>
        <button type="submit" class="btn btn-primary">Verify Code</button>
    </form>
    <%
        String msg = (String) request.getAttribute("msg");
        if (msg != null) {
    %>
    <div class="alert alert-danger mt-3"><%= msg %></div>
    <%
        }
    %>
</div>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/5.1.3/js/bootstrap.bundle.min.js"></script>
</body>
</html>
