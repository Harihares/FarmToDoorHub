<%@page import="com.show.Feedback"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.Database.Dbconnection" %>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Base64"%>
<%@ page import="java.lang.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
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
<img src="data:image/jpeg;base64, <%=Base64.getEncoder().encodeToString((byte[])request.getAttribute("imagedata"))%> ">
<h2><%=request.getAttribute("namedata")%></h2>
<p>Price: <%=request.getAttribute("pricedata")%></p>

<h3>Feedback:</h3>
<%
List<Feedback> feedbackList = (List<Feedback>) request.getAttribute("feedbackList");
for (Feedback feedback : feedbackList) {
    String customerName = feedback.getCustomerName();
    String feedbackText = feedback.getFeedback();
%>
    <p><b><%=customerName%>:</b> <%=feedbackText%></p>
<%
}
%>
    
</body>
</html>
